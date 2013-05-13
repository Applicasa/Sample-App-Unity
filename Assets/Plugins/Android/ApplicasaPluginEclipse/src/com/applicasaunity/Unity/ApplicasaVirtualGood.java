//
// VirtualGood.java
// Created by Applicasa 
// 5/13/2013
//

package com.applicasaunity.Unity;

import java.util.List;

import android.content.Intent;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiQuery;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualGoodRequest;
import applicasa.kit.IAP.IAP.GetVirtualGoodKind;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.IAP.LiIapAction;

import com.applicasa.ApplicasaManager.LiStore;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualGoodGetArrayCallback;
import com.applicasa.VirtualGood.VirtualGood;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;
import com.unity3d.player.UnityPlayer;

public class ApplicasaVirtualGood {


	static {
		System.loadLibrary("Applicasa");
	}


	

public static String ApplicasaVirtualGoodGetVirtualGoodID(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodID;
}
public static void ApplicasaVirtualGoodSetVirtualGoodID(Object virtualGood, String virtualGoodID)
	{
	((VirtualGood)virtualGood).VirtualGoodID = virtualGoodID;
}
public static String ApplicasaVirtualGoodGetVirtualGoodTitle(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodTitle;
}
public static void ApplicasaVirtualGoodSetVirtualGoodTitle(Object virtualGood, String virtualGoodTitle)
	{
	((VirtualGood)virtualGood).VirtualGoodTitle = virtualGoodTitle;
}
public static String ApplicasaVirtualGoodGetVirtualGoodDescription(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodDescription;
}
public static void ApplicasaVirtualGoodSetVirtualGoodDescription(Object virtualGood, String virtualGoodDescription)
	{
	((VirtualGood)virtualGood).VirtualGoodDescription = virtualGoodDescription;
}
public static String ApplicasaVirtualGoodGetVirtualGoodAppleIdentifier(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodAppleIdentifier;
}
public static void ApplicasaVirtualGoodSetVirtualGoodAppleIdentifier(Object virtualGood, String virtualGoodAppleIdentifier)
	{
	((VirtualGood)virtualGood).VirtualGoodAppleIdentifier = virtualGoodAppleIdentifier;
}
public static String ApplicasaVirtualGoodGetVirtualGoodGoogleIdentifier(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodGoogleIdentifier;
}
public static void ApplicasaVirtualGoodSetVirtualGoodGoogleIdentifier(Object virtualGood, String virtualGoodGoogleIdentifier)
	{
	((VirtualGood)virtualGood).VirtualGoodGoogleIdentifier = virtualGoodGoogleIdentifier;
}
public static int ApplicasaVirtualGoodGetVirtualGoodMainCurrency(Object virtualGood)
{
return ((VirtualGood)virtualGood).VirtualGoodMainCurrency;
}
public static void ApplicasaVirtualGoodSetVirtualGoodMainCurrency(Object virtualGood, int virtualGoodMainCurrency)
	{
	((VirtualGood)virtualGood).VirtualGoodMainCurrency = virtualGoodMainCurrency;
}
public static int ApplicasaVirtualGoodGetVirtualGoodSecondaryCurrency(Object virtualGood)
{
return ((VirtualGood)virtualGood).VirtualGoodSecondaryCurrency;
}
public static void ApplicasaVirtualGoodSetVirtualGoodSecondaryCurrency(Object virtualGood, int virtualGoodSecondaryCurrency)
	{
	((VirtualGood)virtualGood).VirtualGoodSecondaryCurrency = virtualGoodSecondaryCurrency;
}
public static String ApplicasaVirtualGoodGetVirtualGoodRelatedVirtualGood(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodRelatedVirtualGood;
}
public static void ApplicasaVirtualGoodSetVirtualGoodRelatedVirtualGood(Object virtualGood, String virtualGoodRelatedVirtualGood)
	{
	((VirtualGood)virtualGood).VirtualGoodRelatedVirtualGood = virtualGoodRelatedVirtualGood;
}
public static float ApplicasaVirtualGoodGetVirtualGoodStoreItemPrice(Object virtualGoodStoreItemPrice)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodStoreItemPrice;
	return ((VirtualGood)virtualGood).VirtualGoodStoreItemPrice;
}

