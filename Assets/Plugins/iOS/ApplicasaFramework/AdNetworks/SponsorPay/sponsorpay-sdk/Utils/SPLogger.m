//
//  SPLogger.m
//  SponsoPay iOS SDK
//
//  Created by David Davila on 8/21/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPLogger.h"
#define kSPLoggerBufferedMessagesStringPropertyName @"bufferedMessagesString"

static SPLogger *__defaultSPLogger;

@interface SPLogger ()

@property (readonly) NSDateFormatter *dateFormatter;

- (void)sendFormatToSystemLog:(NSString *)format arguments:(va_list)arguments;
- (void)addFormatToLogBuffer:(NSString *)format arguments:(va_list)arguments;

@end

@implementation SPLogger
{
    NSMutableString *_logMessagesBuffer;
    NSDateFormatter *_dateFormatter;
}
@synthesize shouldOutputToSystemLog;
@synthesize shouldBufferLogMessages;

- (NSString *)bufferedMessagesString
{
    if (_logMessagesBuffer) {
        return [NSString stringWithString:_logMessagesBuffer];
    }
    return nil;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"HH:mm:ss"];

    }
    return _dateFormatter;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.shouldOutputToSystemLog = NO;
        self.shouldBufferLogMessages = NO;
    }
    return self;
}

- (void)dealloc
{
    [_logMessagesBuffer release];
    _logMessagesBuffer = nil;
    [_dateFormatter release];
    _dateFormatter = nil;
    [super dealloc];
}

- (void)logFormat:(NSString *)format arguments:(va_list)arguments
{
    NSString *wrappedFormat = [NSString stringWithFormat: @"[SP]: %@\n", format];
    
    if (self.shouldOutputToSystemLog) {
        [self sendFormatToSystemLog:wrappedFormat arguments:arguments];
    }
    if (self.shouldBufferLogMessages) {
        [self addFormatToLogBuffer:wrappedFormat arguments:arguments];
    }
}

- (void)sendFormatToSystemLog:(NSString *)format arguments:(va_list)arguments
{
    NSLogv(format, arguments);
}

- (void)addFormatToLogBuffer:(NSString *)format arguments:(va_list)arguments
{
    NSDate *now = [NSDate date];
    NSString *timeString = [self.dateFormatter stringFromDate:now];
    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:arguments];
    NSString *timestampedLogMessage = [NSString stringWithFormat:@"%@ %@", timeString, logMessage];
    [logMessage release];
    
    [self willChangeValueForKey:kSPLoggerBufferedMessagesStringPropertyName];
    if (!_logMessagesBuffer) {
        _logMessagesBuffer = [[NSMutableString alloc] initWithString:timestampedLogMessage];
    } else {
        [_logMessagesBuffer appendString:timestampedLogMessage];
    }
    [self didChangeValueForKey:kSPLoggerBufferedMessagesStringPropertyName];
}

- (void)log:(NSString *)format, ...;
{
    va_list arguments;
    
    va_start(arguments, format);
    [self logFormat:format arguments:arguments];
    va_end(arguments);
}

- (void)shutUp
{
    self.shouldBufferLogMessages = NO;
    self.shouldOutputToSystemLog = NO;
}

+ (void)log:(NSString *)format, ...;
{
    va_list arguments;

    va_start(arguments, format);
    [[self defaultLogger] logFormat:format arguments:arguments];
    va_end(arguments);
}

+ (SPLogger *)defaultLogger
{
    if (!__defaultSPLogger) {
        __defaultSPLogger = [[SPLogger alloc] init];
    }

    return __defaultSPLogger;
}

@end
