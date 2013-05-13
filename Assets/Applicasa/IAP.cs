using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class IAP{	

#if UNITY_IPHONE && !UNITY_EDITOR
//		/**********************
//		 Buy Currency & Goods
//		**********************/
		
		[DllImport("__Internal")]
		private static extern string ApplicasaIAPBuyVirtualCurrency(System.IntPtr virtualCurrency, Action action);
		public static void BuyVirtualCurrency(VirtualCurrency virtualCurrency, Action action) {
			ApplicasaIAPBuyVirtualCurrency(virtualCurrency.innerVirtualCurrency, action);
		}
		
		[DllImport("__Internal")]
		private static extern string ApplicasaIAPBuyVirtualGood(System.IntPtr virtualGood, int quantity, Currency currencyKind, Action action);
		public static void BuyVirtualGood(VirtualGood virtualGood, int quantity, Currency currencyKind, Action action) {
			ApplicasaIAPBuyVirtualGood(virtualGood.innerVirtualGood, quantity, currencyKind, action);
		}
	
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPBuyWithRealMoney(System.IntPtr virtualGood, Action action);
		public static void BuyWithRealMoney(VirtualGood virtualGood, Action action) {
			ApplicasaIAPBuyWithRealMoney(virtualGood.innerVirtualGood, action);
		}
  
//		/**********************
//		 Give Currency & Goods
//		 **********************/		
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGiveAmount(int amount, Currency currencyKind, Action callback);
		public static void GiveCurrency(int amount, Currency currencyKind, Action action) {
			ApplicasaIAPGiveAmount(amount, currencyKind, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGiveVirtualGood(System.IntPtr virtualGood, int quantity, Action callback);
		public static void GiveVirtualGood(VirtualGood virtualGood, int quantity, Action action) {
			ApplicasaIAPGiveVirtualGood(virtualGood.innerVirtualGood, quantity, action);
		}
		
//		/**********************
//		 Use Currency & Goods
//		 **********************/
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPUseAmount(int amount, Currency currencyKind, Action callback);
		public static void UseCurrency(int amount, Currency currencyKind, Action action) {
			ApplicasaIAPUseAmount(amount, currencyKind, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPUseVirtualGood(System.IntPtr virtualGood, int quantity, Action callback);
		public static void UseVirtualGood(VirtualGood virtualGood, int quantity, Action action) {
			ApplicasaIAPUseVirtualGood(virtualGood.innerVirtualGood, quantity, action);
		}		

//		/**********************
//		 Query Methods
//		 **********************/

		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGetVirtualCurrenciesWithBlock(VirtualCurrency.GetVirtualCurrencyArrayFinished callback);
		public static void GetVirtualCurrencies(VirtualCurrency.GetVirtualCurrencyArrayFinished callback) {
			ApplicasaIAPGetVirtualCurrenciesWithBlock(callback);
		}		
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGetVirtualGoodsOfType(VirtualGoodType type, VirtualGood.GetVirtualGoodArrayFinished callback);
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGood.GetVirtualGoodArrayFinished callback) {
			ApplicasaIAPGetVirtualGoodsOfType(type, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGetVirtualGoodsOfTypeAndCategory(VirtualGoodType type, IntPtr virtualGoodCategory, VirtualGood.GetVirtualGoodArrayFinished callback);
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGoodCategory virtualGoodCategory, VirtualGood.GetVirtualGoodArrayFinished callback) {
			ApplicasaIAPGetVirtualGoodsOfTypeAndCategory(type, virtualGoodCategory.innerVirtualGoodCategory , callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback);
		public static void GetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback) {
			ApplicasaIAPGetVirtualGoodsByCategoryPosition(type, position , callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaIAPGetVirtualGoodCategoriesWithBlock(VirtualGoodCategory.GetVirtualGoodCategoryArrayFinished callback);
		public static void GetVirtualGoodCategories(VirtualGoodCategory.GetVirtualGoodCategoryArrayFinished callback) {
			ApplicasaIAPGetVirtualGoodCategoriesWithBlock(callback);
		}		

//		/**********************
//		 Balance Methods
//		 **********************/
		
		[DllImport("__Internal")]
		private static extern int ApplicasaIAPGetCurrentUserMainBalance();
		public static int GetCurrentUserMainBalance() {
			return ApplicasaIAPGetCurrentUserMainBalance();
		}
  
		[DllImport("__Internal")]
		private static extern int ApplicasaIAPGetCurrentUserSecondaryBalance();
		public static int GetCurrentUserSecondaryBalance() {
			return ApplicasaIAPGetCurrentUserSecondaryBalance();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaRefreshStore();
		public static IEnumerator RefreshStore(Applicasa.Manager.CallbackInitializeIAP _callbackInitializeIAP) {
		ApplicasaRefreshStore();
		while (Applicasa.Core.IAPStatus() == Applicasa.IAP_STATUS.RUNNING) {
			 yield return new WaitForSeconds(0.2f);
		   }
		if (Applicasa.Core.IAPStatus() == Applicasa.IAP_STATUS.SUCCESS)
			_callbackInitializeIAP(true, new Error());
		else
		{
			Error error = new Error();
			error.Id = (int)Applicasa.Core.IAPStatus();
			_callbackInitializeIAP(false, error);
		}
		   yield return null;
		}

		[DllImport("__Internal")]
		private static extern void ApplicasaRevalidateVirtualCurrency();
		public static IEnumerator RevalidateVirtualCurrency(Applicasa.Manager.CallbackInitializeIAP _callbackInitializeIAP) {
		ApplicasaRevalidateVirtualCurrency();
		while (Applicasa.Core.ReValidateStatus() == Applicasa.IAP_STATUS.RUNNING) {
			 yield return new WaitForSeconds(0.2f);
		   }
		   if (Applicasa.Core.ReValidateStatus() == Applicasa.IAP_STATUS.SUCCESS)
			_callbackInitializeIAP(true, new Error());
		  else
		{
			Error error = new Error();
			error.Id = (int)Applicasa.Core.ReValidateStatus();
			_callbackInitializeIAP(false, error);
		}
		   yield return null;
		}


  
#elif UNITY_ANDROID&&!UNITY_EDITOR
		
		private static AndroidJavaClass javaUnityApplicasaIAP;
		
//		/**********************
//		 Buy Currency & Goods
//		**********************/
		
		public static void BuyVirtualCurrency(VirtualCurrency virtualCurrency, Action action) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaIAP.CallStatic("ApplicasaIAPBuyVirtualCurrency",virtualCurrency.innerVirtualCurrencyJavaObject, uniqueActionID);
		}

		public static void BuyVirtualGood(VirtualGood virtualGood, int quantity, Currency currencyKind, Action action) {
			if (currencyKind  == Currency.RealMoney)
			{
				BuyWithRealMoney(virtualGood, action);
			}
			else{
				if(javaUnityApplicasaIAP==null)
					javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
				int uniqueActionID=Core.currentCallbackID;
				Core.currentCallbackID++;
				Core.setActionCallback(action,uniqueActionID);
				javaUnityApplicasaIAP.CallStatic("ApplicasaIAPBuyVirtualGood", virtualGood.innerVirtualGoodJavaObject, quantity, (int)currencyKind, uniqueActionID);
			}
		}
		
		public static void BuyWithRealMoney(VirtualGood virtualGood, Action action) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaIAP.CallStatic("ApplicasaIAPBuyWithRealMoney", virtualGood.innerVirtualGoodJavaObject, uniqueActionID);
		}
	
//		/**********************
//		 Give Currency & Goods
//		 **********************/		
		
		public static void GiveCurrency(int amount, Currency currencyKind, Action action) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaIAP.CallStatic("ApplicasaIAPGiveAmount",amount, (int)currencyKind, uniqueActionID);
		}
		
		public static void GiveVirtualGood(VirtualGood virtualGood, int quantity, Action action) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaIAP.CallStatic("ApplicasaIAPGiveVirtualGood",virtualGood.innerVirtualGoodJavaObject, quantity, uniqueActionID);
		}
		
//		/**********************
//		 Use Currency & Goods
//		 **********************/
		
		public static void UseCurrency(int amount, Currency currencyKind, Action action) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaIAP.CallStatic("ApplicasaIAPUseAmount",amount, (int)currencyKind, uniqueActionID);
		}
		
		public static void UseVirtualGood(VirtualGood virtualGood, int quantity, Action action) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaIAP.CallStatic("ApplicasaIAPUseVirtualGood",virtualGood.innerVirtualGoodJavaObject, quantity, uniqueActionID);
		}

//		/**********************
//		 Query Methods
//		 **********************/

		public static void GetVirtualCurrencies(VirtualCurrency.GetVirtualCurrencyArrayFinished callback) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			Error error;
			error.Id=1;
			error.Message="Success";
			
			AndroidJavaObject virtualCurrencyArrayJava = javaUnityApplicasaIAP.CallStatic<AndroidJavaObject>("ApplicasaIAPGetVirtualCurrenciesWithBlock");
			
			VirtualCurrency.VirtualCurrencyArray virtualCurrencyArray;
			
			virtualCurrencyArray.ArraySize=virtualCurrencyArrayJava.Call<int>("size");
			virtualCurrencyArray.Array=virtualCurrencyArrayJava.GetRawObject();
			
			callback(true,error,virtualCurrencyArray);
		}
		
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGood.GetVirtualGoodArrayFinished callback) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			Error error;
			error.Id=1;
			error.Message="Success";
			
			AndroidJavaObject virtualGoodArrayJava = javaUnityApplicasaIAP.CallStatic<AndroidJavaObject>("ApplicasaIAPGetVirtualGoodsOfType",(int)type);
			
			VirtualGood.VirtualGoodArray virtualGoodArray;
			virtualGoodArray.ArraySize=virtualGoodArrayJava.Call<int>("size");
			virtualGoodArray.Array=virtualGoodArrayJava.GetRawObject();
			
			callback(true,error,virtualGoodArray);
		}
		
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGoodCategory virtualGoodCategory, VirtualGood.GetVirtualGoodArrayFinished callback) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			Error error;
			error.Id=1;
			error.Message="Success";
			
			AndroidJavaObject virtualGoodArrayJava = javaUnityApplicasaIAP.CallStatic<AndroidJavaObject>("ApplicasaIAPGetVirtualGoodsOfTypeAndCategory",(int)type, virtualGoodCategory.innerVirtualGoodCategoryJavaObject);
			
			VirtualGood.VirtualGoodArray virtualGoodArray;
			
			virtualGoodArray.ArraySize=virtualGoodArrayJava.Call<int>("size");
			virtualGoodArray.Array=virtualGoodArrayJava.GetRawObject();
			
			callback(true,error,virtualGoodArray);
		}
		
		public static void GetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			Error error;
			error.Id=1;
			error.Message="Success";
			
			AndroidJavaObject virtualGoodArrayJava = javaUnityApplicasaIAP.CallStatic<AndroidJavaObject>("ApplicasaIAPGetVirtualGoodsOfTypeByCategoryPosition", position, (int)type);
			
			VirtualGood.VirtualGoodArray virtualGoodArray;
			
			virtualGoodArray.ArraySize=virtualGoodArrayJava.Call<int>("size");
			virtualGoodArray.Array=virtualGoodArrayJava.GetRawObject();
			
			callback(true,error,virtualGoodArray);
		}
		
		public static void GetVirtualGoodCategories(VirtualGoodCategory.GetVirtualGoodCategoryArrayFinished callback) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			Error error;
			error.Id=1;
			error.Message="Success";
			
			AndroidJavaObject virtualGoodCategoryArrayJava = javaUnityApplicasaIAP.CallStatic<AndroidJavaObject>("ApplicasaIAPGetVirtualGoodCategoriesWithBlock");
			
			VirtualGoodCategory.VirtualGoodCategoryArray virtualGoodCategoryArray;
			
			virtualGoodCategoryArray.ArraySize=virtualGoodCategoryArrayJava.Call<int>("size");
			virtualGoodCategoryArray.Array=virtualGoodCategoryArrayJava.GetRawObject();
			
			callback(true,error,virtualGoodCategoryArray);
		}		

