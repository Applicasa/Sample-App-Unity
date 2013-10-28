//
//  SPFlurryAdapter.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 6/17/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPFlurryAdapter.h"
#import "../AdNetworkSettings.h"

static const NSInteger kFlurryNoAdsErrorCode = 104;

@interface SPFlurryAdapter()

@property (assign) BOOL flurrySDKInitialized;
@property (copy) SPTPNValidationResultBlock validationResultsBlock;

@property (copy) SPTPNVideoEventsHandlerBlock videoEventsCallback; // TODO: move up
@property (assign, nonatomic) SPTPNProviderPlayingState playingState; // TODO: move up

@property (assign) BOOL playingDidTimeout;
@property (readonly, nonatomic) UIWindow *mainWindow;

@end

@implementation SPFlurryAdapter

- (id)initWithAPIKey:(NSString *)APIKey
       videoAdsSpace:(NSString *)videoAdsSpace
{
    self = [super init];
    if (self) {
        self.flurryAPIKey = APIKey;
        self.videoAdsSpace = videoAdsSpace;
    }
    return self;
}

- (NSString *)providerName
{
    return @"flurryappcircleclips";
}

- (void)startProvider
{
#ifdef SPFlurrySDKAvailable_4_2_1
    if (!self.flurrySDKInitialized) {
        [SPLogger log:@"Initializing Flurry SDK"];
        [Flurry startSession:self.flurryAPIKey];
        [FlurryAds initialize:self.mainWindow.rootViewController];
        [FlurryAds setAdDelegate:self];
    }
#endif
}

- (void)videosAvailable:(SPTPNValidationResultBlock)callback
{
#ifdef SPFlurrySDKAvailable_4_2_1
    if ([FlurryAds adReadyForSpace:self.videoAdsSpace]) {
        self.validationResultsBlock = nil;
        callback(self.providerName, SPTPNValidationSuccess);
    } else {
        self.validationResultsBlock = callback;
        [self fetchFlurryAd];
        [self startValidationTimeoutChecker];
    }
#endif
}

- (void)fetchFlurryAd
{
#ifdef SPFlurrySDKAvailable_4_2_1
    [FlurryAds fetchAdForSpace:self.videoAdsSpace
                         frame:self.mainWindow.rootViewController.view.frame
                          size:FULLSCREEN];
#endif
}

- (void)startValidationTimeoutChecker
{
    void(^timeoutBlock)(void) = ^(void) {
        if (self.validating) {
            [self notifyOfValidationResult:SPTPNValidationTimeout];
        }
    };
    // TODO: move up
    double delayInSeconds = SPTPNTimeoutInterval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), timeoutBlock);
}


- (void)playVideoWithParentViewController:(UIViewController *)parentVC
                        notifyingCallback:(SPTPNVideoEventsHandlerBlock)eventsCallback
{
#ifdef SPFlurrySDKAvailable_4_2_1
    self.videoEventsCallback = eventsCallback;
    self.playingState = SPTPNProviderPlayingStateWaitingForPlayStart;

    [FlurryAds displayAdForSpace:self.videoAdsSpace
        modallyForViewController:parentVC];

    [self startPlayingTimeoutChecker];
#endif
}

- (void)startPlayingTimeoutChecker
{
    self.playingDidTimeout = NO;

    void(^timeoutBlock)(void) = ^(void) {
        if (self.playingState == SPTPNProviderPlayingStateWaitingForPlayStart) {
            self.playingDidTimeout = YES;
            self.playingState = SPTPNProviderPlayingStateNotPlaying;
            self.videoEventsCallback(self.providerName, SPTPNVideoEventTimeout);
        }
    };

    double delayInSeconds = SPTPNTimeoutInterval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), timeoutBlock);
}

- (UIWindow *)mainWindow
{
    return [UIApplication sharedApplication].windows[0];
}

#pragma mark - FlurryAdDelegate protocol implementation
#ifdef SPFlurrySDKAvailable_4_2_1

- (void)spaceDidReceiveAd:(NSString*)adSpace
{
    if ([self isThisAdSpace:adSpace])
        if (self.validating)
            [self notifyOfValidationResult:SPTPNValidationSuccess];
}

- (void)spaceDidFailToReceiveAd:(NSString *)adSpace error:(NSError *)error
{
    if ([self isThisAdSpace:adSpace]) {
        [SPLogger log:@"Flurry's callback invoked: %s %@", __PRETTY_FUNCTION__, error];

        if (self.validating) {
            SPTPNValidationResult validationResult =
            (error.code == kFlurryNoAdsErrorCode ? SPTPNValidationNoVideoAvailable : SPTPNValidationError);
            [self notifyOfValidationResult:validationResult];
        }
    }
}

- (BOOL)spaceShouldDisplay:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    if ([self isThisAdSpace:adSpace]) {
        if (self.playingDidTimeout) {
            return NO;
        } else {
            self.playingState = SPTPNProviderPlayingStatePlaying;
            self.videoEventsCallback(self.providerName, SPTPNVideoEventStarted);
            return YES;
        }
    }

    return YES;
}

- (void)spaceDidFailToRender:(NSString *)adSpace error:(NSError *)error
{
    if ([self isThisAdSpace:adSpace])
        if (self.playingState != SPTPNProviderPlayingStateNotPlaying)
            self.videoEventsCallback(self.providerName, SPTPNVideoEventError);
}

- (void)videoDidFinish:(NSString *)adSpace
{
    if (self.playingState == SPTPNProviderPlayingStatePlaying) {
        self.playingState = SPTPNProviderPlayingStateNotPlaying;
        self.videoEventsCallback(self.providerName, SPTPNVideoEventFinished);
    }
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial
{
    if (self.playingState == SPTPNProviderPlayingStatePlaying) {
        self.playingState = SPTPNProviderPlayingStateNotPlaying;
        self.videoEventsCallback(self.providerName, SPTPNVideoEventAborted);
    } else {
        self.videoEventsCallback(self.providerName, SPTPNVideoEventClosed);
    }
}

- (void)spaceWillLeaveApplication:(NSString *)adSpace
{

}

- (void)spaceWillExpand:(NSString *)adSpace
{

}

- (void)spaceWillCollapse:(NSString *)adSpace
{

}

- (void)spaceDidCollapse:(NSString *)adSpace
{

}

- (void)spaceDidReceiveClick:(NSString *)adSpace
{

}

#endif
#pragma mark -

- (BOOL)validating
{
    return self.validationResultsBlock != nil;
}

- (void)notifyOfValidationResult:(SPTPNValidationResult)result
{
    if (self.validationResultsBlock) {
        self.validationResultsBlock(self.providerName, result);
        self.validationResultsBlock = nil;
    }
}

- (BOOL)isThisAdSpace:(NSString *)adSpace
{
    return [self.videoAdsSpace isEqualToString:adSpace];
}
@end
