//
//  SPCallbackSendingOperation.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 12/3/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCallbackSendingOperation : NSOperation

@property (retain) NSString *appId;
@property (retain) NSString *actionId;
@property (retain) NSString *baseURLString;

@property (assign) BOOL answerAlreadyReceived;

@property (assign) BOOL didCallbackSucceed;
@property (assign) int httpStatusCode;

- (id)init;

- (id)initWithAppId:(NSString *)appId
      baseURLString:(NSString *)baseURLString
           actionId:(NSString *)actionId
     answerReceived:(BOOL)answerReceived;

+ (id)operationForAppId:(NSString *)appId
          baseURLString:(NSString *)baseURLString
               actionId:(NSString *)actionId
         answerReceived:(BOOL)answerReceived;

@end
