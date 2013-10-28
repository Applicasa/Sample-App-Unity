//
//  SPSchemeParser.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/18/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPSchemeParser.h"

static BOOL isEmptyString(NSString *string);

@interface SPSchemeParser ()

- (void)resetOutputs;
- (void)determineOutputsBasedOnURL;
- (void)processExitCommand;
- (void)processStartCommand;

@end

@implementation SPSchemeParser

@synthesize URL = _URL;

@synthesize requestsContinueWebViewLoading = _requestsContinueWebViewLoading;
@synthesize requestsOpeningExternalDestination = _requestsOpeningExternalDestination;
@synthesize externalDestination = _externalDestination;
@synthesize requestsClosing = _requestsClosing;
@synthesize requestsStopShowingLoadingActivityIndicator = _requestsStopShowingLoadingActivityIndicator;

- (id)init
{
    self = [super init];
    
    if (self) {
        [self resetOutputs];
    }
    
    return self;
}

- (void)setURL:(NSURL *)URL
{
    [_URL release];
    _URL = [URL retain];
    
    [self determineOutputsBasedOnURL];
}

- (void)determineOutputsBasedOnURL
{
	[self resetOutputs];

    NSString *scheme = [self.URL scheme];
	
    if (![scheme isEqualToString:SPONSORPAY_URL_SCHEME]) {
        return;
    }
    
    _requestsContinueWebViewLoading = NO;
    
    NSString *command = [self.URL host];
    
    if ([command isEqualToString:SPONSORPAY_EXIT_PATH]) {
        [self processExitCommand];
    }
    else if ([command isEqualToString:SPONSORPAY_START_PATH]) {
        [self processStartCommand];
    }
}

- (void)resetOutputs
{
    _requestsContinueWebViewLoading = YES;
    _requestsOpeningExternalDestination = NO;
    _requestsClosing = NO;
    _requestsStopShowingLoadingActivityIndicator = NO;

    if (_externalDestination) {
        [_externalDestination release];
        _externalDestination = nil;
    }
}

- (void)processExitCommand
{
    NSDictionary *queryDict = [self.URL SPQueryDictionary];
    NSString *destination = [[queryDict valueForKey:@"url"] SPURLDecodedString];
    
    BOOL isDestinationEmpty = isEmptyString(destination);
    
    if (isDestinationEmpty) {
        _requestsClosing = YES;
    } else {
        _externalDestination = [[NSURL alloc] initWithString:destination];
        _requestsOpeningExternalDestination = YES;
        _requestsClosing =  self.shouldRequestCloseWhenOpeningExternalURL;
    }
}

- (void)processStartCommand
{
    _requestsStopShowingLoadingActivityIndicator = YES;
}

@end

static BOOL isEmptyString(NSString *string)
{
    return string == nil || [string isEqualToString:@""];
}