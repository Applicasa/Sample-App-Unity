//
//  LiChartboost.h
//  LiCore
//
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiKitPromotions.h>
#import "Chartboost.h"
#import "LiManager.h"
#import "PromoView.h"
#import <LiCore/LiKitPromotions.h>
#import <LiCore/LiCore.h>


@interface LiChartboostManager : NSObject
#define LI_CHARTBOOST_VERSION @"1.0.1"


@property (nonatomic, strong) Promotion *promo;
@property (nonatomic, strong) PromoView *view;
+ (LiChartboostManager *) sharedInstance;
- (void) showChartboostWithPromoView:(PromoView *)view;

@end
