//
//  SPLogger.h
//  SponsoPay iOS SDK
//
//  Created by David Davila on 8/21/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLogger : NSObject

+ (SPLogger *)defaultLogger;

@property BOOL shouldOutputToSystemLog;
@property BOOL shouldBufferLogMessages;
@property (readonly) NSString *bufferedMessagesString;

- (void)log:(NSString *)format, ...;

- (void)logFormat:(NSString *)format arguments:(va_list)arguments;

- (void)shutUp;

+ (void)log:(NSString *)format, ...;

@end
