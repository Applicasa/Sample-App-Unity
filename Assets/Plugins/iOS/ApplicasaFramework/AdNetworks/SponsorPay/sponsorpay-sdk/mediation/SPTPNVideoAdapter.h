//
//  SPTPNVideoAdapter.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 5/17/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTPNMediationTypes.h"
#import <UIKit/UIKit.h>

#define SPTPNTimeoutInterval ((NSTimeInterval)4.5)

@protocol SPTPNVideoAdapter <NSObject>

- (NSString *)providerName;
- (void)startProvider;
- (void)videosAvailable:(SPTPNValidationResultBlock)callback;
- (void)playVideoWithParentViewController:(UIViewController *)parentVC
                        notifyingCallback:(SPTPNVideoEventsHandlerBlock)eventsCallback;

@end

typedef enum {
    SPTPNProviderPlayingStateNotPlaying,
    SPTPNProviderPlayingStateWaitingForPlayStart,
    SPTPNProviderPlayingStatePlaying

} SPTPNProviderPlayingState;