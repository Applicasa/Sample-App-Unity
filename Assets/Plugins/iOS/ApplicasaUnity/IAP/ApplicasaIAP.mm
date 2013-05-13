#import "ApplicasaCore.h"
#import <LiCore/LiKitIAP.h>

extern "C" {


void ApplicasaIAPBuyVirtualCurrency(VirtualCurrency* virtualCurrency, ApplicasaAction action) {
    [IAP buyVirtualCurrency:virtualCurrency withBlock:ApplicasaActionToBlock(action)];
}
    
void ApplicasaIAPBuyWithRealMoney(VirtualGood* virtualGood, ApplicasaAction action) {
        [IAP buyVirtualGoodWithRealMoney:virtualGood withBlock:ApplicasaActionToBlock(action)];
}


void ApplicasaIAPBuyVirtualGood(VirtualGood* virtualGood, int quantity, LiCurrency currencyKind, ApplicasaAction action) {
    [IAP buyVirtualGood:virtualGood quantity:quantity withCurrencyKind:currencyKind andBlock:ApplicasaActionToBlock(action)];
}

//		/**********************
//		 Give Currency & Goods
//		 **********************/


void ApplicasaIAPGiveAmount(int amount, LiCurrency currencyKind, ApplicasaAction callback) {
    [IAP giveAmount:amount ofCurrencyKind:currencyKind withBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaIAPGiveVirtualGood(VirtualGood* virtualGood, int quantity, ApplicasaAction callback) {
    [IAP giveVirtualGood:virtualGood quantity:quantity withBlock:ApplicasaActionToBlock(callback)];
}

//		/**********************
//		 Use Currency & Goods
//		 **********************/


void ApplicasaIAPUseAmount(int amount, LiCurrency currencyKind, ApplicasaAction callback) {
    [IAP useAmount:amount ofCurrencyKind:currencyKind withBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaIAPUseVirtualGood(VirtualGood* virtualGood, int quantity, ApplicasaAction callback) {
    [IAP useVirtualGood:virtualGood quantity:quantity withBlock:ApplicasaActionToBlock(callback)];
}

//		/**********************
//		 Query Methods
//		 **********************/


void ApplicasaIAPGetVirtualCurrenciesWithBlock(ApplicasaGetVirtualCurrencyArrayFinished callback) {
    [IAP getVirtualCurrenciesWithBlock:ApplicasaGetVirtualCurrencyArrayFinishedToBlock(callback)];
}


void ApplicasaIAPGetVirtualGoodsOfType(VirtualGoodType type, ApplicasaGetVirtualGoodArrayFinished callback) {
    [IAP getVirtualGoodsOfType:type withBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}


void ApplicasaIAPGetVirtualGoodsOfTypeAndCategory(VirtualGoodType type, VirtualGoodCategory* virtualGoodCategory, ApplicasaGetVirtualGoodArrayFinished callback) {
    [IAP getVirtualGoodsOfType:type andCategory:virtualGoodCategory withBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}


void ApplicasaIAPGetVirtualGoodCategoriesWithBlock(ApplicasaGetVirtualGoodCategoryArrayFinished callback) {
    [IAP getVirtualGoodCategoriesWithBlock:ApplicasaGetVirtualGoodCategoryArrayFinishedToBlock(callback)];
}

void ApplicasaIAPGetVirtualGoodsByCategoryPosition(VirtualGoodType type,int position,ApplicasaGetVirtualGoodArrayFinished callback){
    [IAP getVirtualGoodsOfType:type byCategoryPosition:position withBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}
	
//		/**********************
//		 Balance Methods
//		 **********************/


int ApplicasaIAPGetCurrentUserMainBalance() {
    return [IAP getCurrentUserMainBalance];
}


int ApplicasaIAPGetCurrentUserSecondaryBalance() {
    return [IAP getCurrentUserSecondaryBalance];
}


void ApplicasaRefreshStore(){
    [LiKitIAP refreshStore];
}
void ApplicasaRevalidateVirtualCurrency()
    { 
        [LiKitIAP reValidateVirtualCurrencies];
    }

}