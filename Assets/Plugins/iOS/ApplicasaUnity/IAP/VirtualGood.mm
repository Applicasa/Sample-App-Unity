//
// VirtualGood.mm
// Created by Applicasa 
// 1/21/2014
//

//
// VirtualGood.mm
// Created by Applicasa 
// 4/9/2013
//

#import "ApplicasaCore.h"
#import "VirtualGood.h"

extern "C" {




const char* ApplicasaVirtualGoodGetVirtualGoodID(VirtualGood* virtualGood) {
	return NSStringToCharPointer(virtualGood.virtualGoodID);
}
void ApplicasaVirtualGoodSetVirtualGoodID(VirtualGood* virtualGood, const char * virtualGoodID) {
	virtualGood.virtualGoodID = CharPointerToNSString(virtualGoodID);
}
const char* ApplicasaVirtualGoodGetVirtualGoodTitle(VirtualGood* virtualGood) {
	return NSStringToCharPointer(virtualGood.virtualGoodTitle);
}
void ApplicasaVirtualGoodSetVirtualGoodTitle(VirtualGood* virtualGood, const char * virtualGoodTitle) {
	virtualGood.virtualGoodTitle = CharPointerToNSString(virtualGoodTitle);
}
const char* ApplicasaVirtualGoodGetVirtualGoodDescription(VirtualGood* virtualGood) {
	return NSStringToCharPointer(virtualGood.virtualGoodDescription);
}
void ApplicasaVirtualGoodSetVirtualGoodDescription(VirtualGood* virtualGood, const char * virtualGoodDescription) {
	virtualGood.virtualGoodDescription = CharPointerToNSString(virtualGoodDescription);
}
const char* ApplicasaVirtualGoodGetVirtualGoodAppleIdentifier(VirtualGood* virtualGood) {
	return NSStringToCharPointer(virtualGood.virtualGoodAppleIdentifier);
}
void ApplicasaVirtualGoodSetVirtualGoodAppleIdentifier(VirtualGood* virtualGood, const char * virtualGoodAppleIdentifier) {
	virtualGood.virtualGoodAppleIdentifier = CharPointerToNSString(virtualGoodAppleIdentifier);
}
const char* ApplicasaVirtualGoodGetVirtualGoodGoogleIdentifier(VirtualGood* virtualGood) {
	return NSStringToCharPointer(virtualGood.virtualGoodGoogleIdentifier);
}
void ApplicasaVirtualGoodSetVirtualGoodGoogleIdentifier(VirtualGood* virtualGood, const char * virtualGoodGoogleIdentifier) {
	virtualGood.virtualGoodGoogleIdentifier = CharPointerToNSString(virtualGoodGoogleIdentifier);
}
const int ApplicasaVirtualGoodGetVirtualGoodMainCurrency(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodMainCurrency;
}
void ApplicasaVirtualGoodSetVirtualGoodMainCurrency(VirtualGood* virtualGood,int virtualGoodMainCurrency) {
	virtualGood.virtualGoodMainCurrency = virtualGoodMainCurrency;
}
const int ApplicasaVirtualGoodGetVirtualGoodSecondaryCurrency(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodSecondaryCurrency;
}
void ApplicasaVirtualGoodSetVirtualGoodSecondaryCurrency(VirtualGood* virtualGood,int virtualGoodSecondaryCurrency) {
	virtualGood.virtualGoodSecondaryCurrency = virtualGoodSecondaryCurrency;
}
const char* ApplicasaVirtualGoodGetVirtualGoodRelatedVirtualGood(VirtualGood* virtualGood) {
	return NSStringToCharPointer(virtualGood.virtualGoodRelatedVirtualGood);
}
void ApplicasaVirtualGoodSetVirtualGoodRelatedVirtualGood(VirtualGood* virtualGood, const char * virtualGoodRelatedVirtualGood) {
	virtualGood.virtualGoodRelatedVirtualGood = CharPointerToNSString(virtualGoodRelatedVirtualGood);
}
const float ApplicasaVirtualGoodGetVirtualGoodIOSBundleMin(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodIOSBundleMin;
}
void ApplicasaVirtualGoodSetVirtualGoodIOSBundleMin(VirtualGood* virtualGood, float virtualGoodIOSBundleMin) {
	virtualGood.virtualGoodIOSBundleMin = virtualGoodIOSBundleMin;
}
const float ApplicasaVirtualGoodGetVirtualGoodIOSBundleMax(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodIOSBundleMax;
}
void ApplicasaVirtualGoodSetVirtualGoodIOSBundleMax(VirtualGood* virtualGood, float virtualGoodIOSBundleMax) {
	virtualGood.virtualGoodIOSBundleMax = virtualGoodIOSBundleMax;
}
const float ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMin(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodAndroidBundleMin;
}
void ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMin(VirtualGood* virtualGood, float virtualGoodAndroidBundleMin) {
	virtualGood.virtualGoodAndroidBundleMin = virtualGoodAndroidBundleMin;
}
const float ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMax(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodAndroidBundleMax;
}
void ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMax(VirtualGood* virtualGood, float virtualGoodAndroidBundleMax) {
	virtualGood.virtualGoodAndroidBundleMax = virtualGoodAndroidBundleMax;
}
const float ApplicasaVirtualGoodGetVirtualGoodStoreItemPrice(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodStoreItemPrice;
}
void ApplicasaVirtualGoodSetVirtualGoodStoreItemPrice(VirtualGood* virtualGood, float virtualGoodStoreItemPrice) {
	virtualGood.virtualGoodStoreItemPrice = virtualGoodStoreItemPrice;
}
const int ApplicasaVirtualGoodGetVirtualGoodPos(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodPos;
}
const int ApplicasaVirtualGoodGetVirtualGoodQuantity(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodQuantity;
}
void ApplicasaVirtualGoodSetVirtualGoodQuantity(VirtualGood* virtualGood,int virtualGoodQuantity) {
	virtualGood.virtualGoodQuantity = virtualGoodQuantity;
}
const int ApplicasaVirtualGoodGetVirtualGoodMaxForUser(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodMaxForUser;
}
void ApplicasaVirtualGoodSetVirtualGoodMaxForUser(VirtualGood* virtualGood,int virtualGoodMaxForUser) {
	virtualGood.virtualGoodMaxForUser = virtualGoodMaxForUser;
}
const int ApplicasaVirtualGoodGetVirtualGoodUserInventory(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodUserInventory;
}
void ApplicasaVirtualGoodSetVirtualGoodUserInventory(VirtualGood* virtualGood,int virtualGoodUserInventory) {
	virtualGood.virtualGoodUserInventory = virtualGoodUserInventory;
}
const char* ApplicasaVirtualGoodGetVirtualGoodImageA(VirtualGood* virtualGood) {
	return NSStringToCharPointer([virtualGood.virtualGoodImageA absoluteString]);
}
void ApplicasaVirtualGoodSetVirtualGoodImageA(VirtualGood* virtualGood,const char* url) {
	virtualGood.virtualGoodImageA = [NSURL URLWithString:CharPointerToNSString(url)];
}
const char* ApplicasaVirtualGoodGetVirtualGoodImageB(VirtualGood* virtualGood) {
	return NSStringToCharPointer([virtualGood.virtualGoodImageB absoluteString]);
}
void ApplicasaVirtualGoodSetVirtualGoodImageB(VirtualGood* virtualGood,const char* url) {
	virtualGood.virtualGoodImageB = [NSURL URLWithString:CharPointerToNSString(url)];
}
const char* ApplicasaVirtualGoodGetVirtualGoodImageC(VirtualGood* virtualGood) {
	return NSStringToCharPointer([virtualGood.virtualGoodImageC absoluteString]);
}
void ApplicasaVirtualGoodSetVirtualGoodImageC(VirtualGood* virtualGood,const char* url) {
	virtualGood.virtualGoodImageC = [NSURL URLWithString:CharPointerToNSString(url)];
}
const bool ApplicasaVirtualGoodGetVirtualGoodInAppleStore(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodInAppleStore;
}
void ApplicasaVirtualGoodSetVirtualGoodInAppleStore(VirtualGood* virtualGood,bool virtualGoodInAppleStore) {
	 virtualGood.virtualGoodInAppleStore=virtualGoodInAppleStore;
}
const bool ApplicasaVirtualGoodGetVirtualGoodInGoogleStore(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodInGoogleStore;
}
void ApplicasaVirtualGoodSetVirtualGoodInGoogleStore(VirtualGood* virtualGood,bool virtualGoodInGoogleStore) {
	 virtualGood.virtualGoodInGoogleStore=virtualGoodInGoogleStore;
}
const bool ApplicasaVirtualGoodGetVirtualGoodIsStoreItem(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodIsStoreItem;
}
void ApplicasaVirtualGoodSetVirtualGoodIsStoreItem(VirtualGood* virtualGood,bool virtualGoodIsStoreItem) {
	 virtualGood.virtualGoodIsStoreItem=virtualGoodIsStoreItem;
}
VirtualGoodCategory* ApplicasaVirtualGoodGetVirtualGoodMainCategory(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodMainCategory;
}

void ApplicasaVirtualGoodSetVirtualGoodMainCategory(VirtualGood* virtualGood, VirtualGoodCategory* virtualGoodMainCategory){
	virtualGood.virtualGoodMainCategory = virtualGoodMainCategory;
}
const bool ApplicasaVirtualGoodGetVirtualGoodIsDeal(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodIsDeal;
}
void ApplicasaVirtualGoodSetVirtualGoodIsDeal(VirtualGood* virtualGood,bool virtualGoodIsDeal) {
	 virtualGood.virtualGoodIsDeal=virtualGoodIsDeal;
}
const bool ApplicasaVirtualGoodGetVirtualGoodConsumable(VirtualGood* virtualGood) {
	return virtualGood.virtualGoodConsumable;
}
void ApplicasaVirtualGoodSetVirtualGoodConsumable(VirtualGood* virtualGood,bool virtualGoodConsumable) {
	 virtualGood.virtualGoodConsumable=virtualGoodConsumable;
}
const double ApplicasaVirtualGoodGetVirtualGoodLastUpdate(VirtualGood* virtualGood) {
	return ((double)virtualGood.virtualGoodLastUpdate.timeIntervalSince1970);
}



struct ApplicasaSKProduct ApplicasaVirtualGoodGetProduct(VirtualGood* virtualGood) {
    struct ApplicasaSKProduct product;
    product.LocalizedDescription = NSStringToCharPointer(virtualGood.product.localizedDescription);
    product.LocalizedTitle = NSStringToCharPointer(virtualGood.product.localizedTitle);
    product.ProductIdentifier = NSStringToCharPointer(virtualGood.product.productIdentifier);
    product.Price = NSStringToCharPointer([virtualGood.product.price stringValue]);
    return product;
}

const char * ApplicasaVirtualGoodGetItunesPrice(VirtualGood* virtualGood) {
    return NSStringToCharPointer([NSNumberFormatter localizedStringFromNumber:virtualGood.itunesPrice numberStyle:NSNumberFormatterCurrencyStyle]);
}


void ApplicasaVirtualGoodBuyWithRealMoney(VirtualGood* virtualGood, ApplicasaAction callback) {
        [virtualGood buyWithRealMoneyAndBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaVirtualGoodBuyQuantity(VirtualGood* virtualGood, int quantity, LiCurrency currencyKind, ApplicasaAction callback) {
    [virtualGood buyQuantity:quantity withCurrencyKind:currencyKind andBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaVirtualGoodGiveQuantity(VirtualGood* virtualGood, int quantity, ApplicasaAction callback) {
    [virtualGood giveQuantity:quantity withBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaVirtualGoodUseQuantity(VirtualGood* virtualGood, int quantity, ApplicasaAction callback) {
    [virtualGood useQuantity:quantity withBlock:ApplicasaActionToBlock(callback)];
}



void ApplicasaVirtualGoodGetLocalArrayWithQuery(LiQuery* query, ApplicasaGetVirtualGoodArrayFinished callback) {
    [VirtualGood getLocalArrayWithQuery:query andBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}


void ApplicasaVirtualGoodsGetVirtualGoodsOfType(VirtualGoodType type, ApplicasaGetVirtualGoodArrayFinished callback) {
    [VirtualGood getVirtualGoodsOfType:type withBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}


void ApplicasaVirtualGoodsGetVirtualGoodsOfTypeAndCategory(VirtualGoodType type, VirtualGoodCategory* virtualGoodCategory, ApplicasaGetVirtualGoodArrayFinished callback) {
    [VirtualGood getVirtualGoodsOfType:type andCategory:virtualGoodCategory withBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}
void ApplicasaVirtualGoodsGetVirtualGoodsByCategoryPosition(VirtualGoodType type,int position,ApplicasaGetVirtualGoodArrayFinished callback){
    [VirtualGood getVirtualGoodsOfType:type byCategoryPosition:position withBlock:ApplicasaGetVirtualGoodArrayFinishedToBlock(callback)];
}
}

