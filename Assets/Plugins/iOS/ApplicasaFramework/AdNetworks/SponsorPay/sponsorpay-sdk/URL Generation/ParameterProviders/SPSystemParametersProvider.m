//
//  SPSystemParametersProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/2/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPSystemParametersProvider.h"

static NSString *const kSPURLParamKeyOSName = @"os_name";
static NSString *const kSPURLParamKeyOSVersion = @"os_version";
static NSString *const kSPURLParamKeyPhoneModel = @"phone_model";
static NSString *const kSPURLParamKeyManufacturer = @"manufacturer";
static NSString *const kSPURLParamValueManufacturerApple = @"Apple Inc.";

@implementation SPSystemParametersProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    UIDevice *device = [UIDevice currentDevice];
    
    NSDictionary *systemParametersDictionary = @{
    kSPURLParamKeyOSName : device.systemName,
    kSPURLParamKeyOSVersion : device.systemVersion,
    kSPURLParamKeyPhoneModel : device.model,
    kSPURLParamKeyManufacturer : kSPURLParamValueManufacturerApple
    };
    
    return systemParametersDictionary;
}

@end
