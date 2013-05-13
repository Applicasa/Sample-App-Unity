package com.applicasa.VirtualGood;
import java.util.ArrayList;
import java.util.List;
import java.util.GregorianCalendar;

import applicasa.LiCore.communication.LiUtility;


import applicasa.LiCore.communication.LiCallback.LiCallbackAction;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualGoodGetByIDCallback;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualGoodGetArrayCallback;
import com.applicasa.ApplicasaManager.LiManager.LiObject;

import android.database.Cursor;
import applicasa.LiCore.sqlDB.database.LiDbObject;
import applicasa.LiCore.communication.LiRequestConst.QueryKind;
import applicasa.LiCore.communication.LiUtility;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.LiCore.communication.LiObjRequest;
import applicasa.LiCore.communication.LiRequestConst.RequestCallback;
import applicasa.LiCore.communication.LiRequestConst.LiObjResponse;
import applicasa.LiCore.communication.LiFilters;
import applicasa.LiCore.communication.LiQuery;
import applicasa.LiCore.communication.LiFilters.Operation;
import applicasa.LiCore.sqlDB.database.LiCoreDBmanager;
import applicasa.LiJson.LiJSONException;
import applicasa.LiJson.LiJSONObject;


import applicasa.kit.IAP.Callbacks.LiCallbackIAPPurchase;
import android.app.Activity;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;
import applicasa.kit.IAP.IAP;
import applicasa.kit.IAP.IAP.GetVirtualGoodKind;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualGoodRequest;

