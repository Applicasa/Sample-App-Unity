//
// VirtualCurrency.cs
// Created by Applicasa 
// 6/24/2013
//

//
// VirtualCurrency.cs
// Created by Applicasa 
// 5/28/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa
{
    public class VirtualCurrency
    {
	
#if UNITY_ANDROID
		private static AndroidJavaClass javaUnityApplicasaVirtualCurrency;
		
		public AndroidJavaObject innerVirtualCurrencyJavaObject;
		
		
		[DllImport("Applicasa")]
		public static extern void setGetVirtualCurrencyArrayFinished(GetVirtualCurrencyArrayFinished callback, int uniqueActionID);
		
#endif

        public delegate void GetVirtualCurrencyArrayFinished(bool success, Error error, VirtualCurrencyArray virtualCurrencyArrayPtr);

        public VirtualCurrency(IntPtr virtualCurrencyPtr)
        {
            innerVirtualCurrency = virtualCurrencyPtr;
#if UNITY_ANDROID
			if(javaUnityApplicasaVirtualCurrency==null)
				javaUnityApplicasaVirtualCurrency = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualCurrency");
			if(innerVirtualCurrencyJavaObject==null)
				innerVirtualCurrencyJavaObject = new AndroidJavaObject(innerVirtualCurrency);
#endif
        }

#if UNITY_ANDROID
		public VirtualCurrency(IntPtr virtualCurrencyPtr, AndroidJavaObject virtualCurrencyJavaObject) {
			innerVirtualCurrency = virtualCurrencyPtr;
			innerVirtualCurrencyJavaObject = virtualCurrencyJavaObject;
			if(javaUnityApplicasaVirtualCurrency==null)
				javaUnityApplicasaVirtualCurrency = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualCurrency");
		}
#endif
#if UNITY_ANDROID		
		~VirtualCurrency() {
			AndroidJNI.DeleteGlobalRef(innerVirtualCurrency);
		}
#endif
        public struct VirtualCurrencyArray
        {
            public int ArraySize;
            public IntPtr Array;
        }

        public static VirtualCurrency[] GetVirtualCurrencyArray(VirtualCurrencyArray virtualCurrencyArray)
        {
            VirtualCurrency[] virtualCurrencies = new VirtualCurrency[virtualCurrencyArray.ArraySize];
#if UNITY_ANDROID			
			AndroidJavaObject tempJavaObjectArray=new AndroidJavaObject(virtualCurrencyArray.Array);
#endif
            for (int i = 0; i < virtualCurrencyArray.ArraySize; i++)
            {
#if UNITY_IPHONE
				IntPtr newPtr = Marshal.ReadIntPtr (virtualCurrencyArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				virtualCurrencies[i] = new VirtualCurrency(newPtr);
#endif
#if UNITY_ANDROID				
				AndroidJavaObject tempJavaObject = tempJavaObjectArray.Call<AndroidJavaObject>("get",i);
				IntPtr newPtr = AndroidJNI.NewGlobalRef(tempJavaObject.GetRawObject());				
				virtualCurrencies[i] = new VirtualCurrency(newPtr, new AndroidJavaObject(newPtr));
#endif
            }
            return virtualCurrencies;
        }

        #region Class Methods and Members

        public IntPtr innerVirtualCurrency;

        	#region Class Members
#if UNITY_IPHONE

		public string VirtualCurrencyID {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyID(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyID(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyTitle {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyTitle(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyTitle(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyAppleIdentifier {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyAppleIdentifier(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyAppleIdentifier(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyGoogleIdentifier {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyGoogleIdentifier(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyGoogleIdentifier(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyDescription {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyDescription(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyDescription(innerVirtualCurrency, value);}
		}
		public float VirtualCurrencyPrice {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyPrice(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyPrice(innerVirtualCurrency, value);}
		}
		public float VirtualCurrencyIOSBundleMin {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMin(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMin(innerVirtualCurrency, value);}
		}
		public float VirtualCurrencyIOSBundleMax {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMax(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMax(innerVirtualCurrency, value);}
		}
		public float VirtualCurrencyAndroidBundleMin {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMin(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMin(innerVirtualCurrency, value);}
		}
		public float VirtualCurrencyAndroidBundleMax {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMax(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMax(innerVirtualCurrency, value);}
		}
		public int VirtualCurrencyCredit {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyCredit(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyCredit(innerVirtualCurrency, value);}
		}
		public int VirtualCurrencyPos {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyPos(innerVirtualCurrency);}
		}
		public Currency VirtualCurrencyKind {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyKind(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyKind(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyImageA {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyImageA(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyImageA(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyImageB {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyImageB(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyImageB(innerVirtualCurrency, value);}
		}
		public string VirtualCurrencyImageC {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyImageC(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyImageC(innerVirtualCurrency, value);}
		}
		public bool VirtualCurrencyIsDeal {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyIsDeal(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyIsDeal(innerVirtualCurrency, value);}
		}
		public bool VirtualCurrencyInAppleStore {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyInAppleStore(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyInAppleStore(innerVirtualCurrency, value);}
		}
		public bool VirtualCurrencyInGoogleStore {
			get {return ApplicasaVirtualCurrencyGetVirtualCurrencyInGoogleStore(innerVirtualCurrency);}
			set {ApplicasaVirtualCurrencySetVirtualCurrencyInGoogleStore(innerVirtualCurrency, value);}
		}
		public DateTime VirtualCurrencyLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaVirtualCurrencyGetVirtualCurrencyLastUpdate(innerVirtualCurrency));}
		}
	public SKProduct Product {
		get {return ApplicasaVirtualCurrencyGetProduct(innerVirtualCurrency);}
	}
	public string LocalPrice {
		get {return ApplicasaVirtualCurrencyGetItunesPrice(innerVirtualCurrency);}
	}

	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyID(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyID(System.IntPtr virtualCurrency, string virtualCurrencyID);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyTitle(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyTitle(System.IntPtr virtualCurrency, string virtualCurrencyTitle);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyAppleIdentifier(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyAppleIdentifier(System.IntPtr virtualCurrency, string virtualCurrencyAppleIdentifier);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyGoogleIdentifier(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyGoogleIdentifier(System.IntPtr virtualCurrency, string virtualCurrencyGoogleIdentifier);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyDescription(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyDescription(System.IntPtr virtualCurrency, string virtualCurrencyDescription);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualCurrencyGetVirtualCurrencyPrice(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyPrice(System.IntPtr virtualCurrency, float virtualCurrencyPrice);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMin(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMin(System.IntPtr virtualCurrency, float virtualCurrencyIOSBundleMin);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMax(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMax(System.IntPtr virtualCurrency, float virtualCurrencyIOSBundleMax);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMin(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMin(System.IntPtr virtualCurrency, float virtualCurrencyAndroidBundleMin);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMax(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMax(System.IntPtr virtualCurrency, float virtualCurrencyAndroidBundleMax);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualCurrencyGetVirtualCurrencyCredit(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyCredit(System.IntPtr virtualCurrency, int virtualCurrencyCredit);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualCurrencyGetVirtualCurrencyPos(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern Currency ApplicasaVirtualCurrencyGetVirtualCurrencyKind(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyKind(System.IntPtr virtualCurrency, Currency virtualCurrencyKind);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyImageA(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyImageA(System.IntPtr virtualCurrency, string virtualCurrencyImageA);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyImageB(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyImageB(System.IntPtr virtualCurrency, string virtualCurrencyImageB);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetVirtualCurrencyImageC(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyImageC(System.IntPtr virtualCurrency, string virtualCurrencyImageC);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualCurrencyGetVirtualCurrencyIsDeal(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyIsDeal(System.IntPtr virtualCurrency, bool virtualCurrencyIsDeal);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualCurrencyGetVirtualCurrencyInAppleStore(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyInAppleStore(System.IntPtr virtualCurrency, bool virtualCurrencyInAppleStore);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualCurrencyGetVirtualCurrencyInGoogleStore(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualCurrencySetVirtualCurrencyInGoogleStore(System.IntPtr virtualCurrency, bool virtualCurrencyInGoogleStore);
	[DllImport("__Internal")]
	private static extern double ApplicasaVirtualCurrencyGetVirtualCurrencyLastUpdate(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern SKProduct ApplicasaVirtualCurrencyGetProduct(System.IntPtr virtualCurrency);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualCurrencyGetItunesPrice(System.IntPtr virtualCurrency);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string VirtualCurrencyID {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyID", innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyID", innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyTitle {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyTitle", innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyTitle", innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyAppleIdentifier {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyAppleIdentifier", innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyAppleIdentifier", innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyGoogleIdentifier {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyGoogleIdentifier", innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyGoogleIdentifier", innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyDescription {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyDescription", innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyDescription", innerVirtualCurrencyJavaObject, value);}
		}
		public float VirtualCurrencyPrice {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<float>("ApplicasaVirtualCurrencyGetVirtualCurrencyPrice",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyPrice",innerVirtualCurrencyJavaObject, value);}
		}
		public float VirtualCurrencyIOSBundleMin {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<float>("ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMin",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMin",innerVirtualCurrencyJavaObject, value);}
		}
		public float VirtualCurrencyIOSBundleMax {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<float>("ApplicasaVirtualCurrencyGetVirtualCurrencyIOSBundleMax",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyIOSBundleMax",innerVirtualCurrencyJavaObject, value);}
		}
		public float VirtualCurrencyAndroidBundleMin {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<float>("ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMin",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMin",innerVirtualCurrencyJavaObject, value);}
		}
		public float VirtualCurrencyAndroidBundleMax {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<float>("ApplicasaVirtualCurrencyGetVirtualCurrencyAndroidBundleMax",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyAndroidBundleMax",innerVirtualCurrencyJavaObject, value);}
		}
		public int VirtualCurrencyCredit {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<int>("ApplicasaVirtualCurrencyGetVirtualCurrencyCredit",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyCredit",innerVirtualCurrencyJavaObject, value);}
		}
		public int VirtualCurrencyPos {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<int>("ApplicasaVirtualCurrencyGetVirtualCurrencyPos",innerVirtualCurrencyJavaObject);}
		}
		public Currency VirtualCurrencyKind {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<Currency>("ApplicasaVirtualCurrencyGetVirtualCurrencyKind",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyKind",innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyImageA {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyImageA",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyImageA",innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyImageB {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyImageB",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyImageB",innerVirtualCurrencyJavaObject, value);}
		}
		public string VirtualCurrencyImageC {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyImageC",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyImageC",innerVirtualCurrencyJavaObject, value);}
		}
		public bool VirtualCurrencyIsDeal {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<bool>("ApplicasaVirtualCurrencyGetVirtualCurrencyIsDeal",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyIsDeal",innerVirtualCurrencyJavaObject, value);}
		}
		public bool VirtualCurrencyInAppleStore {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<bool>("ApplicasaVirtualCurrencyGetVirtualCurrencyInAppleStore",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyInAppleStore",innerVirtualCurrencyJavaObject, value);}
		}
		public bool VirtualCurrencyInGoogleStore {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<bool>("ApplicasaVirtualCurrencyGetVirtualCurrencyInGoogleStore",innerVirtualCurrencyJavaObject);}
			set {javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencySetVirtualCurrencyInGoogleStore",innerVirtualCurrencyJavaObject, value);}
		}
		public DateTime VirtualCurrencyLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(javaUnityApplicasaVirtualCurrency.CallStatic<double>("ApplicasaVirtualCurrencyGetVirtualCurrencyLastUpdate",innerVirtualCurrencyJavaObject));}
		}
		public SKProduct Product {
			get {
			SKProduct item = new SKProduct();
			item.LocalizedDescription = javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetProviderDescription",innerVirtualCurrencyJavaObject);
			item.LocalizedTitle = javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetProviderTitle",innerVirtualCurrencyJavaObject);
			item.Price = javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetProviderPrice",innerVirtualCurrencyJavaObject);
			item.ProductIdentifier = javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualCurrencyGoogleIdentifier",innerVirtualCurrencyJavaObject);
			
			return item;}
		}
		public string LocalPrice {
			get {return javaUnityApplicasaVirtualCurrency.CallStatic<string>("ApplicasaVirtualCurrencyGetProviderPrice",innerVirtualCurrencyJavaObject);}
		}
		

#else

		public string VirtualCurrencyID {
			get {return "";}
			set { }
		}
		public string VirtualCurrencyTitle {
			get {return "";}
			set { }
		}
		public string VirtualCurrencyAppleIdentifier {
			get {return "";}
			set { }
		}
		public string VirtualCurrencyGoogleIdentifier {
			get {return "";}
			set { }
		}
		public string VirtualCurrencyDescription {
			get {return "";}
			set { }
		}
		public float VirtualCurrencyPrice {
			get {return 0;}
			set { }
		}
		public float VirtualCurrencyIOSBundleMin {
			get {return 0;}
			set { }
		}
		public float VirtualCurrencyIOSBundleMax {
			get {return 0;}
			set { }
		}
		public float VirtualCurrencyAndroidBundleMin {
			get {return 0;}
			set { }
		}
		public float VirtualCurrencyAndroidBundleMax {
			get {return 0;}
			set { }
		}
		public int VirtualCurrencyCredit {
			get {return 0;}
			set { }
		}
		public int VirtualCurrencyPos {
			get {return 0;}
		}
		public Currency VirtualCurrencyKind {
			get {return new Currency();}
			set { }
		}
		public string VirtualCurrencyImageA {
			get {return "";}
			set { }
		}
		public string VirtualCurrencyImageB {
			get {return "";}
			set { }
		}
		public string VirtualCurrencyImageC {
			get {return "";}
			set { }
		}
		public bool VirtualCurrencyIsDeal {
			get {return false;}
			set { }
		}
		public bool VirtualCurrencyInAppleStore {
			get {return false;}
			set { }
		}
		public bool VirtualCurrencyInGoogleStore {
			get {return false;}
			set { }
		}
		public DateTime VirtualCurrencyLastUpdate {
			get {return new DateTime();}
		}
		
		public SKProduct Product {
			get {return new SKProduct();}
		}
		public string LocalPrice {
			get {return "";}
		}
#endif
#endregion


#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualCurrencyBuyVirtualCurrencyWithBlock(System.IntPtr virtualCurrency, Action callback);
		public void Buy(Action action) {
			ApplicasaVirtualCurrencyBuyVirtualCurrencyWithBlock(innerVirtualCurrency, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Buy(Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencyBuy", innerVirtualCurrencyJavaObject, uniqueActionID);
		}
#else
		public void Buy(Action action) {
			action(true,new Error(),"",Actions.Update);
		}
#endif

        #endregion
        #region Static Methods
#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualCurrencyGetVirtualCurrenciesWithBlock(GetVirtualCurrencyArrayFinished callback);
		public static void GetVirtualCurrencies(GetVirtualCurrencyArrayFinished callback) {
			ApplicasaVirtualCurrencyGetVirtualCurrenciesWithBlock(callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualCurrencyGiveAmount(int amount, Currency currencyKind , Action callback);
		public static void GiveAmount(int amount, Currency currencyKind, Action action) {
			ApplicasaVirtualCurrencyGiveAmount(amount, currencyKind, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualCurrencyUseAmount(int amount, Currency currencyKind , Action callback);
		public static void UseAmount(int amount, Currency currencyKind, Action action) {
			ApplicasaVirtualCurrencyUseAmount(amount, currencyKind, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void ApplicasaVirtualCurrencyGetVirtualCurrenciesWithBlock(GetVirtualCurrencyArrayFinished callback) {
			if(javaUnityApplicasaVirtualCurrency==null)
				javaUnityApplicasaVirtualCurrency = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualCurrency");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetVirtualCurrencyArrayFinished(callback,uniqueActionID);
			javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencyGetVirtualCurrencies", uniqueActionID);
		}
		
		public static void ApplicasaVirtualCurrencyGiveAmount(int amount, Currency currencyKind , Action callback) {
			if(javaUnityApplicasaVirtualCurrency==null)
				javaUnityApplicasaVirtualCurrency = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualCurrency");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(callback,uniqueActionID);
			javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencyGiveAmount", amount, (int)currencyKind, uniqueActionID);
		}
		
		public static void ApplicasaVirtualCurrencyUseAmount(int amount, Currency currencyKind , Action callback) {
			if(javaUnityApplicasaVirtualCurrency==null)
				javaUnityApplicasaVirtualCurrency = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualCurrency");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(callback,uniqueActionID);
			javaUnityApplicasaVirtualCurrency.CallStatic("ApplicasaVirtualCurrencyUseAmount", amount, (int)currencyKind, uniqueActionID);
		}
#else
		public static void ApplicasaVirtualCurrencyGetVirtualCurrenciesWithBlock(GetVirtualCurrencyArrayFinished callback) {
			callback(true,new Error(),new VirtualCurrencyArray());
		}
		
		public static void ApplicasaVirtualCurrencyGiveAmount(int amount, Currency currencyKind , Action callback) {
			callback(true,new Error(),"",Actions.Update);
		}
		
		public static void ApplicasaVirtualCurrencyUseAmount(int amount, Currency currencyKind , Action callback) {
			callback(true,new Error(),"",Actions.Update);
		}
#endif
        #endregion
    }
}


