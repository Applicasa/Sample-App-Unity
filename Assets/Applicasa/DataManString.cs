//
// DataManString.cs
// Created by Applicasa 
// 1/21/2014
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class DataManString {	
		public static DataManString[] finalDataManString;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaDataManString;
	
        public AndroidJavaObject innerDataManStringJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetDataManStringFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetDataManStringArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetDataManStringFinished(bool success, Error error, IntPtr dataManStringPtr);
		public delegate void GetDataManStringArrayFinished(bool success, Error error, DataManStringArray dataManStringArrayPtr);
		
		public DataManString(IntPtr dataManStringPtr) {
			innerDataManString = dataManStringPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			if(innerDataManStringJavaObject==null)
				innerDataManStringJavaObject = new AndroidJavaObject("com.applicasa.DataManString.DataManString",innerDataManString);
#endif
		}
		
#if UNITY_ANDROID 
		public DataManString(IntPtr dataManStringPtr, AndroidJavaObject dataManStringJavaObject) {
			innerDataManString = dataManStringPtr;
			innerDataManStringJavaObject = dataManStringJavaObject;
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaDataManString();
		#endif
		public DataManString() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaDataManString==null)
			javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
		   innerDataManStringJavaObject = new AndroidJavaObject("com.applicasa.DataManString.DataManString");
		   innerDataManString = innerDataManStringJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerDataManString = ApplicasaDataManString();
		#endif
		  }

		public struct DataManStringArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static DataManString[] GetDataManStringArray(DataManStringArray dataManStringArray) {
			
			DataManString[] dataManStringInner = new DataManString[dataManStringArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(dataManStringArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManStringInner[count] = new DataManString(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return dataManStringInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static DataManString[] GetDataManStringArray(DataManStringArray dataManStringArray) {
			DataManString[] dataManStrings = new DataManString[dataManStringArray.ArraySize];

			for (int i=0; i < dataManStringArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (dataManStringArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				dataManStrings[i] = new DataManString(newPtr);
			}
			return dataManStrings;
		}
#else
		public static DataManString[] GetDataManStringArray(DataManStringArray dataManStringArray) {
			DataManString[] dataManStrings = new DataManString[0];
			return dataManStrings;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~DataManString()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerDataManString);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerDataManString;
		
			#region Class Members
#if UNITY_IPHONE

		public string DataManStringID {
			get {return ApplicasaDataManStringGetDataManStringID(innerDataManString);}
			set {ApplicasaDataManStringSetDataManStringID(innerDataManString, value);}
		}
		public DateTime DataManStringLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaDataManStringGetDataManStringLastUpdate(innerDataManString));}
		}
		public string DataManStringKey {
			get {return ApplicasaDataManStringGetDataManStringKey(innerDataManString);}
			set {ApplicasaDataManStringSetDataManStringKey(innerDataManString, value);}
		}
		public string DataManStringValue {
			get {return ApplicasaDataManStringGetDataManStringValue(innerDataManString);}
			set {ApplicasaDataManStringSetDataManStringValue(innerDataManString, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaDataManStringGetDataManStringID(System.IntPtr dataManString);
	[DllImport("__Internal")]
	private static extern void ApplicasaDataManStringSetDataManStringID(System.IntPtr dataManString, string dataManStringID);
	[DllImport("__Internal")]
	private static extern double ApplicasaDataManStringGetDataManStringLastUpdate(System.IntPtr dataManString);
	[DllImport("__Internal")]
	private static extern string ApplicasaDataManStringGetDataManStringKey(System.IntPtr dataManString);
	[DllImport("__Internal")]
	private static extern void ApplicasaDataManStringSetDataManStringKey(System.IntPtr dataManString, string dataManStringKey);
	[DllImport("__Internal")]
	private static extern string ApplicasaDataManStringGetDataManStringValue(System.IntPtr dataManString);
	[DllImport("__Internal")]
	private static extern void ApplicasaDataManStringSetDataManStringValue(System.IntPtr dataManString, string dataManStringValue);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string DataManStringID {
			get {return javaUnityApplicasaDataManString.CallStatic<string>("ApplicasaDataManStringGetDataManStringID", innerDataManStringJavaObject);}
			set {javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringSetDataManStringID", innerDataManStringJavaObject, value);}
		}
		public DateTime DataManStringLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaDataManString.CallStatic<double>("ApplicasaDataManStringGetDataManStringLastUpdate",innerDataManStringJavaObject));}
		}
		public string DataManStringKey {
			get {return javaUnityApplicasaDataManString.CallStatic<string>("ApplicasaDataManStringGetDataManStringKey", innerDataManStringJavaObject);}
			set {javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringSetDataManStringKey", innerDataManStringJavaObject, value);}
		}
		public string DataManStringValue {
			get {return javaUnityApplicasaDataManString.CallStatic<string>("ApplicasaDataManStringGetDataManStringValue", innerDataManStringJavaObject);}
			set {javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringSetDataManStringValue", innerDataManStringJavaObject, value);}
		}

#else

		public string DataManStringID {
			get {return "";}
			set { }
		}
		public DateTime DataManStringLastUpdate {
			get {return new DateTime();}
		}
		public string DataManStringKey {
			get {return "";}
			set { }
		}
		public string DataManStringValue {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringSaveWithBlock(System.IntPtr dataManString, Action callback);
		public void Save(Action action) {
			ApplicasaDataManStringSaveWithBlock(innerDataManString, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringIncreaseFieldInt(System.IntPtr dataManString, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringIncreaseFieldFloat(System.IntPtr dataManString, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaDataManStringIncreaseFieldInt(innerDataManString, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaDataManStringIncreaseFieldFloat(innerDataManString, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringDeleteWithBlock(System.IntPtr dataManString, Action callback);
		public void Delete(Action action) {
			ApplicasaDataManStringDeleteWithBlock(innerDataManString, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringUploadFile(System.IntPtr dataManString, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaDataManStringUploadFile(innerDataManString, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringSaveWithBlock", innerDataManStringJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringIncreaseFieldInt", innerDataManStringJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringIncreaseFieldFloat", innerDataManStringJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringDeleteWithBlock", innerDataManStringJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringUploadFile", innerDataManStringJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaDataManStringGetById(string id, QueryKind queryKind, GetDataManStringFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetDataManStringFinished callback) {
			ApplicasaDataManStringGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetDataManStringArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDataManStringArrayFinished callback) {
			ApplicasaDataManStringGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManStringGetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManStringArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManStringArrayFinished callback) {
			ApplicasaDataManStringGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern DataManStringArray ApplicasaDataManStringGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static DataManString[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetDataManStringArray(ApplicasaDataManStringGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			DataManStringArray dataManStringArray = ApplicasaDataManStringGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalDataManString = GetDataManStringArray(dataManStringArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetDataManStringArrayIEnumerator(DataManStringArray dataManStringArray) {
			finalDataManString = GetDataManStringArray(dataManStringArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaDataManStringUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaDataManStringUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetDataManStringFinished callback) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDataManStringArrayFinished callback) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManStringArrayFinished callback) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaDataManString.CallStatic("ApplicasaDataManStringGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static DataManString[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaDataManString.CallStatic<AndroidJavaObject[]>("ApplicasaDataManStringGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			DataManString[] dataManStringInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				DataManString[] dataManStringtemp = new DataManString[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManStringtemp[j] = new DataManString(tempObj.GetRawObject(),tempObj);
				}
				if (dataManStringInner == null)
					dataManStringInner = dataManStringtemp;
				else{
				   DataManString[] firstOne = dataManStringInner;
				    dataManStringInner = new DataManString[firstOne.Length+dataManStringtemp.Length];
					firstOne.CopyTo(dataManStringInner,0);
					dataManStringtemp.CopyTo(dataManStringInner,firstOne.Length);
				}
				
			}
			return dataManStringInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
				
				int count = javaUnityApplicasaDataManString.CallStatic<int>("ApplicasaDataManStringUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaDataManString==null)
				javaUnityApplicasaDataManString = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManString");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaDataManString.CallStatic<AndroidJavaObject[]>("ApplicasaDataManStringGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			DataManString[] dataManStringInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				DataManString[] dataManStringtemp = new DataManString[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManStringtemp[j] = new DataManString(tempObj.GetRawObject(),tempObj);
				}
				if (dataManStringInner == null)
					dataManStringInner = dataManStringtemp;
				else{
				   DataManString[] firstOne = dataManStringInner;
				    dataManStringInner = new DataManString[firstOne.Length+dataManStringtemp.Length];
					firstOne.CopyTo(dataManStringInner,0);
					dataManStringtemp.CopyTo(dataManStringInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalDataManString = dataManStringInner;
		}
		
		public static  IEnumerator GetDataManStringArrayIEnumerator(DataManStringArray dataManStringArray) {
		
			DataManString[] dataManStringInner = new DataManString[dataManStringArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(dataManStringArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManStringInner[count] = new DataManString(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalDataManString = dataManStringInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				DataManString[]  dataManStringInner = new DataManString[0];
			    finalDataManString = dataManStringInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetDataManStringFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDataManStringArrayFinished callback) {
			callback(true,new Error(),new DataManStringArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManStringArrayFinished callback) {
			callback(true,new Error(),new DataManStringArray());
		}
		
		public static DataManString[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			DataManString[] dataManString = new DataManString[0];
		    
			return dataManString;
		}	
		
		public static  IEnumerator GetDataManStringArrayIEnumerator(DataManStringArray dataManStringArray) {
			yield return new WaitForSeconds(0.2f);
			DataManString[]  dataManStringInner = new DataManString[0];
			finalDataManString = dataManStringInner;
		}
#endif
		
		#endregion
	}
}

