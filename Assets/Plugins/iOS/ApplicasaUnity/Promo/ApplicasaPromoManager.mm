#import "ApplicasaCore.h"
#import "ApplicasaPromotionDelegator.h"
#import "LiPromo.h"

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

}