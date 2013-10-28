//
//  SPSHA1MacAddressProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/1/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPSHA1MacAddressProvider.h"
#import "SPSignature.h"

static NSString *const kSPURLParamKeyMACAddressSHA1 = @"sha1_mac";

@implementation SPSHA1MacAddressProvider

@synthesize macAddressSHA1 =_macAddressSHA1;

- (NSString *)macAddressSHA1 {
    if (!_macAddressSHA1)
        _macAddressSHA1 = [[self calculateMACAddressSHA1] retain];

    return _macAddressSHA1;
}

- (NSString *)calculateMACAddressSHA1 {
    if ([self.macAddressPlain isEqualToString:@""])
        return @"";
    else
        return [SPSignature formattedSHA1forString:self.macAddressPlain];
}


- (void)dealloc {
    [_macAddressSHA1 release];
    [super dealloc];
}

- (NSDictionary *)dictionaryWithKeyValueParameters {
    return [NSDictionary dictionaryWithObject:self.macAddressSHA1 forKey:kSPURLParamKeyMACAddressSHA1];
}

@end

