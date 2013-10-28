//
//  SPActionIdValidator.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 12/6/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPActionIdValidator : NSObject

+ (BOOL)validate:(NSString *)actionId reasonForInvalid:(NSString **)reason;

+ (void)validateOrThrow:(NSString *)actionId;

@end
