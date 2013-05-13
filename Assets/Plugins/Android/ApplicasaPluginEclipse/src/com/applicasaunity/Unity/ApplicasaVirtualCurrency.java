//
// VirtualCurrency.java
// Created by Applicasa 
// 5/13/2013
//

package com.applicasaunity.Unity;


import java.util.List;

import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPPurchase;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualCurrencyRequest;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.IAP.LiIapAction;
import applicasa.kit.IAP.Data.VirtualItem;

import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.unity3d.player.UnityPlayer;

public class ApplicasaVirtualCurrency {
	
    static {
        System.loadLibrary("Applicasa");
    }
	
	
	

public static String ApplicasaVirtualCurrencyGetVirtualCurrencyID(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyID;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyID(Object virtualCurrency, String virtualCurrencyID)
	{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyID = virtualCurrencyID;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyTitle(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyTitle;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyTitle(Object virtualCurrency, String virtualCurrencyTitle)
	{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyTitle = virtualCurrencyTitle;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyAppleIdentifier(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyAppleIdentifier;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyAppleIdentifier(Object virtualCurrency, String virtualCurrencyAppleIdentifier)
	{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyAppleIdentifier = virtualCurrencyAppleIdentifier;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyGoogleIdentifier(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyGoogleIdentifier;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyGoogleIdentifier(Object virtualCurrency, String virtualCurrencyGoogleIdentifier)
	{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyGoogleIdentifier = virtualCurrencyGoogleIdentifier;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyDescription(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyDescription;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyDescription(Object virtualCurrency, String virtualCurrencyDescription)
	{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyDescription = virtualCurrencyDescription;
}
public static float ApplicasaVirtualCurrencyGetVirtualCurrencyPrice(Object virtualCurrencyPrice)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyPrice;
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyPrice;
}

public static void ApplicasaVirtualCurrencySetVirtualCurrencyPrice(Object virtualCurrencyObj, float virtualCurrencyPrice)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
	virtualCurrency.VirtualCurrencyPrice = virtualCurrencyPrice;
}
public static float ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMin(Object virtualCurrencyIOSBundleMin)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyIOSBundleMin;
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyIOSBundleMin;
}

public static void ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMin(Object virtualCurrencyObj, float virtualCurrencyIOSBundleMin)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
	virtualCurrency.VirtualCurrencyIOSBundleMin = virtualCurrencyIOSBundleMin;
}
public static float ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMax(Object virtualCurrencyIOSBundleMax)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyIOSBundleMax;
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyIOSBundleMax;
}

public static void ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMax(Object virtualCurrencyObj, float virtualCurrencyIOSBundleMax)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
	virtualCurrency.VirtualCurrencyIOSBundleMax = virtualCurrencyIOSBundleMax;
}
public static float ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMin(Object virtualCurrencyAndroidBundleMin)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyAndroidBundleMin;
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyAndroidBundleMin;
}

public static void ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMin(Object virtualCurrencyObj, float virtualCurrencyAndroidBundleMin)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
	virtualCurrency.VirtualCurrencyAndroidBundleMin = virtualCurrencyAndroidBundleMin;
}
public static float ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMax(Object virtualCurrencyAndroidBundleMax)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyAndroidBundleMax;
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyAndroidBundleMax;
}

public static void ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMax(Object virtualCurrencyObj, float virtualCurrencyAndroidBundleMax)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
	virtualCurrency.VirtualCurrencyAndroidBundleMax = virtualCurrencyAndroidBundleMax;
}
public static int ApplicasaVirtualCurrencyGetVirtualCurrencyPos(Object virtualCurrency)
{
return ((VirtualCurrency)virtualCurrency).VirtualCurrencyPos;
}
public static int ApplicasaVirtualCurrencyGetVirtualCurrencyCredit(Object virtualCurrency)
{
return ((VirtualCurrency)virtualCurrency).VirtualCurrencyCredit;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyCredit(Object virtualCurrency, int virtualCurrencyCredit)
	{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyCredit = virtualCurrencyCredit;
}
public static LiCurrency ApplicasaVirtualCurrencyGetVirtualCurrencyKind(Object virtualCurrencyObj)
{
	VirtualCurrency virtualCurrency=(VirtualCurrency)virtualCurrencyObj;
	return virtualCurrency.VirtualCurrencyKind;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyKind(Object virtualCurrency, LiCurrency virtualCurrencyKind)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyKind = virtualCurrencyKind;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyImageA(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyImageA;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyImageA(Object virtualCurrency, String virtualCurrencyImageA)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyImageA = virtualCurrencyImageA;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyImageB(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyImageB;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyImageB(Object virtualCurrency, String virtualCurrencyImageB)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyImageB = virtualCurrencyImageB;
}
public static String ApplicasaVirtualCurrencyGetVirtualCurrencyImageC(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyImageC;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyImageC(Object virtualCurrency, String virtualCurrencyImageC)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyImageC = virtualCurrencyImageC;
}
public static boolean ApplicasaVirtualCurrencyGetVirtualCurrencyIsDeal(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyIsDeal;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyIsDeal(Object virtualCurrency, boolean virtualCurrencyIsDeal)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyIsDeal = virtualCurrencyIsDeal;
}
public static boolean ApplicasaVirtualCurrencyGetVirtualCurrencyInAppleStore(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyInAppleStore;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyInAppleStore(Object virtualCurrency, boolean virtualCurrencyInAppleStore)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyInAppleStore = virtualCurrencyInAppleStore;
}
public static boolean ApplicasaVirtualCurrencyGetVirtualCurrencyInGoogleStore(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyInGoogleStore;
}
public static void ApplicasaVirtualCurrencySetVirtualCurrencyInGoogleStore(Object virtualCurrency, boolean virtualCurrencyInGoogleStore)
{
	((VirtualCurrency)virtualCurrency).VirtualCurrencyInGoogleStore = virtualCurrencyInGoogleStore;
}
public static double ApplicasaVirtualCurrencyGetVirtualCurrencyLastUpdate(Object virtualCurrency)
{
	return ((VirtualCurrency)virtualCurrency).VirtualCurrencyLastUpdate.getTimeInMillis();
}


	
	
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualCurrencyGetVirtualGoodStoreProviderPrice(Object virtualCurrency)
	{
		if (((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getPrice() != null)
			return ((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getPrice();
		return "";
	}
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualCurrencyGetVirtualGoodStoreProviderTitle(Object virtualCurrency)
	{
		if (((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getPrice() != null)
			return ((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getTitle();
		return "";
	}
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualCurrencyGetVirtualGoodStoreProviderDescription(Object virtualCurrency)
	{
		if (((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getPrice() != null)
			return ((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getDescription();
			return "";
	}
	/**
	 *	SKU
	 */
	public static String ApplicasaVirtualCurrencyGetVirtualGoodStoreProviderType(Object virtualCurrency)
	{
		if (((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getPrice() != null)
			return ((VirtualCurrency)virtualCurrency).VirtualCurrencySkuDetail.getType();
		return "";
	}
	
		//native response calls
		
		public static native void responseCallbackGetVirtualCurrencyArrayFinished(int uniqueGetVirtualCurrencyArrayFinishedID, boolean success, String errorMessage, int errorType, int listSize, List<VirtualCurrency> virtualCurrencyArrayPtr);
		
        public static void ApplicasaVirtualCurrencyBuy(Object vcObj, final int uniqueActionID)
        {
            VirtualCurrency vc=(VirtualCurrency)vcObj;
			ApplicasaIAP.ApplicasaIAPBuyVirtualCurrency(vc, uniqueActionID);
        }
		
		public static void ApplicasaVirtualCurrencyGetVirtualCurrencies(final int uniqueActionID) 
		{
			List<VirtualCurrency> vcList = VirtualCurrency.getAllVirtualCurrency();
			responseCallbackGetVirtualCurrencyArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), vcList.size(), vcList);
		}
		
		public static void ApplicasaVirtualCurrencyGiveAmount(int amount, int currencyKind, final int uniqueActionID) 
		{
			VirtualCurrency.giveVirtualCurrency(amount, LiCurrency.values()[currencyKind], new LiCallbackVirtualCurrencyRequest() {
				
				@Override
				public void onActionFinisedSuccessfully(LiIapAction arg0, int arg1,
						LiCurrency arg2) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), arg2.toString(), RequestAction.NONE.ordinal());
					
				}
				
				@Override
				public void onActionFailed(LiIapAction arg0, int arg1, LiCurrency arg2,
						LiErrorHandler arg3) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, arg3.errorMessage, ApplicasaResponse.toInt(arg3.errorType), "", RequestAction.NONE.ordinal());
					
				}
			});
		}
		
		public static void ApplicasaVirtualCurrencyUseAmount(int amount, int currencyKind, final int uniqueActionID) 
		{
			VirtualCurrency.useVirtualCurrency(amount, LiCurrency.values()[currencyKind], new LiCallbackVirtualCurrencyRequest() {
				
				@Override
				public void onActionFinisedSuccessfully(LiIapAction arg0, int arg1,
						LiCurrency arg2) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), arg2.toString(), RequestAction.NONE.ordinal());
					
				}
				
				@Override
				public void onActionFailed(LiIapAction arg0, int arg1, LiCurrency arg2,
						LiErrorHandler arg3) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, arg3.errorMessage, ApplicasaResponse.toInt(arg3.errorType), "", RequestAction.NONE.ordinal());
					
				}
			});
		}
}

