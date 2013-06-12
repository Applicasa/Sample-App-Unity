//
//  LiPromo.m
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import "LiPromo.h"

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
