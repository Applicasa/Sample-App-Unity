using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class PromotionManager {
		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaPromoSetLiKitPromotionDelegate(Promotion.PromotionsAvailable eventCallback);
		public static void SetLiKitPromotionDelegate(Promotion.PromotionsAvailable eventCallback) {
			ApplicasaPromoSetLiKitPromotionDelegate(eventCallback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaPromoSetLiKitPromotionDelegateAndCheck(Promotion.PromotionsAvailable eventCallback, bool checkPromotions);
		public static void SetLiKitPromotionDelegateAndCheckPromotions(Promotion.PromotionsAvailable eventCallback, bool checkPromotions) {
			ApplicasaPromoSetLiKitPromotionDelegateAndCheck(eventCallback, checkPromotions);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaPromoGetAvailablePromosWithBlock(Promotion.GetPromotionArrayFinished callback);
		public static void GetAvailablePromos(Promotion.GetPromotionArrayFinished callback) {
			ApplicasaPromoGetAvailablePromosWithBlock(callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaPromoRefreshPromotions();
		public static void RefreshPromotions() {
			ApplicasaPromoRefreshPromotions();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaPromoDismissAllPromotion();
		public static void DismissAllPromotion() {
			ApplicasaPromoDismissAllPromotion();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaRaiseCustomEvent(string value);
		public static void RaiseCustomEvent(string value) {
			ApplicasaRaiseCustomEvent(value);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR		
		private static AndroidJavaClass javaUnityApplicasaPromotionManager;
		
		[DllImport("Applicasa")]
		private static extern void setPromotionsAvailable(Promotion.PromotionsAvailable callback, int uniqueActionID);
		
		public static void SetLiKitPromotionDelegate(Promotion.PromotionsAvailable eventCallback) {
			if(javaUnityApplicasaPromotionManager==null)
				javaUnityApplicasaPromotionManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotionManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setPromotionsAvailable(eventCallback, uniqueActionID);
			javaUnityApplicasaPromotionManager.CallStatic("ApplicasaPromoSetLiKitPromotionDelegate", uniqueActionID);
		}
		
		public static void SetLiKitPromotionDelegateAndCheckPromotions(Promotion.PromotionsAvailable eventCallback, bool checkPromotions) {
			if(javaUnityApplicasaPromotionManager==null)
				javaUnityApplicasaPromotionManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotionManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setPromotionsAvailable(eventCallback, uniqueActionID);
			javaUnityApplicasaPromotionManager.CallStatic("ApplicasaPromoSetLiKitPromotionDelegateAndCheck", uniqueActionID, checkPromotions);
		}
		
		public static void GetAvailablePromos(Promotion.GetPromotionArrayFinished callback) {
			if(javaUnityApplicasaPromotionManager==null)
				javaUnityApplicasaPromotionManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotionManager");
			AndroidJavaObject promotionArrayJava=javaUnityApplicasaPromotionManager.CallStatic<AndroidJavaObject>("ApplicasaPromoGetAvailablePromosWithBlock");
			
			Promotion.PromotionArray promotionArray;
			
			promotionArray.ArraySize=promotionArrayJava.Call<int>("size");
			promotionArray.Array=promotionArrayJava.GetRawObject();
			
			callback(true, new Error(), promotionArray);
		}
		
		public static void RefreshPromotions() {
			if(javaUnityApplicasaPromotionManager==null)
				javaUnityApplicasaPromotionManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotionManager");
			javaUnityApplicasaPromotionManager.CallStatic("ApplicasaPromoRefreshPromotions");
		}
		
		public static void DismissAllPromotion() {
			if(javaUnityApplicasaPromotionManager==null)
				javaUnityApplicasaPromotionManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotionManager");
			javaUnityApplicasaPromotionManager.CallStatic("ApplicasaPromoDismissAllPromotion");
		}
		
		public static void RaiseCustomEvent(string value) {
		if(javaUnityApplicasaPromotionManager==null)
				javaUnityApplicasaPromotionManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotionManager");
			javaUnityApplicasaPromotionManager.CallStatic("ApplicasaRaiseCustomEvent", value);
		}
#else
		public static void SetLiKitPromotionDelegate(Promotion.PromotionsAvailable eventCallback) {
			eventCallback(new Promotion.PromotionArray());		
		}
		
		public static void SetLiKitPromotionDelegateAndCheckPromotions(Promotion.PromotionsAvailable eventCallback, bool checkPromotions) {
			eventCallback(new Promotion.PromotionArray());
		}
		
		public static void GetAvailablePromos(Promotion.GetPromotionArrayFinished callback) {
			callback(true, new Error(), new Promotion.PromotionArray());
		}
		
		public static void DismissAllPromotion() {
			
		}
		public static void RefreshPromotions() {
		}
		
		public static void RaiseCustomEvent(string value) {
		}
#endif
	}
}
