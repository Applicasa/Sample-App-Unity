//
//  SPSystemVersionChecker.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 6/11/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSystemVersionChecker : NSObject

+ (BOOL)runningOniOS5OrNewer;
+ (BOOL)runningOniOS6OrNewer;
+ (BOOL)runningOniOS7OrNewer;
+ (BOOL)checkForiOSVersion:(NSString *)versionString;
@end