//		/**********************
//		 Balance Methods
//		 **********************/
		
		public static int GetCurrentUserMainBalance() {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			return javaUnityApplicasaIAP.CallStatic<int>("ApplicasaIAPGetCurrentUserMainBalance");
		}
		
		public static int GetCurrentUserSecondaryBalance() {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			return javaUnityApplicasaIAP.CallStatic<int>("ApplicasaIAPGetCurrentUserSecondaryBalance");
		}
		
		public static IEnumerator RefreshStore(Applicasa.Manager.CallbackInitializeIAP _callbackInitializeIAP) {
			if(javaUnityApplicasaIAP==null)
				javaUnityApplicasaIAP = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaIAP");
			javaUnityApplicasaIAP.CallStatic("ApplicasaRefreshStore");
			_callbackInitializeIAP(true, new Error());
			yield return null;
		}
		
		public static IEnumerator RevalidateVirtualCurrency(Applicasa.Manager.CallbackInitializeIAP _callbackInitializeIAP) {
			_callbackInitializeIAP(true, new Error());
		   yield return null;
		}
#else
//		/**********************
//		 Buy Currency & Goods
//		**********************/
		
		public static void BuyVirtualCurrency(VirtualCurrency virtualCurrency, Action action) {
			action(true,new Error(),"",Actions.DoIapAction);
		}
		
		public static void BuyVirtualGood(VirtualGood virtualGood, int quantity, Currency currencyKind, Action action) {
			action(true,new Error(),"",Actions.DoIapAction);
		}
		
		public static void BuyWithRealMoney(VirtualGood virtualGood, Action action) {
			action(true,new Error(),"",Actions.DoIapAction);
		}

