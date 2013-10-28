//
//  SPAdvertisementViewControllerSubclass.h
//  SponsorPay iOS SDK
//
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAdvertisementViewController.h"
#import "SPSchemeParser.h"
#import "SPLoadingIndicator.h"

@interface SPAdvertisementViewController (ForSubclassEyesOnly)

@property (retain, nonatomic) UIWebView *webView;

@property (retain, nonatomic) SPSchemeParser *sponsorpaySchemeParser;

@property (retain, nonatomic) SPLoadingIndicator *loadingProgressView;

@property (unsafe_unretained, nonatomic) UIViewController *publisherViewController;

- (UIInterfaceOrientation)currentStatusBarOrientation;

- (CGRect)fullScreenFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (void)loadURLInWebView:(NSURL *)url;

- (void)animateLoadingViewIn;

- (void)animateLoadingViewOut;

- (void)handleWebViewLoadingError:(NSError *)error;

- (void)webViewDidFinishLoad;

- (void)attachWebViewToViewHierarchy;

- (void)presentAsChildOfViewController:(UIViewController *)viewController;

- (void)dismissFromPublisherViewControllerAnimated:(BOOL)animated;

@end
