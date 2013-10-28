//
//  SPTPNMediationTypes.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 6/13/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SPTPNValidationNoVideoAvailable,
    SPTPNValidationTimeout,
    SPTPNValidationNetworkError,
    SPTPNValidationDiskError,
    SPTPNValidationError,
    SPTPNValidationSuccess
} SPTPNValidationResult;

NSString *SPTPNValidationResultToString(SPTPNValidationResult validationResult);

typedef enum {
    SPTPNVideoEventStarted,
    SPTPNVideoEventAborted,
    SPTPNVideoEventFinished,
    SPTPNVideoEventClosed,
    SPTPNVideoEventNoVideo,
    SPTPNVideoEventTimeout,
    SPTPNVideoEventError
} SPTPNVideoEvent;

NSString *SPTPNVideoEventToString(SPTPNVideoEvent event);

typedef void (^SPTPNValidationResultBlock)(NSString *tpnKey, SPTPNValidationResult validationResult);
typedef void (^SPTPNVideoEventsHandlerBlock)(NSString *tpnKey, SPTPNVideoEvent event);
