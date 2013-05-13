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

#import <LiCore/LiKitPromotions.h>
#import <LiCore/LiCore.h>


@interface LiChartboostManager : NSObject


@property (nonatomic, strong) Promotion *promo;
+ (LiChartboostManager *) sharedInstance;
- (void) showChartboostWithPromotion:(Promotion *)promotion;

//- (void) initChartboost;
@end