public static void ApplicasaVirtualGoodSetVirtualGoodStoreItemPrice(Object virtualGoodObj, float virtualGoodStoreItemPrice)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
	virtualGood.VirtualGoodStoreItemPrice = virtualGoodStoreItemPrice;
}
public static float ApplicasaVirtualGoodGetVirtualGoodIOSBundleMin(Object virtualGoodIOSBundleMin)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodIOSBundleMin;
	return ((VirtualGood)virtualGood).VirtualGoodIOSBundleMin;
}

public static void ApplicasaVirtualGoodSetVirtualGoodIOSBundleMin(Object virtualGoodObj, float virtualGoodIOSBundleMin)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
	virtualGood.VirtualGoodIOSBundleMin = virtualGoodIOSBundleMin;
}
public static float ApplicasaVirtualGoodGetVirtualGoodIOSBundleMax(Object virtualGoodIOSBundleMax)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodIOSBundleMax;
	return ((VirtualGood)virtualGood).VirtualGoodIOSBundleMax;
}

public static void ApplicasaVirtualGoodSetVirtualGoodIOSBundleMax(Object virtualGoodObj, float virtualGoodIOSBundleMax)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
	virtualGood.VirtualGoodIOSBundleMax = virtualGoodIOSBundleMax;
}
public static float ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMin(Object virtualGoodAndroidBundleMin)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodAndroidBundleMin;
	return ((VirtualGood)virtualGood).VirtualGoodAndroidBundleMin;
}

public static void ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMin(Object virtualGoodObj, float virtualGoodAndroidBundleMin)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
	virtualGood.VirtualGoodAndroidBundleMin = virtualGoodAndroidBundleMin;
}
public static float ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMax(Object virtualGoodAndroidBundleMax)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodAndroidBundleMax;
	return ((VirtualGood)virtualGood).VirtualGoodAndroidBundleMax;
}

public static void ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMax(Object virtualGoodObj, float virtualGoodAndroidBundleMax)
{
	VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
	virtualGood.VirtualGoodAndroidBundleMax = virtualGoodAndroidBundleMax;
}
public static int ApplicasaVirtualGoodGetVirtualGoodPos(Object virtualGood)
{
return ((VirtualGood)virtualGood).VirtualGoodPos;
}
public static int ApplicasaVirtualGoodGetVirtualGoodMaxForUser(Object virtualGood)
{
return ((VirtualGood)virtualGood).VirtualGoodMaxForUser;
}
public static void ApplicasaVirtualGoodSetVirtualGoodMaxForUser(Object virtualGood, int virtualGoodMaxForUser)
	{
	((VirtualGood)virtualGood).VirtualGoodMaxForUser = virtualGoodMaxForUser;
}
public static int ApplicasaVirtualGoodGetVirtualGoodUserInventory(Object virtualGood)
{
return ((VirtualGood)virtualGood).VirtualGoodUserInventory;
}
public static void ApplicasaVirtualGoodSetVirtualGoodUserInventory(Object virtualGood, int virtualGoodUserInventory)
	{
	((VirtualGood)virtualGood).VirtualGoodUserInventory = virtualGoodUserInventory;
}
public static int ApplicasaVirtualGoodGetVirtualGoodQuantity(Object virtualGood)
{
return ((VirtualGood)virtualGood).VirtualGoodQuantity;
}
public static void ApplicasaVirtualGoodSetVirtualGoodQuantity(Object virtualGood, int virtualGoodQuantity)
	{
	((VirtualGood)virtualGood).VirtualGoodQuantity = virtualGoodQuantity;
}
public static String ApplicasaVirtualGoodGetVirtualGoodImageA(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodImageA;
}
public static void ApplicasaVirtualGoodSetVirtualGoodImageA(Object virtualGood, String virtualGoodImageA)
{
	((VirtualGood)virtualGood).VirtualGoodImageA = virtualGoodImageA;
}
public static String ApplicasaVirtualGoodGetVirtualGoodImageB(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodImageB;
}
public static void ApplicasaVirtualGoodSetVirtualGoodImageB(Object virtualGood, String virtualGoodImageB)
{
	((VirtualGood)virtualGood).VirtualGoodImageB = virtualGoodImageB;
}
public static String ApplicasaVirtualGoodGetVirtualGoodImageC(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodImageC;
}
public static void ApplicasaVirtualGoodSetVirtualGoodImageC(Object virtualGood, String virtualGoodImageC)
{
	((VirtualGood)virtualGood).VirtualGoodImageC = virtualGoodImageC;
}
public static VirtualGoodCategory ApplicasaVirtualGoodGetVirtualGoodMainCategory(Object virtualGoodO) {
VirtualGood virtualGood=(VirtualGood)virtualGoodO;
	return virtualGood.VirtualGoodMainCategory;
}

