//
//  IAP.h
// Created by Applicasa 
// 10/09/2012
//

#import <Foundation/Foundation.h>
#import <LiCore/LiObject.h>
#import <LiCore/LiKitIAPDelegate.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"

@class VirtualGood;
@class VirtualCurrency;

@interface IAP : NSObject

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/


/**********************
 Buy Currency & Goods
**********************/

+ (void) buyVirtualCurrency:(VirtualCurrency *)virtualCurrency withBlock:(LiBlockAction)block;

+ (void) buyVirtualGood:(VirtualGood *)virtualGood quantity:(NSInteger)quantity withCurrencyKind:(LiCurrency)currencyKind andBlock:(LiBlockAction)block;

+ (void) buyVirtualGoodWithRealMoney:(VirtualGood *)virtualGood withBlock:(LiBlockAction)block;

/**********************
 Give Currency & Goods
 **********************/

+ (void) giveAmount:(NSInteger)amount ofCurrencyKind:(LiCurrency)currencyKind withBlock:(LiBlockAction)block;

+ (void) giveVirtualGood:(VirtualGood *)virtualGood quantity:(NSInteger)quantity withBlock:(LiBlockAction)block;

/**********************
 Use Currency & Goods
 **********************/

+ (void) useAmount:(NSInteger)amount ofCurrencyKind:(LiCurrency)currencyKind withBlock:(LiBlockAction)block;

+ (void) useVirtualGood:(VirtualGood *)virtualGood quantity:(NSInteger)quantity withBlock:(LiBlockAction)block;

/**********************
 Query Methods
 **********************/

+ (void) getVirtualCurrenciesWithBlock:(GetVirtualCurrencyArrayFinished)block;

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type withBlock:(GetVirtualCurrencyArrayFinished)block;

+ (void) getVirtualGoodCategoriesWithBlock:(GetVirtualGoodCategoryArrayFinished)block;

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type andCategory:(VirtualGoodCategory *)category withBlock:(GetVirtualCurrencyArrayFinished)block;

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type byCategoryPosition:(int)position withBlock:(GetVirtualCurrencyArrayFinished)block;

+ (void) getAllVirtualGoodStoreItem:(GetVirtualGoodCategoryArrayFinished)block;

/**********************
 Balance Methods
 **********************/

+ (NSInteger) getCurrentUserMainBalance;
+ (NSInteger) getCurrentUserSecondaryBalance;

@end
