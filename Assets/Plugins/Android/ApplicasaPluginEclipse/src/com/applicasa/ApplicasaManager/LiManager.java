package com.applicasa.ApplicasaManager;

import java.util.List;
import java.util.ArrayList;
import org.apache.http.NameValuePair;
import java.util.HashMap;
import java.util.Map;
	/** Applicasa imports **/
import com.applicasa.User.User;
import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;
import com.applicasa.VirtualGood.VirtualGood;
import applicasa.LiCore.Applicasa;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.communication.LiObjRequest.LiCallbackInitialize;
import android.content.Context;
import applicasa.LiCore.Push.LiPushManager;
import applicasa.LiJson.LiJSONArray;
import applicasa.LiJson.LiJSONException;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPInitialize;

public class LiManager {
	
	/**
	* Initialize applicasa's Framework Using application context and application Key
	* @param context
	* @param callback a callback to indicate when the initialize operation has Finished.
	* if initialize is Successful
	*/
	public static void initialize(Context context,LiCallbackInitialize liCallbackInitialize)
	{		
		Applicasa.initializeApplicasa(context,LiConfig.getApplicationKey(),liCallbackInitialize);	
	}
	
	/**
	* Initialize applicasa's Framework Using application context and application Key
	* @param context
	* @param liCallbackInitialize
	* a callback to indicate when the initialize operation has Finished.
	* if initialize is Successful
	* @param liCallbackIAPInitialize
	* a callback to indicate when the In App billing initialize operation has Finished.
	* if initialize is Successful
	*/
	public static void initialize(Context context,LiCallbackInitialize liCallbackInitialize, LiCallbackIAPInitialize liCallbackIAPInitialize) 
	{
		Applicasa.initializeApplicasa(context,LiConfig.getApplicationKey(),liCallbackInitialize, liCallbackIAPInitialize);	
	}
	
	// GCM
		
	/**
	* Register for push GCM service
	* 
	* @param senderID 
	*  GCM - project number from Google API "https://code.google.com/apis/console/#project:xxxxxxxxx"
	*  C2DM - sender Email address
	*/
		
	public static void registerToGCM()
	{
		Applicasa.registerToGCM();
	}
	
	/**
	* Unregister from push GCM service
	*/
	public static void unRegisterFromGCM()
	{
		Applicasa.unRegisterFromGCM();
	}
	
	public static boolean isRegisteredToGCM()
	{
		return Applicasa.isRegisterToGCM();
	}
	public static LiJSONArray getDataBaseCreation() throws LiJSONException
	{
		LiJSONArray array = new LiJSONArray();
		array.put(User.createDB());
		array.put(VirtualCurrency.createDB());
		array.put(VirtualGoodCategory.createDB());
		array.put(VirtualGood.createDB());
		
		return array;
	}
	protected static Map<String, LiObject> stringMap = new HashMap<String, LiObject>();
		public static enum LiObject{
		User,
		VirtualCurrency,
		VirtualGoodCategory,
		VirtualGood;
			private LiObject() {
				stringMap.put(this.toString(), this);
			}
		public static LiObject getLiObject(String key) {
			return stringMap.get(key);
		}
	};
	/**
	* 
	* @return true if Applicasa service is initialized, else false
	*/
	public static boolean isInitialized()
	{
		return Applicasa.isInitialized();
	}
}

