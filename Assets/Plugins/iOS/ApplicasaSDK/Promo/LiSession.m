//
//  LiSession.m
//  testForLior
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import "LiSession.h"
#import <LiCore/LiKitPromotions.h>

@implementation LiSession

+ (void) sessionStart{
    [LiKitPromotions initSession];
}

+ (void) sessionPause{
    [LiKitPromotions pauseSession];
}

+ (void) sessionResume{
    [LiKitPromotions resumeSession];
}

+ (void) sessionEnd{
    [LiKitPromotions endSession];
}

#pragma mark - Game Methods

+ (void) gameStart:(NSString *)gameName{
    [LiKitPromotions startGame:gameName];
}

+ (void) gamePause{
    [LiKitPromotions pauseGame];
}

+ (void) gameResume{
    [LiKitPromotions resumeGame];
}

+ (void) gameFinishedWithResult:(LiGameResult)gameResult mainCurrencyBalance:(NSInteger)mainBalance secondaryCurrencyBalance:(NSInteger)secondaryBalance finalScore:(NSInteger)score andBonus:(NSInteger)bonus{
    [LiKitPromotions finishGameWithGameResult:gameResult MainCurrency:mainBalance SecondaryCurrency:secondaryBalance Score:score Bonus:bonus];
}

#pragma mark - Deprecated Methods
/*********************************************************************************
 DEPRECATED METHODS:
 
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the next release. You should update your code immediately.
 **********************************************************************************/

+ (void)gameFinishWithGameResult:(LiGameResult)gameResult MainCurrency:(NSInteger)mainCurrency SecondaryCurrency:(NSInteger)secondaryCurrency Score:(NSInteger)score Bonus:(NSInteger)bonus {
    [self gameFinishedWithResult:gameResult mainCurrencyBalance:mainCurrency secondaryCurrencyBalance:secondaryCurrency finalScore:score andBonus:bonus];
}

@end
