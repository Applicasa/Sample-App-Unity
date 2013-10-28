//
//  SPSchemeParser.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/18/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SP_URL_scheme.h"
#import "NSString+SPURLEncoding.h"
#import "NSURL+SPParametersParsing.h"

@interface SPSchemeParser : NSObject

@property (retain, nonatomic) NSURL *URL;
@property (assign) BOOL shouldRequestCloseWhenOpeningExternalURL;

@property (readonly) BOOL requestsContinueWebViewLoading;
@property (readonly) BOOL requestsOpeningExternalDestination;
@property (readonly) NSURL *externalDestination;
@property (readonly) BOOL requestsClosing;
@property (readonly) BOOL requestsStopShowingLoadingActivityIndicator;

@end
