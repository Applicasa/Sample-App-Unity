package com.applicasaunity.Unity;

import java.util.List;

import android.app.Activity;
import android.content.Intent;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualCurrencyRequest;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualGoodRequest;
import applicasa.kit.IAP.IAP.GetVirtualGoodKind;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.IAP.LiIapAction;

import com.applicasa.ApplicasaManager.LiStore;
import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.applicasa.VirtualGood.VirtualGood;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;
import com.unity3d.player.UnityPlayer;

public class ApplicasaIAP {
	
    static {
        System.loadLibrary("Applicasa");
    }
    
    public static void ApplicasaIAPBuyVirtualCurrency(Object virtualCurrencyObj, final int uniqueActionID) {
    	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
    	InAppActivity.virtualCurrency=virtualCurrency;
    	InAppActivity.isVC=true;
    	InAppActivity.uniqueActionID=uniqueActionID;
    	Intent myIntent = new Intent(UnityPlayer.currentActivity, InAppActivity.class);
		UnityPlayer.currentActivity.startActivity(myIntent);
    }
    
    public static void waitForPlayStore(Activity playStoreActivity, int uniqueActionID, boolean success, String errorMessage, int errorType, String itemID, int action) {
    	playStoreActivity.finish();
		ApplicasaCore.responseCallbackAction(uniqueActionID, success, errorMessage, errorType, itemID, action);
	}
    
    public static void ApplicasaIAPBuyWithRealMoney(Object virtualGoodObj, final int uniqueActionID) {
    	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
    	InAppActivity.virtualGood=virtualGood;
    	InAppActivity.isVC=false;
    	InAppActivity.uniqueActionID=uniqueActionID;
    	Intent myIntent = new Intent(UnityPlayer.currentActivity, InAppActivity.class);
		UnityPlayer.currentActivity.startActivity(myIntent);
    }
    
    public static void ApplicasaIAPBuyVirtualGood(Object virtualGoodObj, int quantity, int currencyKind, final int uniqueActionID) {
    	if(virtualGoodObj==null) {
    		return;
    	}
    	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
    	LiStore.buyVirtualGoods(virtualGood, quantity, LiCurrency.values()[currencyKind], new LiCallbackVirtualGoodRequest() {
			
			@Override
			public void onActionFinisedSuccessfully(LiIapAction action, VirtualGood virtualGood) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), virtualGood.VirtualGoodID, action.ordinal());
			}
			
			@Override
			public void onActionFailed(LiIapAction action, VirtualGood virtualGood,
                                       LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), virtualGood.VirtualGoodID, RequestAction.NONE.ordinal());
			}
		});
    }
    
    public static void ApplicasaIAPGiveAmount(int amount, int currencyKind, final int uniqueActionID) {
    	LiStore.giveVirtualCurrency(amount, LiCurrency.values()[currencyKind], new LiCallbackVirtualCurrencyRequest() {
			
			@Override
			public void onActionFinisedSuccessfully(LiIapAction action, int itemID,
                                                    LiCurrency currency) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), ""+itemID, action.ordinal());
			}
			
			@Override
			public void onActionFailed(LiIapAction action, int itemID, LiCurrency currency,
                                       LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), ""+itemID, RequestAction.NONE.ordinal());
			}
		});
    }
    
    public static void ApplicasaIAPGiveVirtualGood(Object virtualGood, int quantity, final int uniqueActionID) {
    	LiStore.giveVirtualGoods((VirtualGood)virtualGood, quantity, new LiCallbackVirtualGoodRequest() {
			
			@Override
			public void onActionFinisedSuccessfully(LiIapAction action, VirtualGood virtualGood) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), virtualGood.VirtualGoodID, action.ordinal());
			}
			
			@Override
			public void onActionFailed(LiIapAction action, VirtualGood virtualGood,
                                       LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), virtualGood.VirtualGoodID, RequestAction.NONE.ordinal());
			}
		});
    }
    
    public static void ApplicasaIAPUseAmount(int amount, int currencyKind, final int uniqueActionID) {
    	LiStore.useVirtualCurrency(amount, LiCurrency.values()[currencyKind], new LiCallbackVirtualCurrencyRequest() {
			
    		@Override
			public void onActionFinisedSuccessfully(LiIapAction action, int itemID,
                                                    LiCurrency currency) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), ""+itemID, action.ordinal());
			}
			
			@Override
			public void onActionFailed(LiIapAction action, int itemID, LiCurrency currency,
                                       LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), ""+itemID, RequestAction.NONE.ordinal());
			}
		});
    }
    
    public static void ApplicasaIAPUseVirtualGood(Object virtualGood, int quantity, final int uniqueActionID) {
    	LiStore.useVirtualGoods((VirtualGood)virtualGood, quantity, new LiCallbackVirtualGoodRequest() {
			
			@Override
			public void onActionFinisedSuccessfully(LiIapAction action, VirtualGood virtualGood) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), virtualGood.VirtualGoodID, action.ordinal());
			}
			
			@Override
			public void onActionFailed(LiIapAction action, VirtualGood virtualGood,
                                       LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), virtualGood.VirtualGoodID, RequestAction.NONE.ordinal());
			}
		});
    }
    
    public static List<VirtualCurrency> ApplicasaIAPGetVirtualCurrenciesWithBlock() {
    	return LiStore.getAllVirtualCurrency();
    }
    
    public static List<VirtualGood> ApplicasaIAPGetVirtualGoodsOfType(int getVirtualGoodKind) {
    	List<VirtualGood> items=LiStore.getAllVirtualGoods(GetVirtualGoodKind.values()[getVirtualGoodKind]);
    	return items;
    }
    
    public static List<VirtualGood> ApplicasaIAPGetVirtualGoodsOfTypeAndCategory(int getVirtualGoodKind, Object virtualGoodCategory) throws LiErrorHandler {
    	return LiStore.getVirtualGoodByCategory((VirtualGoodCategory)virtualGoodCategory, GetVirtualGoodKind.values()[getVirtualGoodKind]);
    }
    
    public static List<VirtualGood> ApplicasaIAPGetVirtualGoodsOfTypeByCategoryPosition(int psotion, int getVirtualGoodKind) throws LiErrorHandler {
    	return LiStore.getVirtualGoodByCategoryPosition(psotion, GetVirtualGoodKind.values()[getVirtualGoodKind]);
    }
    
    
    
    public static List<VirtualGoodCategory> ApplicasaIAPGetVirtualGoodCategoriesWithBlock() {
    	return LiStore.getAllVirtualGoodsCategory();
    }
    
    public static int ApplicasaIAPGetCurrentUserMainBalance() {
    	return LiStore.getUserCurrencyBalance(LiCurrency.MainCurrency);
    }
    
    public static int ApplicasaIAPGetCurrentUserSecondaryBalance() {
    	return LiStore.getUserCurrencyBalance(LiCurrency.SencondaryCurrency);
    }
	
	public static void ApplicasaRefreshStore() {
		try {
			LiStore.refreshStore();
		} catch (LiErrorHandler e) {
			e.printStackTrace();
		}
    }
}
