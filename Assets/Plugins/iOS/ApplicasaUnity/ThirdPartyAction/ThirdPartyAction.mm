//
// TrialPayAction.mm
// Created by Applicasa 
// 7/24/2013
//

#import "ApplicasaCore.h"
#import <LiCore/TPAction.h>
#import <LiCore/LiTrialPayManager.h>
#import <LiCore/LiKitPromotions.h>
extern "C" {

/*


 @property (nonatomic, assign) LiCurrency tPActionCurrencyKind;


 @property (nonatomic, assign) LiThirdPartyReward tPActionKind;

 */

const char* ApplicasaThirdPartyActionGetThirdPartyActionID(TPAction* thirdPartyAction) {
	return NSStringToCharPointer(thirdPartyAction.tPActionID);
}
void ApplicasaThirdPartyActionSetThirdPartyActionID(TPAction* thirdPartyAction, const char * thirdPartyActionID) {
	thirdPartyAction.tPActionID = CharPointerToNSString(thirdPartyActionID);
}
const double ApplicasaThirdPartyActionGetThirdPartyActionLastUpdate(TPAction* thirdPartyAction) {
	return ((double)thirdPartyAction.tPActionLastUpdate.timeIntervalSince1970);
}
const float ApplicasaThirdPartyActionGetThirdPartyActionRevenue(TPAction* thirdPartyAction) {
	return thirdPartyAction.tPActionRevenue;
}
void ApplicasaThirdPartyActionSetThirdPartyActionRevenue(TPAction* thirdPartyAction, float thirdPartyActionRevenue) {
	thirdPartyAction.tPActionRevenue = thirdPartyActionRevenue;
}
const LiCurrency ApplicasaThirdPartyActionGetThirdPartyActionCurrencyKind(TPAction* thirdPartyAction) {
	return thirdPartyAction.tPActionCurrencyKind;
}
void ApplicasaThirdPartyActionSetThirdPartyActionCurrencyKind(TPAction* thirdPartyAction,LiCurrency thirdPartyActionCurrencyKind) {
	thirdPartyAction.tPActionCurrencyKind = thirdPartyActionCurrencyKind;
}
const int ApplicasaThirdPartyActionGetThirdPartyActionQuantity(TPAction* thirdPartyAction) {
	return thirdPartyAction.tPActionQuantity;
}
void ApplicasaThirdPartyActionSetThirdPartyActionQuantity(TPAction* thirdPartyAction,int thirdPartyActionQuantity) {
	thirdPartyAction.tPActionQuantity = thirdPartyActionQuantity;
}
const char* ApplicasaThirdPartyActionGetThirdPartyActionPromotion(TPAction* thirdPartyAction) {
	return NSStringToCharPointer(thirdPartyAction.tPActionPromotion);
}
void ApplicasaThirdPartyActionSetThirdPartyActionPromotion(TPAction* thirdPartyAction, const char * thirdPartyActionPromotion) {
	thirdPartyAction.tPActionPromotion = CharPointerToNSString(thirdPartyActionPromotion);
}
const LiThirdPartyReward ApplicasaThirdPartyActionGetThirdPartyActionKind(TPAction* thirdPartyAction) {
	return thirdPartyAction.tPActionKind;
}
void ApplicasaThirdPartyActionSetThirdPartyActionKind(TPAction* thirdPartyAction,LiThirdPartyReward thirdPartyActionKind) {
	thirdPartyAction.tPActionKind = thirdPartyActionKind;
}
const double ApplicasaThirdPartyActionGetThirdPartyActionDate(TPAction* thirdPartyAction) {
	return ((double)thirdPartyAction.tPActionDate.timeIntervalSince1970);
}
void ApplicasaThirdPartyActionSetThirdPartyActionDate(TPAction* thirdPartyAction, double thirdPartyActionDate) {
	thirdPartyAction.tPActionDate =  [NSDate dateWithTimeIntervalSince1970:thirdPartyActionDate];
}
VirtualGood* ApplicasaThirdPartyActionGetThirdPartyActionVirtualGood(TPAction* thirdPartyAction) {
	return thirdPartyAction.tPActionVirtualGood;
}

void ApplicasaThirdPartyActionSetThirdPartyActionVirtualGood(TPAction* thirdPartyAction, VirtualGood* thirdPartyActionVirtualGood){
	thirdPartyAction.tPActionVirtualGood = thirdPartyActionVirtualGood;
}
const char* ApplicasaThirdPartyActionGetThirdPartyActionUser(TPAction* thirdPartyAction) {
	return NSStringToCharPointer(thirdPartyAction.tPActionUser);
}
void ApplicasaThirdPartyActionSetThirdPartyActionUser(TPAction* thirdPartyAction, const char * thirdPartyActionUser) {
	thirdPartyAction.tPActionUser = CharPointerToNSString(thirdPartyActionUser);
}

TPAction * ApplicasaThirdPartyAction() {
    return [[TPAction alloc] init];
}



void ApplicasaGetThirdPartyActions(ApplicasaGetThirdPartyActionArrayFinished callback) {
    [LiKitPromotions getThirdPartyActions:ApplicasaGetThirdPartyActionArrayFinishedToBlock(callback)];
}







}