public static void ApplicasaVirtualGoodSetVirtualGoodMainCategory(Object virtualGoodO,
VirtualGoodCategory virtualGoodMainCategory) {
	VirtualGood virtualGood=(VirtualGood)virtualGoodO;
	virtualGood.VirtualGoodMainCategory = virtualGoodMainCategory;
}
public static boolean ApplicasaVirtualGoodGetVirtualGoodIsDeal(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodIsDeal;
}
public static void ApplicasaVirtualGoodSetVirtualGoodIsDeal(Object virtualGood, boolean virtualGoodIsDeal)
{
	((VirtualGood)virtualGood).VirtualGoodIsDeal = virtualGoodIsDeal;
}
public static boolean ApplicasaVirtualGoodGetVirtualGoodConsumable(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodConsumable;
}
public static void ApplicasaVirtualGoodSetVirtualGoodConsumable(Object virtualGood, boolean virtualGoodConsumable)
{
	((VirtualGood)virtualGood).VirtualGoodConsumable = virtualGoodConsumable;
}
public static boolean ApplicasaVirtualGoodGetVirtualGoodIsStoreItem(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodIsStoreItem;
}
public static void ApplicasaVirtualGoodSetVirtualGoodIsStoreItem(Object virtualGood, boolean virtualGoodIsStoreItem)
{
	((VirtualGood)virtualGood).VirtualGoodIsStoreItem = virtualGoodIsStoreItem;
}
public static boolean ApplicasaVirtualGoodGetVirtualGoodInAppleStore(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodInAppleStore;
}
public static void ApplicasaVirtualGoodSetVirtualGoodInAppleStore(Object virtualGood, boolean virtualGoodInAppleStore)
{
	((VirtualGood)virtualGood).VirtualGoodInAppleStore = virtualGoodInAppleStore;
}
public static boolean ApplicasaVirtualGoodGetVirtualGoodInGoogleStore(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodInGoogleStore;
}
public static void ApplicasaVirtualGoodSetVirtualGoodInGoogleStore(Object virtualGood, boolean virtualGoodInGoogleStore)
{
	((VirtualGood)virtualGood).VirtualGoodInGoogleStore = virtualGoodInGoogleStore;
}
public static double ApplicasaVirtualGoodGetVirtualGoodLastUpdate(Object virtualGood)
{
	return ((VirtualGood)virtualGood).VirtualGoodLastUpdate.getTimeInMillis();
}


		/**
	 *	SKU
	 */
	public static String ApplicasaVirtualGoodGetVirtualGoodStoreProviderPrice(Object virtualGood)
	{
		if (((VirtualGood)virtualGood).VirtualGoodSkuDetail != null)
			return ((VirtualGood)virtualGood).VirtualGoodSkuDetail.getPrice();
		return "";
	}
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualGoodGetVirtualGoodStoreProviderTitle(Object virtualGood)
	{
		if (((VirtualGood)virtualGood).VirtualGoodSkuDetail != null)
			return ((VirtualGood)virtualGood).VirtualGoodSkuDetail.getTitle();
		return "";
			
	}
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualGoodGetVirtualGoodStoreProviderDescription(Object virtualGood)
	{
		if (((VirtualGood)virtualGood).VirtualGoodSkuDetail != null)
			return ((VirtualGood)virtualGood).VirtualGoodSkuDetail.getDescription();
		return "";
	}
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualGoodGetVirtualGoodStoreProviderType(Object virtualGood)
	{
		if (((VirtualGood)virtualGood).VirtualGoodSkuDetail != null)
			return ((VirtualGood)virtualGood).VirtualGoodSkuDetail.getType();
		return "";
	}
	
	// native response calls
	public static native void responseCallbackGetVirtualGoodArrayFinished(
			int uniqueGetVirtualGoodArrayFinishedID, boolean success,
			String errorMessage, int errorType,
			int listSize, List<VirtualGood> VirtualGoodArrayPtr);

	
	public static void ApplicasaVirtualGoodGetLocalArrayWithQuery(Object query, final int uniqueActionID) {
		VirtualGood.getArrayWithQuery(((LiQuery)query), new LiVirtualGoodGetArrayCallback() {
			
			@Override
			public void onGetVirtualGoodFailure(LiErrorHandler error) {
				responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
			}
			
			@Override
			public void onGetVirtualGoodComplete(List<VirtualGood> items) {
				responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), items);
			}
		});
	}
	
	public static void ApplicasaVirtualGoodsGetVirtualGoodsOfType(int type, final int uniqueActionID) {
		List<VirtualGood> items = VirtualGood.getAllVirtualGoods(GetVirtualGoodKind.values()[type]);
		responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), items);
	}
	
	public static void ApplicasaVirtualGoodsGetVirtualGoodsOfTypeByCategory(int type, Object virtualGoodCategory, final int uniqueActionID) {
		List<VirtualGood> items=null;
		try {
			items = VirtualGood.getVirtualGoodByCategory((VirtualGoodCategory)virtualGoodCategory, GetVirtualGoodKind.values()[type]);
		} catch (LiErrorHandler e) {
			e.printStackTrace();
		}
		if(items.size()>0)
		{
			responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), items);
		}
		else
		{
			responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, false, "", 1, 0, null);
		}
	}
    
    public static void ApplicasaVirtualGoodsGetVirtualGoodsOfTypeByCategoryPosition(int type, int position, final int uniqueActionID) {
        List<VirtualGood> items=null;
        try {
             items = VirtualGood.getVirtualGoodByCategoryPosition(position, GetVirtualGoodKind.values()[type]);
            } catch (LiErrorHandler e) {
                 e.printStackTrace();
                }
        if(items.size()>0)
            {
                 responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), items);
                }
        else
            {
                responseCallbackGetVirtualGoodArrayFinished(uniqueActionID, false, "", 1, 0, null);
            }
    }
    
    
    public static void ApplicasaVirtualGoodBuyWithRealMoney(Object virtualGoodObj, final int uniqueActionID) {
        VirtualGood virtualGood=(VirtualGood)virtualGoodObj;
        InAppActivity.virtualGood=virtualGood;
        InAppActivity.isVC=false;
        InAppActivity.uniqueActionID=uniqueActionID;
        Intent myIntent = new Intent(UnityPlayer.currentActivity, InAppActivity.class);
        UnityPlayer.currentActivity.startActivity(myIntent);
    }
	
	public static void ApplicasaVirtualGoodBuyQuantity(Object virtualGood, int quantity, int currencyKind, final int uniqueActionID) {
		((VirtualGood)virtualGood).buyVirtualGoods(quantity, LiCurrency.values()[currencyKind], new LiCallbackVirtualGoodRequest() {
			
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
	
	public static void ApplicasaVirtualGoodGiveQuantity(Object virtualGood, int quantity, final int uniqueActionID) {
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
	
	public static void ApplicasaVirtualGoodUseQuantity(Object virtualGood, int quantity, final int uniqueActionID) {
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
}

