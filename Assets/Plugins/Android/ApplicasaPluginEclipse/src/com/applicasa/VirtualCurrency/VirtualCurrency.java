package com.applicasa.VirtualCurrency;
import java.util.ArrayList;
import java.util.List;
import java.util.GregorianCalendar;

import applicasa.LiCore.communication.LiUtility;


import applicasa.LiCore.communication.LiCallback.LiCallbackAction;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualCurrencyGetByIDCallback;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualCurrencyGetArrayCallback;
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


import applicasa.kit.IAP.IAP;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPPurchase;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualCurrencyRequest;
import android.app.Activity;

public class VirtualCurrency extends VirtualCurrencyData {
 /** End of Basic SDK **/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                     ///////////////////////////////////////
//////////////////////////////////                     In App Method                   ///////////////////////////////////////
//////////////////////////////////                                                     ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
	/**
	 * Purchase from Google Store the Virtual Currency
	 * @return
	 */
	public boolean buyVirtualCurrency(Activity activity, LiCallbackIAPPurchase liCallbackIAPPurchase)
	{
		return IAP.buyVirtualCurrency(activity, this, liCallbackIAPPurchase);
	}
	
	/**
	 * Give Coins
	 * @param coins
	 * @return
	 */
	public static boolean  giveVirtualCurrency(int coins, LiCurrency licurrency, LiCallbackVirtualCurrencyRequest liCallbackVirtualCurrencyRequest )
	{
		return IAP.giveVirtualCurrency(coins, licurrency, liCallbackVirtualCurrencyRequest);
	}
	
