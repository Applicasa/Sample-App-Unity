//
//  SupersonicAdsAdvertiser.h
//  SupersonicAds
//
//  Created by Amit Goldhecht on 1/31/12.
//  Copyright (c) 2012 OnO Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CommonCrypto/CommonDigest.h>

@interface SupersonicAdsAdvertiser : NSObject <NSURLConnectionDelegate>

+ (SupersonicAdsAdvertiser*)sharedSupersonicAds;
- (void)reportAppStartedWithAdvertiserId:(NSString *)advertiserID advertiserPassword:(NSString *)advertiserPassword campaignID:(NSString *)campaignID;

@end
