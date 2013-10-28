//
// ThirdPartyAction.cs
// Created by Applicasa 
// 7/24/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;


namespace Applicasa {
	public class ThirdPartyAction {	
		
        static GetThirdPartyActionArrayFinished kCallback;
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaThirdPartyAction;
	
        public AndroidJavaObject innerThirdPartyActionJavaObject;
	
        [DllImport("Applicasa")]
		private static extern void setGetObjectArrayFinished(GetThirdPartyActionArrayFinishedInner callback, int uniqueActionID);
		
#endif
		private delegate void GetThirdPartyActionArrayFinishedInner(bool success, Error error, ThirdPartyActionArray ThirdPartyActionArrayPtr);
        public delegate void GetThirdPartyActionArrayFinished(bool success, Error error, ThirdPartyAction[] result);
		
        [MonoPInvokeCallback (typeof ( Applicasa.ThirdPartyAction.GetThirdPartyActionArrayFinishedInner))]
        private static void HandleResponse(bool success, Applicasa.Error error, ThirdPartyActionArray ThirdPartyActionArrayPtr)
        {
            ThirdPartyAction[] array = null;
            if (success)
            {
                if (ThirdPartyActionArrayPtr.ArraySize >0)
                    array = GetThirdPartyActionArray(ThirdPartyActionArrayPtr);
            }
			if (kCallback!= null)
            kCallback(success, error, array);
            kCallback = null;
        }

#if UNITY_IPHONE 
		public ThirdPartyAction(IntPtr ThirdPartyActionPtr) {
			innerThirdPartyAction = ThirdPartyActionPtr;
			}
#endif
		
		
#if UNITY_ANDROID 
		public ThirdPartyAction(IntPtr ThirdPartyActionPtr, AndroidJavaObject ThirdPartyActionJavaObject) {
			innerThirdPartyAction = ThirdPartyActionPtr;
			innerThirdPartyActionJavaObject = ThirdPartyActionJavaObject;
			if(javaUnityApplicasaThirdPartyAction==null)
				javaUnityApplicasaThirdPartyAction = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaThirdPartyAction");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaThirdPartyAction();
		#endif
		
		
		public ThirdPartyAction() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaThirdPartyAction==null)
			javaUnityApplicasaThirdPartyAction = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaThirdPartyAction");
		   innerThirdPartyActionJavaObject = new AndroidJavaObject("com.applicasa.ThirdPartyAction.ThirdPartyAction");
		   innerThirdPartyAction = innerThirdPartyActionJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerThirdPartyAction = ApplicasaThirdPartyAction();
		#endif
		  }

    	
		public struct ThirdPartyActionArray {
			public int ArraySize;
			public IntPtr Array;
		}
	
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static ThirdPartyAction[] GetThirdPartyActionArray(ThirdPartyActionArray ThirdPartyActionsArray) {
			
			ThirdPartyAction[] ThirdPartyActionsInner = new ThirdPartyAction[ThirdPartyActionsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(ThirdPartyActionsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					ThirdPartyActionsInner[count] = new ThirdPartyAction(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return ThirdPartyActionsInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static ThirdPartyAction[] GetThirdPartyActionArray(ThirdPartyActionArray ThirdPartyActionsArray) {
			ThirdPartyAction[] ThirdPartyActions = new ThirdPartyAction[ThirdPartyActionsArray.ArraySize];

			for (int i=0; i < ThirdPartyActionsArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (ThirdPartyActionsArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				ThirdPartyActions[i] = new ThirdPartyAction(newPtr);
			}
			return ThirdPartyActions;
		}
#else
		public static ThirdPartyAction[] GetThirdPartyActionArray(ThirdPartyActionArray ThirdPartyActionsArray) {
			ThirdPartyAction[] ThirdPartyActions = new ThirdPartyAction[0];
			return ThirdPartyActions;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~ThirdPartyAction()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerThirdPartyAction);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerThirdPartyAction;
		
			#region Class Members
#if UNITY_IPHONE

		public string ThirdPartyActionID {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionID(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionID(innerThirdPartyAction, value);}
		}
		public DateTime ThirdPartyActionLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaThirdPartyActionGetThirdPartyActionLastUpdate(innerThirdPartyAction));}
		}
		public float ThirdPartyActionRevenue {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionRevenue(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionRevenue(innerThirdPartyAction, value);}
		}
		public Currency ThirdPartyActionCurrencyKind {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionCurrencyKind(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionCurrencyKind(innerThirdPartyAction, (int)value);}
		}
		public int ThirdPartyActionQuantity {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionQuantity(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionQuantity(innerThirdPartyAction, value);}
		}
		public string ThirdPartyActionPromotion {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionPromotion(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionPromotion(innerThirdPartyAction, value);}
		}
		public TRIAL_PAY_KIND ThirdPartyActionKind {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionKind(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionKind(innerThirdPartyAction,(int) value);}
		}
		public DateTime ThirdPartyActionDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaThirdPartyActionGetThirdPartyActionDate(innerThirdPartyAction));}
			set {ApplicasaThirdPartyActionSetThirdPartyActionDate(innerThirdPartyAction, value.Ticks);}
		}
		public VirtualGood ThirdPartyActionVirtualGood {
			get {return new VirtualGood(ApplicasaThirdPartyActionGetThirdPartyActionVirtualGood(innerThirdPartyAction));}
			set {ApplicasaThirdPartyActionSetThirdPartyActionVirtualGood(innerThirdPartyAction, value.innerVirtualGood);}
		}
		public string ThirdPartyActionUser {
			get {return ApplicasaThirdPartyActionGetThirdPartyActionUser(innerThirdPartyAction);}
			set {ApplicasaThirdPartyActionSetThirdPartyActionUser(innerThirdPartyAction, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaThirdPartyActionGetThirdPartyActionID(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionID(System.IntPtr ThirdPartyAction, string ThirdPartyActionID);
	[DllImport("__Internal")]
	private static extern double ApplicasaThirdPartyActionGetThirdPartyActionLastUpdate(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern float ApplicasaThirdPartyActionGetThirdPartyActionRevenue(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionRevenue(System.IntPtr ThirdPartyAction, float ThirdPartyActionRevenue);
	[DllImport("__Internal")]
	private static extern  Currency ApplicasaThirdPartyActionGetThirdPartyActionCurrencyKind(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionCurrencyKind(System.IntPtr ThirdPartyAction, int ThirdPartyActionCurrencyKind);
	[DllImport("__Internal")]
	private static extern int ApplicasaThirdPartyActionGetThirdPartyActionQuantity(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionQuantity(System.IntPtr ThirdPartyAction, int ThirdPartyActionQuantity);
	[DllImport("__Internal")]
	private static extern string ApplicasaThirdPartyActionGetThirdPartyActionPromotion(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionPromotion(System.IntPtr ThirdPartyAction, string ThirdPartyActionPromotion);
	[DllImport("__Internal")]
	private static extern TRIAL_PAY_KIND ApplicasaThirdPartyActionGetThirdPartyActionKind(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionKind(System.IntPtr ThirdPartyAction, int ThirdPartyActionKind);
	[DllImport("__Internal")]
	private static extern double ApplicasaThirdPartyActionGetThirdPartyActionDate(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionDate(System.IntPtr ThirdPartyAction, double ThirdPartyActionDate);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaThirdPartyActionGetThirdPartyActionVirtualGood(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionVirtualGood(System.IntPtr ThirdPartyAction, IntPtr ThirdPartyActionVirtualGood);
	[DllImport("__Internal")]
	private static extern string ApplicasaThirdPartyActionGetThirdPartyActionUser(System.IntPtr ThirdPartyAction);
	[DllImport("__Internal")]
	private static extern void ApplicasaThirdPartyActionSetThirdPartyActionUser(System.IntPtr ThirdPartyAction, string ThirdPartyActionUser);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string ThirdPartyActionID {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<string>("ApplicasaThirdPartyActionGetThirdPartyActionID", innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionID", innerThirdPartyActionJavaObject, value);}
		}
		public DateTime ThirdPartyActionLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaThirdPartyAction.CallStatic<double>("ApplicasaThirdPartyActionGetThirdPartyActionLastUpdate",innerThirdPartyActionJavaObject));}
		}
		public float ThirdPartyActionRevenue {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<float>("ApplicasaThirdPartyActionGetThirdPartyActionRevenue",innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionRevenue",innerThirdPartyActionJavaObject, value);}
		}
		public TRIAL_PAY_KIND ThirdPartyActionCurrencyKind {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<TRIAL_PAY_KIND>("ApplicasaThirdPartyActionGetThirdPartyActionCurrencyKind",innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionCurrencyKind",innerThirdPartyActionJavaObject, value);}
		}
		public int ThirdPartyActionQuantity {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<int>("ApplicasaThirdPartyActionGetThirdPartyActionQuantity",innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionQuantity",innerThirdPartyActionJavaObject, value);}
		}
		public string ThirdPartyActionPromotion {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<string>("ApplicasaThirdPartyActionGetThirdPartyActionPromotion", innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionPromotion", innerThirdPartyActionJavaObject, value);}
		}
		public Currency ThirdPartyActionKind {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<Currency>("ApplicasaThirdPartyActionGetThirdPartyActionKind",innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionKind",innerThirdPartyActionJavaObject, value);}
		}
		public DateTime ThirdPartyActionDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaThirdPartyAction.CallStatic<double>("ApplicasaThirdPartyActionGetThirdPartyActionDate",innerThirdPartyActionJavaObject));}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionDate", innerThirdPartyActionJavaObject, (long)value.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds);}
		}
		public VirtualGood ThirdPartyActionVirtualGood {			
			get {
			AndroidJavaObject androidJavaObject = javaUnityApplicasaThirdPartyAction.CallStatic<AndroidJavaObject>("ApplicasaThirdPartyActionGetThirdPartyActionVirtualGood",innerThirdPartyActionJavaObject);
			return new VirtualGood(androidJavaObject.GetRawObject(),androidJavaObject);
			}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionVirtualGood",innerThirdPartyActionJavaObject, value.innerVirtualGoodJavaObject);}
		}
		public string ThirdPartyActionUser {
			get {return javaUnityApplicasaThirdPartyAction.CallStatic<string>("ApplicasaThirdPartyActionGetThirdPartyActionUser", innerThirdPartyActionJavaObject);}
			set {javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaThirdPartyActionSetThirdPartyActionUser", innerThirdPartyActionJavaObject, value);}
		}

#else

        public string ThirdPartyActionID {
			get {return "";}
			set { }
		}
		public DateTime ThirdPartyActionLastUpdate {
			get {return new DateTime();}
		}
		public float ThirdPartyActionRevenue {
			get {return 0;}
			set { }
		}
		public int ThirdPartyActionCurrencyKind {
			get {return 0;}
			set { }
		}
		public int ThirdPartyActionQuantity {
			get {return 0;}
			set { }
		}
		public string ThirdPartyActionPromotion {
			get {return "";}
			set { }
		}
		public int ThirdPartyActionKind {
			get {return 0;}
			set { }
		}
		public DateTime ThirdPartyActionDate {
			get {return new DateTime();}
			set { }
		}
		public VirtualGood ThirdPartyActionVirtualGood {
			get {return null;}
			set { }
		}
		public string ThirdPartyActionUser {
			get {return "";}
			set { }
		}
#endif
#endregion

		

		#endregion
		
		#region Static Methods
		
#if UNITY_IPHONE && !UNITY_EDITOR
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGetThirdPartyActions(GetThirdPartyActionArrayFinishedInner InnerCallback);
		public static void GetThirdPartyActions(GetThirdPartyActionArrayFinished callback) {
			kCallback = callback;
			ApplicasaGetThirdPartyActions(HandleResponse);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR

		public static void GetThirdPartyActions(GetThirdPartyActionArrayFinished callback) {
			if(javaUnityApplicasaThirdPartyAction==null)
				javaUnityApplicasaThirdPartyAction = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaTPAction");
			
			kCallback = callback;
			
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(HandleResponse, uniqueActionID);
			javaUnityApplicasaThirdPartyAction.CallStatic("ApplicasaGetTPAction",  uniqueActionID);
		}
#else

        public static void GetThirdPartyActions(GetThirdPartyActionArrayFinished callback) {
			callback(true,new Error(),null);
		}	
#endif
		
		#endregion
	}
}

