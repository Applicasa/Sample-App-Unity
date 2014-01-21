//
// VirtualGood.cs
// Created by Applicasa 
// 6/24/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa
{
    public class VirtualGood
    {

#if UNITY_ANDROID
		private static AndroidJavaClass javaUnityApplicasaVirtualGood;

		public AndroidJavaObject innerVirtualGoodJavaObject;
		
		
		[DllImport("Applicasa")]
		public static extern void setGetVirtualGoodArrayFinished(GetVirtualGoodArrayFinished callback, int uniqueActionID);

#endif

        public delegate void GetVirtualGoodArrayFinished(bool success, Error error, VirtualGoodArray virtualGoodArrayPtr);

#if UNITY_IPHONE
        public VirtualGood(IntPtr virtualGoodPtr)
        {
            innerVirtualGood = virtualGoodPtr;
        }
#endif

#if UNITY_ANDROID
		public VirtualGood(IntPtr virtualGoodPtr, AndroidJavaObject virtualGoodJavaObject) {
			innerVirtualGood = virtualGoodPtr;
			innerVirtualGoodJavaObject = virtualGoodJavaObject;
			if(javaUnityApplicasaVirtualGood==null)
				javaUnityApplicasaVirtualGood = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGood");
		}
#endif
#if UNITY_ANDROID
		~VirtualGood() {
			AndroidJNI.DeleteGlobalRef(innerVirtualGood);
		}
#endif

        public struct VirtualGoodArray
        {
            public int ArraySize;
            public IntPtr Array;
        }

#if UNITY_ANDROID && !UNITY_EDITOR	
			public static VirtualGood[] GetVirtualGoodArray(VirtualGoodArray virtualGoodArray) {
			
			VirtualGood[] virtualGoodInner = new VirtualGood[virtualGoodArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(virtualGoodArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					virtualGoodInner[count] = new VirtualGood(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return virtualGoodInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static VirtualGood[] GetVirtualGoodArray(VirtualGoodArray virtualGoodArray) {
			VirtualGood[] virtualGoods = new VirtualGood[virtualGoodArray.ArraySize];

			for (int i=0; i < virtualGoodArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (virtualGoodArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				virtualGoods[i] = new VirtualGood(newPtr);
			}
			return virtualGoods;
		}
#else
		public static VirtualGood[] GetVirtualGoodArray(VirtualGoodArray virtualGoodArray) {
			VirtualGood[] virtualGoods = new VirtualGood[0];
			return virtualGoods;
		}
#endif

        #region Class Methods and Members

        public IntPtr innerVirtualGood;

        	#region Class Members
#if UNITY_IPHONE

		public string VirtualGoodID {
			get {return ApplicasaVirtualGoodGetVirtualGoodID(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodID(innerVirtualGood, value);}
		}
		public string VirtualGoodTitle {
			get {return ApplicasaVirtualGoodGetVirtualGoodTitle(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodTitle(innerVirtualGood, value);}
		}
		public string VirtualGoodDescription {
			get {return ApplicasaVirtualGoodGetVirtualGoodDescription(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodDescription(innerVirtualGood, value);}
		}
		public string VirtualGoodAppleIdentifier {
			get {return ApplicasaVirtualGoodGetVirtualGoodAppleIdentifier(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodAppleIdentifier(innerVirtualGood, value);}
		}
		public string VirtualGoodGoogleIdentifier {
			get {return ApplicasaVirtualGoodGetVirtualGoodGoogleIdentifier(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodGoogleIdentifier(innerVirtualGood, value);}
		}
		public int VirtualGoodMainCurrency {
			get {return ApplicasaVirtualGoodGetVirtualGoodMainCurrency(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodMainCurrency(innerVirtualGood, value);}
		}
		public int VirtualGoodSecondaryCurrency {
			get {return ApplicasaVirtualGoodGetVirtualGoodSecondaryCurrency(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodSecondaryCurrency(innerVirtualGood, value);}
		}
		public string VirtualGoodRelatedVirtualGood {
			get {return ApplicasaVirtualGoodGetVirtualGoodRelatedVirtualGood(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodRelatedVirtualGood(innerVirtualGood, value);}
		}
		public float VirtualGoodIOSBundleMin {
			get {return ApplicasaVirtualGoodGetVirtualGoodIOSBundleMin(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodIOSBundleMin(innerVirtualGood, value);}
		}
		public float VirtualGoodIOSBundleMax {
			get {return ApplicasaVirtualGoodGetVirtualGoodIOSBundleMax(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodIOSBundleMax(innerVirtualGood, value);}
		}
		public float VirtualGoodAndroidBundleMin {
			get {return ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMin(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMin(innerVirtualGood, value);}
		}
		public float VirtualGoodAndroidBundleMax {
			get {return ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMax(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMax(innerVirtualGood, value);}
		}
		public float VirtualGoodStoreItemPrice {
			get {return ApplicasaVirtualGoodGetVirtualGoodStoreItemPrice(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodStoreItemPrice(innerVirtualGood, value);}
		}
		public int VirtualGoodQuantity {
			get {return ApplicasaVirtualGoodGetVirtualGoodQuantity(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodQuantity(innerVirtualGood, value);}
		}
		public int VirtualGoodMaxForUser {
			get {return ApplicasaVirtualGoodGetVirtualGoodMaxForUser(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodMaxForUser(innerVirtualGood, value);}
		}
		public int VirtualGoodUserInventory {
			get {return ApplicasaVirtualGoodGetVirtualGoodUserInventory(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodUserInventory(innerVirtualGood, value);}
		}
		public int VirtualGoodPos {
			get {return ApplicasaVirtualGoodGetVirtualGoodPos(innerVirtualGood);}
		}
		public string VirtualGoodImageA {
			get {return ApplicasaVirtualGoodGetVirtualGoodImageA(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodImageA(innerVirtualGood, value);}
		}
		public string VirtualGoodImageB {
			get {return ApplicasaVirtualGoodGetVirtualGoodImageB(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodImageB(innerVirtualGood, value);}
		}
		public string VirtualGoodImageC {
			get {return ApplicasaVirtualGoodGetVirtualGoodImageC(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodImageC(innerVirtualGood, value);}
		}
		public VirtualGoodCategory VirtualGoodMainCategory {
			get {return new VirtualGoodCategory(ApplicasaVirtualGoodGetVirtualGoodMainCategory(innerVirtualGood));}
			set {ApplicasaVirtualGoodSetVirtualGoodMainCategory(innerVirtualGood, value.innerVirtualGoodCategory);}
		}
		public bool VirtualGoodIsDeal {
			get {return ApplicasaVirtualGoodGetVirtualGoodIsDeal(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodIsDeal(innerVirtualGood, value);}
		}
		public bool VirtualGoodConsumable {
			get {return ApplicasaVirtualGoodGetVirtualGoodConsumable(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodConsumable(innerVirtualGood, value);}
		}
		public bool VirtualGoodInAppleStore {
			get {return ApplicasaVirtualGoodGetVirtualGoodInAppleStore(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodInAppleStore(innerVirtualGood, value);}
		}
		public bool VirtualGoodInGoogleStore {
			get {return ApplicasaVirtualGoodGetVirtualGoodInGoogleStore(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodInGoogleStore(innerVirtualGood, value);}
		}
		public bool VirtualGoodIsStoreItem {
			get {return ApplicasaVirtualGoodGetVirtualGoodIsStoreItem(innerVirtualGood);}
			set {ApplicasaVirtualGoodSetVirtualGoodIsStoreItem(innerVirtualGood, value);}
		}
		public DateTime VirtualGoodLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaVirtualGoodGetVirtualGoodLastUpdate(innerVirtualGood));}
		}
	public SKProduct Product {
		get {return ApplicasaVirtualGoodGetProduct(innerVirtualGood);}
	}
	public string LocalPrice {
		get {return ApplicasaVirtualGoodGetItunesPrice(innerVirtualGood);}
	}

	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodID(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodID(System.IntPtr virtualGood, string virtualGoodID);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodTitle(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodTitle(System.IntPtr virtualGood, string virtualGoodTitle);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodDescription(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodDescription(System.IntPtr virtualGood, string virtualGoodDescription);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodAppleIdentifier(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodAppleIdentifier(System.IntPtr virtualGood, string virtualGoodAppleIdentifier);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodGoogleIdentifier(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodGoogleIdentifier(System.IntPtr virtualGood, string virtualGoodGoogleIdentifier);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodGetVirtualGoodMainCurrency(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodMainCurrency(System.IntPtr virtualGood, int virtualGoodMainCurrency);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodGetVirtualGoodSecondaryCurrency(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodSecondaryCurrency(System.IntPtr virtualGood, int virtualGoodSecondaryCurrency);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodRelatedVirtualGood(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodRelatedVirtualGood(System.IntPtr virtualGood, string virtualGoodRelatedVirtualGood);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualGoodGetVirtualGoodIOSBundleMin(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodIOSBundleMin(System.IntPtr virtualGood, float virtualGoodIOSBundleMin);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualGoodGetVirtualGoodIOSBundleMax(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodIOSBundleMax(System.IntPtr virtualGood, float virtualGoodIOSBundleMax);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMin(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMin(System.IntPtr virtualGood, float virtualGoodAndroidBundleMin);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMax(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMax(System.IntPtr virtualGood, float virtualGoodAndroidBundleMax);
	[DllImport("__Internal")]
	private static extern float ApplicasaVirtualGoodGetVirtualGoodStoreItemPrice(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodStoreItemPrice(System.IntPtr virtualGood, float virtualGoodStoreItemPrice);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodGetVirtualGoodQuantity(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodQuantity(System.IntPtr virtualGood, int virtualGoodQuantity);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodGetVirtualGoodMaxForUser(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodMaxForUser(System.IntPtr virtualGood, int virtualGoodMaxForUser);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodGetVirtualGoodUserInventory(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodUserInventory(System.IntPtr virtualGood, int virtualGoodUserInventory);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodGetVirtualGoodPos(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodImageA(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodImageA(System.IntPtr virtualGood, string virtualGoodImageA);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodImageB(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodImageB(System.IntPtr virtualGood, string virtualGoodImageB);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetVirtualGoodImageC(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodImageC(System.IntPtr virtualGood, string virtualGoodImageC);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaVirtualGoodGetVirtualGoodMainCategory(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodMainCategory(System.IntPtr virtualGood, IntPtr virtualGoodMainCategory);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualGoodGetVirtualGoodIsDeal(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodIsDeal(System.IntPtr virtualGood, bool virtualGoodIsDeal);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualGoodGetVirtualGoodConsumable(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodConsumable(System.IntPtr virtualGood, bool virtualGoodConsumable);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualGoodGetVirtualGoodInAppleStore(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodInAppleStore(System.IntPtr virtualGood, bool virtualGoodInAppleStore);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualGoodGetVirtualGoodInGoogleStore(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodInGoogleStore(System.IntPtr virtualGood, bool virtualGoodInGoogleStore);
	[DllImport("__Internal")]
	private static extern bool ApplicasaVirtualGoodGetVirtualGoodIsStoreItem(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodSetVirtualGoodIsStoreItem(System.IntPtr virtualGood, bool virtualGoodIsStoreItem);
	[DllImport("__Internal")]
	private static extern double ApplicasaVirtualGoodGetVirtualGoodLastUpdate(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern SKProduct ApplicasaVirtualGoodGetProduct(System.IntPtr virtualGood);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodGetItunesPrice(System.IntPtr virtualGood);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string VirtualGoodID {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodID", innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodID", innerVirtualGoodJavaObject, value);}
		}
		public string VirtualGoodTitle {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodTitle", innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodTitle", innerVirtualGoodJavaObject, value);}
		}
		public string VirtualGoodDescription {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodDescription", innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodDescription", innerVirtualGoodJavaObject, value);}
		}
		public string VirtualGoodAppleIdentifier {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodAppleIdentifier", innerVirtualGoodJavaObject);}
		}
		public string VirtualGoodGoogleIdentifier {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodGoogleIdentifier", innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodGoogleIdentifier", innerVirtualGoodJavaObject, value);}
		}
		public int VirtualGoodMainCurrency {
			get {return javaUnityApplicasaVirtualGood.CallStatic<int>("ApplicasaVirtualGoodGetVirtualGoodMainCurrency",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodMainCurrency",innerVirtualGoodJavaObject, value);}
		}
		public int VirtualGoodSecondaryCurrency {
			get {return javaUnityApplicasaVirtualGood.CallStatic<int>("ApplicasaVirtualGoodGetVirtualGoodSecondaryCurrency",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodSecondaryCurrency",innerVirtualGoodJavaObject, value);}
		}
		public string VirtualGoodRelatedVirtualGood {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodRelatedVirtualGood", innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodRelatedVirtualGood", innerVirtualGoodJavaObject, value);}
		}
		public float VirtualGoodIOSBundleMin {
			get {return javaUnityApplicasaVirtualGood.CallStatic<float>("ApplicasaVirtualGoodGetVirtualGoodIOSBundleMin",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodIOSBundleMin",innerVirtualGoodJavaObject, value);}
		}
		public float VirtualGoodIOSBundleMax {
			get {return javaUnityApplicasaVirtualGood.CallStatic<float>("ApplicasaVirtualGoodGetVirtualGoodIOSBundleMax",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodIOSBundleMax",innerVirtualGoodJavaObject, value);}
		}
		public float VirtualGoodAndroidBundleMin {
			get {return javaUnityApplicasaVirtualGood.CallStatic<float>("ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMin",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMin",innerVirtualGoodJavaObject, value);}
		}
		public float VirtualGoodAndroidBundleMax {
			get {return javaUnityApplicasaVirtualGood.CallStatic<float>("ApplicasaVirtualGoodGetVirtualGoodAndroidBundleMax",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodAndroidBundleMax",innerVirtualGoodJavaObject, value);}
		}
		public float VirtualGoodStoreItemPrice {
			get {return javaUnityApplicasaVirtualGood.CallStatic<float>("ApplicasaVirtualGoodGetVirtualGoodStoreItemPrice",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodStoreItemPrice",innerVirtualGoodJavaObject, value);}
		}
		public int VirtualGoodQuantity {
			get {return javaUnityApplicasaVirtualGood.CallStatic<int>("ApplicasaVirtualGoodGetVirtualGoodQuantity",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodQuantity",innerVirtualGoodJavaObject, value);}
		}
		public int VirtualGoodMaxForUser {
			get {return javaUnityApplicasaVirtualGood.CallStatic<int>("ApplicasaVirtualGoodGetVirtualGoodMaxForUser",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodMaxForUser",innerVirtualGoodJavaObject, value);}
		}
		public int VirtualGoodUserInventory {
			get {return javaUnityApplicasaVirtualGood.CallStatic<int>("ApplicasaVirtualGoodGetVirtualGoodUserInventory",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodUserInventory",innerVirtualGoodJavaObject, value);}
		}
		public int VirtualGoodPos {
			get {return javaUnityApplicasaVirtualGood.CallStatic<int>("ApplicasaVirtualGoodGetVirtualGoodPos",innerVirtualGoodJavaObject);}
		}
		public string VirtualGoodImageA {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodImageA",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodImageA",innerVirtualGoodJavaObject, value);}
		}
		public string VirtualGoodImageB {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodImageB",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodImageB",innerVirtualGoodJavaObject, value);}
		}
		public string VirtualGoodImageC {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodImageC",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodImageC",innerVirtualGoodJavaObject, value);}
		}
		public VirtualGoodCategory VirtualGoodMainCategory {
			get {
				AndroidJavaObject temp = javaUnityApplicasaVirtualGood.CallStatic<AndroidJavaObject>("ApplicasaVirtualGoodGetVirtualGoodMainCategory",innerVirtualGoodJavaObject);
				return new VirtualGoodCategory(temp.GetRawObject(),temp);
			}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodMainCategory",innerVirtualGoodJavaObject, value.innerVirtualGoodCategoryJavaObject);}
		}
		public bool VirtualGoodIsDeal {
			get {return javaUnityApplicasaVirtualGood.CallStatic<bool>("ApplicasaVirtualGoodGetVirtualGoodIsDeal",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodIsDeal",innerVirtualGoodJavaObject, value);}
		}
		public bool VirtualGoodConsumable {
			get {return javaUnityApplicasaVirtualGood.CallStatic<bool>("ApplicasaVirtualGoodGetVirtualGoodConsumable",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodConsumable",innerVirtualGoodJavaObject, value);}
		}
		public bool VirtualGoodInAppleStore {
			get {return javaUnityApplicasaVirtualGood.CallStatic<bool>("ApplicasaVirtualGoodGetVirtualGoodInAppleStore",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodInAppleStore",innerVirtualGoodJavaObject, value);}
		}
		public bool VirtualGoodInGoogleStore {
			get {return javaUnityApplicasaVirtualGood.CallStatic<bool>("ApplicasaVirtualGoodGetVirtualGoodInGoogleStore",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodInGoogleStore",innerVirtualGoodJavaObject, value);}
		}
		public bool VirtualGoodIsStoreItem {
			get {return javaUnityApplicasaVirtualGood.CallStatic<bool>("ApplicasaVirtualGoodGetVirtualGoodIsStoreItem",innerVirtualGoodJavaObject);}
			set {javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodSetVirtualGoodIsStoreItem",innerVirtualGoodJavaObject, value);}
		}
		public DateTime VirtualGoodLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(javaUnityApplicasaVirtualGood.CallStatic<double>("ApplicasaVirtualGoodGetVirtualGoodLastUpdate",innerVirtualGoodJavaObject));}
		}
		public SKProduct Product {
			get {
			SKProduct item = new SKProduct();
			item.LocalizedDescription = javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetStoreProviderDescription",innerVirtualGoodJavaObject);
			item.LocalizedTitle = javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetStoreProviderTitle",innerVirtualGoodJavaObject);
			item.Price = javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualCurrencyGetVirtualGoodStoreProviderPrice",innerVirtualGoodJavaObject);
			item.ProductIdentifier = javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetVirtualGoodAppleIdentifier",innerVirtualGoodJavaObject);
			return item;}
		}
		public string LocalPrice {
			get {return javaUnityApplicasaVirtualGood.CallStatic<string>("ApplicasaVirtualGoodGetStoreProviderPrice",innerVirtualGoodJavaObject);}
		}

#else

		public string VirtualGoodID {
			get {return "";}
			set { }
		}
		public string VirtualGoodTitle {
			get {return "";}
			set { }
		}
		public string VirtualGoodDescription {
			get {return "";}
			set { }
		}
		public string VirtualGoodAppleIdentifier {
			get {return "";}
			set { }
		}
		public string VirtualGoodGoogleIdentifier {
			get {return "";}
			set { }
		}
		public int VirtualGoodMainCurrency {
			get {return 0;}
			set { }
		}
		public int VirtualGoodSecondaryCurrency {
			get {return 0;}
			set { }
		}
		public string VirtualGoodRelatedVirtualGood {
			get {return "";}
			set { }
		}
		public float VirtualGoodIOSBundleMin {
			get {return 0;}
			set { }
		}
		public float VirtualGoodIOSBundleMax {
			get {return 0;}
			set { }
		}
		public float VirtualGoodAndroidBundleMin {
			get {return 0;}
			set { }
		}
		public float VirtualGoodAndroidBundleMax {
			get {return 0;}
			set { }
		}
		public float VirtualGoodStoreItemPrice {
			get {return 0;}
			set { }
		}
		public int VirtualGoodQuantity {
			get {return 0;}
			set { }
		}
		public int VirtualGoodMaxForUser {
			get {return 0;}
			set { }
		}
		public int VirtualGoodUserInventory {
			get {return 0;}
			set { }
		}
		public int VirtualGoodPos {
			get {return 0;}
		}
		public string VirtualGoodImageA {
			get {return "";}
			set { }
		}
		public string VirtualGoodImageB {
			get {return "";}
			set { }
		}
		public string VirtualGoodImageC {
			get {return "";}
			set { }
		}
		public VirtualGoodCategory VirtualGoodMainCategory {
			get {return null;}
			set { }
		}
		public bool VirtualGoodIsDeal {
			get {return false;}
			set { }
		}
		public bool VirtualGoodConsumable {
			get {return false;}
			set { }
		}
		public bool VirtualGoodInAppleStore {
			get {return false;}
			set { }
		}
		public bool VirtualGoodInGoogleStore {
			get {return false;}
			set { }
		}
		public bool VirtualGoodIsStoreItem {
			get {return false;}
			set { }
		}
		public DateTime VirtualGoodLastUpdate {
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




#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodBuyQuantity(System.IntPtr virtualGood, int quantity, Currency currencyKind, Action callback);
		public void Buy(int quantity, Currency currencyKind, Action action) {
			ApplicasaVirtualGoodBuyQuantity(innerVirtualGood, quantity, currencyKind, action);
		}
				
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodBuyWithRealMoney(System.IntPtr virtualGood, Action callback);
		public void BuyWithRealMoney(Action action) {
			ApplicasaVirtualGoodBuyWithRealMoney(innerVirtualGood, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodGiveQuantity(System.IntPtr virtualGood, int quantity, Action callback);
		public void Give(int quantity, Action action) {
			ApplicasaVirtualGoodGiveQuantity(innerVirtualGood, quantity, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodUseQuantity(System.IntPtr virtualGood, int quantity, Action callback);
		public void Use(int quantity, Action action) {
			ApplicasaVirtualGoodUseQuantity(innerVirtualGood, quantity, action);
		}
#elif UNITY_ANDROID && !UNITY_EDITOR
		public void Buy(int quantity, Currency currencyKind, Action action) {
			if (currencyKind == Currency.RealMoney)
				BuyWithRealMoney(action);
			else{
				int uniqueActionID=Core.currentCallbackID;
				Core.currentCallbackID++;
				Core.setActionCallback(action,uniqueActionID);
				javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodBuyQuantity", innerVirtualGoodJavaObject, quantity, (int)currencyKind, uniqueActionID);
			}
		}

		public void BuyWithRealMoney(Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
   			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodBuyWithRealMoney", innerVirtualGoodJavaObject, uniqueActionID);
  		}

		public void Give(int quantity, Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodGiveQuantity", innerVirtualGoodJavaObject, quantity, uniqueActionID);
		}

		public void Use(int quantity, Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodUseQuantity", innerVirtualGoodJavaObject, quantity, uniqueActionID);
		}
#else
        public void Buy(int quantity, Currency currencyKind, Action action)
        {
            action(true, new Error(), "", Actions.Update);
        }

        public void Give(int quantity, Action action)
        {
            action(true, new Error(), "", Actions.Update);
        }

        public void Use(int quantity, Action action)
        {
            action(true, new Error(), "", Actions.Update);
        }

		public void BuyWithRealMoney(Action action)
        {
            action(true, new Error(), "", Actions.Update);
        }

#endif
        #endregion
        #region Static Methods
#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodGetLocalArrayWithQuery(IntPtr query, GetVirtualGoodArrayFinished callback);
		public static void GetLocalArrayWithQuery(Query query, GetVirtualGoodArrayFinished callback) {
			ApplicasaVirtualGoodGetLocalArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero) ,callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodsGetVirtualGoodsOfType(VirtualGoodType type, GetVirtualGoodArrayFinished callback);
		public static void GetVirtualGoods(VirtualGoodType type, GetVirtualGoodArrayFinished callback) {
			ApplicasaVirtualGoodsGetVirtualGoodsOfType(type, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodsGetVirtualGoodsOfTypeAndCategory(VirtualGoodType type, IntPtr virtualGoodCategory, GetVirtualGoodArrayFinished callback);
		public static void GetVirtualGoods(VirtualGoodType type, VirtualGoodCategory virtualGoodCategory, GetVirtualGoodArrayFinished callback) {
			ApplicasaVirtualGoodsGetVirtualGoodsOfTypeAndCategory(type, virtualGoodCategory.innerVirtualGoodCategory, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodsGetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback);
		public static void GetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback) {
			ApplicasaVirtualGoodsGetVirtualGoodsByCategoryPosition(type, position , callback);
		}
#elif UNITY_ANDROID &&!UNITY_EDITOR
		public static void GetLocalArrayWithQuery(Query query, GetVirtualGoodArrayFinished callback) {
			if(javaUnityApplicasaVirtualGood==null)
				javaUnityApplicasaVirtualGood = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGood");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetVirtualGoodArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodGetLocalArrayWithQuery", query.innerQueryJavaObject ,uniqueActionID);
		}

		public static void GetVirtualGoods(VirtualGoodType type, GetVirtualGoodArrayFinished callback) {
			if(javaUnityApplicasaVirtualGood==null)
				javaUnityApplicasaVirtualGood = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGood");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetVirtualGoodArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodsGetVirtualGoodsOfType", (int)type, uniqueActionID);
		}

		public static void GetVirtualGoods(VirtualGoodType type, VirtualGoodCategory virtualGoodCategory, GetVirtualGoodArrayFinished callback) {
			if(javaUnityApplicasaVirtualGood==null)
				javaUnityApplicasaVirtualGood = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGood");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetVirtualGoodArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodsGetVirtualGoodsOfTypeAndCategory", (int)type, virtualGoodCategory.innerVirtualGoodCategoryJavaObject, uniqueActionID);
		}

		public static void GetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback) {
   			if(javaUnityApplicasaVirtualGood==null)
    				javaUnityApplicasaVirtualGood = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGood");
			int uniqueActionID=Core.currentCallbackID;
  			 Core.currentCallbackID++;
  			 setGetVirtualGoodArrayFinished(callback, uniqueActionID);
   			javaUnityApplicasaVirtualGood.CallStatic("ApplicasaVirtualGoodsGetVirtualGoodsByCategoryPosition", (int)type, position , uniqueActionID);
  		}

#else

        public static void GetLocalArrayWithQuery(Query query, GetVirtualGoodArrayFinished callback)
        {
            callback(true, new Error(), new VirtualGoodArray());
        }

        public static void GetVirtualGoods(VirtualGoodType type, GetVirtualGoodArrayFinished callback)
        {
            callback(true, new Error(), new VirtualGoodArray());
        }

        public static void GetVirtualGoods(VirtualGoodType type, VirtualGoodCategory virtualGoodCategory, GetVirtualGoodArrayFinished callback)
        {
            callback(true, new Error(), new VirtualGoodArray());
        }

	 	public static void GetVirtualGoodsByCategoryPosition(VirtualGoodType type, int position, VirtualGood.GetVirtualGoodArrayFinished callback) 
		{
	  	 callback(true, new Error(), new VirtualGoodArray());
		}
#endif
        #endregion
    }
}