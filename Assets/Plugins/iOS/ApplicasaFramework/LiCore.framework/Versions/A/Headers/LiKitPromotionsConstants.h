//
//  LiKitPromotionsConstants.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

typedef enum {
    LEVEL_RESULT_WIN = 1,
    LEVEL_RESULT_LOSE,
    LEVEL_RESULT_EXIT
}LEVEL_RESULT;


typedef enum {
    LiUsageProfileNone = 0,
    LiUsageProfileCivilan,
    LiUsageProfilePrivate,
    LiUsageProfileSergeant,
    LiUsageProfileGeneral
} LiUsageProfile;

typedef enum{
    LiSpendingProfileNone = 0,
    LiSpendingProfileZombie,
    LiSpendingProfileTourist,
    LiSpendingProfileTaxPayer,
    LiSpendingProfileRockefeller
} LiSpendingProfile;

typedef enum {
    LiPromotionResultLinkOpened = 1,
    LiPromotionResultStringInfo,
    LiPromotionResultGiveMainCurrencyVirtualCurrency,
    LiPromotionResultGiveSecondaryCurrencyVirtualCurrency,
    LiPromotionResultGiveVirtualGood,
    LiPromotionResultDealVirtualCurrency,
    LiPromotionResultDealVirtualGood,
    LiPromotionResultNothing,
    LiPromotionResultTrialPay,
    LiPromotionResultSupersonicAds,
    LiPromotionResultSponsorPay,
    LiPromotionResultAppnext,
    LiPromotionResultMMedia,
     LiPromotionResultChartboost
} LiPromotionResult;

typedef enum {
    LiPromotionActionCancel = 0,
    LiPromotionActionPressed,
    LiPromotionActionFailed
}LiPromotionAction;

typedef enum {
    LiThirdPartyNone = 0,
    LiThirdPartyRewardVirtualCurrency = 1,
    LiThirdPartyRewardVirtualGood
}LiThirdPartyReward;

typedef enum {
    // App session events
    appStart = 1100,
    appStop,
    appPause,
    appResume,
    
    // User-based session events
    userFirstSession = 1200,
    userReturnSession,
    userLogin,
    userLogout,
    userRegister,
    
    // Game events
    gameStarted = 1300,
    gameWin,
    gameLose,
    gamePause,
    gameResume,
    
    // IAP
    
    // VirtualCurrency-based events
    virtualCurrencyBought = 1400,
    virtualCurrencyGiven,
    virtualCurrencyUsed,
    virtualCurrencyFirstPurchase,
    
    // VirtualGood-based events
    virtualGoodBought = 1500,
    virtualGoodGiven,
    virtualGoodUsed,
    virtualGoodFirstPurchase,
    
    // Balance-based events
    balanceChanged = 1600,
    balanceZero,
    balanceLow,
    balanceChangedBy,
    
    // Inventory-based events
    inventoryDepleted = 1700, // all inventory at zero
    inventoryItemDepleted, // a specific item depleted from inventory
    
    // Level events
    levelStart = 1800,
    levelQuit,
    levelRestart,
    levelPause,
    levelResume,
    levelComplete,
    levelFail,
    levelTooDifficult,
    levelTooEasy,
    
    // Player events
    playerDied = 1900,
    playerDidAction,
    playerAchievement,
    
    // Promo events
    promoDisplayed = 2000,
    promoAccepted,
    promoDismissed,
    
    
    // Score events
    scoreHigh = 2100,
    scoreLow,
    scoreAchieved,
    
    // Choice events
    choiceGood = 2200,
    choiceBad,
    choiceAggressive,
    choiceDefensive,
    choiceNeutral,
    
    // Versus events
    versusStart = 2300,
    versusEnd,
    versusQuit,
    versusWin,
    versusLoss,
    
    // Level-up events
    levelUpCharacter = 2400,
    levelUpItem,
    
    // Unlockable events
    unlockedCharacter = 2500,
    unlockedItem,
    unlockedLevel,
    unlockedSecret,
    
    custome = 3000
    
} LiEventTypes;

typedef void (^GetPromotionArrayFinished)(NSError *error, NSArray *array);

typedef enum {
    LiAnalyticsKindUpdatePromotion = 1,
    LiAnalyticsKindUpdateSession = 2,
    LiAnalyticsKindUpdateAnalytic = 3
} LiAnalyticsKind;

@protocol LiKitPromotionsDelegate <NSObject>

- (void) liKitPromotionsAvailable:(NSArray *)promotions;

@end