public class VirtualGood extends VirtualGoodData {
 /** End of Basic SDK **/

/** End of Basic SDK **/

/**
	 * 		VirtualGood is a Special In App Billing class.
	 * 
	 * 
	 */
	 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////														//////////////////////////////////////
//////////////////////////////////						In App Method                   //////////////////////////////////////
//////////////////////////////////														//////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	/**
	 * Consume The Product with specific quantity
	 * @param quantity
	 * @return	
	 */
	public boolean useVirtualGoods(int quantity, LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest)
	{
		return IAP.useVirtualGoods(this, quantity,liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Buys specific quantity of this product, credit balance will decrease quantity * credit
	 * @param quantity
	 * @return
	 */
	public boolean buyVirtualGoods(int quantity, LiCurrency licurrency, LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest)
	{
		return IAP.buyVirtualGoods(this, quantity, licurrency,liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Buys specific quantity of this product, With real money
	 * @param quantity
	 * @return
	 */
	public boolean buyVirtualGoods(Activity activity, LiCallbackIAPPurchase liCallbackIAPPurchase)
	{
		return IAP.buyVirtualGoods(activity, this, liCallbackIAPPurchase);
	}
	
	/**
	 * Gives specific quantity of this product without any cost
	 * @param quantity
	 * @return	
	 */
	public boolean giveVirtualGoods(int quantity, LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest)
	{
		return IAP.giveVirtualGoods(this, quantity,liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Consumes  1 quantity of The Product
	 * @param quantity
	 * @return
	 */
	public boolean useVirtualGoods(LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest)
	{
		return IAP.useVirtualGoods(this, 1,liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Buy 1 quantity  of this product, credit balance will decrease quantity * credit
	 * @param quantity
	 * @return
	 */
	public boolean buyVirtualGoods(LiCurrency licurrency, LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest)
	{
		return IAP.buyVirtualGoods(this, 1, licurrency,liCallbackVirtualGoodRequest);
	}
	
	/**
	 * Gives 1 quantity of this product without any cost
	 * @param quantity
	 * @return
	 */
	public boolean giveVirtualGoods(LiCallbackVirtualGoodRequest liCallbackVirtualGoodRequest)
	{
		 return IAP.giveVirtualGoods(this, 1,liCallbackVirtualGoodRequest);
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////												    	///////////////////////////////////////
//////////////////////////////////								GET 	                ///////////////////////////////////////
//////////////////////////////////														///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	    /**
	    * A- Synchronized Method to returns an object from server by filters
	    * @param ID
	    * @return
	    * @throws LiErrorHandler
	    */
	    public static void getArrayWithQuery(LiQuery query, LiVirtualGoodGetArrayCallback liVirtualGoodGetArrayCallback)
	    {
	        LiObjRequest request = new LiObjRequest();
	        request.setClassName(kClassName);
	        request.setAction(RequestAction.GET_ARRAY);
	        request.setGet(QueryKind.LOCAL);
	        request.setQueryToRequest(query);
	        request.setCallback(callbackHandler);
	        setGetCallback(liVirtualGoodGetArrayCallback,request.requestID);
	        request.startASync();
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
		 * Get all virtual good by get kind
		 * ALL - return all virtual Good
		 * HasInventory - returns all Virtual product with a positive inventory
		 * NoInventory - returns all Virtual product with a 0 inventory
		 * @param getVirtualGoodKind
		 * @return
		 */
		public static List<VirtualGood> getVirtualGoodByCategory(VirtualGoodCategory virtualGoodCategory, GetVirtualGoodKind getVirtualGoodKind) throws LiErrorHandler 
		{
		 	 return IAP.getVirtualGoodByCategory(virtualGoodCategory, getVirtualGoodKind );
		}

		/**		* Get all virtual good by Category Position		* ALL - return all virtual Good		* HasInventory - returns all Virtual product with a positive inventory		* NoInventory - returns all Virtual product with a 0 inventory		* @param position must be > 0		* @return		*/		public static List<VirtualGood> getVirtualGoodByCategoryPosition(int position, GetVirtualGoodKind getVirtualGoodKind) throws LiErrorHandler 		{			return IAP.getVirtualGoodByCategoryPosition(position, getVirtualGoodKind);		}

	    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////														//////////////////////////////////////
//////////////////////////////////							SAVE    	                //////////////////////////////////////
//////////////////////////////////													    //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    
	    /**
		 * Saves the Object to Applicasa's Servers
		 * The method saves all of the item's value to the server
		 * If the Object has an ID the operation will update existing object in applicasa's server; otherwise an add operation will be called
		 * 
		 * In Order to Update a specific field Use the method saveFields
		 * @param actionCallback
		 * @return
		 * @throws LiErrorHandler
		 */
		public void saveForCurrentUser(LiCallbackAction liCallbackAction) 
		{
			LiObjRequest request = new LiObjRequest();
			
			// If Id is of hex representation and not 0, then the itemId is Mongo id
			if (VirtualGoodID!= "0" && LiUtility.isHex(VirtualGoodID))
			{
				request.setAction(RequestAction.UPDATE_ACTION);
				request.setRecordID(VirtualGoodID);
				request.setIncrementedFields(incrementedFields);
				resetIncrementedFields();
			}
			else
			{
				if (liCallbackAction != null)
					liCallbackAction.onFailure(new LiErrorHandler(ApplicasaResponse.RESPONSE_ERROR, "Can't add new Virtual Good from SDK only from CMS"));
				return;
			}
			
			request.setClassName(kClassName);
			request.setCallback(callbackHandler);
			request.setEnableOffline(EnableOffline);
			
			setActionCallback(liCallbackAction,request.requestID);
			// add the Values of the Object Item to the Request
			try
			{
				request = addValuesToLiObjRequest(this, request);
			}catch (LiErrorHandler error)
			{
				if (liCallbackAction != null)
					liCallbackAction.onFailure(error);
					return;
			}
			
			request.startASync();
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////														 /////////////////////////////////////
//////////////////////////////////					Callback Handler	                 /////////////////////////////////////
//////////////////////////////////														 /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



	static RequestCallback callbackHandler = new RequestCallback() {

		public void onCompleteGet(String requestID, Cursor cursor) {
			// TODO Auto-generated method stub
			List<VirtualGood> returnList = new ArrayList<VirtualGood>();
			
			returnList = BuildVirtualGoodFromCursor( cursor);
			
			Object callback = virtualGoodCallbacks.get(requestID);
			if (callback != null && callback instanceof LiVirtualGoodGetArrayCallback )
			{
				virtualGoodCallbacks.remove(requestID);
				((LiVirtualGoodGetArrayCallback)callback).onGetVirtualGoodComplete(returnList);
			}
			if (callback != null && callback instanceof LiVirtualGoodGetByIDCallback )
			{
				virtualGoodCallbacks.remove(requestID);
				((LiVirtualGoodGetByIDCallback)callback).onGetVirtualGoodComplete(returnList.get(0));
			}
	
		}
	
		public void LiException(String requestID,LiErrorHandler ex) {
			// TODO Auto-generated method stub
			Object callback = virtualGoodCallbacks.get(requestID);
			if (callback != null && callback instanceof LiVirtualGoodGetArrayCallback )
			{
				virtualGoodCallbacks.remove(requestID);
				((LiVirtualGoodGetArrayCallback)callback).onGetVirtualGoodFailure(ex);
			}
			else if (callback != null && callback instanceof LiVirtualGoodGetByIDCallback )
			{
				virtualGoodCallbacks.remove(requestID);
				((LiVirtualGoodGetByIDCallback)callback).onGetVirtualGoodFailure(ex);
			}
			else if (callback != null && callback instanceof LiCallbackAction )
			{
				virtualGoodCallbacks.remove(requestID);
				((LiCallbackAction)callback).onFailure(ex);
			}
		}
	
			public void onCompleteAction(String requestID, LiObjResponse response) {
				// TODO Auto-generated method stub
			}
	};


	public static List<VirtualGood> BuildVirtualGoodFromCursor(Cursor cursor)
	{
		List<VirtualGood> returnList = new ArrayList<VirtualGood>();
		if (cursor.getCount() == 0 ) {}// nothing received
		else
		{
				cursor.moveToFirst();
		
			while (!cursor.isAfterLast())
			{
				returnList.add(new VirtualGood(cursor));
				cursor.moveToNext();
			}			
		}
		cursor.close();
	
		return returnList;
	}


	private static void setGetCallback(LiVirtualGoodGetArrayCallback virtualGoodGetArrayCallback, String reqID) {
		// TODO Auto-generated method stub
		virtualGoodCallbacks.put(reqID, virtualGoodGetArrayCallback);
	} 
	private static void setActionCallback(LiCallbackAction  liCallbackAction, String reqID) {
		// TODO Auto-generated method stub
		virtualGoodCallbacks.put(reqID, liCallbackAction);
	}  
		 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////                                                   ////////////////////////////////////////
///////////////////////////////////                    Init Method                    ////////////////////////////////////////
///////////////////////////////////                    Don't ALTER                    ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public VirtualGood()
	{
		this.VirtualGoodID = "0";
		this.VirtualGoodTitle = "";
		this.VirtualGoodDescription = "";
		this.VirtualGoodAppleIdentifier = "";
		this.VirtualGoodGoogleIdentifier = "";
		this.VirtualGoodMainCurrency = 0;
		this.VirtualGoodSecondaryCurrency = 0;
		this.VirtualGoodRelatedVirtualGood = "";
		this.VirtualGoodStoreItemPrice = 0f;
		this.VirtualGoodIOSBundleMin = 0f;
		this.VirtualGoodIOSBundleMax = 0f;
		this.VirtualGoodAndroidBundleMin = 0f;
		this.VirtualGoodAndroidBundleMax = 0f;
		this.VirtualGoodPos = 1;
		this.VirtualGoodMaxForUser = 0;
		this.VirtualGoodUserInventory = 0;
		this.VirtualGoodQuantity = 0;
		this.VirtualGoodImageA = "";
		this.VirtualGoodImageB = "";
		this.VirtualGoodImageC = "";
		this.VirtualGoodIsDeal = false;
		this.VirtualGoodConsumable = true;
		this.VirtualGoodIsStoreItem = false;
		this.VirtualGoodInAppleStore = false;
		this.VirtualGoodInGoogleStore = false;
		(this.VirtualGoodLastUpdate = new GregorianCalendar()).setTimeInMillis(0);
		this.VirtualGoodMainCategory = new VirtualGoodCategory("0");
	}

	public VirtualGood(Cursor cursor) 
	{
		initWithCursor(cursor);
	}
	
	public VirtualGood(Cursor cursor,String header,int level) 
	{
		initWithCursor(cursor,header,level);
	}
	
	public VirtualGood(String VirtualGoodID)
	{
		this.VirtualGoodID = VirtualGoodID;
	}

	/**
	* Init Object with Cursor
	* @param corsor
	* @return
	*/
	public VirtualGood initWithCursor(Cursor cursor)
	{
		return initWithCursor(cursor,"",0);
	}
	
	/**
	* Init Object with Cursor
	* @param corsor
	* @return
	*/
	public VirtualGood initWithCursor(Cursor cursor,String header,int level)
	{
		int columnIndex;
	
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodID.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodID = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodTitle.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodTitle = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodDescription.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodDescription = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodAppleIdentifier.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodAppleIdentifier = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodGoogleIdentifier.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodGoogleIdentifier = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodMainCurrency.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodMainCurrency = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodSecondaryCurrency.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodSecondaryCurrency = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodRelatedVirtualGood.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodRelatedVirtualGood = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualGood.VirtualGoodStoreItemPrice.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodStoreItemPrice = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualGood.VirtualGoodIOSBundleMin.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodIOSBundleMin = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualGood.VirtualGoodIOSBundleMax.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodIOSBundleMax = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualGood.VirtualGoodAndroidBundleMin.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodAndroidBundleMin = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualGood.VirtualGoodAndroidBundleMax.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodAndroidBundleMax = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodPos.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodPos = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodMaxForUser.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodMaxForUser = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodUserInventory.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodUserInventory = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodQuantity.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodQuantity = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodImageA.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodImageA = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodImageB.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodImageB = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodImageC.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualGoodImageC = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodIsDeal.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualGoodIsDeal = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodConsumable.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualGoodConsumable = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodIsStoreItem.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualGoodIsStoreItem = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodInAppleStore.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualGoodInAppleStore = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodInGoogleStore.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualGoodInGoogleStore = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodLastUpdate.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			long dateStr = cursor.getLong(columnIndex);
			GregorianCalendar gc= new GregorianCalendar();
			gc.setTimeInMillis(dateStr);
			this.VirtualGoodLastUpdate = gc;
		}
		
			columnIndex = cursor.getColumnIndex(header + LiFieldVirtualGood.VirtualGoodMainCategory.toString());
			if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST && level==0)
			{ 
				this.VirtualGoodMainCategory = new VirtualGoodCategory(cursor,LiFieldVirtualGood.VirtualGoodMainCategory.toString(),level+1);
			}
			else if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST){
				this.VirtualGoodMainCategory = new VirtualGoodCategory(cursor.getString(columnIndex));
			}
	
		return this;
	}
	
	/**
	* Initialize values with Object
	* @param item
	* @return
	*/
	public String initWithObject(VirtualGood item)
	{
		this.VirtualGoodID			= item.VirtualGoodID;
		this.VirtualGoodTitle			= item.VirtualGoodTitle;
		this.VirtualGoodDescription			= item.VirtualGoodDescription;
		this.VirtualGoodAppleIdentifier			= item.VirtualGoodAppleIdentifier;
		this.VirtualGoodGoogleIdentifier			= item.VirtualGoodGoogleIdentifier;
		this.VirtualGoodMainCurrency			= item.VirtualGoodMainCurrency;
		this.VirtualGoodSecondaryCurrency			= item.VirtualGoodSecondaryCurrency;
		this.VirtualGoodRelatedVirtualGood			= item.VirtualGoodRelatedVirtualGood;
		this.VirtualGoodStoreItemPrice			= item.VirtualGoodStoreItemPrice;
		this.VirtualGoodIOSBundleMin			= item.VirtualGoodIOSBundleMin;
		this.VirtualGoodIOSBundleMax			= item.VirtualGoodIOSBundleMax;
		this.VirtualGoodAndroidBundleMin			= item.VirtualGoodAndroidBundleMin;
		this.VirtualGoodAndroidBundleMax			= item.VirtualGoodAndroidBundleMax;
		this.VirtualGoodPos			= item.VirtualGoodPos;
		this.VirtualGoodMaxForUser			= item.VirtualGoodMaxForUser;
		this.VirtualGoodUserInventory			= item.VirtualGoodUserInventory;
		this.VirtualGoodQuantity			= item.VirtualGoodQuantity;
		this.VirtualGoodImageA			= item.VirtualGoodImageA;
		this.VirtualGoodImageB			= item.VirtualGoodImageB;
		this.VirtualGoodImageC			= item.VirtualGoodImageC;
		this.VirtualGoodIsDeal			= item.VirtualGoodIsDeal;
		this.VirtualGoodConsumable			= item.VirtualGoodConsumable;
		this.VirtualGoodIsStoreItem			= item.VirtualGoodIsStoreItem;
		this.VirtualGoodInAppleStore			= item.VirtualGoodInAppleStore;
		this.VirtualGoodInGoogleStore			= item.VirtualGoodInGoogleStore;
		this.VirtualGoodLastUpdate			= item.VirtualGoodLastUpdate;
		this.VirtualGoodMainCategory			= item.VirtualGoodMainCategory;
	
		return VirtualGoodID;
	}
	
	/**
	* Function to add the given object fields to the request parameters list
	* @param item
	* @param request
	* @return
	*/
	public static LiObjRequest addValuesToLiObjRequest(VirtualGood item, LiObjRequest request) throws LiErrorHandler
	{
		if (item == null)
			throw new LiErrorHandler(ApplicasaResponse.NULL_ITEM);
		
		request.addParametersArrayValue(LiFieldVirtualGood.VirtualGoodUserInventory, item.VirtualGoodUserInventory);
		return request;
	}
	
/**
* Initialize Dictionary with VirtualGood item instance
* @param dictionary
* @return
*/
public LiJSONObject dictionaryRepresentation(boolean withFK) throws LiErrorHandler {

	try{
		LiJSONObject dictionary = new LiJSONObject();
		dictionary.put(LiFieldVirtualGood.VirtualGoodID, VirtualGoodID);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodTitle, VirtualGoodTitle);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodDescription, VirtualGoodDescription);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodAppleIdentifier, VirtualGoodAppleIdentifier);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodGoogleIdentifier, VirtualGoodGoogleIdentifier);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodMainCurrency, VirtualGoodMainCurrency);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodSecondaryCurrency, VirtualGoodSecondaryCurrency);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodRelatedVirtualGood, VirtualGoodRelatedVirtualGood);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodStoreItemPrice, VirtualGoodStoreItemPrice);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodIOSBundleMin, VirtualGoodIOSBundleMin);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodIOSBundleMax, VirtualGoodIOSBundleMax);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodAndroidBundleMin, VirtualGoodAndroidBundleMin);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodAndroidBundleMax, VirtualGoodAndroidBundleMax);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodPos, VirtualGoodPos);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodMaxForUser, VirtualGoodMaxForUser);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodUserInventory, VirtualGoodUserInventory);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodQuantity, VirtualGoodQuantity);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodImageA, VirtualGoodImageA);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodImageB, VirtualGoodImageB);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodImageC, VirtualGoodImageC);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodIsDeal, VirtualGoodIsDeal);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodConsumable, VirtualGoodConsumable);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodIsStoreItem, VirtualGoodIsStoreItem);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodInAppleStore, VirtualGoodInAppleStore);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodInGoogleStore, VirtualGoodInGoogleStore);
	
		dictionary.put(LiFieldVirtualGood.VirtualGoodLastUpdate, LiUtility.convertDateToDictionaryRepresenataion(VirtualGoodLastUpdate));
	
		if (withFK)
			dictionary.put(LiFieldVirtualGood.VirtualGoodMainCategory, VirtualGoodMainCategory.dictionaryRepresentation(true));
		else
			dictionary.put(LiFieldVirtualGood.VirtualGoodMainCategory, VirtualGoodMainCategory.VirtualGoodCategoryID);
		return dictionary;
		}
		catch (LiJSONException ex)
		{
			throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR, ex.getMessage());
		}
	}
	
	public static LiDbObject createDB() throws LiJSONException{
		LiDbObject dbObject = new LiDbObject();
		dbObject.put("LiClassName", kClassName);
		dbObject.put(LiFieldVirtualGood.VirtualGoodID, LiCoreDBmanager.PRIMARY_KEY,-1);
		dbObject.put(LiFieldVirtualGood.VirtualGoodTitle, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodDescription, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodAppleIdentifier, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodGoogleIdentifier, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodMainCurrency, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldVirtualGood.VirtualGoodSecondaryCurrency, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldVirtualGood.VirtualGoodRelatedVirtualGood, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodStoreItemPrice, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualGood.VirtualGoodIOSBundleMin, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualGood.VirtualGoodIOSBundleMax, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualGood.VirtualGoodAndroidBundleMin, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualGood.VirtualGoodAndroidBundleMax, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualGood.VirtualGoodPos, LiCoreDBmanager.INTEGER,1);
		dbObject.put(LiFieldVirtualGood.VirtualGoodMaxForUser, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldVirtualGood.VirtualGoodUserInventory, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldVirtualGood.VirtualGoodQuantity, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldVirtualGood.VirtualGoodImageA, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodImageB, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodImageC, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualGood.VirtualGoodMainCategory, LiCoreDBmanager.FOREIGN_KEY+"_VirtualGoodCategory","0");
		dbObject.put(LiFieldVirtualGood.VirtualGoodIsDeal, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualGood.VirtualGoodConsumable, LiCoreDBmanager.BOOL,true);
		dbObject.put(LiFieldVirtualGood.VirtualGoodIsStoreItem, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualGood.VirtualGoodInAppleStore, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualGood.VirtualGoodInGoogleStore, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualGood.VirtualGoodLastUpdate, LiCoreDBmanager.DATE,0);
	return dbObject;
}
	public void increment(LiFieldVirtualGood liFieldVirtualGood) throws LiErrorHandler
	{
		increment(liFieldVirtualGood, 1);
	}
		 
	public void increment(LiFieldVirtualGood liFieldVirtualGood, Object value) throws LiErrorHandler
	{
		String key = liFieldVirtualGood.toString();
		float oldValueFloat = 0;
		int oldValueInt = 0;
		Object incrementedField = getVirtualGoodFieldbySortType(liFieldVirtualGood);
		try {
			if (incrementedField instanceof Integer)
			{
				int incInt;
				if (value instanceof Integer)
					incInt = (Integer)value;
				else
					 throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR, "Incremented Value isn't of the same type as the requested field");
				int total = (Integer)incrementedField+incInt;
				setVirtualGoodFieldbySortType(liFieldVirtualGood, total);
				if (incrementedFields.has(liFieldVirtualGood.toString()))
					oldValueInt = (Integer)incrementedFields.remove(key);
	
				incrementedFields.put(key, (oldValueInt+incInt));
			}
			else if (incrementedField instanceof Float)
			{
				float incFloat;
				 if (value instanceof Float)
					incFloat = (Float)value;
				 else
					incFloat = Float.valueOf((Integer)value);
				float total = (Float)incrementedField+incFloat;
				setVirtualGoodFieldbySortType(liFieldVirtualGood, total);
					if (incrementedFields.has(liFieldVirtualGood.toString()))
						oldValueFloat = (Float)incrementedFields.remove(key);
				incrementedFields.put(key, (oldValueFloat+incFloat));
			}
			else
				throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR,"Can't increase, Specified field is not Int or Float");
		} catch (LiJSONException e) {
			// TODO Auto-generated catch block
			throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR,"Can't increase, Recheck inserted Values");
		}
	}
		 
	private void resetIncrementedFields() {
		// TODO Auto-generated method stub
		incrementedFields = new LiJSONObject();
	}
	

}
