//
//  SPAppIdValidator.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/26/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import "SPAppIdValidator.h"

@implementation SPAppIdValidator

+ (void)validateOrThrow:(NSString *)appId;
{
    if (!appId || [appId isEqualToString:@""] || [appId isEqualToString:@"0"]) {
        NSString *invalidAppIdReason = [NSString stringWithFormat:
                                        @"A valid App ID must be specified ('%@' was provided)", appId];
        
        @throw [NSException exceptionWithName:@"SPInvalidAppIdException"
                                       reason:invalidAppIdReason
                                     userInfo:nil];
    }
}
@end
