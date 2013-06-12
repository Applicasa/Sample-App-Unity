//
//  PromoView.m
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import "PromoView.h"
#import "VirtualGood.h"
#import "LiPromoHelperViews.h"
#import "VirtualCurrency.h"
#import "IAP.h"
#import <LiCore/LiKitPromotions.h>
#import <LiCore/LiCore.h>
#import "User.h"
#import "LiConfig.h"

#define kCancelButtonTag 1
#define kActionButtonTag 2


#if (ENABLE_CHARTBOOST)
#define CHARTBOOST
#import <LiChartboost/LiChartboostManager.h>
#endif

@interface PromoView()

- (void) defaultAction;
- (VirtualCurrency *) getVirtualCurrencyByID:(NSString *)ID;
- (VirtualGood *) getVirtualGoodByID:(NSString *)ID IsDeal:(BOOL)isDeal;
- (void) closeAction;
- (IBAction) promoButtonPressed:(UIButton *)sender;

+(PromoView *) showRegularPromotionWithPromoView:(PromoView *)view;
+(PromoView *) showTrialPayWithPromoView:(PromoView *)view;
+(PromoView *) showChartboostWithPromoView:(PromoView *)view;
@end

@implementation PromoView
@synthesize promotion;

#pragma mark - UI Builder

+ (PromoView *) promoViewWithPromotion:(Promotion *)promotion andFrame:(CGRect)frame{
    PromoView *view = [[PromoView alloc] initWithFrame:frame];
    view.promotion = promotion;
    [view setBackgroundColor:[UIColor clearColor]];
    
    switch(promotion.promotionActionKind)
    {
        case LiPromotionTypeChartboost:
            view = [self showChartboostWithPromoView:view];
            break;
        case LiPromotionTypeTrialPay:
            view = [self showTrialPayWithPromoView:view];
            break;
            default:
            view = [self showRegularPromotionWithPromoView:view];
            break;
    }
    return view;
}

- (IBAction) promoButtonPressed:(UIButton *)sender{
    if (sender.tag == kCancelButtonTag){
        [self closeAction];
    } else if (sender.tag == kActionButtonTag){
        [self defaultAction];
    }
    [self removeFromSuperview];
}

#pragma mark - Close Button

- (void) closeAction{
    promotion.block(LiPromotionActionCancel,0,nil);
    [LiKitPromotions promo:promotion ButtonClicked:NO CancelButton:YES];
}

#pragma mark - Action Button

- (VirtualGood *) getVirtualGoodByID:(NSString *)ID IsDeal:(BOOL)isDeal{
    NSArray *items = isDeal?[LiKitIAP virtualGoodDeals]:[LiKitIAP virtualGoods];
    for (VirtualGood *virtualGood in items) {
        if ([virtualGood.virtualGoodID isEqualToString:ID])
            return virtualGood;
    }
    return nil;
}

- (VirtualCurrency *) getVirtualCurrencyByID:(NSString *)ID{
    NSArray *items = [LiKitIAP virtualCurrencyDeals];
    for (VirtualCurrency *virtualCurrency in items) {
        if ([virtualCurrency.virtualCurrencyID isEqualToString:ID])
            return virtualCurrency;
    }
    return nil;
    
}

