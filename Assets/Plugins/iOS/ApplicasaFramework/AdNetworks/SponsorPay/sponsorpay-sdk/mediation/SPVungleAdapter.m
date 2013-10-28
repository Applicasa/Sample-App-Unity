//
//  SPVungleAdapter.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 5/30/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPVungleAdapter.h"
#import "SPLogger.h"

@interface SPVungleAdapter()

@property (retain) NSString *appId;

@property (assign) BOOL vungleSDKInitialized;
@property (assign) SPTPNProviderPlayingState playingState;
@property (assign) BOOL videoDidPlayFull;
@property (copy) SPTPNVideoEventsHandlerBlock videoEventsCallback;

#ifdef SPVungleSDKAvailable_1_3_2
@property (assign) VGStatus lastReportedVungleStatus;
#endif

@end

@implementation SPVungleAdapter

- (id)initWithAppId:(id)appId
{
    self = [super init];

    if (self)
        self.appId = appId;

    return self;
}

- (NSString *)providerName
{
    return @"vungle";
}

- (void)startProvider
{
#ifdef SPVungleSDKAvailable_1_3_2

    if (!self.vungleSDKInitialized) {
        [SPLogger log:@"Initializing Vungle SDK"];

        [VGVunglePub startWithPubAppID:self.appId];
        [VGVunglePub setDelegate:self];

        self.vungleSDKInitialized = YES;
    }
#endif
}

- (void)videosAvailable:(SPTPNValidationResultBlock)callback
{
#ifdef SPVungleSDKAvailable_1_3_2
    SPTPNValidationResult validationResult;

    switch(self.lastReportedVungleStatus) {
        case VGStatusNetworkError:
            validationResult = SPTPNValidationNetworkError;
            break;
        case VGStatusDiskError:
            validationResult = SPTPNValidationDiskError;
            break;
        default:
        case VGStatusOkay:
            validationResult = [VGVunglePub adIsAvailable] ? SPTPNValidationSuccess : SPTPNValidationNoVideoAvailable;
            break;
    }

    callback(self.providerName, validationResult);
#endif
}

- (void)playVideoWithParentViewController:(UIViewController *)parentVC
                        notifyingCallback:(SPTPNVideoEventsHandlerBlock)eventsCallback
{
#ifdef SPVungleSDKAvailable_1_3_2
    self.videoDidPlayFull = NO;
    self.videoEventsCallback = eventsCallback;
    [VGVunglePub playIncentivizedAd:parentVC animated:YES showClose:NO userTag:nil];
    self.playingState = SPTPNProviderPlayingStateWaitingForPlayStart;
#endif
}

#pragma mark - VGVunglePubDelegate protocol implementation

#ifdef SPVungleSDKAvailable_1_3_2

// Called immedediately before Vungle's ad view controller appears.
// It's the closest we have to the video started event
- (void)vungleViewWillAppear:(UIViewController *)viewController
{
    [SPLogger log:@"%s", __PRETTY_FUNCTION__];
    self.videoEventsCallback(self.providerName, SPTPNVideoEventStarted);
    self.playingState = SPTPNProviderPlayingStatePlaying;
}

// Called when a video ad has finished playing
- (void)vungleMoviePlayed:(VGPlayData *)playData
{
    [SPLogger log:@"%s", __PRETTY_FUNCTION__];

    self.videoDidPlayFull = playData.playedFull;

    SPTPNVideoEvent event = self.videoDidPlayFull ? SPTPNVideoEventFinished : SPTPNVideoEventAborted;
    self.videoEventsCallback(self.providerName, event);
    self.playingState = SPTPNProviderPlayingStateNotPlaying;
}

- (void)vungleViewDidDisappear:(UIViewController *)viewController
{
    [SPLogger log:@"%s", __PRETTY_FUNCTION__];
    if (self.videoDidPlayFull)
        self.videoEventsCallback(self.providerName, SPTPNVideoEventClosed);
}

- (void)vungleStatusUpdate:(VGStatusData *)statusData
{
    VGStatus vungleStatus = statusData.status;

    self.lastReportedVungleStatus = vungleStatus;

    BOOL vungleStatusIsError =
    vungleStatus == SPTPNValidationNetworkError || statusData.status == SPTPNValidationDiskError;

    if (vungleStatusIsError) {
        BOOL isPlayingOrWaitingToPlay =
        self.playingState == SPTPNProviderPlayingStateWaitingForPlayStart
        || self.playingState == SPTPNProviderPlayingStatePlaying;
        if (isPlayingOrWaitingToPlay) {
            self.videoEventsCallback(self.providerName, SPTPNVideoEventError);
        }
    }
}

#endif

@end
