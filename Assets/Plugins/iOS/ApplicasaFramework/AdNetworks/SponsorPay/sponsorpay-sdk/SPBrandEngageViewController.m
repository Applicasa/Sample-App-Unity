//
//  SPBrandEngageViewController.m
//  SponsorPay Mobile Brand Engage SDK
//
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPBrandEngageViewController.h"
#import "SPSystemVersionChecker.h"

@interface SPBrandEngageViewController ()

@property (retain) UIWebView *webView;

- (CGRect)fullScreenFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end

@implementation SPBrandEngageViewController {
    BOOL _viewDidAppearPreviously;
}

#pragma mark - Housekeeping

- (id)initWithWebView:(UIWebView *)webView
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.wantsFullScreenLayout = YES;
        self.webView = webView;
    }
    return self;
}

- (void)dealloc
{
    [self.webView setDelegate:nil];
    [self setWebView:nil];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView
{
    UIView *rootView = [[UIView alloc] initWithFrame:[self fullScreenFrameForInterfaceOrientation:self.interfaceOrientation]];
    rootView.backgroundColor = [UIColor blackColor];
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = rootView;
    [rootView release];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.webView) {
        [SPLogger log:@"Brand Engage View Controller's Web View is nil!"];
        return;
    }

    if (![SPSystemVersionChecker runningOniOS6OrNewer]) // <-- fix targeted to iOS 5
        self.view.frame = [self fullScreenFrameForInterfaceOrientation:self.interfaceOrientation];

    if (!self.webView.superview) { // viewWillAppear could be called after the full screen video has finished playing
        self.webView.frame = self.view.frame;
        self.webView.alpha = 0.0;
        [self.view addSubview:self.webView];
    }

    [self performSelector:@selector(fadeWebViewIn)
               withObject:nil
               afterDelay:kSPDelayForFadingWebViewIn];

}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_viewDidAppearPreviously) {
        _viewDidAppearPreviously = YES;
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.webView) {
        self.webView.alpha = 0.0;
    }
}

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
    return NO;
}

#endif

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (CGRect)fullScreenFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
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

#pragma mark - Status bar preference

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -

- (void)fadeWebViewIn {
    [UIView animateWithDuration:kSPDurationForFadeWebViewInAnimation animations:^{
        self.webView.alpha = 1.0;
    }];
}

@end
