//
// VirtualGoodCategory.cs
// Created by Applicasa 
// 1/21/2014
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class VirtualGoodCategory {	
		public static VirtualGoodCategory[] finalVirtualGoodCategory;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaVirtualGoodCategory;
	
        public AndroidJavaObject innerVirtualGoodCategoryJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetVirtualGoodCategoryFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetVirtualGoodCategoryArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetVirtualGoodCategoryFinished(bool success, Error error, IntPtr virtualGoodCategoryPtr);
		public delegate void GetVirtualGoodCategoryArrayFinished(bool success, Error error, VirtualGoodCategoryArray virtualGoodCategoryArrayPtr);
		
		public VirtualGoodCategory(IntPtr virtualGoodCategoryPtr) {
			innerVirtualGoodCategory = virtualGoodCategoryPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			if(innerVirtualGoodCategoryJavaObject==null)
				innerVirtualGoodCategoryJavaObject = new AndroidJavaObject("com.applicasa.VirtualGoodCategory.VirtualGoodCategory",innerVirtualGoodCategory);
#endif
		}
		
#if UNITY_ANDROID 
		public VirtualGoodCategory(IntPtr virtualGoodCategoryPtr, AndroidJavaObject virtualGoodCategoryJavaObject) {
			innerVirtualGoodCategory = virtualGoodCategoryPtr;
			innerVirtualGoodCategoryJavaObject = virtualGoodCategoryJavaObject;
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaVirtualGoodCategory();
		#endif
		public VirtualGoodCategory() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaVirtualGoodCategory==null)
			javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
		   innerVirtualGoodCategoryJavaObject = new AndroidJavaObject("com.applicasa.VirtualGoodCategory.VirtualGoodCategory");
		   innerVirtualGoodCategory = innerVirtualGoodCategoryJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerVirtualGoodCategory = ApplicasaVirtualGoodCategory();
		#endif
		  }

		public struct VirtualGoodCategoryArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static VirtualGoodCategory[] GetVirtualGoodCategoryArray(VirtualGoodCategoryArray virtualGoodCategoryArray) {
			
			VirtualGoodCategory[] virtualGoodCategoryInner = new VirtualGoodCategory[virtualGoodCategoryArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(virtualGoodCategoryArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					virtualGoodCategoryInner[count] = new VirtualGoodCategory(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return virtualGoodCategoryInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static VirtualGoodCategory[] GetVirtualGoodCategoryArray(VirtualGoodCategoryArray virtualGoodCategoryArray) {
			VirtualGoodCategory[] virtualGoodCategorys = new VirtualGoodCategory[virtualGoodCategoryArray.ArraySize];

			for (int i=0; i < virtualGoodCategoryArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (virtualGoodCategoryArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				virtualGoodCategorys[i] = new VirtualGoodCategory(newPtr);
			}
			return virtualGoodCategorys;
		}
#else
		public static VirtualGoodCategory[] GetVirtualGoodCategoryArray(VirtualGoodCategoryArray virtualGoodCategoryArray) {
			VirtualGoodCategory[] virtualGoodCategorys = new VirtualGoodCategory[0];
			return virtualGoodCategorys;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~VirtualGoodCategory()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerVirtualGoodCategory);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerVirtualGoodCategory;
		
			#region Class Members
#if UNITY_IPHONE

		public string VirtualGoodCategoryID {
			get {return ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryID(innerVirtualGoodCategory);}
			set {ApplicasaVirtualGoodCategorySetVirtualGoodCategoryID(innerVirtualGoodCategory, value);}
		}
		public string VirtualGoodCategoryName {
			get {return ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryName(innerVirtualGoodCategory);}
			set {ApplicasaVirtualGoodCategorySetVirtualGoodCategoryName(innerVirtualGoodCategory, value);}
		}
		public DateTime VirtualGoodCategoryLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryLastUpdate(innerVirtualGoodCategory));}
		}
		public int VirtualGoodCategoryPos {
			get {return ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryPos(innerVirtualGoodCategory);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryID(System.IntPtr virtualGoodCategory);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodCategorySetVirtualGoodCategoryID(System.IntPtr virtualGoodCategory, string virtualGoodCategoryID);
	[DllImport("__Internal")]
	private static extern string ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryName(System.IntPtr virtualGoodCategory);
	[DllImport("__Internal")]
	private static extern void ApplicasaVirtualGoodCategorySetVirtualGoodCategoryName(System.IntPtr virtualGoodCategory, string virtualGoodCategoryName);
	[DllImport("__Internal")]
	private static extern double ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryLastUpdate(System.IntPtr virtualGoodCategory);
	[DllImport("__Internal")]
	private static extern int ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryPos(System.IntPtr virtualGoodCategory);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string VirtualGoodCategoryID {
			get {return javaUnityApplicasaVirtualGoodCategory.CallStatic<string>("ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryID", innerVirtualGoodCategoryJavaObject);}
			set {javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategorySetVirtualGoodCategoryID", innerVirtualGoodCategoryJavaObject, value);}
		}
		public string VirtualGoodCategoryName {
			get {return javaUnityApplicasaVirtualGoodCategory.CallStatic<string>("ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryName", innerVirtualGoodCategoryJavaObject);}
			set {javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategorySetVirtualGoodCategoryName", innerVirtualGoodCategoryJavaObject, value);}
		}
		public DateTime VirtualGoodCategoryLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaVirtualGoodCategory.CallStatic<double>("ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryLastUpdate",innerVirtualGoodCategoryJavaObject));}
		}
		public int VirtualGoodCategoryPos {
			get {return javaUnityApplicasaVirtualGoodCategory.CallStatic<int>("ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryPos",innerVirtualGoodCategoryJavaObject);}
		}

#else

		public string VirtualGoodCategoryID {
			get {return "";}
			set { }
		}
		public string VirtualGoodCategoryName {
			get {return "";}
			set { }
		}
		public DateTime VirtualGoodCategoryLastUpdate {
			get {return new DateTime();}
		}
		public int VirtualGoodCategoryPos {
			get {return 0;}
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategorySaveWithBlock(System.IntPtr virtualGoodCategory, Action callback);
		public void Save(Action action) {
			ApplicasaVirtualGoodCategorySaveWithBlock(innerVirtualGoodCategory, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryIncreaseFieldInt(System.IntPtr virtualGoodCategory, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryIncreaseFieldFloat(System.IntPtr virtualGoodCategory, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaVirtualGoodCategoryIncreaseFieldInt(innerVirtualGoodCategory, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaVirtualGoodCategoryIncreaseFieldFloat(innerVirtualGoodCategory, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryDeleteWithBlock(System.IntPtr virtualGoodCategory, Action callback);
		public void Delete(Action action) {
			ApplicasaVirtualGoodCategoryDeleteWithBlock(innerVirtualGoodCategory, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryUploadFile(System.IntPtr virtualGoodCategory, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaVirtualGoodCategoryUploadFile(innerVirtualGoodCategory, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategorySaveWithBlock", innerVirtualGoodCategoryJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryIncreaseFieldInt", innerVirtualGoodCategoryJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryIncreaseFieldFloat", innerVirtualGoodCategoryJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryDeleteWithBlock", innerVirtualGoodCategoryJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryUploadFile", innerVirtualGoodCategoryJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
		}
#else
		public void Save(Action action) {
			action(true,new Error(),"",Actions.Update);
		}

		public void IncreaseField(Fields field, int val) {
		}
		public void IncreaseField(Fields field, float val) {
		}

		public void Delete(Action action) {
			action(true,new Error(),"",Actions.Update);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			action(true,new Error(),"",Actions.Update);
		}
#endif

		#endregion
		
		#region Static Methods
		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryGetById(string id, QueryKind queryKind, GetVirtualGoodCategoryFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetVirtualGoodCategoryFinished callback) {
			ApplicasaVirtualGoodCategoryGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetVirtualGoodCategoryArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetVirtualGoodCategoryArrayFinished callback) {
			ApplicasaVirtualGoodCategoryGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaVirtualGoodCategoryGetLocalArrayWithRawSqlQuery(string rawQuery, GetVirtualGoodCategoryArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetVirtualGoodCategoryArrayFinished callback) {
			ApplicasaVirtualGoodCategoryGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern VirtualGoodCategoryArray ApplicasaVirtualGoodCategoryGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static VirtualGoodCategory[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetVirtualGoodCategoryArray(ApplicasaVirtualGoodCategoryGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			VirtualGoodCategoryArray virtualGoodCategoryArray = ApplicasaVirtualGoodCategoryGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalVirtualGoodCategory = GetVirtualGoodCategoryArray(virtualGoodCategoryArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetVirtualGoodCategoryArrayIEnumerator(VirtualGoodCategoryArray virtualGoodCategoryArray) {
			finalVirtualGoodCategory = GetVirtualGoodCategoryArray(virtualGoodCategoryArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaVirtualGoodCategoryUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaVirtualGoodCategoryUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetVirtualGoodCategoryFinished callback) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetVirtualGoodCategoryArrayFinished callback) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetVirtualGoodCategoryArrayFinished callback) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaVirtualGoodCategory.CallStatic("ApplicasaVirtualGoodCategoryGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static VirtualGoodCategory[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaVirtualGoodCategory.CallStatic<AndroidJavaObject[]>("ApplicasaVirtualGoodCategoryGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			VirtualGoodCategory[] virtualGoodCategoryInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				VirtualGoodCategory[] virtualGoodCategorytemp = new VirtualGoodCategory[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					virtualGoodCategorytemp[j] = new VirtualGoodCategory(tempObj.GetRawObject(),tempObj);
				}
				if (virtualGoodCategoryInner == null)
					virtualGoodCategoryInner = virtualGoodCategorytemp;
				else{
				   VirtualGoodCategory[] firstOne = virtualGoodCategoryInner;
				    virtualGoodCategoryInner = new VirtualGoodCategory[firstOne.Length+virtualGoodCategorytemp.Length];
					firstOne.CopyTo(virtualGoodCategoryInner,0);
					virtualGoodCategorytemp.CopyTo(virtualGoodCategoryInner,firstOne.Length);
				}
				
			}
			return virtualGoodCategoryInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
				
				int count = javaUnityApplicasaVirtualGoodCategory.CallStatic<int>("ApplicasaVirtualGoodCategoryUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaVirtualGoodCategory==null)
				javaUnityApplicasaVirtualGoodCategory = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaVirtualGoodCategory");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaVirtualGoodCategory.CallStatic<AndroidJavaObject[]>("ApplicasaVirtualGoodCategoryGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			VirtualGoodCategory[] virtualGoodCategoryInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				VirtualGoodCategory[] virtualGoodCategorytemp = new VirtualGoodCategory[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					virtualGoodCategorytemp[j] = new VirtualGoodCategory(tempObj.GetRawObject(),tempObj);
				}
				if (virtualGoodCategoryInner == null)
					virtualGoodCategoryInner = virtualGoodCategorytemp;
				else{
				   VirtualGoodCategory[] firstOne = virtualGoodCategoryInner;
				    virtualGoodCategoryInner = new VirtualGoodCategory[firstOne.Length+virtualGoodCategorytemp.Length];
					firstOne.CopyTo(virtualGoodCategoryInner,0);
					virtualGoodCategorytemp.CopyTo(virtualGoodCategoryInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalVirtualGoodCategory = virtualGoodCategoryInner;
		}
		
		public static  IEnumerator GetVirtualGoodCategoryArrayIEnumerator(VirtualGoodCategoryArray virtualGoodCategoryArray) {
		
			VirtualGoodCategory[] virtualGoodCategoryInner = new VirtualGoodCategory[virtualGoodCategoryArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(virtualGoodCategoryArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					virtualGoodCategoryInner[count] = new VirtualGoodCategory(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalVirtualGoodCategory = virtualGoodCategoryInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				VirtualGoodCategory[]  virtualGoodCategoryInner = new VirtualGoodCategory[0];
			    finalVirtualGoodCategory = virtualGoodCategoryInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetVirtualGoodCategoryFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetVirtualGoodCategoryArrayFinished callback) {
			callback(true,new Error(),new VirtualGoodCategoryArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetVirtualGoodCategoryArrayFinished callback) {
			callback(true,new Error(),new VirtualGoodCategoryArray());
		}
		
		public static VirtualGoodCategory[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			VirtualGoodCategory[] virtualGoodCategory = new VirtualGoodCategory[0];
		    
			return virtualGoodCategory;
		}	
		
		public static  IEnumerator GetVirtualGoodCategoryArrayIEnumerator(VirtualGoodCategoryArray virtualGoodCategoryArray) {
			yield return new WaitForSeconds(0.2f);
			VirtualGoodCategory[]  virtualGoodCategoryInner = new VirtualGoodCategory[0];
			finalVirtualGoodCategory = virtualGoodCategoryInner;
		}
#endif
		
		#endregion
	}
}

