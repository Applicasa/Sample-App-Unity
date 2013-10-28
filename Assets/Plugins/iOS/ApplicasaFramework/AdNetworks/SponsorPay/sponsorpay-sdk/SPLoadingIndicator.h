//
//  SPLoadingIndicator.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 10/12/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    SPAnimationTypeFade = (1UL << 0),
    SPAnimationTypeTranslateBottomUp = (1UL << 1),
};
typedef NSUInteger SPAnimationTypes;

@interface SPLoadingIndicator : NSObject

- (id)initFullScreen:(BOOL)fullScreen showSpinner:(BOOL)showSpinner;
- (void)presentWithAnimationTypes:(SPAnimationTypes)animationTypes;
- (void)dismiss;

@end
