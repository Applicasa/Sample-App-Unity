//
//  SPLoadingIndicator.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/12/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import "SPLoadingIndicator.h"
#import "QuartzCore/QuartzCore.h"

static const CGFloat kSPLoadingProgressViewBGColorRed   = .23;
static const CGFloat kSPLoadingProgressViewBGColorBlue  = .23;
static const CGFloat kSPLoadingProgressViewBGColorGreen = .23;
static const CGFloat kSPLoadingProgressViewBGColorAlpha = 1;

static const CGFloat kSPLoadingProgressViewPadding = 15;
static const CGFloat kSPLoadingProgressViewCornerRadius = 10;

static const CGFloat kSPMostTransparentAlphaForFadeAnimation = 0.0;
static const CGFloat kSPMostOpaqueAlpha = 0.95;

static const NSTimeInterval kSPIntroAnimationLength = 0.5;
static const NSTimeInterval kSPOutroAnimationLength = 0.5;

@interface SPLoadingIndicator()

@property (retain, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (retain, nonatomic) UIView *spinnerView;
@property (retain, nonatomic) UIView *blackFullScreen;
@property (retain, nonatomic) UIView *rootView;
@property (readonly, nonatomic) UIWindow *parentWindow;
@property (assign) BOOL dismissable;

@end

@implementation SPLoadingIndicator {
    BOOL _showFullScreen;
    BOOL _showSpinner;
}

- (id)init
{
    self = [self initFullScreen:NO showSpinner:YES];
    return self;
}

- (id)initFullScreen:(BOOL)fullScreen showSpinner:(BOOL)showSpinner
{
    self = [super init];
    if (self) {
        _showFullScreen = fullScreen;
        _showSpinner = fullScreen ? showSpinner : YES;
    }
    return self;
}

#pragma mark - View hierarchy

@synthesize activityIndicatorView = _activityIndicatorView;

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView =
        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activityIndicatorView startAnimating];
    }
    return _activityIndicatorView;
}

@synthesize rootView = _rootView;

- (UIView *)rootView
{
    if (_rootView) {
        return _rootView;
    }

    if (_showFullScreen) {
        _rootView = self.blackFullScreen;
        if (_showSpinner) {
            [_rootView addSubview:self.spinnerView];
            self.spinnerView.center = _rootView.center;
        }
    }
    else {
        _rootView = self.spinnerView;
    }

    return _rootView;
}

@synthesize spinnerView = _spinnerView;

- (UIView *)spinnerView
{
    if (!_spinnerView) {
        CGSize sizeForSpinnerView = [self sizeForSpinnerView];

        _spinnerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, // Will be centered in window later
                                                 sizeForSpinnerView.width, sizeForSpinnerView.height)];

        _spinnerView.backgroundColor = [UIColor colorWithRed:kSPLoadingProgressViewBGColorRed
                                                       green:kSPLoadingProgressViewBGColorGreen
                                                        blue:kSPLoadingProgressViewBGColorBlue
                                                       alpha:kSPLoadingProgressViewBGColorAlpha];
        _spinnerView.layer.cornerRadius = kSPLoadingProgressViewCornerRadius;

        UIView *activityIndicator = self.activityIndicatorView;
        activityIndicator.center = _spinnerView.center;
        [_spinnerView addSubview:activityIndicator];
    }

    return _spinnerView;
}

@synthesize blackFullScreen = _blackFullScreen;

- (UIView *)blackFullScreen
{
    if (!_blackFullScreen) {
        CGRect fullScreenFrame = self.parentWindow.rootViewController.view.frame;
        _blackFullScreen = [[UIView alloc] initWithFrame:fullScreenFrame];
        _blackFullScreen.backgroundColor = [UIColor blackColor];
        _blackFullScreen.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _blackFullScreen;
}

@synthesize parentWindow = _parentWindow;

- (UIWindow *)parentWindow {
    if (!_parentWindow) {
        // It's assumed the parent window won't be deallocated during this instance's lifecyle
        _parentWindow = [[UIApplication sharedApplication] keyWindow];
    }
    
    return _parentWindow;
}

- (CGSize)sizeForSpinnerView
{
    CGSize activityIndicatorSize = self.activityIndicatorView.frame.size;
    return CGSizeMake(activityIndicatorSize.width + (2 * kSPLoadingProgressViewPadding),
                      activityIndicatorSize.height + (2 * kSPLoadingProgressViewPadding));
}

#pragma mark - Presenting and dismissing

- (void)presentWithAnimationTypes:(SPAnimationTypes)animationTypes
{
    self.dismissable = YES;

    [self.parentWindow addSubview:self.rootView];
    
    [self setupInitialStateForAnimationTypes:animationTypes];
    
    [UIView animateWithDuration:kSPIntroAnimationLength
                     animations:^{
                         if (animationTypes & SPAnimationTypeFade)
                             self.rootView.alpha = kSPMostOpaqueAlpha;

                         if (animationTypes & SPAnimationTypeTranslateBottomUp)
                            self.rootView.center = self.parentWindow.center;
                     }
     ];
}

- (void)dismiss
{
    if (!self.dismissable) {
        return;
    }
    self.dismissable = NO;
    
    [UIView animateWithDuration:kSPOutroAnimationLength
                     animations:^{
                         self.rootView.alpha = kSPMostTransparentAlphaForFadeAnimation;
                     }
                     completion:^(BOOL finished){
                         [self.rootView removeFromSuperview];
                     }
     ];
}

- (void)setupInitialStateForAnimationTypes:(SPAnimationTypes)animationTypes
{
    CGFloat initialAlpha;
    CGPoint initialCenter;
    
    if (animationTypes & SPAnimationTypeFade) {
         initialAlpha = kSPMostTransparentAlphaForFadeAnimation;
    } else {
        initialAlpha = kSPMostOpaqueAlpha;
    }
    if (animationTypes & SPAnimationTypeTranslateBottomUp) {
        initialCenter.x = self.parentWindow.center.x;
        initialCenter.y = self.parentWindow.frame.size.height;
    } else {
        initialCenter = self.parentWindow.center;
    }
    
    self.rootView.alpha = initialAlpha;
    self.rootView.center = initialCenter;
}

#pragma mark - Housekeeping

- (void)dealloc
{
    self.activityIndicatorView = nil;
    self.spinnerView = nil;
    self.blackFullScreen = nil;
    self.rootView = nil;
    
    [super dealloc];
}

@end
