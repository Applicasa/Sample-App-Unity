//
//  MiniView.m
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import "MiniView.h"
#import "VirtualGood.h"
#import "LiPromoHelperViews.h"
#import "VirtualCurrency.h"
#import "IAP.h"
#import <LiCore/LiKitPromotions.h>
#import <LiCore/LiCore.h>

#define kCancelButtonTag 1
#define kActionButtonTag 2

@interface MiniView()

- (void) defaultAction;
- (VirtualCurrency *) getVirtualCurrencyByID:(NSString *)ID;
- (VirtualGood *) getVirtualGoodByID:(NSString *)ID IsDeal:(BOOL)isDeal;
- (void) closeAction;
- (IBAction) promoButtonPressed:(UIButton *)sender;

@end

@implementation MiniView
@synthesize promotion;

#pragma mark - UI Builder

+ (MiniView *) MiniViewWithPromotion:(Promotion *)promotion andFrame:(CGRect)frame{
    MiniView *view = [[[MiniView alloc] initWithFrame:frame]autorelease];
    view.promotion = promotion;
    [view setBackgroundColor:[UIColor clearColor]];

    UIImageView *bgImageView = [[[UIImageView alloc] initWithFrame:frame]autorelease];
    [bgImageView setUserInteractionEnabled:YES];
    [bgImageView setContentMode:UIViewContentModeScaleAspectFit];
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [view addSubview:bgImageView];
    [view sendSubviewToBack:bgImageView];
    
    LiActivityIndicator *bgActivity = [LiActivityIndicator startAnimatingOnView:bgImageView];
    
    [[promotion promotionImage] getCachedImageWithBlock:^(NSError *error, UIImage *image) {
        [bgImageView setImage:image];
        [bgActivity stopAndRemove];
    }];

    UIButton *closeButton = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-60, 15, 40, 40)]autorelease];
    [closeButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton addTarget:view action:@selector(promoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.tag = kCancelButtonTag;
    [view addSubview:closeButton];
 
    UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width/10)*3, (frame.size.height/10)*8, (frame.size.width/10)*4, (frame.size.height/10)*2)];
    [actionButton addTarget:view action:@selector(promoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [actionButton setBackgroundColor:[UIColor clearColor]];
    actionButton.tag = kActionButtonTag;
    [view addSubview:actionButton];

    [[promotion promotionButton] getCachedImageWithBlock:^(NSError *error, UIImage *image) {
        CGRect rect = actionButton.frame;
        rect.size.width = (image.size.width)/2;
        rect.size.height = (image.size.height)/2;
        rect.origin.x = (view.frame.size.width-rect.size.width)/2;
        
        [actionButton setFrame:rect];
        [actionButton setImage:image forState:UIControlStateNormal];
    }];
    
    return view;
    
        //return [view autorelease];
}

- (IBAction) promoButtonPressed:(UIButton *)sender{
    if (sender.tag == kCancelButtonTag){
        [self closeAction];
    } else if (sender.tag == kActionButtonTag){
        [self defaultAction];
    }
    [self removeFromSuperview];
    //[self autorelease];
}

#pragma mark - Close Button

- (void) closeAction{
    promotion.block(LiPromotionActionCancel,LiPromotionResultNothing,nil);
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
                NSLog(@"Virtual Currency purchase was cancled %@",error);
                promoAction = LiPromotionActionCancel;
            }
            else
                promoAction = LiPromotionActionFailed;

            NSLog(@"Commit Promotion Action Failed With Error %@",error);
            info = error;
        }
        
		promotion.block(promoAction,result,info);
    };
    switch (promotion.promotionActionKind) {
        case LiPromotionTypeLink:{
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
            LiCurrency currencyKind = (LiCurrency) [[dictionary objectForKey:@"virtualCurrencyKind"] integerValue];
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

#pragma mark - Deprecated Methods
/*********************************************************************************
 DEPRECATED METHODS:
 
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the next release. You should update your code immediately.
 **********************************************************************************/

@end
