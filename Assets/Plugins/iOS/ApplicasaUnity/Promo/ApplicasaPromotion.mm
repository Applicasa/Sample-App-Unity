#import "ApplicasaCore.h"
//#import "iPhone_View.h"
#ifdef UNITY_4_2_0
#import "UnityAppController.h"
#else
#import "AppController.h"
#endif

#import "LiCore/Promotion.h"
#import "LiCore/LiKitPromotions.h"

void UnityPause(bool pause);

extern "C" {
    
    const char * ApplicasaPromotionGetID(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionID);
    }
    
    double ApplicasaPromotionGetLastUpdate(Promotion* promotion) {
        return ((double)promotion.promotionLastUpdate.timeIntervalSince1970);
    }
    
    const char * ApplicasaPromotionGetName(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionName);
    }
    
    LiEventTypes ApplicasaPromotionGetAppEvent(Promotion* promotion) {
        return promotion.promotionAppEvent;
    }
    
    
    int ApplicasaPromotionGetMaxPerUser(Promotion* promotion) {
        return promotion.promotionMaxPerUser;
    }
    
    int ApplicasaPromotionGetMaxPerDay(Promotion* promotion) {
        return promotion.promotionMaxPerDay;
    }
    
    int ApplicasaPromotionGetPriority(Promotion* promotion) {
        return promotion.promotionMaxPerUser;
    }
    
    bool ApplicasaPromotionGetShowImmediately(Promotion* promotion) {
        return promotion.promotionShowImmediately;
    }
    
    bool ApplicasaPromotionGetShowOnce(Promotion* promotion) {
        return promotion.promotionShowOnce;
    }
    
    int ApplicasaPromotionGetGender(Promotion* promotion) {
        return promotion.promotionGender;
    }
    
    const char * ApplicasaPromotionGetSpendProfile(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionSpendProfile);
    }
    
    const char * ApplicasaPromotionGetUseProfile(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionUseProfile);
    }
    
    const char * ApplicasaPromotionGetCountry(Promotion* promotion)  {
        return NSStringToCharPointer(promotion.promotionCountry);
    }
    
    const char * ApplicasaPromotionGetAge(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionAge);
    }
    
    double ApplicasaPromotionGetStartTime(Promotion* promotion) {
        return ((double)promotion.promotionStartTime.timeIntervalSince1970);
    }
    
    double ApplicasaPromotionGetEndTime(Promotion* promotion) {
        return ((double)promotion.promotionEndTime.timeIntervalSince1970);
    }
    
    const char * ApplicasaPromotionGetFilterParameters(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionFilterParameters);
    }
    
    const char * ApplicasaPromotionGetType(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionType);
    }
    
    LiPromotionActionKind ApplicasaPromotionGetActionKind(Promotion* promotion) {
        return promotion.promotionActionKind;
    }
    
    const char * ApplicasaPromotionGetActionData(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionActionData);
    }
    
    const char * ApplicasaPromotionGetImage(Promotion* promotion) {
        return NSStringToCharPointer([promotion.promotionImage absoluteString]);
    }
    
    const char * ApplicasaPromotionGetButton(Promotion* promotion) {
        return NSStringToCharPointer([promotion.promotionButton absoluteString]);
    }
    
    int ApplicasaPromotionGetEligible(Promotion* promotion) {
        return promotion.promotionEligible;
    }
    
    int ApplicasaPromotionGetViews(Promotion* promotion) {
        return promotion.promotionViews;
    }
    
    int ApplicasaPromotionGetUsed(Promotion* promotion) {
        return promotion.promotionUsed;
    }
    
    const char * ApplicasaPromotionGetImageBase(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionImageBase);
    }
    
    const char * ApplicasaPromotionGetDefaultPhone(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionDefaultPhone);
    }
    
    const char * ApplicasaPromotionGetDefaultTablet(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionDefaultTablet);
    }
    
    const char * ApplicasaPromotionGetImageOptions(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionImageOptions);
    }
    
    bool ApplicasaPromotionGetWaitingToBeViewed(Promotion* promotion) {
        return promotion.promotionWaitingToBeViewed;
    }
    
    const char * ApplicasaPromotionGetIdentifier(Promotion* promotion) {
        return NSStringToCharPointer(promotion.promotionIdentifier);
    }
    
    void ApplicasaPromotionDismiss(Promotion* promotion)
    {
        [LiKitPromotions dismiss:promotion];
    }
	
	void ApplicasaPromotionShowWithBlock(Promotion* promotion, ApplicasaPromotionResult callback) {
        switch (promotion.promotionActionKind) {
            case LiPromotionTypeAppnext:
            case LiPromotionTypeChartboost://8
            case LiPromotionTypeMMedia://10
            case LiPromotionTypeSponsorPay://11
            case LiPromotionTypeSupersonicAds://12
              
                break;
                
            default:
                IncreasePromoCounter();
                break;
        }
        
        
        UIView *view = [[UIApplication sharedApplication].keyWindow.subviews objectAtIndex:0];
        [promotion showOnView:view Block:ApplicasaPromotionResultToBlock(callback)];
    }
	
    
    void ApplicasaPromotionGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetPromotionArrayFinished callback) {
        [Promotion getArrayLocallyWithRawSQLQuery:CharPointerToNSString(rawQuery) WithBlock:ApplicasaGetPromotionArrayFinishedToBlock(callback)];
    }
}