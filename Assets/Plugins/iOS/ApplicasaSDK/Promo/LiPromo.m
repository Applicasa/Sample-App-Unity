//
//  LiPromo.m
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import "LiPromo.h"

#import "LiConfig.h"
#if (ENABLE_SUPERSONICADS)
#define SUPERSONICADS
#import <LiSupersonicAds/LiSupersonicAdsManager.h>
#endif

@implementation LiPromo


+ (void) setLiKitPromotionsDelegate:(id <LiKitPromotionsDelegate>)delegate{
    [LiKitPromotions setLiKitPromotionsDelegate:delegate];
}

+ (void) setLiKitPromotionsDelegate:(id <LiKitPromotionsDelegate>)delegate 	andCheckForPromotions:(BOOL)shouldCheckPromotions{

    [LiKitPromotions setLiKitPromotionsDelegate:delegate andCheckForAvailablePromotions:shouldCheckPromotions];

}

+ (void) getAvailablePromosWithBlock:(GetPromotionArrayFinished)block{
    [LiKitPromotions getAllAvailblePromosWithBlock:block];
}

+ (void) refreshPromotions{
    [LiKitPromotions refreshPromotions];
}

+(void) dismissAllPromotions
{
    [LiKitPromotions dismissAllPromotions];
}
+(void) raiseCustomEventByName:(NSString *)value
{
    [LiKitPromotions raiseCustomEventByName:value];
}

+(void) raiseCustomEventByName:(NSString *)value AndShowWithBlock:(PromotionResultBlock) block;
{
    [LiKitPromotions raiseCustomEventByName:value AndShowWithView:nil WithBlock:block];
}
+(void) raiseCustomEventByName:(NSString *)value AndShowWithView:(UIView *)view WithBlock:(PromotionResultBlock) block;
{
    [LiKitPromotions raiseCustomEventByName:value AndShowWithView:view WithBlock:block];
}

+(Promotion *) raiseCustomEventByNameAndReturnPromotion:(NSString *)value
{
    return [LiKitPromotions raiseCustomEventByNameAndReturn:value];
}

+ (void) getThirdPartyActions:(LiThirdPartyResponse)block
{
    [LiKitPromotions getThirdPartyActions:block];
}

+(void) showDemoCampaign
{
#ifdef SUPERSONICADS
    [LiSupersonicAdsManager setShowDemoCampaign];
#endif
}

#pragma mark - Deprecated Methods


@end
