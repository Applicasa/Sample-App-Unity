//
//  SPOfferWallViewController.h
//  SponsorPay iOS SDK
//
//  Copyright 2011-2013 SponsorPay. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SPAdvertisementViewController.h"

/**
 Value to return as status on [SPOfferWallViewControllerDelegate offerWallViewController:isFinishedWithStatus:]
 when there is a network error.
 */
#define SPONSORPAY_ERR_NETWORK  -1

@class SPOfferWallViewController;

/**
  The SPOfferWallViewControllerDelegate protocol is to be implemented by classes that wish to be notified when a presented SPOfferWallViewControllerDelegate is dismissed.
 */
@protocol SPOfferWallViewControllerDelegate <NSObject>

/**
  Sent when the SPOfferWallViewController finished. It can have been explicitly dismissed by the user, closed itself when redirecting outside of the app to proceed with an offer, or closed due to an error.

 @param offerWallVC the SPOfferWallViewController which is being closed.
 @param status if there was a network error, this will have the value of SPONSORPAY_ERR_NETWORK.
 */
- (void)offerWallViewController:(SPOfferWallViewController *)offerWallVC
           isFinishedWithStatus:(int)status;

@end

/**
 SPOfferWallViewController is a subclass of SPAdvertisementViewController that requests and shows SponsorPay's Mobile OfferWall.
 
 In order to present itself it requires that you pass to it an instance of one of your own UIViewController subclasses that will act as the OfferWall parent. @see showOfferWallWithParentViewController:
 
 It will notify its delegate when it's closed. @see SPOfferWallViewControllerDelegate.
 */
@interface SPOfferWallViewController : SPAdvertisementViewController <UIAlertViewDelegate>

/**
 Delegate conforming to the SPOfferWallViewControllerDelegate protocol that will be notified when the OfferWall is closed.
 */
@property (nonatomic, assign) id<SPOfferWallViewControllerDelegate> delegate;

/**
 Please don't initialize this class directly, rather access it through [SponsorPaySDK offerWallViewController] or [SponsorPaySDK offerWallViewControllerForCredentials:]
 */
- (id)init;

/**
 Presents the SponsorPay Mobile OfferWall as a child view controller of your own view controller.
 
 @param parentViewController An instance of your own UIViewController subclass that will be used as the parent view controller of the presented OfferWall.
 */
- (void)showOfferWallWithParentViewController:(UIViewController *)parentViewController;

// TODO: extract these two selectors common to all components subject to staging mode
+ (void)overrideBaseURLWithURLString:(NSString *)newURLString;
+ (void)restoreBaseURLToDefault;

@end
