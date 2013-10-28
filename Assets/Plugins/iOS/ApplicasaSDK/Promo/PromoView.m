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
#import "LiManager.h"

#define kCancelButtonTag 1
#define kActionButtonTag 2


#if (ENABLE_CHARTBOOST)
#define CHARTBOOST
#import <LiChartboost/LiChartboostManager.h>
#endif
#if (ENABLE_MMEDIA)
#define MMEDIA
#import <LiMMedia/LiMMediaManager.h>
#endif

#if (ENABLE_SPONSORPAY)
#define SPONSORPAY
#import <LiSponsorPay/LiSponsorPayManager.h>
#endif

#if (ENABLE_APPNEXT)
#define APPNEXT
#import <LiAppnext/LiAppnextManager.h>
#endif

#if (ENABLE_SUPERSONICADS)
#define SUPERSONIC
#import <LiSupersonicAds/LiSupersonicAdsManager.h>
#endif

@interface PromoView()<UIWebViewDelegate>

- (void) defaultAction;
- (VirtualCurrency *) getVirtualCurrencyByID:(NSString *)ID;
- (VirtualGood *) getVirtualGoodByID:(NSString *)ID IsDeal:(BOOL)isDeal;
- (void) closeAction;
- (IBAction) promoButtonPressed:(UIButton *)sender;

-(PromoView *) showRegularPromotionWithPromoView:(PromoView *)view;
-(PromoView *) showTrialPayWithPromoView:(PromoView *)view;
-(PromoView *) showChartboostWithPromoView:(PromoView *)view;
-(PromoView *)showSponsorPayWithPromoView:(PromoView *)view;
-(PromoView *)showAppnextWithPromoView:(PromoView *)view;
-(PromoView *)showSupersonicAdsWithPromoView:(PromoView *)view;


@property (assign,nonatomic) NSString *baseOfferwallUrl;
@property (retain,nonatomic) UIWebView *offerwallWebview;
@property (assign,nonatomic)  UIButton *backButton;
-(void) backButtonPressed;
@end

@implementation PromoView
@synthesize promotion,baseOfferwallUrl,offerwallWebview,backButton;

static BOOL isDuringTrialPay =FALSE;
#pragma mark - UI Builder

+ (PromoView *) promoViewWithPromotion:(Promotion *)promotion andFrame:(CGRect)frame{
    PromoView *view = [[PromoView alloc] initWithFrame:frame];
    view.promotion = promotion;
    [view setBackgroundColor:[UIColor clearColor]];
    
    switch(promotion.promotionActionKind)
    {
        case LiPromotionTypeMMedia:
            view = [view showMMediaWithPromoView:view];
            break;
        case LiPromotionTypeChartboost:
            view = [view showChartboostWithPromoView:view];
            break;
        case LiPromotionTypeTrialPay:
            if (!isDuringTrialPay)
                view = [view showTrialPayWithPromoView:view];
            break;
        case LiPromotionTypeSponsorPay:
            view = [view showSponsorPayWithPromoView:view];
            break;
        case LiPromotionTypeSupersonicAds:
            view = [view showSupersonicAdsWithPromoView:view];
            break;
        case LiPromotionTypeAppnext:
            view = [view showAppnextWithPromoView:view];
            break;
            default:
            view = [view showRegularPromotionWithPromoView:view];
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
    if (promotion.promotionActionKind == LiPromotionTypeTrialPay)
    {
        isDuringTrialPay = FALSE;
        promotion.block(LiPromotionActionPressed,LiPromotionResultTrialPay,nil);
        [LiKitPromotions promo:promotion ButtonClicked:NO CancelButton:YES];
    }
    else
    {
        promotion.block(LiPromotionActionCancel,0,nil);
    
        [LiKitPromotions promo:promotion ButtonClicked:NO CancelButton:YES];
    }
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

-(PromoView *) showRegularPromotionWithPromoView:(PromoView *)view
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

-(PromoView *)showTrialPayWithPromoView:(PromoView *)view
{
    isDuringTrialPay = TRUE;
    offerwallWebview = [[UIWebView alloc] initWithFrame:view.frame];
    NSDictionary *dictionary = [view.promotion.promotionActionData liJSONValue];
    NSString *tempURL = [dictionary objectForKey:@"link"];
    NSString *userID = [[User getCurrentUser ] userID];
    NSString *isSandBox = [LiManager isSandboxEnabled]?@"true":@"false";
    NSURL *url = [NSURL URLWithString:[tempURL stringByAppendingFormat:@"sid=%@&Promotion=%@&IsSandbox=%@%@",userID,view.promotion.promotionID,isSandBox,[LiKitPromotions getTrialPayDeviceInfo] ]];
     baseOfferwallUrl = [url absoluteString];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [offerwallWebview loadRequest:requestObj];
    [offerwallWebview setDelegate:self];
    [view addSubview:offerwallWebview];

    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width-35, 5, 30, 30)];
    [closeButton setImage:[UIImage imageNamed:@"Close"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor clearColor]];
    [closeButton addTarget:view action:@selector(promoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.tag = kCancelButtonTag;
    [view addSubview:closeButton];
    
    return view;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme hasPrefix:@"http"]) {
        return YES;
    }
    
    NSURL *url = request.URL;
    if ([request.URL.scheme hasPrefix:@"tpbow"]) {
        url = [NSURL URLWithString:[request.URL.absoluteString substringFromIndex:5]];
    }
    
    [[UIApplication sharedApplication] openURL: url];
    return NO;
}

