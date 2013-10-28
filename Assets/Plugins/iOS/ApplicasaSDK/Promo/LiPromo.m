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

+(void) showDemoCampaign
{
#ifdef SUPERSONICADS
    [LiSupersonicAdsManager setShowDemoCampaign];
#endif
}

#pragma mark - Deprecated Methods
/*********************************************************************************
 DEPRECATED METHODS:
 
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the next release. You should update your code immediately.
 **********************************************************************************/

+(void)getAllAvailblePromosWithBlock:(GetPromotionArrayFinished)block {
    [self getAvailablePromosWithBlock:block];
}

@end
