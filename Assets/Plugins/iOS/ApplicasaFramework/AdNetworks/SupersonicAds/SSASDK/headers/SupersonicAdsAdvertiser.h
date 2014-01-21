//
//  SupersonicAdsAdvertiser.h
//  SupersonicAds
//
//  Created by SSA on 1/31/12.
//  Copyright (c) 2012 SSA All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SupersonicAdsAdvertiser : NSObject <NSURLConnectionDelegate>

+ (SupersonicAdsAdvertiser*)sharedSupersonicAds;

- (void)reportAppStartedWithAdvertiserId:(NSString *)advertiserID advertiserPassword:(NSString *)advertiserPassword campaignID:(NSString *)campaignID;

@end
