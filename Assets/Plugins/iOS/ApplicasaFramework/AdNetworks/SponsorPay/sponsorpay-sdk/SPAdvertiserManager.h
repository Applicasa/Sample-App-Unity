//
//  SPAdvertiserManager.h
//  SponsorPay iOS SDK
//
//  Copyright 2011-2013 SponsorPay. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SPPersistence.h"

/**
 * Singleton for reporting offers to the SponsorPay server.
 */
@interface SPAdvertiserManager : NSObject

+ (SPAdvertiserManager *)advertiserManagerForAppId:(NSString *)appId;

- (void)reportOfferCompleted;

- (void)reportActionCompleted:(NSString *)actionId;

+ (void)overrideBaseURLWithURLString:(NSString *)newURLString;
+ (void)restoreBaseURLToDefault;

@end
