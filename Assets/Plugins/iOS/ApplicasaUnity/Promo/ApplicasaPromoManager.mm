#import "ApplicasaCore.h"
#import "ApplicasaPromotionDelegator.h"
#import "LiPromo.h"

#import "LiManager.h"
#if(ENABLE_SUPERSONICADS)
#import <LiSupersonicAds/LiSupersonicAdsManager.h>
#endif

#include "ApplicasaPromotion.h"

extern "C" {
 

void ApplicasaPromoSetLiKitPromotionDelegate(ApplicasaPromotionsAvailable eventCallback) {
    ApplicasaPromotionDelegator* delegator = [[[ApplicasaPromotionDelegator alloc] initWithFunction:eventCallback] autorelease];
    [LiPromo setLiKitPromotionsDelegate:delegator];
}
    
void ApplicasaPromoSetLiKitPromotionDelegateAndCheck(ApplicasaPromotionsAvailable eventCallback, bool checkPromotions) {
    [LiPromo setLiKitPromotionsDelegate:[[[ApplicasaPromotionDelegator alloc] initWithFunction:eventCallback] autorelease] andCheckForPromotions:checkPromotions];
        
}

void ApplicasaPromoGetAvailablePromosWithBlock(ApplicasaGetPromotionArrayFinished callback) {
    [LiPromo getAvailablePromosWithBlock:ApplicasaGetPromotionArrayFinishedToBlock(callback)];
}


void ApplicasaPromoRefreshPromotions() {
    [LiPromo refreshPromotions];
}

void ApplicasaPromoDismissAllPromotion() {
    [LiPromo dismissAllPromotions];
}
    
void ApplicasaRaiseCustomEvent( const char * value) {
    [LiPromo raiseCustomEventByName:CharPointerToNSString(value)];
}

void ApplicasaRaiseCustomEventAndShowWithBlock( const char * value, ApplicasaPromotionResult callback) {
    Promotion * promotion = [LiPromo raiseCustomEventByNameAndReturnPromotion:CharPointerToNSString(value)];
	if (promotion)
		ApplicasaPromotionShowWithBlock(promotion,callback);
	else
	{
		struct PromotionResultInfo promoResult;
		promoResult.stringResult = NSStringToCharPointer(@"No Promotions for this custom event");
		promoResult.intResult = -1;
		promoResult.type = PromotionResultDataTypeString;
		callback(LiPromotionActionCancel, LiPromotionResultNothing, promoResult);
	}
}

void ApplicasaShowDemoCampaigns()
{
    #if(ENABLE_SUPERSONICADS)
    [[LiSupersonicAdsManager setShowDemoCampaign ];
    #endif
}

}