//
//  SPLocaleParameterProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/2/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPLocaleParametersProvider.h"

static NSString *const kSPURLParamKeyLanguage = @"language";

@implementation SPLocaleParametersProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    NSDictionary *localeParameters = @{kSPURLParamKeyLanguage : [[NSLocale currentLocale] localeIdentifier]};
    
    return localeParameters;
}

@end
