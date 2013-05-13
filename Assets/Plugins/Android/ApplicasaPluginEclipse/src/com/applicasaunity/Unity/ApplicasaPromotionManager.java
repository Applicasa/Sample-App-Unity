package com.applicasaunity.Unity;

import java.util.List;

import com.applicasa.ApplicasaManager.LiPromo;
import com.applicasa.Promotion.Promotion;

import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback;

public class ApplicasaPromotionManager {

    static {
        System.loadLibrary("Applicasa");
    }

    public static void ApplicasaPromoSetLiKitPromotionDelegate(final int uniqueActionID) {
    	LiPromo.setPromoCallback(new LiPromotionCallback() {
			
			@Override
			public void onHasPromotionToDisplay(List<Promotion> promotions) {
				ApplicasaPromotion.responseCallbackPromotionsAvailable(uniqueActionID, promotions.size(), promotions);
			}
		});
    }
    
    public static void ApplicasaPromoSetLiKitPromotionDelegateAndCheck(final int uniqueActionID, boolean shouldCheck) {
    	LiPromo.setPromoCallbackAndCheckForAvailablePromotions(new LiPromotionCallback() {
			
			@Override
			public void onHasPromotionToDisplay(List<Promotion> promotions) {
				ApplicasaPromotion.responseCallbackPromotionsAvailable(uniqueActionID, promotions.size(), promotions);
			}
		}, shouldCheck);
    }
    
    public static List<Promotion> ApplicasaPromoGetAvailablePromosWithBlock() {
    	return LiPromo.getAvailablePromotions();
    }
    
    public static void ApplicasaPromoRefreshPromotions() throws LiErrorHandler {
    	LiPromo.refreshPromotions(null);
    }
	
}
