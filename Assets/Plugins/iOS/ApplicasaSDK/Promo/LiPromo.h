//
//  LiPromo.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiKitPromotions.h>

@interface LiPromo : NSObject


+ (void) setLiKitPromotionsDelegate:(id <LiKitPromotionsDelegate>)delegate;
+ (void) setLiKitPromotionsDelegate:(id <LiKitPromotionsDelegate>)delegate andCheckForPromotions:(BOOL) shouldCheckPromotions;

+ (void) getAvailablePromosWithBlock:(GetPromotionArrayFinished)block;

+ (void) refreshPromotions;

+(void) dismissAllPromotions;
+(void) raiseCustomEventByName:(NSString *)value;
+(Promotion *) raiseCustomEventByNameAndReturnPromotion:(NSString *)value;
+(void) raiseCustomEventByName:(NSString *)value AndShowWithBlock:(PromotionResultBlock) block;
+(void) raiseCustomEventByName:(NSString *)value AndShowWithView:(UIView *)view WithBlock:(PromotionResultBlock) block;
+(void) showDemoCampaign;
+ (void) getThirdPartyActions:(LiThirdPartyResponse)block;
@end
