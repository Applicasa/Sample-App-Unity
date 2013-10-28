//
//  SPActionIdValidator.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 12/6/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPActionIdValidator.h"

@implementation SPActionIdValidator

+ (BOOL)validate:(NSString *)actionId reasonForInvalid:(NSString **)reason
{
    if (!actionId) {
        *reason = @"actionId must not be nil";
        return NO;
    }
    if (!actionId.length) {
        *reason = @"actionId must not be empty";
        return NO;
    }

    NSError *error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z0-9_]+$"
                                                                            options:0
                                                                              error:&error];
    NSRange fullStringRange = NSMakeRange(0, actionId.length);
    
    NSRange matchRange = [regexp rangeOfFirstMatchInString:actionId
                                                   options:0
                                                     range:fullStringRange];

    BOOL matchSuccess = (matchRange.length == fullStringRange.length);
    
    if (!matchSuccess) {
        *reason = @"actionId must consist exclusively of uppercase latin characters, numbers and the underscore symbol (_)";
    }
    
    return matchSuccess;
}

+ (void)validateOrThrow:(NSString *)actionId
{
    NSString *exceptionReason = nil;
    if (![self validate:actionId reasonForInvalid:&exceptionReason]) {
         [NSException exceptionWithName:@"SPInvalidActionIdException"
                                       reason:exceptionReason
                                     userInfo:nil];
    }
}

@end
