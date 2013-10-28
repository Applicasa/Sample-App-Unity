//
//  SPAdvertisementViewController.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/22/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPAdvertisementViewController.h"
#import "SPAdvertisementViewController_SDKPrivate.h"
#import "SPAdvertisementViewControllerSubclass.h"
#import "SPTargetedNotificationFilter.h"
#import "SPLogger.h"

@interface SPAdvertisementViewController ()

@property (nonatomic, retain) NSString *appId;
@property (nonatomic, retain) NSString *userId;
@property (readwrite, retain, nonatomic) NSString *currencyName;
@property (copy) SPViewControllerDisposalBlock disposalBlock;

- (id)initWithUserId:(NSString *)userId appId:(NSString *)appId;

@end

@implementation SPAdvertisementViewController {
    UIWebView *_webView;
    SPSchemeParser *_sponsorpaySchemeParser;
    SPLoadingIndicator *_loadingProgressView;
    UIViewController *_publisherViewController; // Can use parentViewController from iOS 5 on
}

#pragma mark - Initializers

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        [self registerForCurrencyNameChangeNotification];
    }
    
    return self;
}

- (id)initWithUserId:(NSString *)userId
               appId:(NSString *)appId
{
	self = [self init];
    
    if (self) {
        self.userId = userId;
        self.appId = appId;
 	}
    
    return self;
}

#pragma mark - UIViewController lifecycle

- (void)loadView
{
    UIView *rootView =
    [[UIView alloc] initWithFrame:[self fullScreenFrameForInterfaceOrientation:[self currentStatusBarOrientation]]];
    rootView.backgroundColor = [UIColor clearColor];
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = rootView;
    [rootView release];  
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(appWillEnterForegroundNotification:)
												 name:UIApplicationWillEnterForegroundNotification
											   object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
}

- (void)attachWebViewToViewHierarchy
{
    if (!self.webView.superview) {
        [self.view addSubview:self.webView];
    }
}

#pragma mark -

#pragma mark - Orientation management

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

- (NSUInteger)supportedInterfaceOrientations
{
    //    return [self currentStatusBarOrientation];
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#endif

- (UIInterfaceOrientation)currentStatusBarOrientation
{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

- (CGRect)fullScreenFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect applicationFrame = [[UIScreen mainScreen] bounds];
    
    CGRect fullScreenFrame;
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        fullScreenFrame = applicationFrame;
    } else {
        fullScreenFrame = CGRectMake(applicationFrame.origin.y,
                                     applicationFrame.origin.x,
                                     applicationFrame.size.height,
                                     applicationFrame.size.width);
    }
    
    return fullScreenFrame;
}

#pragma mark -

- (void)loadURLInWebView:(NSURL *) url
{
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:requestObj];
}

- (void)appWillEnterForegroundNotification:(NSNotification *)notification {
	if (self.webView != nil && self.webView.superview != nil ) {
		[self.webView reload];
	}
}

#pragma mark - Loading indicators management

- (void)animateLoadingViewIn
{
    [self.loadingProgressView presentWithAnimationTypes:SPAnimationTypeFade];
}

- (void)animateLoadingViewOut
{
    [[self loadingProgressView] dismiss];
}

#pragma mark - UIWebViewDelegate methods


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    self.sponsorpaySchemeParser.URL = request.URL;
    self.sponsorpaySchemeParser.shouldRequestCloseWhenOpeningExternalURL = self.shouldFinishOnRedirect;
    
    if (self.sponsorpaySchemeParser.requestsStopShowingLoadingActivityIndicator) {
        [self animateLoadingViewOut];
    }
    
    BOOL openingExternalDestination = self.sponsorpaySchemeParser.requestsOpeningExternalDestination;
    
    if (openingExternalDestination) {
        [[UIApplication sharedApplication] openURL:self.sponsorpaySchemeParser.externalDestination];
    }

    BOOL shouldContinueLoading = self.sponsorpaySchemeParser.requestsContinueWebViewLoading;

    if (self.sponsorpaySchemeParser.requestsClosing) {
        [self dismissAnimated:!openingExternalDestination];
    }
    
    return shouldContinueLoading;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // Error -999 is triggered when the WebView starts a request before the previous one was completed.
    // We assume that kind of error can be safely ignored.
    if ([error code] != -999) {
        if (!self.sponsorpaySchemeParser.requestsOpeningExternalDestination) {
            [self handleWebViewLoadingError:error];
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self webViewDidFinishLoad];
}

