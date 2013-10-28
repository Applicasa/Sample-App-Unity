//
//  SPMD5MacAddressProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/1/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPMD5MacAddressProvider.h"
#import "SPSignature.h"

static NSString *const kSPURLParamKeyMACAdressMD5 = @"md5_mac";

@implementation SPMD5MacAddressProvider

@synthesize macAddressMD5 = _macAddressMD5;

- (NSString *)macAddressMD5 {
    if (!_macAddressMD5)
        _macAddressMD5 = [[self calculateMACAddressMD5] retain];
    
    return _macAddressMD5;
}

- (NSString *)calculateMACAddressMD5 {
    if ([self.macAddressPlain isEqualToString:@""])
        return @"";
    else
        return [SPSignature formattedMD5forString:self.macAddressPlain];
}

- (void)dealloc {
    [_macAddressMD5 release];
    [super dealloc];
}

- (NSDictionary *)dictionaryWithKeyValueParameters {
    return [NSDictionary dictionaryWithObject:self.macAddressMD5 forKey:kSPURLParamKeyMACAdressMD5];
}

@end