	/**
	 * Use the Virtual Currency (e.g. decrease User's credit balance)
	 * @return
	 */
	public static boolean  useVirtualCurrency(int coins, LiCurrency licurrency, LiCallbackVirtualCurrencyRequest liCallbackVirtualCurrencyRequest)
	{
		return IAP.useVirtualCurrency(coins,licurrency,liCallbackVirtualCurrencyRequest);
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
	* Get all Virtual Currency by currency kind
	* @return list of virtual Currency
	*/
	public static List<VirtualCurrency> getAllVirtualCurrencyByKind(LiCurrency lilicurrency) 
	{
		return IAP.getAllVirtualCurrencyByKind(lilicurrency);
	} 
 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////                                                   ////////////////////////////////////////
///////////////////////////////////                    Init Method                    ////////////////////////////////////////
///////////////////////////////////                    Don't ALTER                    ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public VirtualCurrency()
	{
		this.VirtualCurrencyID = "0";
		this.VirtualCurrencyTitle = "";
		this.VirtualCurrencyAppleIdentifier = "";
		this.VirtualCurrencyGoogleIdentifier = "";
		this.VirtualCurrencyDescription = "";
		this.VirtualCurrencyPrice = 0f;
		this.VirtualCurrencyIOSBundleMin = 0f;
		this.VirtualCurrencyIOSBundleMax = 0f;
		this.VirtualCurrencyAndroidBundleMin = 0f;
		this.VirtualCurrencyAndroidBundleMax = 0f;
		this.VirtualCurrencyPos = 1;
		this.VirtualCurrencyCredit = 0;
		this.VirtualCurrencyKind = null;
		this.VirtualCurrencyImageA = "";
		this.VirtualCurrencyImageB = "";
		this.VirtualCurrencyImageC = "";
		this.VirtualCurrencyIsDeal = false;
		this.VirtualCurrencyInAppleStore = false;
		this.VirtualCurrencyInGoogleStore = false;
		(this.VirtualCurrencyLastUpdate = new GregorianCalendar()).setTimeInMillis(0);
	}

	public VirtualCurrency(Cursor cursor) 
	{
		initWithCursor(cursor);
	}
	
	public VirtualCurrency(Cursor cursor,String header,int level) 
	{
		initWithCursor(cursor,header,level);
	}
	
	public VirtualCurrency(String VirtualCurrencyID)
	{
		this.VirtualCurrencyID = VirtualCurrencyID;
	}

	/**
	* Init Object with Cursor
	* @param corsor
	* @return
	*/
	public VirtualCurrency initWithCursor(Cursor cursor)
	{
		return initWithCursor(cursor,"",0);
	}
	
	/**
	* Init Object with Cursor
	* @param corsor
	* @return
	*/
	public VirtualCurrency initWithCursor(Cursor cursor,String header,int level)
	{
		int columnIndex;
	
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyID.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyID = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyTitle.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyTitle = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyAppleIdentifier.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyAppleIdentifier = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyGoogleIdentifier.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyGoogleIdentifier = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyDescription.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyDescription = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualCurrency.VirtualCurrencyPrice.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyPrice = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualCurrency.VirtualCurrencyIOSBundleMin.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyIOSBundleMin = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualCurrency.VirtualCurrencyIOSBundleMax.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyIOSBundleMax = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualCurrency.VirtualCurrencyAndroidBundleMin.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyAndroidBundleMin = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header +LiFieldVirtualCurrency.VirtualCurrencyAndroidBundleMax.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyAndroidBundleMax = cursor.getFloat(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyPos.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyPos = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyCredit.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyCredit = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyKind.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyKind = LiCurrency.values()[cursor.getInt(columnIndex)];
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyImageA.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyImageA = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyImageB.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyImageB = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyImageC.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.VirtualCurrencyImageC = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyIsDeal.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualCurrencyIsDeal = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyInAppleStore.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualCurrencyInAppleStore = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyInGoogleStore.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.VirtualCurrencyInGoogleStore = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldVirtualCurrency.VirtualCurrencyLastUpdate.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			long dateStr = cursor.getLong(columnIndex);
			GregorianCalendar gc= new GregorianCalendar();
			gc.setTimeInMillis(dateStr);
			this.VirtualCurrencyLastUpdate = gc;
		}
		
	
		return this;
	}
	
	/**
	* Initialize values with Object
	* @param item
	* @return
	*/
	public String initWithObject(VirtualCurrency item)
	{
		this.VirtualCurrencyID			= item.VirtualCurrencyID;
		this.VirtualCurrencyTitle			= item.VirtualCurrencyTitle;
		this.VirtualCurrencyAppleIdentifier			= item.VirtualCurrencyAppleIdentifier;
		this.VirtualCurrencyGoogleIdentifier			= item.VirtualCurrencyGoogleIdentifier;
		this.VirtualCurrencyDescription			= item.VirtualCurrencyDescription;
		this.VirtualCurrencyPrice			= item.VirtualCurrencyPrice;
		this.VirtualCurrencyIOSBundleMin			= item.VirtualCurrencyIOSBundleMin;
		this.VirtualCurrencyIOSBundleMax			= item.VirtualCurrencyIOSBundleMax;
		this.VirtualCurrencyAndroidBundleMin			= item.VirtualCurrencyAndroidBundleMin;
		this.VirtualCurrencyAndroidBundleMax			= item.VirtualCurrencyAndroidBundleMax;
		this.VirtualCurrencyPos			= item.VirtualCurrencyPos;
		this.VirtualCurrencyCredit			= item.VirtualCurrencyCredit;
		this.VirtualCurrencyKind			= item.VirtualCurrencyKind;
		this.VirtualCurrencyImageA			= item.VirtualCurrencyImageA;
		this.VirtualCurrencyImageB			= item.VirtualCurrencyImageB;
		this.VirtualCurrencyImageC			= item.VirtualCurrencyImageC;
		this.VirtualCurrencyIsDeal			= item.VirtualCurrencyIsDeal;
		this.VirtualCurrencyInAppleStore			= item.VirtualCurrencyInAppleStore;
		this.VirtualCurrencyInGoogleStore			= item.VirtualCurrencyInGoogleStore;
		this.VirtualCurrencyLastUpdate			= item.VirtualCurrencyLastUpdate;
	
		return VirtualCurrencyID;
	}
	
	/**
	* Function to add the given object fields to the request parameters list
	* @param item
	* @param request
	* @return
	*/
/**
* Initialize Dictionary with VirtualCurrency item instance
* @param dictionary
* @return
*/
public LiJSONObject dictionaryRepresentation(boolean withFK) throws LiErrorHandler {

	try{
		LiJSONObject dictionary = new LiJSONObject();
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyID, VirtualCurrencyID);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyTitle, VirtualCurrencyTitle);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyAppleIdentifier, VirtualCurrencyAppleIdentifier);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyGoogleIdentifier, VirtualCurrencyGoogleIdentifier);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyDescription, VirtualCurrencyDescription);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyPrice, VirtualCurrencyPrice);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyIOSBundleMin, VirtualCurrencyIOSBundleMin);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyIOSBundleMax, VirtualCurrencyIOSBundleMax);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyAndroidBundleMin, VirtualCurrencyAndroidBundleMin);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyAndroidBundleMax, VirtualCurrencyAndroidBundleMax);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyPos, VirtualCurrencyPos);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyCredit, VirtualCurrencyCredit);
	
		if (VirtualCurrencyKind != null)
			dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyKind, VirtualCurrencyKind.ordinal());
		else
			dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyKind, 1);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyImageA, VirtualCurrencyImageA);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyImageB, VirtualCurrencyImageB);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyImageC, VirtualCurrencyImageC);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyIsDeal, VirtualCurrencyIsDeal);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyInAppleStore, VirtualCurrencyInAppleStore);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyInGoogleStore, VirtualCurrencyInGoogleStore);
	
		dictionary.put(LiFieldVirtualCurrency.VirtualCurrencyLastUpdate, LiUtility.convertDateToDictionaryRepresenataion(VirtualCurrencyLastUpdate));
	
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
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyID, LiCoreDBmanager.PRIMARY_KEY,-1);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyTitle, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyAppleIdentifier, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyGoogleIdentifier, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyDescription, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyPrice, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyIOSBundleMin, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyIOSBundleMax, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyAndroidBundleMin, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyAndroidBundleMax, LiCoreDBmanager.REAL,0f);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyPos, LiCoreDBmanager.INTEGER,1);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyCredit, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyKind, LiCoreDBmanager.INTEGER,1);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyImageA, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyImageB, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyImageC, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyIsDeal, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyInAppleStore, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyInGoogleStore, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldVirtualCurrency.VirtualCurrencyLastUpdate, LiCoreDBmanager.DATE,0);
	return dbObject;
}
	public void increment(LiFieldVirtualCurrency liFieldVirtualCurrency) throws LiErrorHandler
	{
		increment(liFieldVirtualCurrency, 1);
	}
		 
	public void increment(LiFieldVirtualCurrency liFieldVirtualCurrency, Object value) throws LiErrorHandler
	{
		String key = liFieldVirtualCurrency.toString();
		float oldValueFloat = 0;
		int oldValueInt = 0;
		Object incrementedField = getVirtualCurrencyFieldbySortType(liFieldVirtualCurrency);
		try {
			if (incrementedField instanceof Integer)
			{
				int incInt;
				if (value instanceof Integer)
					incInt = (Integer)value;
				else
					 throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR, "Incremented Value isn't of the same type as the requested field");
				int total = (Integer)incrementedField+incInt;
				setVirtualCurrencyFieldbySortType(liFieldVirtualCurrency, total);
				if (incrementedFields.has(liFieldVirtualCurrency.toString()))
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
				setVirtualCurrencyFieldbySortType(liFieldVirtualCurrency, total);
					if (incrementedFields.has(liFieldVirtualCurrency.toString()))
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
