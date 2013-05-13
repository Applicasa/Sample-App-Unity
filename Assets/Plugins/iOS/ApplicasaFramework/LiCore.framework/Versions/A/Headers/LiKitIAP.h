//
//  LiKitIAP.h
//  Applicasa
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//  

#import <UIKit/UIKit.h>

#import <LiCore/SKProduct+LiPriceAsString.h>
#import <LiCore/LiKitIAPDelegate.h>
#import <LiCore/LiResponse.h>
#import "LiDataTypes.h"
#import <LiCore/LiObject.h>



@class VirtualGoodCategory;
@class VirtualCurrency;
@class VirtualGood;

@interface LiKitIAP : NSObject

typedef enum {
    FAIL = 0,
    SUCCESS = 1,
    RUNNING = 2,
    SUCCESS_INIT_BUT_FAILED_VERIFY_VIRTUAL_CURRENCY = 3,
    SUCCESS_INIT_BUT_WITH_ZERO_ITEMS
} IAP_STATUS;

+ (BOOL) liKitIAPLoaded;
+ (IAP_STATUS) liKitIAPStatus;


+ (NSDictionary *) getIAPActionFieldsDictionary;
+ (NSDictionary *) getIAPFKsDictionary;

+ (BOOL) validateObjectDictionary:(NSDictionary *)dictionary FromTable:(NSString *)tableName Header:(NSString *)header;
+ (void) validateVirtualCurrencys:(NSArray *)items WithDelegate:(id <LiKitIAPDelegate>)delegate;

+ (NSArray *) virtualCurrencies;
+ (NSArray *) virtualGoods;
+ (NSArray *) virtualGoodsStoreItems;
+ (NSArray *) virtualGoodCategories;

+ (void) getTrialPayActions:(LiTrialPayResponse)block;

+ (NSArray *) virtualGoodDeals;
+ (NSArray *) virtualCurrencyDeals;
+ (VirtualGood *) getVirtualGoodById:(NSString *)Id;

+ (void) refreshInventories;
+ (void) refreshStore;

//AppStore Methods

//AppStore Purchase method
+ (void) purchaseVirtualCurrency:(VirtualCurrency *)VirtualCurrency Delegate:(id <LiKitIAPDelegate>)delegate;
//Give App credits for free
+ (BOOL) giveAmount:(NSInteger)amount CurrencyKind:(LiCurrency)currencyKind WithError:(NSError **)error;
//Use the App credits
+ (BOOL) useAmount:(NSInteger)amount CurrencyKind:(LiCurrency)currencyKind WithError:(NSError **)error;
//Get the current balance
+ (NSInteger) getCurrentUserMainBalance;
+ (NSInteger) getCurrentUserSecondaryBalance;

+ (NSArray *) getVirtualGoodsByType:(VirtualGoodType)type andCategory:(VirtualGoodCategory *)category;
+ (NSArray *) getVirtualGoodsByType:(VirtualGoodType)type andCategoryPosition:(int)position WithError:(NSError **)error;

+ (void)purchaseVirtualGoodWithRealMoney:(VirtualGood *)product Delegate:(id <LiKitIAPDelegate>)delegate WithError:(NSError **)error;

+ (BOOL) purchaseVirtualGood:(VirtualGood *)product Quantity:(NSInteger)quantity CurrencyKind:(LiCurrency)currencyKind WithError:(NSError **)error;
+ (BOOL) giveVirtualGood:(VirtualGood *)product Quantity:(NSInteger)quantity WithError:(NSError **)error;
+ (BOOL) useVirtualGood:(VirtualGood *)product Quantity:(NSInteger)quantity WithError:(NSError **)error;

+ (void) reValidateVirtualCurrencies;
+ (IAP_STATUS) validateStatus;

+ (BOOL) isDuringInApp;
+(void)setDuringInApp:(BOOL)duringIAP;

@end
