//
//  LiMMediaManager.h
//  LiCore
//
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiManager.h"
#import "MMSDK.h"
#import <CoreLocation/CoreLocation.h>
#import "PromoView.h"

@interface LiMMediaManager : NSObject

#define LI_MMEDIA_VERSION @"1.0.3"

@property (nonatomic, strong) PromoView *promoView;

+ (LiMMediaManager *) sharedInstance;
- (void) showMMediaWithPromoView:(PromoView *)promoView;

@end
