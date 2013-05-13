package com.applicasa.ApplicasaManager;

import java.util.List;

import android.app.Activity;
import android.content.Intent;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.communication.LiRequestConst.RequestCallback.LiCallbackGetStoreCallback;
import applicasa.LiCore.communication.LiRequestConst.RequestCallback.LiCallbackGetVirtualGoodInventory;
import applicasa.kit.IAP.IAP;
import applicasa.kit.IAP.IAP.GetVirtualGoodKind;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPBalanceChanged;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPPurchase;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualCurrencyRequest;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualGoodRequest;
import applicasa.kit.IAP.billing.Utils.LiPurchase;
import applicasa.kit.IAP.billing.Utils.LiIabHelper.OnConsumeFinishedListener;
import applicasa.kit.IAP.billing.Utils.LiIabHelper.QueryInventoryFinishedListener;

import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.applicasa.VirtualGood.VirtualGood;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;

public class LiStore {
	
	private static String TAG = LiStore.class.getName();
	
	public final static int IAB_REQUEST = 287; 
	
	/**
	 * Buy the Given virtual store - using Credits
	 * @param virtualGood
	 * @param quantity
	 * @return
	 */
	public static boolean buyVirtualGoods(VirtualGood virtualGood, int quantity,LiCurrency currency,LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest )
	{
		return  IAP.buyVirtualGoods(virtualGood, quantity, currency, liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Buy the Given virtual store - using Real Money
	 * @param virtualGood
	 * @param quantity
	 * @return
	 */
	public static boolean buyVirtualGoods(Activity activity, VirtualGood virtualGood, LiCallbackIAPPurchase liCallbackIAPPurchase)
	{
		return  IAP.buyVirtualGoods( activity,  virtualGood,  liCallbackIAPPurchase);
	}
	
	/**
	 * Buy the given app Store item - using real money
	 * @param appStoreItem
	 * @return
	 */
	public static boolean buyVirtualCurrency(Activity activity, VirtualCurrency virtualCurrency, LiCallbackIAPPurchase liCallbackIAPPurchase) {
		return IAP.buyVirtualCurrency(activity, virtualCurrency, liCallbackIAPPurchase);
	}
	
	/**
	 * Give virtualGood by given quantity 
	 * @param virtualGood
	 * @param quantity
	 * @return
	 */
	public static boolean giveVirtualGoods(VirtualGood virtualGood, int quantity,LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest ) 
	{
		return  IAP.giveVirtualGoods(virtualGood, quantity, liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Give Coins
	 * @param coins
	 * @return
	 */
	public static  boolean giveVirtualCurrency(int amount, LiCurrency currency, LiCallbackVirtualCurrencyRequest LiCallbackVirtualCurrencyRequest) 
	{
		return IAP.giveVirtualCurrency(amount, currency,LiCallbackVirtualCurrencyRequest);
	}
	
	
	/**
	 * consumes quantity of virualGood
	 * @param virtualGood
	 * @param quantity
	 * @return
	 */
	public static boolean useVirtualGoods(VirtualGood virtualGood, int quantity, LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest ) 
	{
		return IAP.useVirtualGoods( virtualGood, quantity, liCallbackVirtualGoodRequest); 
	}
	
	/**
	 * consumes coins
	 * @param coins
	 * @return
	 */
	public static boolean  useVirtualCurrency(int amount, LiCurrency currency, LiCallbackVirtualCurrencyRequest LiCallbackVirtualCurrencyRequest) 
	{
		return IAP.useVirtualCurrency(amount, currency, LiCallbackVirtualCurrencyRequest);
		
	}

	/**
	 * Get all Virtual Currency
	 * @return list of virtual Currency
	 */
	public static List<VirtualCurrency> getAllVirtualCurrency() 
	{
		return IAP.getAllVirtualCurrency();
	}
	
	/**
	 * Get all Virtual Currency By currency kind
	 * @return list of virtual Currency
	 */
	public static List<VirtualCurrency> getAllVirtualCurrencyByKind(LiCurrency currency) 
	{
		return IAP.getAllVirtualCurrencyByKind(currency);
	}

	/**
	 * Get all virtual good by get kind
	 * ALL - return all virtual Good
	 * HasInventory - returns all Virtual product with a positive inventory
	 * NoInventory - returns all Virtual product with a 0 inventory
	 * @param getVirtualGoodKind
	 * @return
	 */
	public static  List<VirtualGood> getAllVirtualGoods(GetVirtualGoodKind getVirtualGoodKind)
	{
		return IAP.getAllVirtualGoods(getVirtualGoodKind);
	}
	
	/**
	 * Get all virtual good Category
	 * @return
	 */
	public static  List<VirtualGoodCategory> getAllVirtualGoodsCategory()
	{
		return IAP.getAllVirtualGoodsCategory();
	} 
	
	
	/**
	 * Get all virtual good by get kind
	 * ALL - return all virtual Good
	 * HasInventory - returns all Virtual product with a positive inventory
	 * NoInventory - returns all Virtual product with a 0 inventory
	 * @param getVirtualGoodKind
	 * @return
	 */
	public static List<VirtualGood> getVirtualGoodByCategory(VirtualGoodCategory virtualGoodCategory, GetVirtualGoodKind getVirtualGoodKind) throws LiErrorHandler {
		// TODO Auto-generated method stub
	 	 return IAP.getVirtualGoodByCategory(virtualGoodCategory, getVirtualGoodKind );
	}
	
	/**
	 * Get VirtualGood category by Position
	 * @return
	 */
	public static List<VirtualGood> getVirtualGoodByCategoryPosition(int pos, GetVirtualGoodKind getVirtualGoodKind) throws LiErrorHandler {
		// TODO Auto-generated method stub
	 	 return IAP.getVirtualGoodByCategoryPosition( pos,  getVirtualGoodKind);
	}
	
	
	/**
	 * return User's Balance
	 * @return
	 */
	public static int getUserCurrencyBalance(LiCurrency currency){return IAP.getUserCurrencyBalance(currency);}
	
	/**
	 * Retrieves User's Inventory from the server
	 * @throws LiErrorHandler
	 */
	public static void refreshInventory(LiCallbackGetVirtualGoodInventory liCallbackGetVirtualGoodInventory) throws LiErrorHandler
	{
		IAP.refreshInventory(liCallbackGetVirtualGoodInventory);
	}
	
	
	/**
	 * Retrieves the whole store from server
	 * @throws LiErrorHandler
	 */
	
	public static void refreshStore() throws LiErrorHandler
	{
		IAP.refreshStore();
	}
	
	public static void refreshStore(LiCallbackGetStoreCallback liCallbackGetStoreCallback) throws LiErrorHandler
	{
		IAP.refreshStore(liCallbackGetStoreCallback);
	}
	
	
	
	
	
	
	/**
	 *  Reload IAP Localy
	 * @throws LiErrorHandler 
	 */
	public static void reloadIAPLocaly() throws LiErrorHandler
	{
		IAP.reloadIAPLocaly();
	}
	
	/**
	 * Reload User's Inventory from local db
	 * @throws LiErrorHandler
	 */
	public static void reloadVirtualGoodInventory() 
	{
		IAP.reloadVirtualGoodInventory();
	}

	/**
	 * return the virtual good by Id
	 * @param id
	 * @return
	 */
	public static VirtualGood getVirtualGoodById(String id) {
		// TODO Auto-generated method stub
		return IAP.getVirtualGoodById(id);
	}
	
	/**
	 * return the virtual currency deal by Id
	 * @param id
	 * @return
	 */
	public static VirtualCurrency getVirtualCurrencyDealById(String id) {
		// TODO Auto-generated method stub
		return IAP.getVirtualCurrencyDealById(id);
	}


	/**
	 * return the virtual good deal by Id
	 * @param id
	 * @return
	 */
	public static VirtualGood getVirtualGoodDealById(String id) {
		// TODO Auto-generated method stub
		return IAP.getVirtualGoodDealById(id);
	}
	
	/**
	 * After purchase is completed the calling activity will go to foreground and onActivityResult method is called,
	 * In order to complete it process this method must be called to update the usere's balance
	 * @param requestCode == LiStore.IAB_REQUEST
	 * @param resultCode
	 * @param data
	 */
	public static void onActivityResult(int requestCode, int resultCode, Intent data) {
		IAP.onActivityResult(requestCode,  resultCode,  data);
    }
	
	/**
	 * Callback that notifies when usere's balance has changed
	 * @param liCallbackIAPBalanceChanged
	 */
	public static void setLiCallbackIAPBalanceChanged(LiCallbackIAPBalanceChanged liCallbackIAPBalanceChanged)
	{
		IAP.setLiCallbackIAPBalanceChanged(liCallbackIAPBalanceChanged);
	}
	
	/**
	 * dispose the IAB service, must be called when application is destroyed
	 */
	public static void dispose()
	{
		IAP.dispose();
	}
	
	/**
	 * In cases when application restarts after in app billing purchase to complete the process this method is called during applicasa's initialization
	 * However, it can be called at any other time.
	 *  
	 */
	public static void handleFailedOnActivityResultRequests()
	{
		IAP.handleFailedOnActivityResultRequests();
	}

	/**
	 * Return the currency inventory that the user has currently
	 * @param mGotInventoryListener
	 */
	public static void queryInventoryAsync(
			QueryInventoryFinishedListener mGotInventoryListener) {
		// TODO Auto-generated method stub
		IAP.queryInventoryAsync(mGotInventoryListener);
	}
	
	/**
	 * In-App-Billing V3 requires that user's inventory is consumed before making another purchase for the same product
	 * Applicasa does that automatically for the product it manages, To enable support for other product you may use it combined with queryInventoryAsync
	 * @param purchase - the purchase to consume
	 * @param mConsumeFinishedListener
	 */
	public static void consumeAsync(LiPurchase purchase,
			OnConsumeFinishedListener mConsumeFinishedListener) {
		// TODO Auto-generated method stub
		IAP.consumeAsync(purchase, mConsumeFinishedListener);
	}
}