#pragma mark - Unimplemented methods

- (void)dismissAnimated:(BOOL)animated
{
    
}

- (void)webViewDidFinishLoad
{
    
}

- (void)handleWebViewLoadingError:(NSError *)error
{
    
}

# pragma mark - Presentation of publisher's VC

- (void)presentAsChildOfViewController:(UIViewController *)parentViewController
{
    self.publisherViewController = parentViewController;
    [parentViewController presentViewController:self animated:YES completion:nil];
}

- (void)dismissFromPublisherViewControllerAnimated:(BOOL)animated
{
    if (!self.publisherViewController) {
        return;
    }

    UIViewController* publisherVC = [self.publisherViewController retain];

    self.publisherViewController = nil;

    dispatch_async(dispatch_get_main_queue(), self.disposalBlock);

    [publisherVC dismissViewControllerAnimated:animated completion:nil];

    [publisherVC release];
}

#pragma mark - Currency name change notification

- (void)registerForCurrencyNameChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(currencyNameChanged:)
                                                 name:SPCurrencyNameChangeNotification
                                               object:nil];
}

- (void)currencyNameChanged:(NSNotification *)notification
{
    if ([SPTargetedNotificationFilter instanceWithAppId:self.appId
                                                 userId:self.userId
                            shouldRespondToNotification:notification]) {
        id newCurrencyName = notification.userInfo[SPNewCurrencyNameKey];
        if ([newCurrencyName isKindOfClass:[NSString class]]) {
            self.currencyName = newCurrencyName;
            [SPLogger log:@"%@ currency name is now: %@", self, self.currencyName];
        }
    }
}

#pragma mark - Manually implemented properties

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.delegate = self;
    }
    return _webView;
}

- (void)setWebView:(UIWebView *)webView
{
    [_webView setDelegate:nil];
    [_webView release];
    _webView = [webView retain];
}

- (SPLoadingIndicator *)loadingProgressView
{
    if (nil == _loadingProgressView)
        _loadingProgressView = [[SPLoadingIndicator alloc] init];
    
    return _loadingProgressView;
}

- (void)setLoadingProgressView:(SPLoadingIndicator *)loadingProgressView
{
    [_loadingProgressView release];
    _loadingProgressView = [loadingProgressView retain];
}

- (SPSchemeParser *)sponsorpaySchemeParser {
    if (!_sponsorpaySchemeParser) {
        _sponsorpaySchemeParser = [[SPSchemeParser alloc] init];
    }
    return _sponsorpaySchemeParser;
}

- (void)setSponsorpaySchemeParser:(SPSchemeParser *)sponsorpaySchemeParser
{
    [_sponsorpaySchemeParser release];
    _sponsorpaySchemeParser = [sponsorpaySchemeParser retain];
}

- (UIViewController *)publisherViewController
{
    return _publisherViewController;
}

- (void)setPublisherViewController:(UIViewController *)publisherViewController
{
    // This is an unsafe_unretained property
    _publisherViewController = publisherViewController;
}

#pragma mark - Housekeeping

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [SPLogger log:@"Deallocing advertisement VC: %@", self];

    self.webView = nil;
    self.appId = nil;
    self.userId = nil;
    self.loadingProgressView = nil;
    self.sponsorpaySchemeParser = nil;
    self.customParameters = nil;
    
    [super dealloc];
}

@end
