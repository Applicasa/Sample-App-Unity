//
//  SPBrandEngageViewController.h
//  SponsorPay Mobile Brand Engage SDK
//
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSPDelayForFadingWebViewIn (NSTimeInterval)1.5
#define kSPDurationForFadeWebViewInAnimation (NSTimeInterval)1.0

#import "SPLogger.h"

@interface SPBrandEngageViewController : UIViewController

- (id)initWithWebView:(UIWebView *)webView;

- (void)fadeWebViewIn;

@end
