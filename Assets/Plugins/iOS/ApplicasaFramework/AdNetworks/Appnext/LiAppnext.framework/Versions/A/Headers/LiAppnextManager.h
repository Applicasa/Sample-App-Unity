//
//  LiAppNextManager.h
//  LiCore
//
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LiCore/LiKitPromotions.h>
#import "LiManager.h"
#import "PromoView.h"
#import <LiCore/LiKitPromotions.h>
#import <LiCore/LiCore.h>

@interface LiAppnextManager : NSObject

#define LI_APP_NEXT_VERSION @"1.0.1"
@property (nonatomic, strong) Promotion *promo;
@property (nonatomic, strong) PromoView *view;
+ (LiAppnextManager *) sharedInstance;
- (void) showAppnextWithPromoView:(PromoView *)view;

@end
