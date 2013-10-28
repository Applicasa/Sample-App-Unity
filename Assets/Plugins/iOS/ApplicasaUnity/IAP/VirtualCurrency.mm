//
// VirtualCurrency.mm
// Created by Applicasa 
// 10/24/2013
//

#import "ApplicasaCore.h"
#import "VirtualCurrency.h"

extern "C" {



const char* ApplicasaVirtualCurrencyGetVirtualCurrencyID(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer(virtualCurrency.virtualCurrencyID);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyID(VirtualCurrency* virtualCurrency, const char * virtualCurrencyID) {
	virtualCurrency.virtualCurrencyID = CharPointerToNSString(virtualCurrencyID);
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyTitle(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer(virtualCurrency.virtualCurrencyTitle);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyTitle(VirtualCurrency* virtualCurrency, const char * virtualCurrencyTitle) {
	virtualCurrency.virtualCurrencyTitle = CharPointerToNSString(virtualCurrencyTitle);
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyAppleIdentifier(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer(virtualCurrency.virtualCurrencyAppleIdentifier);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyAppleIdentifier(VirtualCurrency* virtualCurrency, const char * virtualCurrencyAppleIdentifier) {
	virtualCurrency.virtualCurrencyAppleIdentifier = CharPointerToNSString(virtualCurrencyAppleIdentifier);
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyGoogleIdentifier(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer(virtualCurrency.virtualCurrencyGoogleIdentifier);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyGoogleIdentifier(VirtualCurrency* virtualCurrency, const char * virtualCurrencyGoogleIdentifier) {
	virtualCurrency.virtualCurrencyGoogleIdentifier = CharPointerToNSString(virtualCurrencyGoogleIdentifier);
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyDescription(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer(virtualCurrency.virtualCurrencyDescription);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyDescription(VirtualCurrency* virtualCurrency, const char * virtualCurrencyDescription) {
	virtualCurrency.virtualCurrencyDescription = CharPointerToNSString(virtualCurrencyDescription);
}
const float ApplicasaVirtualCurrencyGetVirtualCurrencyPrice(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyPrice;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyPrice(VirtualCurrency* virtualCurrency, float virtualCurrencyPrice) {
	virtualCurrency.virtualCurrencyPrice = virtualCurrencyPrice;
}
const float ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMin(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyIOSBundleMin;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMin(VirtualCurrency* virtualCurrency, float virtualCurrencyIOSBundleMin) {
	virtualCurrency.virtualCurrencyIOSBundleMin = virtualCurrencyIOSBundleMin;
}
const float ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMax(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyIOSBundleMax;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMax(VirtualCurrency* virtualCurrency, float virtualCurrencyIOSBundleMax) {
	virtualCurrency.virtualCurrencyIOSBundleMax = virtualCurrencyIOSBundleMax;
}
const float ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMin(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyAndroidBundleMin;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMin(VirtualCurrency* virtualCurrency, float virtualCurrencyAndroidBundleMin) {
	virtualCurrency.virtualCurrencyAndroidBundleMin = virtualCurrencyAndroidBundleMin;
}
const float ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMax(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyAndroidBundleMax;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMax(VirtualCurrency* virtualCurrency, float virtualCurrencyAndroidBundleMax) {
	virtualCurrency.virtualCurrencyAndroidBundleMax = virtualCurrencyAndroidBundleMax;
}
const int ApplicasaVirtualCurrencyGetVirtualCurrencyPos(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyPos;
}
const int ApplicasaVirtualCurrencyGetVirtualCurrencyCredit(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyCredit;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyCredit(VirtualCurrency* virtualCurrency,int virtualCurrencyCredit) {
	virtualCurrency.virtualCurrencyCredit = virtualCurrencyCredit;
}
LiCurrency ApplicasaVirtualCurrencyGetVirtualCurrencyKind(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyKind;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyKind(VirtualCurrency* virtualCurrency, LiCurrency virtualCurrencyKind) {
	virtualCurrency.virtualCurrencyKind = virtualCurrencyKind;
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyImageA(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer([virtualCurrency.virtualCurrencyImageA absoluteString]);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyImageA(VirtualCurrency* virtualCurrency,const char* url) {
	virtualCurrency.virtualCurrencyImageA = [NSURL URLWithString:CharPointerToNSString(url)];
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyImageB(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer([virtualCurrency.virtualCurrencyImageB absoluteString]);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyImageB(VirtualCurrency* virtualCurrency,const char* url) {
	virtualCurrency.virtualCurrencyImageB = [NSURL URLWithString:CharPointerToNSString(url)];
}
const char* ApplicasaVirtualCurrencyGetVirtualCurrencyImageC(VirtualCurrency* virtualCurrency) {
	return NSStringToCharPointer([virtualCurrency.virtualCurrencyImageC absoluteString]);
}
void ApplicasaVirtualCurrencySetVirtualCurrencyImageC(VirtualCurrency* virtualCurrency,const char* url) {
	virtualCurrency.virtualCurrencyImageC = [NSURL URLWithString:CharPointerToNSString(url)];
}
const bool ApplicasaVirtualCurrencyGetVirtualCurrencyIsDeal(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyIsDeal;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyIsDeal(VirtualCurrency* virtualCurrency,bool virtualCurrencyIsDeal) {
	 virtualCurrency.virtualCurrencyIsDeal=virtualCurrencyIsDeal;
}
const bool ApplicasaVirtualCurrencyGetVirtualCurrencyInAppleStore(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyInAppleStore;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyInAppleStore(VirtualCurrency* virtualCurrency,bool virtualCurrencyInAppleStore) {
	 virtualCurrency.virtualCurrencyInAppleStore=virtualCurrencyInAppleStore;
}
const bool ApplicasaVirtualCurrencyGetVirtualCurrencyInGoogleStore(VirtualCurrency* virtualCurrency) {
	return virtualCurrency.virtualCurrencyInGoogleStore;
}
void ApplicasaVirtualCurrencySetVirtualCurrencyInGoogleStore(VirtualCurrency* virtualCurrency,bool virtualCurrencyInGoogleStore) {
	 virtualCurrency.virtualCurrencyInGoogleStore=virtualCurrencyInGoogleStore;
}
const double ApplicasaVirtualCurrencyGetVirtualCurrencyLastUpdate(VirtualCurrency* virtualCurrency) {
	return ((double)virtualCurrency.virtualCurrencyLastUpdate.timeIntervalSince1970);
}



struct ApplicasaSKProduct ApplicasaVirtualCurrencyGetProduct(VirtualCurrency* virtualCurrency) {
    struct ApplicasaSKProduct product;
    product.LocalizedDescription = NSStringToCharPointer(virtualCurrency.product.localizedDescription);
    product.LocalizedTitle = NSStringToCharPointer(virtualCurrency.product.localizedTitle);
    product.ProductIdentifier = NSStringToCharPointer(virtualCurrency.product.productIdentifier);
    product.Price = NSStringToCharPointer([virtualCurrency.product.price stringValue]);
    return product;
}

const char * ApplicasaVirtualCurrencyGetItunesPrice(VirtualCurrency* virtualCurrency) {
    return NSStringToCharPointer([NSNumberFormatter localizedStringFromNumber:virtualCurrency.itunesPrice numberStyle:NSNumberFormatterCurrencyStyle]);
}

void ApplicasaVirtualCurrencyBuyVirtualCurrencyWithBlock(VirtualCurrency* virtualCurrency, ApplicasaAction callback) {
    [virtualCurrency buyVirtualCurrencyWithBlock:ApplicasaActionToBlock(callback)];
}
 
void ApplicasaVirtualCurrencyGetVirtualCurrenciesWithBlock(ApplicasaGetVirtualCurrencyArrayFinished callback) {
    [VirtualCurrency getVirtualCurrenciesWithBlock:ApplicasaGetVirtualCurrencyArrayFinishedToBlock(callback)];
}

void ApplicasaVirtualCurrencyGiveAmount(int amount, LiCurrency currencyKind , ApplicasaAction callback) {
    [VirtualCurrency giveAmount:amount ofCurrencyKind:currencyKind withBlock:ApplicasaActionToBlock(callback)];
}
 
void ApplicasaVirtualCurrencyUseAmount(int amount, LiCurrency currencyKind , ApplicasaAction callback) {
    [VirtualCurrency useAmount:amount OfCurrencyKind:currencyKind withBlock:ApplicasaActionToBlock(callback)];
}

}
