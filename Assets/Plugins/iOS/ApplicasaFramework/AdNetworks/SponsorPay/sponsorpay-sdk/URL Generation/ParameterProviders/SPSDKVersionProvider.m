//
//  SPSDKVersionProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/3/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPSDKVersionProvider.h"
#import "../../SP_SDK_versions.h"

static NSString *const kSPURLParamKeySDKVersion = @"sdk_version";

@implementation SPSDKVersionProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    NSString *sdkVersionString = [NSString stringWithFormat:@"%d.%d.%d",
                                  SP_SDK_MAJOR_RELEASE_VERSION_NUMBER,
                                  SP_SDK_MINOR_RELEASE_VERSION_NUMBER,
                                  SP_SDK_FIX_RELEASE_VERSION_NUMBER];
    
    NSDictionary *versionParameters = @{ kSPURLParamKeySDKVersion : sdkVersionString };
    
    return versionParameters;
}

@end