// UIWebView: override webViewDidFinishLoad to display or hide back button
// and store offer wall URL
- (void)webViewDidFinishLoad:(UIWebView *)_webView
{
    if (_webView != offerwallWebview) {
        return;
    }
    
    // Back button: Hide if viewing offer wall, otherwise show.
    if ([_webView.request.URL.absoluteString rangeOfString:@"tp_base_page=1"].location != NSNotFound) {
        if (baseOfferwallUrl == nil) {
            baseOfferwallUrl = _webView.request.URL.absoluteString;
        }
        
        if (backButton)
        {
            [backButton removeFromSuperview];
            backButton = nil;
        }
    } else {
        // initialize button and button view
        if(backButton == nil )
        {
            backButton = [UIButton buttonWithType:101];
            [backButton setFrame: CGRectMake(10, 10, 40, 40)];
            [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [backButton setTitle:@"Back" forState:UIControlStateNormal];
            [self addSubview:backButton];
        }
        
    }
}
// Back button: navigate back through UIWebView history stack
- (void)backButtonPressed {
    if (self.offerwallWebview.canGoBack) {
        [self.offerwallWebview goBack];
    }
}
#pragma mark - Chartboost Builder
-(PromoView *)showChartboostWithPromoView:(PromoView *)view
{
    #ifdef CHARTBOOST
    [[LiChartboostManager sharedInstance] showChartboostWithPromoView:view];
    #else
    [view closeAction];
    [view removeFromSuperview];
    NSLog(@"To display Chartboost please enable chartboost in LiConfig.h");
    #endif
    
    return  view;
}
#pragma mark - MMEDIA Builder
-(PromoView *)showMMediaWithPromoView:(PromoView *)view
{
#ifdef MMEDIA
    [[LiMMediaManager sharedInstance] showMMediaWithPromoView:view];
#else
    [view closeAction];
    [view removeFromSuperview];
    NSLog(@"To display MMedia please enable MMedia in LiConfig.h");
#endif
    
    return  view;
}
#pragma mark - SponserPay Builder
-(PromoView *)showSponsorPayWithPromoView:(PromoView *)view
{
#ifdef SPONSORPAY
    [[LiSponsorPayManager sharedInstance] showSponsorPayWithPromoView:view];
#else
    [view closeAction];
    [view removeFromSuperview];
    NSLog(@"To display SPONSERPAY please enable SPONSERPAY in LiConfig.h");
#endif
    
    return  view;
}

#pragma mark - Appnext Builder
-(PromoView *)showAppnextWithPromoView:(PromoView *)view
{
#ifdef APPNEXT
    [[LiAppnextManager sharedInstance] showAppnextWithPromoView:view];
#else
    [view closeAction];
    [view removeFromSuperview];
    NSLog(@"To display Appnext please enable Appnext in LiConfig.h");
#endif
    
    return  view;
}

#pragma mark - SupersonicAds Builder
-(PromoView *)showSupersonicAdsWithPromoView:(PromoView *)view
{
#ifdef SUPERSONIC
    [[LiSupersonicAdsManager sharedInstance] showSupersonicAdsWithPromoView:view];
#else
    [view closeAction];
    [view removeFromSuperview];
    NSLog(@"To display SupersonicAds please enable SupersonicAds in LiConfig.h");
#endif
    
    return  view;
}
+(BOOL) getIsDuringTrialPay{
    return isDuringTrialPay;
}

@end
