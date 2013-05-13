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

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/

+ (void) setLiKitPromotionsDelegate:(id <LiKitPromotionsDelegate>)delegate;
+ (void) setLiKitPromotionsDelegate:(id <LiKitPromotionsDelegate>)delegate andCheckForPromotions:(BOOL) shouldCheckPromotions;

+ (void) getAvailablePromosWithBlock:(GetPromotionArrayFinished)block;
+ (void) getAllAvailblePromosWithBlock:(GetPromotionArrayFinished)block DEPRECATED_ATTRIBUTE;

+ (void) refreshPromotions;

@end
