//
//  SPAdvertisementViewController.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/22/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat kSPMostTransparentAlphaForFadeAnimation;
extern const CGFloat kSPMostOpaqueAlpha;

extern const NSTimeInterval kSPIntroAnimationLength;
extern const NSTimeInterval kSPOutroAnimationLength;


/**
 SPAdvertisementViewController is a subclass of UIViewController that provides common functionality to request and display advertisements from the SponsorPay platform. It's intended to be subclassed by concrete implementations of SponsorPay products, like the Mobile OfferWall.
 
 @see SPOfferWallViewController
 */
@interface SPAdvertisementViewController : UIViewController <UIWebViewDelegate>

/**
 If set to YES, this View Controller will be automatically dismissed when the user clicks on an offer and is redirected outside the app.
 */
@property (readwrite) BOOL shouldFinishOnRedirect;

/** Name of your virtual currency.
 This is a human readable, descriptive name of your virtual currency.
 */
@property (readonly, retain, nonatomic) NSString *currencyName;

/**
 A dictionary of arbitrary key / value strings to be provided to the SponsorPay platform when requesting the advertisement.
 */
@property (retain, nonatomic) NSDictionary *customParameters;

/**
 Dismisses the presented advertisement.
 
 @param animated Whether the dismissal should be animated.
 */
- (void)dismissAnimated:(BOOL)animated;

@end