//		/**********************
//		 Give Currency & Goods
//		 **********************/		
		
		public static void GiveCurrency(int amount, Currency currencyKind, Action action) {
			
			action(true,new Error(),"",Actions.DoIapAction);
		}
		
		public static void GiveVirtualGood(VirtualGood virtualGood, int quantity, Action action) {
			action(true,new Error(),"",Actions.DoIapAction);
		}
		
//		/**********************
//		 Use Currency & Goods
//		 **********************/
		
		public static void UseCurrency(int amount, Currency currencyKind, Action action) {
			action(true,new Error(),"",Actions.DoIapAction);
		}
		
		public static void UseVirtualGood(VirtualGood virtualGood, int quantity, Action action) {
			action(true,new Error(),"",Actions.DoIapAction);
		}

//		/**********************
//		 Query Methods
//		 **********************/

		public static void GetVirtualCurrencies(VirtualCurrency.GetVirtualCurrencyArrayFinished callback) {
			callback(true,new Error(),new VirtualCurrency.VirtualCurrencyArray());
		}
		
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGood.GetVirtualGoodArrayFinished callback) {
			callback(true,new Error(),new VirtualGood.VirtualGoodArray());
		}
		
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGoodCategory virtualGoodCategory, VirtualGood.GetVirtualGoodArrayFinished callback) {
			callback(true,new Error(),new VirtualGood.VirtualGoodArray());
		}
		
		public static void GetVirtualGoodCategories(VirtualGoodCategory.GetVirtualGoodCategoryArrayFinished callback) {
			callback(true,new Error(),new VirtualGoodCategory.VirtualGoodCategoryArray());
		}		

//		/**********************
//		 Balance Methods
//		 **********************/
		
		public static int GetCurrentUserMainBalance() {
			return 0;
		}
		
		public static int GetCurrentUserSecondaryBalance() {
			return 0;
		}		
	
		public static IEnumerator RefreshStore(Applicasa.Manager.CallbackInitializeIAP _callbackInitializeIAP) {
			_callbackInitializeIAP(true, new Error());
			yield return null;
		}
		
		public static IEnumerator RevalidateVirtualCurrency(Applicasa.Manager.CallbackInitializeIAP _callbackInitializeIAP) {
			_callbackInitializeIAP(true, new Error());
		   yield return null;
		}
		
#endif	
	}
}
