//
//  SPSystemVersionChecker.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 6/11/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPSystemVersionChecker.h"

@implementation SPSystemVersionChecker

+ (BOOL)runningOniOS5OrNewer
{
    static BOOL didCacheResult = NO, cachedResult;

    if (!didCacheResult) {
        cachedResult = [self checkForiOSVersion:@"5.0"];
        didCacheResult = YES;
    }

    return cachedResult;
}

+ (BOOL)runningOniOS6OrNewer
{
    static BOOL didCacheResult = NO, cachedResult;

    if (!didCacheResult) {
        cachedResult = [self checkForiOSVersion:@"6.0"];
        didCacheResult = YES;
    }

    return cachedResult;
}

+ (BOOL)runningOniOS7OrNewer
{
    static BOOL didCacheResult = NO, cachedResult;

    if (!didCacheResult) {
        cachedResult = [self checkForiOSVersion:@"7.0"];
        didCacheResult = YES;
    }

    return cachedResult;
}


+ (BOOL)checkForiOSVersion:(NSString *)versionString
{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    return ([currSysVer compare:versionString options:NSNumericSearch] != NSOrderedAscending);
}

@end

