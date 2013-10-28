//
//  SPHostAppBundleParametersProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/2/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPHostAppBundleParametersProvider.h"

static NSString *const kSPURLParamKeyAppBundleName = @"app_bundle_name";
static NSString *const kSPURLParamKeyAppBundleVersion = @"app_version";

@implementation SPHostAppBundleParametersProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    NSString *appBundleName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!appVersion) {
        appVersion = @"";
    }
    
    NSDictionary *hostAppBundleParams = @{
    kSPURLParamKeyAppBundleName : appBundleName,
    kSPURLParamKeyAppBundleVersion : appVersion
    };
    
    return hostAppBundleParams;
}

@end
