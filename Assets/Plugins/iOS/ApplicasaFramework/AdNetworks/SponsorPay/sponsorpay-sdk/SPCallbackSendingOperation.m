//
//  SPCallbackSendingOperation.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 12/3/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPCallbackSendingOperation.h"
#import "SPURLGenerator.h"
#import "Utils/SPLogger.h"

static const NSTimeInterval SPCallbackOperationTimeout = 60.0;
static NSString *const SPURLParamKeySuccessfulAnswerReceived = @"answer_received";
static NSString *const SPURLParameterKeyActionId = @"action_id";

@implementation SPCallbackSendingOperation

- (void)main
{
    if (self.isCancelled) {
        return;
    }

    @autoreleasepool {
        NSURL *callbackURL = [self callbackURL];

        [SPLogger log:@"%@ will send callback on thread: %@ using url:\n%@", self, [NSThread currentThread], callbackURL];

        if (!callbackURL) {
            self.didCallbackSucceed = NO;
            [SPLogger log:@"%@ failed to send callback due to a nil NSURL", self];
            return;
        }

        NSURLRequest *request=[NSURLRequest requestWithURL:callbackURL
                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                           timeoutInterval:SPCallbackOperationTimeout];

        NSHTTPURLResponse *response = nil;
        NSError *requestError = nil;

        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];

        if (requestError) {
            self.didCallbackSucceed = NO;
            [SPLogger log:@"Callback request failed with error: %@", requestError];

            return;
        }

        [SPLogger log:@"%@ received response to callback with status code: %d", self, response.statusCode];
        
        self.httpStatusCode = response.statusCode;
        self.didCallbackSucceed = self.httpStatusCode == 200;
    }
}

- (NSURL *)callbackURL
{
    SPURLGenerator *urlGenerator = [SPURLGenerator URLGeneratorWithBaseURLString:self.baseURLString];
    
    [urlGenerator setAppID:self.appId];
    
    [urlGenerator setParameterWithKey:SPURLParamKeySuccessfulAnswerReceived
                          stringValue:self.answerAlreadyReceived ? @"1" : @"0"];
    
    if (self.actionId) {
        [urlGenerator setParameterWithKey:SPURLParameterKeyActionId
                              stringValue:self.actionId];
    }
    
    return [urlGenerator generatedURL];
}

- (id)init
{
    self = [super init];
    return self;
}

- (id)initWithAppId:(NSString *)appId
      baseURLString:(NSString *)baseURLString
           actionId:(NSString *)actionId
     answerReceived:(BOOL)answerReceived
{
    self = [self init];
    
    if (self) {
        self.appId = appId;
        self.baseURLString = baseURLString;
        self.actionId = actionId;
        self.answerAlreadyReceived = answerReceived;
    }
    
    return self;

}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ {appId = %@ actionId = %@ "
            "answerAlreadyReceived = %d}",
            [super description], self.appId, self.actionId,
            self.answerAlreadyReceived];
}

- (void)dealloc
{
    self.appId = nil;
    self.baseURLString = nil;
    self.actionId = nil;
    [super dealloc];
}

+ (id)operationForAppId:(NSString *)appId
          baseURLString:(NSString *)baseURLString
               actionId:(NSString *)actionId
         answerReceived:(BOOL)answerReceived
{
    SPCallbackSendingOperation *operation =
    [[SPCallbackSendingOperation alloc] initWithAppId:appId
                                        baseURLString:baseURLString
                                             actionId:actionId
                                       answerReceived:answerReceived];

    return [operation autorelease];
}
@end
