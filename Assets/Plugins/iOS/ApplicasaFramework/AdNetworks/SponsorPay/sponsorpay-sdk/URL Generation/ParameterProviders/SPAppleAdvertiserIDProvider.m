//
//  SPAppleAdvertiserIDProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/2/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPAppleAdvertiserIDProvider.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#import <AdSupport/ASIdentifierManager.h>
#endif

static NSString *const kSPURLParamKeyAdvertiserId = @"apple_idfa";
static NSString *const kSPURLParamKeyAdvertiserIdTrackingEnabled = @"apple_idfa_tracking_enabled";

@implementation SPAppleAdvertiserIDProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    NSString *idfaValue = @"";
    NSString *idfaTrackingEnabled = @"";
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    if (NSClassFromString(@"ASIdentifierManager")){
        NSUUID *advertiserId = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        if (advertiserId) {
            idfaValue = [advertiserId UUIDString];
        }
        idfaTrackingEnabled = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled] ? @"true" : @"false";
    }
#endif
    
    NSDictionary *advertiserIDParams = @{
    kSPURLParamKeyAdvertiserId : idfaValue,
    kSPURLParamKeyAdvertiserIdTrackingEnabled : idfaTrackingEnabled
    };
    
    return advertiserIDParams;
}

@end
