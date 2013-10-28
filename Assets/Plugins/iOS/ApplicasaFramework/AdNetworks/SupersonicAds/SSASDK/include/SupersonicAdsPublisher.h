//
//  SupersonicAdsPublisher.h
//  SSABrandConnectNoArc
//
//  Created by orr kowarsky on 2/22/12.
//  Copyright (c) 2012 Orr Kowarsky Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@class SupersonicAdsViewController;

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

@interface SupersonicAdsPublisher : NSObject

@property (nonatomic, assign) id <BrandConnectDelegate> brandConnectDelegate;
@property (nonatomic, assign) id <OfferWallDelegate> offerWallDelegate;

+ (SupersonicAdsPublisher *)sharedSupersonicAds;

- (void)initBrandConnectWithApplicationKey:(NSString *)applicationKey userId:(NSString *)userId delegate:(id)delegate additionalParameters:(NSDictionary *)parameters;

/* Can work on both devices */
- (void)showBrandConnect:(UIViewController *)parentView;

- (void)showOfferWallWithApplicationKey:(NSString *)applicationKey userId:(NSString *)userId delegate:(id)delegate shouldGetLocation:(BOOL)getLocation extraParameters:(NSDictionary *)parameters parentView:(UIViewController *)parentView;

@end