- (void) defaultAction{
    NSDictionary *dictionary = [promotion.promotionActionData liJSONValue];
    __block LiPromotionAction promoAction = LiPromotionActionPressed;
    __block id info = nil;
    __block LiPromotionResult result = LiPromotionResultNothing;
    BOOL respondNow = YES;
    LiBlockAction actionBlock = ^(NSError *error, NSString *itemID, Actions action) {
        if (error){
            if (error.code == 1102)
            {
                promoAction = LiPromotionActionCancel;
            }
            else
                promoAction = LiPromotionActionFailed;
            
            info = error;
        }
		promotion.block(promoAction,result,info);
    };
    switch (promotion.promotionActionKind) {
		case LiPromotionTypeLink:{
            /*LiWebView *webView = [[LiWebView alloc] initWithFrame:self.frame];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[dictionary objectForKey:@"link"]]]];
            [[self superview] addSubview:webView];*/
            info = [NSURL URLWithString:[dictionary objectForKey:@"link_iOS"]];//iOS Link
            if (info == nil)//no iOS link
                info = [NSURL URLWithString:[dictionary objectForKey:@"link_Android"]];
            if (info == nil)//old promotions structure
                info = [NSURL URLWithString:[dictionary objectForKey:@"link"]];
            [[UIApplication sharedApplication] openURL:info];
            result = LiPromotionResultLinkOpened;
        }
            break;
        case LiPromotionTypeString:{
            // iOS String
            info = [dictionary objectForKey:@"string_iOS"];
            if (info == nil)//no iOS String
                info = [dictionary objectForKey:@"string_Android"];
            if (info == nil)//old promotions structure
                info = [dictionary objectForKey:@"string"];
            result = LiPromotionResultStringInfo;
        }
            break;
        case LiPromotionTypeGiveVirtualCurrency:{
            NSInteger amount = [[dictionary objectForKey:@"amount"] integerValue];
            info = [NSNumber numberWithInt:amount];
            LiCurrency currencyKind = [[dictionary objectForKey:@"virtualCurrencyKind"] integerValue];
            result = (currencyKind == MainCurrency)?LiPromotionResultGiveMainCurrencyVirtualCurrency:LiPromotionResultGiveSecondaryCurrencyVirtualCurrency;
            respondNow = NO;
            [IAP giveAmount:amount ofCurrencyKind:currencyKind withBlock:actionBlock];
        }
            break;
        case LiPromotionTypeGiveVirtualGood:{
            NSString *vgID = [dictionary objectForKey:@"_id"];
            info = [self getVirtualGoodByID:vgID IsDeal:NO];
            result = LiPromotionResultGiveVirtualGood;
            respondNow = NO;
            [IAP giveVirtualGood:info quantity:1 withBlock:actionBlock];
        }
            break;
        case LiPromotionTypeOfferDealVC:{
            NSString *vcID = [dictionary objectForKey:@"_id"];
            NSLog(@"responds %d",[self respondsToSelector:@selector(getVirtualCurrencyByID:)]);
            info = [self getVirtualCurrencyByID:vcID];
            result = LiPromotionResultDealVirtualCurrency;
            respondNow = NO;
            [IAP buyVirtualCurrency:info withBlock:actionBlock];
        }
            break;
        case LiPromotionTypeOfferDealVG:{
            NSString *vgID = [dictionary objectForKey:@"_id"];
            info = [self getVirtualGoodByID:vgID IsDeal:YES];
            LiCurrency currencyKind = MainCurrency;
            if ([(VirtualGood *)info virtualGoodMainCurrency] == 0)
                currencyKind = SecondaryCurrency;
            result = LiPromotionResultDealVirtualGood;
            respondNow = NO;
            [IAP buyVirtualGood:info quantity:1 withCurrencyKind:currencyKind andBlock:actionBlock];
        }
            break;
        default:
            //nothing...
            break;
    }
    [LiKitPromotions promo:promotion ButtonClicked:YES CancelButton:NO];
    if (respondNow){
        promotion.block(promoAction,result,info);
    }
}

#pragma mark - Showing methods

+(PromoView *) showRegularPromotionWithPromoView:(PromoView *)view
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:view.frame];
    [bgImageView setUserInteractionEnabled:YES];
    [bgImageView setContentMode:UIViewContentModeScaleToFill];
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [view addSubview:bgImageView];
    [view sendSubviewToBack:bgImageView];
    
    LiActivityIndicator *bgActivity = [LiActivityIndicator startAnimatingOnView:bgImageView];
    
    [[view.promotion promotionImage] getCachedImageWithBlock:^(NSError *error, UIImage *image) {
        [bgImageView setImage:image];
        [bgActivity stopAndRemove];
    }];
    
    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake((view.frame.size.width/10)*3, (view.frame.size.height/10)*8, (view.frame.size.width/10)*4, (view.frame.size.height/10)*2)];
    [actionButton addTarget:view action:@selector(promoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setBackgroundColor:[UIColor clearColor]];
    actionButton.tag = kActionButtonTag;
    [view addSubview:actionButton];
    
    
    [[view.promotion promotionButton] getCachedImageWithBlock:^(NSError *error, UIImage *image) {
       /* CGRect rect = actionButton.frame;
        rect.size.width = (image.size.width)/2;
        rect.size.height = (image.size.height)/2;
        rect.origin.x = (view.frame.size.width-rect.size.width)/2;
        
        [actionButton setFrame:rect];*/
        [actionButton setImage:image forState:UIControlStateNormal];
    }];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width-60, 15, 40, 40)];
    [closeButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton addTarget:view action:@selector(promoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.tag = kCancelButtonTag;
    [view addSubview:closeButton];
    
    return view;
}

+(PromoView *)showTrialPayWithPromoView:(PromoView *)view
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:view.frame];
    NSDictionary *dictionary = [view.promotion.promotionActionData liJSONValue];
    NSString *tempURL = [dictionary objectForKey:@"link"];
    NSString *userID = [[User getCurrentUser ] userID];
    NSURL *url = [NSURL URLWithString:[tempURL stringByAppendingFormat:@"sid=%@&Promotion=%@",userID,view.promotion.promotionID]];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    [view addSubview:webView];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width-35, 5, 30, 30)];
    [closeButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton addTarget:view action:@selector(promoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.tag = kCancelButtonTag;
    [view addSubview:closeButton];
    
    return view;
}

+(PromoView *)showChartboostWithPromoView:(PromoView *)view
{
    #ifdef CHARTBOOST
    [[LiChartboostManager sharedInstance] showChartboostWithPromotion:view];
    #else
    [view closeAction];
    [view removeFromSuperview];
    NSLog(@"To display Chartboost please enable chartboost in LiConfig.h");
    #endif
    
    return  view;
}

@end
