//
//  SPTPNMediationTypes.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 6/13/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPTPNMediationTypes.h"

NSString *SPTPNValidationResultToString(SPTPNValidationResult validationResult)
{
    NSString *validationResultToString;
    switch (validationResult) {
        case SPTPNValidationNoVideoAvailable:
            validationResultToString = @"no_video";
            break;
        case SPTPNValidationTimeout:
            validationResultToString = @"timeout";
            break;
        case SPTPNValidationNetworkError:
            validationResultToString = @"network_error";
            break;
        case SPTPNValidationDiskError:
            validationResultToString = @"disk_error";
            break;
        case SPTPNValidationError:
            validationResultToString = @"error";
            break;
        case SPTPNValidationSuccess:
            validationResultToString = @"success";
            break;
    }
    return validationResultToString;
}

NSString *SPTPNVideoEventToString(SPTPNVideoEvent event)
{
    NSString *videoEventToString;
    switch (event) {
        case SPTPNVideoEventStarted:
            videoEventToString = @"started";
            break;
        case SPTPNVideoEventAborted:
            videoEventToString = @"aborted";
            break;
        case SPTPNVideoEventFinished:
            videoEventToString = @"finished";
            break;
        case SPTPNVideoEventClosed:
            videoEventToString = @"closed";
            break;
        case SPTPNVideoEventNoVideo:
            videoEventToString = @"no_video";
            break;
        case SPTPNVideoEventTimeout:
            videoEventToString = @"timeout";
            break;
        case SPTPNVideoEventError:
            videoEventToString = @"error";
            break;
    }
    return videoEventToString;
}
