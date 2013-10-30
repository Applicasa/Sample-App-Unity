//
// Dynamic.cs
// Created by Applicasa 
// 10/30/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Dynamic {	
		public static Dynamic[] finalDynamic;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaDynamic;
	
        public AndroidJavaObject innerDynamicJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetDynamicFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetDynamicArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetDynamicFinished(bool success, Error error, IntPtr dynamicPtr);
		public delegate void GetDynamicArrayFinished(bool success, Error error, DynamicArray dynamicArrayPtr);
		
		public Dynamic(IntPtr dynamicPtr) {
			innerDynamic = dynamicPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			if(innerDynamicJavaObject==null)
				innerDynamicJavaObject = new AndroidJavaObject("com.applicasa.Dynamic.Dynamic",innerDynamic);
#endif
		}
		
#if UNITY_ANDROID 
		public Dynamic(IntPtr dynamicPtr, AndroidJavaObject dynamicJavaObject) {
			innerDynamic = dynamicPtr;
			innerDynamicJavaObject = dynamicJavaObject;
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaDynamic();
		#endif
		public Dynamic() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaDynamic==null)
			javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
		   innerDynamicJavaObject = new AndroidJavaObject("com.applicasa.Dynamic.Dynamic");
		   innerDynamic = innerDynamicJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerDynamic = ApplicasaDynamic();
		#endif
		  }

		public struct DynamicArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Dynamic[] GetDynamicArray(DynamicArray dynamicArray) {
			
			Dynamic[] dynamicInner = new Dynamic[dynamicArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(dynamicArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dynamicInner[count] = new Dynamic(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return dynamicInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Dynamic[] GetDynamicArray(DynamicArray dynamicArray) {
			Dynamic[] dynamics = new Dynamic[dynamicArray.ArraySize];

			for (int i=0; i < dynamicArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (dynamicArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				dynamics[i] = new Dynamic(newPtr);
			}
			return dynamics;
		}
#else
		public static Dynamic[] GetDynamicArray(DynamicArray dynamicArray) {
			Dynamic[] dynamics = new Dynamic[0];
			return dynamics;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Dynamic()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerDynamic);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerDynamic;
		
			#region Class Members
#if UNITY_IPHONE

		public string DynamicID {
			get {return ApplicasaDynamicGetDynamicID(innerDynamic);}
			set {ApplicasaDynamicSetDynamicID(innerDynamic, value);}
		}
		public DateTime DynamicLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaDynamicGetDynamicLastUpdate(innerDynamic));}
		}
		public string DynamicText {
			get {return ApplicasaDynamicGetDynamicText(innerDynamic);}
			set {ApplicasaDynamicSetDynamicText(innerDynamic, value);}
		}
		public int DynamicNumber {
			get {return ApplicasaDynamicGetDynamicNumber(innerDynamic);}
			set {ApplicasaDynamicSetDynamicNumber(innerDynamic, value);}
		}
		public float DynamicReal {
			get {return ApplicasaDynamicGetDynamicReal(innerDynamic);}
			set {ApplicasaDynamicSetDynamicReal(innerDynamic, value);}
		}
		public DateTime DynamicDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaDynamicGetDynamicDate(innerDynamic));}
			set {ApplicasaDynamicSetDynamicDate(innerDynamic, value.Ticks);}
		}
		public bool DynamicBool {
			get {return ApplicasaDynamicGetDynamicBool(innerDynamic);}
			set {ApplicasaDynamicSetDynamicBool(innerDynamic, value);}
		}
		public string DynamicHtml {
			get {return ApplicasaDynamicGetDynamicHtml(innerDynamic);}
			set {ApplicasaDynamicSetDynamicHtml(innerDynamic, value);}
		}
		public string DynamicImage {
			get {return ApplicasaDynamicGetDynamicImage(innerDynamic);}
			set {ApplicasaDynamicSetDynamicImage(innerDynamic, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaDynamicGetDynamicID(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicID(System.IntPtr dynamic, string dynamicID);
	[DllImport("__Internal")]
	private static extern double ApplicasaDynamicGetDynamicLastUpdate(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern string ApplicasaDynamicGetDynamicText(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicText(System.IntPtr dynamic, string dynamicText);
	[DllImport("__Internal")]
	private static extern int ApplicasaDynamicGetDynamicNumber(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicNumber(System.IntPtr dynamic, int dynamicNumber);
	[DllImport("__Internal")]
	private static extern float ApplicasaDynamicGetDynamicReal(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicReal(System.IntPtr dynamic, float dynamicReal);
	[DllImport("__Internal")]
	private static extern double ApplicasaDynamicGetDynamicDate(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicDate(System.IntPtr dynamic, double dynamicDate);
	[DllImport("__Internal")]
	private static extern bool ApplicasaDynamicGetDynamicBool(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicBool(System.IntPtr dynamic, bool dynamicBool);
	[DllImport("__Internal")]
	private static extern string ApplicasaDynamicGetDynamicHtml(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicHtml(System.IntPtr dynamic, string dynamicHtml);
	[DllImport("__Internal")]
	private static extern string ApplicasaDynamicGetDynamicImage(System.IntPtr dynamic);
	[DllImport("__Internal")]
	private static extern void ApplicasaDynamicSetDynamicImage(System.IntPtr dynamic, string dynamicImage);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string DynamicID {
			get {return javaUnityApplicasaDynamic.CallStatic<string>("ApplicasaDynamicGetDynamicID", innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicID", innerDynamicJavaObject, value);}
		}
		public DateTime DynamicLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaDynamic.CallStatic<double>("ApplicasaDynamicGetDynamicLastUpdate",innerDynamicJavaObject));}
		}
		public string DynamicText {
			get {return javaUnityApplicasaDynamic.CallStatic<string>("ApplicasaDynamicGetDynamicText", innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicText", innerDynamicJavaObject, value);}
		}
		public int DynamicNumber {
			get {return javaUnityApplicasaDynamic.CallStatic<int>("ApplicasaDynamicGetDynamicNumber",innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicNumber",innerDynamicJavaObject, value);}
		}
		public float DynamicReal {
			get {return javaUnityApplicasaDynamic.CallStatic<float>("ApplicasaDynamicGetDynamicReal",innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicReal",innerDynamicJavaObject, value);}
		}
		public DateTime DynamicDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaDynamic.CallStatic<double>("ApplicasaDynamicGetDynamicDate",innerDynamicJavaObject));}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicDate", innerDynamicJavaObject, (long)value.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds);}
		}
		public bool DynamicBool {
			get {return javaUnityApplicasaDynamic.CallStatic<bool>("ApplicasaDynamicGetDynamicBool",innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicBool",innerDynamicJavaObject, value);}
		}
		public string DynamicHtml {
			get {return javaUnityApplicasaDynamic.CallStatic<string>("ApplicasaDynamicGetDynamicHtml", innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicHtml", innerDynamicJavaObject, value);}
		}
		public string DynamicImage {
			get {return javaUnityApplicasaDynamic.CallStatic<string>("ApplicasaDynamicGetDynamicImage",innerDynamicJavaObject);}
			set {javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSetDynamicImage",innerDynamicJavaObject, value);}
		}

#else

		public string DynamicID {
			get {return "";}
			set { }
		}
		public DateTime DynamicLastUpdate {
			get {return new DateTime();}
		}
		public string DynamicText {
			get {return "";}
			set { }
		}
		public int DynamicNumber {
			get {return 0;}
			set { }
		}
		public float DynamicReal {
			get {return 0;}
			set { }
		}
		public DateTime DynamicDate {
			get {return new DateTime();}
			set { }
		}
		public bool DynamicBool {
			get {return false;}
			set { }
		}
		public string DynamicHtml {
			get {return "";}
			set { }
		}
		public string DynamicImage {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicSaveWithBlock(System.IntPtr dynamic, Action callback);
		public void Save(Action action) {
			ApplicasaDynamicSaveWithBlock(innerDynamic, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicIncreaseFieldInt(System.IntPtr dynamic, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicIncreaseFieldFloat(System.IntPtr dynamic, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaDynamicIncreaseFieldInt(innerDynamic, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaDynamicIncreaseFieldFloat(innerDynamic, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicDeleteWithBlock(System.IntPtr dynamic, Action callback);
		public void Delete(Action action) {
			ApplicasaDynamicDeleteWithBlock(innerDynamic, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicUploadFile(System.IntPtr dynamic, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaDynamicUploadFile(innerDynamic, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicSaveWithBlock", innerDynamicJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicIncreaseFieldInt", innerDynamicJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicIncreaseFieldFloat", innerDynamicJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicDeleteWithBlock", innerDynamicJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicUploadFile", innerDynamicJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaDynamicGetById(string id, QueryKind queryKind, GetDynamicFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetDynamicFinished callback) {
			ApplicasaDynamicGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetDynamicArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDynamicArrayFinished callback) {
			ApplicasaDynamicGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDynamicGetLocalArrayWithRawSqlQuery(string rawQuery, GetDynamicArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDynamicArrayFinished callback) {
			ApplicasaDynamicGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern DynamicArray ApplicasaDynamicGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Dynamic[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetDynamicArray(ApplicasaDynamicGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			DynamicArray dynamicArray = ApplicasaDynamicGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalDynamic = GetDynamicArray(dynamicArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetDynamicArrayIEnumerator(DynamicArray dynamicArray) {
			finalDynamic = GetDynamicArray(dynamicArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaDynamicUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaDynamicUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetDynamicFinished callback) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDynamicArrayFinished callback) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDynamicArrayFinished callback) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaDynamic.CallStatic("ApplicasaDynamicGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Dynamic[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaDynamic.CallStatic<AndroidJavaObject[]>("ApplicasaDynamicGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Dynamic[] dynamicInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Dynamic[] dynamictemp = new Dynamic[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dynamictemp[j] = new Dynamic(tempObj.GetRawObject(),tempObj);
				}
				if (dynamicInner == null)
					dynamicInner = dynamictemp;
				else{
				   Dynamic[] firstOne = dynamicInner;
				    dynamicInner = new Dynamic[firstOne.Length+dynamictemp.Length];
					firstOne.CopyTo(dynamicInner,0);
					dynamictemp.CopyTo(dynamicInner,firstOne.Length);
				}
				
			}
			return dynamicInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
				
				int count = javaUnityApplicasaDynamic.CallStatic<int>("ApplicasaDynamicUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaDynamic==null)
				javaUnityApplicasaDynamic = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDynamic");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaDynamic.CallStatic<AndroidJavaObject[]>("ApplicasaDynamicGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Dynamic[] dynamicInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Dynamic[] dynamictemp = new Dynamic[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dynamictemp[j] = new Dynamic(tempObj.GetRawObject(),tempObj);
				}
				if (dynamicInner == null)
					dynamicInner = dynamictemp;
				else{
				   Dynamic[] firstOne = dynamicInner;
				    dynamicInner = new Dynamic[firstOne.Length+dynamictemp.Length];
					firstOne.CopyTo(dynamicInner,0);
					dynamictemp.CopyTo(dynamicInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalDynamic = dynamicInner;
		}
		
		public static  IEnumerator GetDynamicArrayIEnumerator(DynamicArray dynamicArray) {
		
			Dynamic[] dynamicInner = new Dynamic[dynamicArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(dynamicArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dynamicInner[count] = new Dynamic(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalDynamic = dynamicInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Dynamic[]  dynamicInner = new Dynamic[0];
			    finalDynamic = dynamicInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetDynamicFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDynamicArrayFinished callback) {
			callback(true,new Error(),new DynamicArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDynamicArrayFinished callback) {
			callback(true,new Error(),new DynamicArray());
		}
		
		public static Dynamic[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Dynamic[] dynamic = new Dynamic[0];
		    
			return dynamic;
		}	
		
		public static  IEnumerator GetDynamicArrayIEnumerator(DynamicArray dynamicArray) {
			yield return new WaitForSeconds(0.2f);
			Dynamic[]  dynamicInner = new Dynamic[0];
			finalDynamic = dynamicInner;
		}
#endif
		
		#endregion
	}
}

