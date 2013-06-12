	//
//  IAP.m
// Created by Applicasa 
// 10/09/2012
//


#import "IAP.h"
#import "VirtualGood.h"
#import "VirtualCurrency.h"

@implementation IAP

/**********************
 Buy Currency & Goods
 **********************/

+ (void) buyVirtualCurrency:(VirtualCurrency *)virtualCurrency withBlock:(LiBlockAction)block{
    [virtualCurrency buyVirtualCurrencyWithBlock:block];
}

+ (void) buyVirtualGood:(VirtualGood *)virtualGood quantity:(NSInteger)quantity withCurrencyKind:(LiCurrency)currencyKind andBlock:(LiBlockAction)block{
    [virtualGood buyQuantity:quantity withCurrencyKind:currencyKind andBlock:block];
}
+ (void) buyVirtualGoodWithRealMoney:(VirtualGood *)virtualGood withBlock:(LiBlockAction)block{
    [virtualGood buyWithRealMoneyAndBlock:block];
}

/**********************
 Give Currency & Goods
 **********************/

+ (void) giveAmount:(NSInteger)amount ofCurrencyKind:(LiCurrency)currencyKind withBlock:(LiBlockAction)block{
    [VirtualCurrency giveAmount:amount ofCurrencyKind:currencyKind withBlock:block];
}

+ (void) giveVirtualGood:(VirtualGood *)virtualGood quantity:(NSInteger)quantity withBlock:(LiBlockAction)block{
    [virtualGood giveQuantity:quantity withBlock:block];
}

/**********************
 Use Currency & Goods
 **********************/

+ (void) useAmount:(NSInteger)amount ofCurrencyKind:(LiCurrency)currencyKind withBlock:(LiBlockAction)block{
    [VirtualCurrency useAmount:amount OfCurrencyKind:currencyKind withBlock:block];
}

+ (void) useVirtualGood:(VirtualGood *)virtualGood quantity:(NSInteger)quantity withBlock:(LiBlockAction)block{
    [virtualGood useQuantity:quantity withBlock:block];
}

/**********************
 Query Methods
 **********************/

+ (void) getVirtualCurrenciesWithBlock:(GetVirtualCurrencyArrayFinished)block{
    [VirtualCurrency getVirtualCurrenciesWithBlock:block];
}

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type withBlock:(GetVirtualCurrencyArrayFinished)block{
    [VirtualGood getVirtualGoodsOfType:type withBlock:block];
}

+ (void) getVirtualGoodCategoriesWithBlock:(GetVirtualGoodCategoryArrayFinished)block{
    block(nil,[LiKitIAP virtualGoodCategories]);
}

+(void) getVirtualGoodsOfType:(VirtualGoodType)type andCategory:(VirtualGoodCategory *)category withBlock:(GetVirtualCurrencyArrayFinished)block{
    block(nil,[LiKitIAP getVirtualGoodsByType:type andCategory:category]);
}
 
+ (void) getVirtualGoodsOfType:(VirtualGoodType)type byCategoryPosition:(int)position withBlock:(GetVirtualGoodArrayFinished)block{
    NSError *error = nil;
    block (error,[LiKitIAP getVirtualGoodsByType:type andCategoryPosition:position WithError:&error]);
}

+ (void) getAllVirtualGoodStoreItem:(GetVirtualGoodCategoryArrayFinished)block
{
     block(nil,[LiKitIAP virtualGoodsStoreItems]);
}
 
/**********************
 Balance Methods
 **********************/

+ (NSInteger) getCurrentUserMainBalance{
    return [LiKitIAP getCurrentUserMainBalance];
}

+ (NSInteger) getCurrentUserSecondaryBalance{
    return [LiKitIAP getCurrentUserSecondaryBalance];
}

/**********************
 Init Methods
 **********************/
+(void)refreshStore{
    [LiKitIAP refreshStore];
}
+(void) refreshInventories{
    [LiKitIAP refreshInventories];
}
+(void) reValidateVirtualCurrencies{
    [LiKitIAP reValidateVirtualCurrencies];
}

@end
