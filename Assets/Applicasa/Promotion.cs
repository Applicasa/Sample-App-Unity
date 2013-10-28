using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Promotion {

#if UNITY_ANDROID
		[DllImport("Applicasa")]
		private static extern void setGetPromotionArrayFinished(GetPromotionArrayFinished callback, int uniqueActionID);
		
		[DllImport("Applicasa")]
		private static extern void setPromotionsAvailable(PromotionsAvailable callback, int uniqueActionID);
		
		[DllImport("Applicasa")]
		private static extern void setPromotionResultDelegate(PromotionResultDelegate callback, int uniqueActionID);

#endif

		public delegate void GetPromotionArrayFinished(bool success, Error error, PromotionArray promotionArrayPtr);
		public delegate void PromotionsAvailable(PromotionArray promotionArrayPtr);
		public delegate void PromotionResultDelegate(PromotionAction promoAction, Applicasa.PromotionResult result, Applicasa.PromotionResultInfo info);
		//TODO: parse info

#if UNITY_IPHONE||UnityEditor		
		public Promotion(IntPtr promotionPtr) {
			innerPromotion = promotionPtr;
		}
#endif		
#if UNITY_ANDROID
		public Promotion(IntPtr promotionPtr, AndroidJavaObject promotionJavaObject) {
			innerPromotionJavaObject = promotionJavaObject;
			if(javaUnityApplicasaPromotion==null)
				javaUnityApplicasaPromotion = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotion");
		}
#endif

		public struct PromotionArray {
			public int ArraySize;
			public IntPtr Array;
		}
		
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Promotion[] GetPromotionArray(PromotionArray promotionArray) {
			
			Promotion[] promotionInner = new Promotion[promotionArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(promotionArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					promotionInner[count] = new Promotion(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return promotionInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Promotion[] GetPromotionArray(PromotionArray promotionArray) {
			Promotion[] promotions = new Promotion[promotionArray.ArraySize];

			for (int i=0; i < promotionArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (promotionArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				promotions[i] = new Promotion(newPtr);
			}
			return promotions;
		}
#else
		public static Promotion[] GetPromotionArray(PromotionArray promotionArray) {
			Promotion[] promotions = new Promotion[0];
			return promotions;
		}
#endif
		#region Class Methods and Members

#if UNITY_ANDROID
		public Promotion(IntPtr promotionPtr) {

			if(javaUnityApplicasaPromotion==null)
				javaUnityApplicasaPromotion = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotion");
			if(innerPromotionJavaObject==null)
				innerPromotionJavaObject= new AndroidJavaObject("com.applicasa.Promotion.Promotion",promotionPtr);	
		}

		private static AndroidJavaClass javaUnityApplicasaPromotion;

		public AndroidJavaObject innerPromotionJavaObject;
#endif

#if UNITY_IPHONE


		private System.IntPtr innerPromotion;
		[DllImport("__Internal")]
		private static extern void ApplicasaPromotionShowWithBlock(System.IntPtr promotion, PromotionResultDelegate callback);
		public void Show(PromotionResultDelegate callback) {
			ApplicasaPromotionShowWithBlock(innerPromotion, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaPromotionDismiss(System.IntPtr promotion);
		public void dismiss() {
			ApplicasaPromotionDismiss(innerPromotion);
		}		

		/*
		// TODO: - (void) showOnView:(UIView *)view Block:(PromotionResultBlock)block - Can't work with UIViews yet;
		*/
#elif UNITY_ANDROID&&!UNITY_EDITOR

        public void Show(PromotionResultDelegate callback) {
            javaUnityApplicasaPromotion = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotion");
            int uniqueActionID=Core.currentCallbackID;
            Core.currentCallbackID++;
            setPromotionResultDelegate(callback, uniqueActionID);
            javaUnityApplicasaPromotion.CallStatic("ApplicasaPromotionShowWithBlock", innerPromotionJavaObject, uniqueActionID);
        }

		/*
		// TODO: - (void) showOnView:(UIView *)view Block:(PromotionResultBlock)block - Can't work with UIViews yet;
		*/
#else
		public void Show(PromotionResultDelegate callback) {
		   PromotionResultInfo tempPromotionResultInfo = new PromotionResultInfo();
		   tempPromotionResultInfo.type=PromotionResultDataType.String;
		   tempPromotionResultInfo.stringResult="";
		   callback(PromotionAction.Pressed,Applicasa.PromotionResult.Nothing,tempPromotionResultInfo);
		}
#endif


		#region Class Members
#if UNITY_IPHONE
		public string ID { 
			get {return ApplicasaPromotionGetID(innerPromotion);}
		}
		public DateTime LastUpdate { 
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaPromotionGetLastUpdate(innerPromotion));}
		}
		public string Name { 
			get {return ApplicasaPromotionGetName(innerPromotion);}
		}
		public EventTypes AppEvent { 
			get {return ApplicasaPromotionGetAppEvent(innerPromotion);}
		}
		public int MaxPerUser { 
			get {return ApplicasaPromotionGetMaxPerUser(innerPromotion);}
		}
		public int MaxPerDay { 
			get {return ApplicasaPromotionGetMaxPerDay(innerPromotion);}
		}
		public int Priority { 
			get {return ApplicasaPromotionGetPriority(innerPromotion);}
		}
		public bool ShowImmediately { 
			get {return ApplicasaPromotionGetShowImmediately(innerPromotion);}
		}
		public bool ShowOnce { 
			get {return ApplicasaPromotionGetShowOnce(innerPromotion);}
		}
		public int Gender { 
			get {return ApplicasaPromotionGetGender(innerPromotion);}
		}
		public string SpendProfile { 
			get {return ApplicasaPromotionGetSpendProfile(innerPromotion);}
		}
		public string UseProfile { 
			get {return ApplicasaPromotionGetUseProfile(innerPromotion);}
		}
		public string Country { 
			get {return ApplicasaPromotionGetCountry(innerPromotion);}
		}
		public string Age { 
			get {return ApplicasaPromotionGetAge(innerPromotion);}
		}
		public DateTime StartTime { 
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaPromotionGetStartTime(innerPromotion));}
		}
		public DateTime EndTime { 
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaPromotionGetEndTime(innerPromotion));}
		}
		public string FilterParameters { 
			get {return ApplicasaPromotionGetFilterParameters(innerPromotion);}
		}
		public string Type { 
			get {return ApplicasaPromotionGetType(innerPromotion);}
		}
		public PromotionActionKind ActionKind { 
			get {return ApplicasaPromotionGetActionKind(innerPromotion);}
		}
		public string ActionData { 
			get {return ApplicasaPromotionGetActionData(innerPromotion);}
		}
		public string Image { 
			get {return ApplicasaPromotionGetImage(innerPromotion);}
		}
		public string Button { 
			get {return ApplicasaPromotionGetButton(innerPromotion);}
		}
		public int Eligible { 
			get {return ApplicasaPromotionGetEligible(innerPromotion);}
		}
		public int Views { 
			get {return ApplicasaPromotionGetViews(innerPromotion);}
		}
		public int Used { 
			get {return ApplicasaPromotionGetUsed(innerPromotion);}
		}
		public string ImageBase { 
			get {return ApplicasaPromotionGetImageBase(innerPromotion);}
		}
		public string DefaultPhone { 
			get {return ApplicasaPromotionGetDefaultPhone(innerPromotion);}
		}
		public string DefaultTablet { 
			get {return ApplicasaPromotionGetDefaultTablet(innerPromotion);}
		}
		public string ImageOptions { 
			get {return ApplicasaPromotionGetImageOptions(innerPromotion);}
		}
		public bool WaitingToBeViewed { 
			get {return ApplicasaPromotionGetWaitingToBeViewed(innerPromotion);}
		}
		public string Identifier { 
			get {return ApplicasaPromotionGetIdentifier(innerPromotion);}
		}
		
		
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetID(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern double ApplicasaPromotionGetLastUpdate(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetName(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern EventTypes ApplicasaPromotionGetAppEvent(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetMaxPerUser(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetMaxPerDay(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetPriority(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern bool ApplicasaPromotionGetShowImmediately(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern bool ApplicasaPromotionGetShowOnce(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetGender(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetSpendProfile(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetUseProfile(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetCountry(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetAge(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern double ApplicasaPromotionGetStartTime(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern double ApplicasaPromotionGetEndTime(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetFilterParameters(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetType(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern PromotionActionKind ApplicasaPromotionGetActionKind(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetActionData(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetImage(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetButton(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetEligible(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetViews(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern int ApplicasaPromotionGetUsed(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetImageBase(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetDefaultPhone(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetDefaultTablet(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetImageOptions(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern bool ApplicasaPromotionGetWaitingToBeViewed(System.IntPtr promotion);
		[DllImport("__Internal")]
		private static extern string ApplicasaPromotionGetIdentifier(System.IntPtr promotion);
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public string ID { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetID",innerPromotionJavaObject);}
		}
		public DateTime LastUpdate { 
			get {
				using(javaUnityApplicasaPromotion)
					return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(javaUnityApplicasaPromotion.CallStatic<double>("ApplicasaPromotionGetLastUpdate",innerPromotionJavaObject));}
		}
		public string Name { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetName",innerPromotionJavaObject);}
		}
		public EventTypes AppEvent { 
			get {
				using(javaUnityApplicasaPromotion)
					return (EventTypes)javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetAppEvent",innerPromotionJavaObject);}
		}
		public int MaxPerUser { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetMaxPerUser",innerPromotionJavaObject);}
		}
		public int MaxPerDay { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetMaxPerDay",innerPromotionJavaObject);}
		}
		public int Priority { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetPriority",innerPromotionJavaObject);}
		}
		public bool ShowImmediately { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<bool>("ApplicasaPromotionGetShowImmediately",innerPromotionJavaObject);}
		}
		public bool ShowOnce { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<bool>("ApplicasaPromotionGetShowOnce",innerPromotionJavaObject);}
		}
		public int Gender { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetGender",innerPromotionJavaObject);}
		}
		public string SpendProfile { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetSpendProfile",innerPromotionJavaObject);}
		}
		public string UseProfile { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetUseProfile",innerPromotionJavaObject);}
		}
		public string Country { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetCountry",innerPromotionJavaObject);}
		}
		public string Age { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetAge",innerPromotionJavaObject);}
		}
		public DateTime StartTime { 
			get {
				using(javaUnityApplicasaPromotion)
					return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(javaUnityApplicasaPromotion.CallStatic<double>("ApplicasaPromotionGetStartTime",innerPromotionJavaObject));}
		}
		public DateTime EndTime { 
			get {
				using(javaUnityApplicasaPromotion)
					return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(javaUnityApplicasaPromotion.CallStatic<double>("ApplicasaPromotionGetEndTime",innerPromotionJavaObject));}
		}
		public string FilterParameters { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetFilterParameters",innerPromotionJavaObject);}
		}
		public string Type { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetType",innerPromotionJavaObject);}
		}
		public PromotionActionKind ActionKind { 
			get {
				using(javaUnityApplicasaPromotion)
					return (PromotionActionKind)javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetActionKind",innerPromotionJavaObject);}
		}
		public string ActionData { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetActionData",innerPromotionJavaObject);}
		}
		public string Image { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetImage",innerPromotionJavaObject);}
		}
		public string Button { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetButton",innerPromotionJavaObject);}
		}
		public int Eligible { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetEligible",innerPromotionJavaObject);}
		}
		public int Views { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetViews",innerPromotionJavaObject);}
		}
		public int Used { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<int>("ApplicasaPromotionGetUsed",innerPromotionJavaObject);}
		}
		public string ImageBase { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetImageBase",innerPromotionJavaObject);}
		}
		public string DefaultPhone { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetDefaultPhone",innerPromotionJavaObject);}
		}
		public string DefaultTablet { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetDefaultTablet",innerPromotionJavaObject);}
		}
		public string ImageOptions { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetImageOptions",innerPromotionJavaObject);}
		}
		public bool WaitingToBeViewed { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<bool>("ApplicasaPromotionGetWaitingToBeViewed",innerPromotionJavaObject);}
		}
		public string Identifier { 
			get {
				using(javaUnityApplicasaPromotion)
					return javaUnityApplicasaPromotion.CallStatic<string>("ApplicasaPromotionGetIdentifier",innerPromotionJavaObject);}
		}

			public void dismiss() {
			if (javaUnityApplicasaPromotion == null)
			    javaUnityApplicasaPromotion = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPromotion");
           
            javaUnityApplicasaPromotion.CallStatic("ApplicasaPromotionDismiss", innerPromotionJavaObject);

		}
#else
		public string ID { 
			get {return "";}
		}
		public DateTime LastUpdate { 
			get {return new DateTime();}
		}
		public string Name { 
			get {return "";}
		}
		public EventTypes AppEvent { 
			get {return new EventTypes();}
		}
		public int MaxPerUser { 
			get {return 0;}
		}
		public int MaxPerDay { 
			get {return 0;}
		}
		public int Priority { 
			get {return 0;}
		}
		public bool ShowImmediately { 
			get {return false;}
		}
		public bool ShowOnce { 
			get {return false;}
		}
		public int Gender { 
			get {return 0;}
		}
		public string SpendProfile { 
			get {return "";}
		}
		public string UseProfile { 
			get {return "";}
		}
		public string Country { 
			get {return "";}
		}
		public string Age { 
			get {return "";}
		}
		public DateTime StartTime { 
			get {return new DateTime();}
		}
		public DateTime EndTime { 
			get {return new DateTime();}
		}
		public string FilterParameters { 
			get {return "";}
		}
		public string Type { 
			get {return "";}
		}
		public PromotionActionKind ActionKind { 
			get {return PromotionActionKind.Nothing;}
		}
		public string ActionData { 
			get {return "";}
		}
		public string Image { 
			get {return "";}
		}
		public string Button { 
			get {return "";}
		}
		public int Eligible { 
			get {return 0;}
		}
		public int Views { 
			get {return 0;}
		}
		public int Used { 
			get {return 0;}
		}
		public string ImageBase { 
			get {return "";}
		}
		public string DefaultPhone { 
			get {return "";}
		}
		public string DefaultTablet { 
			get {return "";}
		}
		public string ImageOptions { 
			get {return "";}
		}
		public bool WaitingToBeViewed { 
			get {return false;}
		}
		public string Identifier { 
			get {return "";}
		}

		public void dismiss() {
		}
#endif
		#endregion

		#endregion

		#region Static Methods
		
		#endregion
	}
}