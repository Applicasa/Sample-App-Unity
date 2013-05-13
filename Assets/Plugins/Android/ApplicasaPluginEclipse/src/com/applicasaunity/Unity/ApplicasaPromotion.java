package com.applicasaunity.Unity;

import java.util.List;

import com.applicasa.Promotion.Promotion;
import com.unity3d.player.UnityPlayer;
import android.app.Activity;

import applicasa.LiCore.promotion.sessions.LiPromotionCallback.LiPromotionAction;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback.LiPromotionResult;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback.LiPromotionResultCallback;

public class ApplicasaPromotion {

    static {
        System.loadLibrary("Applicasa");
    }
    
	public static native void responseCallbackGetPromotionArrayFinished(int uniqueActionID, boolean success, String errorMessage, int errorType, int listSize, List<Promotion> promotionArrayPtr);
	public static native void responseCallbackPromotionsAvailable(int uniqueActionID, int listSize, List<Promotion> promotionArrayPtr);
	public static native void responseCallbackPromotionResultDelegate(int uniqueActionID, int action, int result, int infoType, String infoString, int infoInt, Object infoVC, Object infoVG);
    
    public static void ApplicasaPromotionShowWithBlock(Object promotionObj, final int uniqueActionID) {
    	final Promotion promotion = (Promotion) promotionObj;
		Activity a = UnityPlayer.currentActivity;
		a.runOnUiThread(new Runnable() {

			public void run() {
				promotion.show(UnityPlayer.currentActivity, new LiPromotionResultCallback() {
			
					@Override
					public void onPromotionResultCallback(LiPromotionAction action,
						LiPromotionResult result, Object info) {
						switch(result) {
							case PromotionResultDealMainVirtualCurrency:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 5, 2, "", 0, info, null);
							 break;
							case PromotionResultDealSeconedaryVirtualCurrency:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 5, 2, "", 0, info, null);
							 break;
							case PromotionResultDealVirtualGood:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 6, 3, "", 0, null, info);
							 break;
							case PromotionResultGiveMainCurrencyVirtualCurrency:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 2, 1, "", (Integer)info, null, null);
							 break;
							case PromotionResultGiveSeconedaryCurrencyVirtualCurrency:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 3, 1, "", (Integer)info, null, null);
							 break;
							case PromotionResultGiveVirtualGood:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 4, 3, "", 0, null, info);
							 break;
							case PromotionResultLinkOpened:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 0, 0, (String)info, 0, null, null);
							 break;
							case PromotionResultNothing:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 7, 0, "", 0, null, null);
							 break;
							case PromotionResultStringInfo:
							 responseCallbackPromotionResultDelegate(uniqueActionID, action.ordinal(), 1, 0, (String)info, 0, null, null);
							 break;
							}
					}
				});
			}
		});
    }
   
    
   public static String ApplicasaPromotionGetID(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionID;
   }
   
   public static double ApplicasaPromotionGetLastUpdate(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionLastUpdate.getTimeInMillis();
   }
   
   public static String ApplicasaPromotionGetName(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionName;
   }
   
   public static int ApplicasaPromotionGetAppEvent(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionAppEvent.ordinal();
   }
   
   public static int ApplicasaPromotionGetMaxPerUser(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionMaxPerUser;
   }
   
   public static int ApplicasaPromotionGetMaxPerDay(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionMaxPerDay;
   }
   
   public static int ApplicasaPromotionGetPriority(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionPriority;
   }
   
   public static boolean ApplicasaPromotionGetShowImmediately(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionShowImmediately;
   }
   
   public static boolean ApplicasaPromotionGetShowOnce(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionShowOnce;
   }
   
   public static int ApplicasaPromotionGetGender(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionGender;
   }
   
   public static String ApplicasaPromotionGetSpendProfile(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionSpendProfile.toString();
   }
   
   public static String ApplicasaPromotionGetUseProfile(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionUseProfile.toString();
   }
   
   public static String ApplicasaPromotionGetCountry(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionCountry;
   }
   
   public static String ApplicasaPromotionGetAge(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionAge;
   }
   
   public static double ApplicasaPromotionGetStartTime(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionStartTime.getTimeInMillis();
   }
   
   public static double ApplicasaPromotionGetEndTime(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionEndTime.getTimeInMillis();
   }
   
   public static String ApplicasaPromotionGetFilterParameters(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionFilterParameters.toString();
   }
   
   public static String ApplicasaPromotionGetType(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionType;
   }
   
   public static int ApplicasaPromotionGetActionKind(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionActionKind.ordinal();
   }
   
   public static String ApplicasaPromotionGetActionData(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionActionData.toString();
   }
   
   public static String ApplicasaPromotionGetImage(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionImage;
   }
   
   public static String ApplicasaPromotionGetButton(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionButton;
   }
   
   public static int ApplicasaPromotionGetEligible(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionEligible;
   }
   
   public static int ApplicasaPromotionGetViews(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionViews;
   }
   
   public static int ApplicasaPromotionGetUsed(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionUsed;
   }
   
   public static String ApplicasaPromotionGetImageBase(Object promotionObj) {
	   //Promotion promotion = (Promotion) promotionObj;
	   return "";
   }
   
   public static String ApplicasaPromotionGetDefaultPhone(Object promotionObj) {
	   //Promotion promotion = (Promotion) promotionObj;
	   return "";
   }
   
   public static String ApplicasaPromotionGetDefaultTablet(Object promotionObj) {
	   //Promotion promotion = (Promotion) promotionObj;
	   return "";
   }
   
   public static String ApplicasaPromotionGetImageOptions(Object promotionObj) {
	   //Promotion promotion = (Promotion) promotionObj;
	   return "";
   }
   
   public static boolean ApplicasaPromotionGetWaitingToBeViewed(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionWaitingToBeViewed;
   }
   
   public static String ApplicasaPromotionGetIdentifier(Object promotionObj) {
	   Promotion promotion = (Promotion) promotionObj;
	   return promotion.PromotionIdentifier;
   }
	
}
