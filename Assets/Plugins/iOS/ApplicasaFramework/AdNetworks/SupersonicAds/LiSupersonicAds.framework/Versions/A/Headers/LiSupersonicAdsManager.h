//
//  LiSuperSonicManager.h
//  LiCore
//
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiKitPromotions.h>
#import "LiManager.h"
#import "PromoView.h"
#import <LiCore/LiKitPromotions.h>
#import <LiCore/LiCore.h>



@interface LiSupersonicAdsManager : NSObject
#define LI_SUPER_SONIC_ADS_VERSION @"1.0.3"

@property (nonatomic, strong) Promotion *promo;
@property (nonatomic, strong) PromoView *view;
+ (LiSupersonicAdsManager *) sharedInstance;
- (void) showSupersonicAdsWithPromoView:(PromoView *)view;

/*
    setShowDemoCampaign add to the SupersonicAds request 'demoCampaign=1'
    That, combine with setting the Admin Id at SupersonicAds Dashboard, will allow you to display testing ads.
 */
+(void) setShowDemoCampaign;

@end
