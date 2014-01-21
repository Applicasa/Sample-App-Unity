//
//  SupersonicAdsPublisher.h
//  SSABrandConnectNoArc
//
//  Created by SSA on 2/22/12.
//  Copyright (c) 2012 SSA Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class SSABCMobile;

@protocol BrandConnectDelegate <NSObject , NSURLConnectionDelegate>
@optional
- (void)brandConnectDidInitWithCampaignInfo:(NSDictionary *)campaignInfo;
- (void)brandConnectDidFailInitWithError:(NSDictionary *)error;
- (void)brandConnectWindowWillOpen;
- (void)brandConnectWindowDidClose;
- (void)brandConnectDidFinishAd:(NSDictionary *)campaignInfo;
- (void)brandConnectNoMoreOffers;
@end



@protocol OfferWallDelegate <NSObject>
@optional
- (void)offerWallDidClose;
@end



@interface SupersonicAdsPublisher : NSObject {
    BOOL noMoreOffersWasCalled;
}

@property (nonatomic, weak) id <BrandConnectDelegate> brandConnectDelegate;
@property (nonatomic, weak) id <OfferWallDelegate> offerWallDelegate;
@property (nonatomic, strong) SSABCMobile *bcMobileObj;
@property (nonatomic, strong) NSString *noInternetConnectionMessage;

+ (SupersonicAdsPublisher *)sharedSupersonicAds;

- (void)initBrandConnectWithApplicationKey:(NSString *)applicationKey userId:(NSString *)userId delegate:(id)delegate additionalParameters:(NSDictionary *)parameters;

- (void)showBrandConnectInParentViewController:(UIViewController *)parentView; /* Can work on both devices */

- (void)showOfferWallWithApplicationKey:(NSString *)applicationKey userId:(NSString *)userId delegate:(id)delegate shouldGetLocation:(BOOL)getLocation extraParameters:(NSDictionary *)parameters parentViewController:(UIViewController *)parentView;

- (int)getNextCampaignCredits; /* works only for SDK version 4 and above*/


@end
