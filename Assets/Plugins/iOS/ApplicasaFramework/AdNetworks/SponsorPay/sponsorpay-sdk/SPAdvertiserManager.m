//
//  SPAdvertiserManager.m
//  SponsorPay iOS SDK
//
//  Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <UIKit/UIDevice.h>
#import "SPAdvertiserManager.h"
#import "SPCallbackSendingOperation.h"
#import "SPURLGenerator.h"
#import "SPAppIdValidator.h"
#import "SP_SDK_versions.h"
#import "Utils/SPLogger.h"

#define CALLBACK_BASE_URL  @"https://service.sponsorpay.com"

static const NSInteger SPMaxConcurrentCallbackOperations = 1;

// Base URL for the advertiser callback
static NSString *callbackBaseURL = CALLBACK_BASE_URL;
static NSString *const installCallbackURLPath = @"/installs/v2";
static NSString *const actionsCallbackURLPath = @"/actions/v2";

static NSOperationQueue *callbackOperationQueue = nil;

@interface SPAdvertiserManager()

@property (retain) NSString *appId;

- initWithAppId:(NSString *)appId;
- (void)sendCallbackWithAction:(NSString *)actionId;

@end

@implementation SPAdvertiserManager

#pragma mark - Initialization and deallocation

+ (SPAdvertiserManager *)advertiserManagerForAppId:(NSString *)appId
{
    static NSMutableDictionary *advertiserManagers;
    
    @synchronized(self)
    {
        if (!advertiserManagers) {
            advertiserManagers = [[NSMutableDictionary alloc] initWithCapacity:2];
        }
        
        if (!advertiserManagers[appId]) {
            SPAdvertiserManager *adManagerForThisAppId = [[self alloc] initWithAppId:appId];
            advertiserManagers[appId] = adManagerForThisAppId;
            [adManagerForThisAppId release];
        }
    }
    
    return advertiserManagers[appId];
}

- (id)initWithAppId:(NSString *)appId
{
	self = [super init];
    
    if (self) {
        self.appId = appId;
    }
    
    return self;
}

- (void)dealloc
{
    self.appId = nil;
    [super dealloc];
}

#pragma mark - Advertiser callback delivery

- (void)reportOfferCompleted
{
    [SPAppIdValidator validateOrThrow:self.appId];
    [self sendCallbackWithAction:nil];
}

- (void)reportActionCompleted:(NSString *)actionId
{
    [SPAppIdValidator validateOrThrow:self.appId];
    [self sendCallbackWithAction:actionId];
}

- (void)sendCallbackWithAction:(NSString *)actionId
{
    // nil action means standard advertiser start up callback
    
    NSString *callbackURLPath;
    BOOL answerAlreadyReceived;
    void (^callbackSuccessfulCompletionBlock)(void);

    if (!actionId) {
        callbackURLPath = installCallbackURLPath;
        answerAlreadyReceived = [SPPersistence didAdvertiserCallbackSucceed];
        callbackSuccessfulCompletionBlock = ^{
            [SPPersistence setDidAdvertiserCallbackSucceed:YES];
        };
    } else {
        callbackURLPath = actionsCallbackURLPath;
        answerAlreadyReceived = [SPPersistence didActionCallbackSucceedForActionId:actionId];
        callbackSuccessfulCompletionBlock = ^{
            [SPPersistence setDidActionCallbackSucceed:YES
                                           forActionId:actionId];
        };
    }
    
    [callbackBaseURL stringByAppendingString: (actionId ? actionsCallbackURLPath : installCallbackURLPath) ];
    
    SPCallbackSendingOperation *callbackOperation =
    [SPCallbackSendingOperation operationForAppId:self.appId
                                    baseURLString:[callbackBaseURL stringByAppendingString:callbackURLPath]
                                         actionId:actionId
                                   answerReceived:answerAlreadyReceived];

    [callbackOperation setCompletionBlock:^{
        if (callbackOperation.didCallbackSucceed) {
            callbackSuccessfulCompletionBlock();
        }
    }];
    
    [self performCallbackSendingOperation:callbackOperation];
}

- (void)performCallbackSendingOperation:(SPCallbackSendingOperation *)callbackOperation
{
    [SPLogger log:@"%@ scheduling callback sending operation from thread:%@", self, [NSThread currentThread]];
    [[SPAdvertiserManager callbackOperationQueue] addOperation:callbackOperation];
}

#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ {appID = %@}", [super description], self.appId];
}

+ (NSOperationQueue *)callbackOperationQueue
{
    @synchronized(self) {
        if (!callbackOperationQueue) {
            callbackOperationQueue = [[NSOperationQueue alloc] init];
            [callbackOperationQueue setMaxConcurrentOperationCount:SPMaxConcurrentCallbackOperations];
        }
    }
    return callbackOperationQueue;
}

#pragma mark - Base URL management

+ (void)overrideBaseURLWithURLString:(NSString *)newUrl {
    [callbackBaseURL release];
    callbackBaseURL = [newUrl retain];
}

+ (void)restoreBaseURLToDefault {
    [SPAdvertiserManager overrideBaseURLWithURLString:CALLBACK_BASE_URL];
}

@end
