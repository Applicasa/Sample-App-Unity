//
// DataManager.cs
// Created by Applicasa 
// 10/24/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class DataManager {	
		public static DataManager[] finalDataManager;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaDataManager;
	
        public AndroidJavaObject innerDataManagerJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetDataManagerFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetDataManagerArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetDataManagerFinished(bool success, Error error, IntPtr dataManagerPtr);
		public delegate void GetDataManagerArrayFinished(bool success, Error error, DataManagerArray dataManagerArrayPtr);
		
		public DataManager(IntPtr dataManagerPtr) {
			innerDataManager = dataManagerPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			if(innerDataManagerJavaObject==null)
				innerDataManagerJavaObject = new AndroidJavaObject("com.applicasa.DataManager.DataManager",innerDataManager);
#endif
		}
		
#if UNITY_ANDROID 
		public DataManager(IntPtr dataManagerPtr, AndroidJavaObject dataManagerJavaObject) {
			innerDataManager = dataManagerPtr;
			innerDataManagerJavaObject = dataManagerJavaObject;
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaDataManager();
		#endif
		public DataManager() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaDataManager==null)
			javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
		   innerDataManagerJavaObject = new AndroidJavaObject("com.applicasa.DataManager.DataManager");
		   innerDataManager = innerDataManagerJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerDataManager = ApplicasaDataManager();
		#endif
		  }

		public struct DataManagerArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static DataManager[] GetDataManagerArray(DataManagerArray dataManagerArray) {
			
			DataManager[] dataManagerInner = new DataManager[dataManagerArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(dataManagerArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManagerInner[count] = new DataManager(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return dataManagerInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static DataManager[] GetDataManagerArray(DataManagerArray dataManagerArray) {
			DataManager[] dataManagers = new DataManager[dataManagerArray.ArraySize];

			for (int i=0; i < dataManagerArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (dataManagerArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				dataManagers[i] = new DataManager(newPtr);
			}
			return dataManagers;
		}
#else
		public static DataManager[] GetDataManagerArray(DataManagerArray dataManagerArray) {
			DataManager[] dataManagers = new DataManager[0];
			return dataManagers;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~DataManager()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerDataManager);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerDataManager;
		
			#region Class Members
#if UNITY_IPHONE

		public string DataManagerID {
			get {return ApplicasaDataManagerGetDataManagerID(innerDataManager);}
			set {ApplicasaDataManagerSetDataManagerID(innerDataManager, value);}
		}
		public DateTime DataManagerLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaDataManagerGetDataManagerLastUpdate(innerDataManager));}
		}
		public int DataManagerAaa {
			get {return ApplicasaDataManagerGetDataManagerAaa(innerDataManager);}
			set {ApplicasaDataManagerSetDataManagerAaa(innerDataManager, value);}
		}
		public string DataManagerName {
			get {return ApplicasaDataManagerGetDataManagerName(innerDataManager);}
			set {ApplicasaDataManagerSetDataManagerName(innerDataManager, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaDataManagerGetDataManagerID(System.IntPtr dataManager);
	[DllImport("__Internal")]
	private static extern void ApplicasaDataManagerSetDataManagerID(System.IntPtr dataManager, string dataManagerID);
	[DllImport("__Internal")]
	private static extern double ApplicasaDataManagerGetDataManagerLastUpdate(System.IntPtr dataManager);
	[DllImport("__Internal")]
	private static extern int ApplicasaDataManagerGetDataManagerAaa(System.IntPtr dataManager);
	[DllImport("__Internal")]
	private static extern void ApplicasaDataManagerSetDataManagerAaa(System.IntPtr dataManager, int dataManagerAaa);
	[DllImport("__Internal")]
	private static extern string ApplicasaDataManagerGetDataManagerName(System.IntPtr dataManager);
	[DllImport("__Internal")]
	private static extern void ApplicasaDataManagerSetDataManagerName(System.IntPtr dataManager, string dataManagerName);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string DataManagerID {
			get {return javaUnityApplicasaDataManager.CallStatic<string>("ApplicasaDataManagerGetDataManagerID", innerDataManagerJavaObject);}
			set {javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerSetDataManagerID", innerDataManagerJavaObject, value);}
		}
		public DateTime DataManagerLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaDataManager.CallStatic<double>("ApplicasaDataManagerGetDataManagerLastUpdate",innerDataManagerJavaObject));}
		}
		public int DataManagerAaa {
			get {return javaUnityApplicasaDataManager.CallStatic<int>("ApplicasaDataManagerGetDataManagerAaa",innerDataManagerJavaObject);}
			set {javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerSetDataManagerAaa",innerDataManagerJavaObject, value);}
		}
		public string DataManagerName {
			get {return javaUnityApplicasaDataManager.CallStatic<string>("ApplicasaDataManagerGetDataManagerName", innerDataManagerJavaObject);}
			set {javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerSetDataManagerName", innerDataManagerJavaObject, value);}
		}

#else

		public string DataManagerID {
			get {return "";}
			set { }
		}
		public DateTime DataManagerLastUpdate {
			get {return new DateTime();}
		}
		public int DataManagerAaa {
			get {return 0;}
			set { }
		}
		public string DataManagerName {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerSaveWithBlock(System.IntPtr dataManager, Action callback);
		public void Save(Action action) {
			ApplicasaDataManagerSaveWithBlock(innerDataManager, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerIncreaseFieldInt(System.IntPtr dataManager, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerIncreaseFieldFloat(System.IntPtr dataManager, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaDataManagerIncreaseFieldInt(innerDataManager, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaDataManagerIncreaseFieldFloat(innerDataManager, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerDeleteWithBlock(System.IntPtr dataManager, Action callback);
		public void Delete(Action action) {
			ApplicasaDataManagerDeleteWithBlock(innerDataManager, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerUploadFile(System.IntPtr dataManager, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaDataManagerUploadFile(innerDataManager, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerSaveWithBlock", innerDataManagerJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerIncreaseFieldInt", innerDataManagerJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerIncreaseFieldFloat", innerDataManagerJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerDeleteWithBlock", innerDataManagerJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerUploadFile", innerDataManagerJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaDataManagerGetById(string id, QueryKind queryKind, GetDataManagerFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetDataManagerFinished callback) {
			ApplicasaDataManagerGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetDataManagerArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDataManagerArrayFinished callback) {
			ApplicasaDataManagerGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaDataManagerGetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManagerArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManagerArrayFinished callback) {
			ApplicasaDataManagerGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern DataManagerArray ApplicasaDataManagerGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static DataManager[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetDataManagerArray(ApplicasaDataManagerGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			DataManagerArray dataManagerArray = ApplicasaDataManagerGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalDataManager = GetDataManagerArray(dataManagerArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetDataManagerArrayIEnumerator(DataManagerArray dataManagerArray) {
			finalDataManager = GetDataManagerArray(dataManagerArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaDataManagerUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaDataManagerUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetDataManagerFinished callback) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDataManagerArrayFinished callback) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManagerArrayFinished callback) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaDataManager.CallStatic("ApplicasaDataManagerGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static DataManager[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaDataManager.CallStatic<AndroidJavaObject[]>("ApplicasaDataManagerGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			DataManager[] dataManagerInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				DataManager[] dataManagertemp = new DataManager[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManagertemp[j] = new DataManager(tempObj.GetRawObject(),tempObj);
				}
				if (dataManagerInner == null)
					dataManagerInner = dataManagertemp;
				else{
				   DataManager[] firstOne = dataManagerInner;
				    dataManagerInner = new DataManager[firstOne.Length+dataManagertemp.Length];
					firstOne.CopyTo(dataManagerInner,0);
					dataManagertemp.CopyTo(dataManagerInner,firstOne.Length);
				}
				
			}
			return dataManagerInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
				
				int count = javaUnityApplicasaDataManager.CallStatic<int>("ApplicasaDataManagerUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaDataManager==null)
				javaUnityApplicasaDataManager = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaDataManager");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaDataManager.CallStatic<AndroidJavaObject[]>("ApplicasaDataManagerGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			DataManager[] dataManagerInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				DataManager[] dataManagertemp = new DataManager[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManagertemp[j] = new DataManager(tempObj.GetRawObject(),tempObj);
				}
				if (dataManagerInner == null)
					dataManagerInner = dataManagertemp;
				else{
				   DataManager[] firstOne = dataManagerInner;
				    dataManagerInner = new DataManager[firstOne.Length+dataManagertemp.Length];
					firstOne.CopyTo(dataManagerInner,0);
					dataManagertemp.CopyTo(dataManagerInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalDataManager = dataManagerInner;
		}
		
		public static  IEnumerator GetDataManagerArrayIEnumerator(DataManagerArray dataManagerArray) {
		
			DataManager[] dataManagerInner = new DataManager[dataManagerArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(dataManagerArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					dataManagerInner[count] = new DataManager(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalDataManager = dataManagerInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				DataManager[]  dataManagerInner = new DataManager[0];
			    finalDataManager = dataManagerInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetDataManagerFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetDataManagerArrayFinished callback) {
			callback(true,new Error(),new DataManagerArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetDataManagerArrayFinished callback) {
			callback(true,new Error(),new DataManagerArray());
		}
		
		public static DataManager[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			DataManager[] dataManager = new DataManager[0];
		    
			return dataManager;
		}	
		
		public static  IEnumerator GetDataManagerArrayIEnumerator(DataManagerArray dataManagerArray) {
			yield return new WaitForSeconds(0.2f);
			DataManager[]  dataManagerInner = new DataManager[0];
			finalDataManager = dataManagerInner;
		}
#endif
		
		#endregion
	}
}

