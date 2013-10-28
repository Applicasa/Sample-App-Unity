//
//  SPMediationCoordinator.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 5/16/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../AdNetworkSettings.h"
#import "SPTPNMediationTypes.h"

@interface SPMediationCoordinator : NSObject

@property (retain) UIViewController *hostViewController;

- (void)startThirdPartySDKs;

- (BOOL)providerAvailable:(NSString *)providerKey;
- (void)videosFromProvider:(NSString *)providerKey available:(SPTPNValidationResultBlock)callback;
- (void)playVideoFromProvider:(NSString *)providerKey eventsCallback:(SPTPNVideoEventsHandlerBlock)eventsCallback;

@end
