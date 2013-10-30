//
// Achievments.cs
// Created by Applicasa 
// 10/30/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Achievments {	
		public static Achievments[] finalAchievments;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaAchievments;
	
        public AndroidJavaObject innerAchievmentsJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetAchievmentsFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetAchievmentsArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetAchievmentsFinished(bool success, Error error, IntPtr achievmentsPtr);
		public delegate void GetAchievmentsArrayFinished(bool success, Error error, AchievmentsArray achievmentsArrayPtr);
		
		public Achievments(IntPtr achievmentsPtr) {
			innerAchievments = achievmentsPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			if(innerAchievmentsJavaObject==null)
				innerAchievmentsJavaObject = new AndroidJavaObject("com.applicasa.Achievments.Achievments",innerAchievments);
#endif
		}
		
#if UNITY_ANDROID 
		public Achievments(IntPtr achievmentsPtr, AndroidJavaObject achievmentsJavaObject) {
			innerAchievments = achievmentsPtr;
			innerAchievmentsJavaObject = achievmentsJavaObject;
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaAchievments();
		#endif
		public Achievments() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaAchievments==null)
			javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
		   innerAchievmentsJavaObject = new AndroidJavaObject("com.applicasa.Achievments.Achievments");
		   innerAchievments = innerAchievmentsJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerAchievments = ApplicasaAchievments();
		#endif
		  }

		public struct AchievmentsArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Achievments[] GetAchievmentsArray(AchievmentsArray achievmentsArray) {
			
			Achievments[] achievmentsInner = new Achievments[achievmentsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(achievmentsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					achievmentsInner[count] = new Achievments(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return achievmentsInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Achievments[] GetAchievmentsArray(AchievmentsArray achievmentsArray) {
			Achievments[] achievmentss = new Achievments[achievmentsArray.ArraySize];

			for (int i=0; i < achievmentsArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (achievmentsArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				achievmentss[i] = new Achievments(newPtr);
			}
			return achievmentss;
		}
#else
		public static Achievments[] GetAchievmentsArray(AchievmentsArray achievmentsArray) {
			Achievments[] achievmentss = new Achievments[0];
			return achievmentss;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Achievments()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerAchievments);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerAchievments;
		
			#region Class Members
#if UNITY_IPHONE

		public string AchievmentsID {
			get {return ApplicasaAchievmentsGetAchievmentsID(innerAchievments);}
			set {ApplicasaAchievmentsSetAchievmentsID(innerAchievments, value);}
		}
		public DateTime AchievmentsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaAchievmentsGetAchievmentsLastUpdate(innerAchievments));}
		}
		public int AchievmentsPoints {
			get {return ApplicasaAchievmentsGetAchievmentsPoints(innerAchievments);}
			set {ApplicasaAchievmentsSetAchievmentsPoints(innerAchievments, value);}
		}
		public string AchievmentsDes {
			get {return ApplicasaAchievmentsGetAchievmentsDes(innerAchievments);}
			set {ApplicasaAchievmentsSetAchievmentsDes(innerAchievments, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaAchievmentsGetAchievmentsID(System.IntPtr achievments);
	[DllImport("__Internal")]
	private static extern void ApplicasaAchievmentsSetAchievmentsID(System.IntPtr achievments, string achievmentsID);
	[DllImport("__Internal")]
	private static extern double ApplicasaAchievmentsGetAchievmentsLastUpdate(System.IntPtr achievments);
	[DllImport("__Internal")]
	private static extern int ApplicasaAchievmentsGetAchievmentsPoints(System.IntPtr achievments);
	[DllImport("__Internal")]
	private static extern void ApplicasaAchievmentsSetAchievmentsPoints(System.IntPtr achievments, int achievmentsPoints);
	[DllImport("__Internal")]
	private static extern string ApplicasaAchievmentsGetAchievmentsDes(System.IntPtr achievments);
	[DllImport("__Internal")]
	private static extern void ApplicasaAchievmentsSetAchievmentsDes(System.IntPtr achievments, string achievmentsDes);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string AchievmentsID {
			get {return javaUnityApplicasaAchievments.CallStatic<string>("ApplicasaAchievmentsGetAchievmentsID", innerAchievmentsJavaObject);}
			set {javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsSetAchievmentsID", innerAchievmentsJavaObject, value);}
		}
		public DateTime AchievmentsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaAchievments.CallStatic<double>("ApplicasaAchievmentsGetAchievmentsLastUpdate",innerAchievmentsJavaObject));}
		}
		public int AchievmentsPoints {
			get {return javaUnityApplicasaAchievments.CallStatic<int>("ApplicasaAchievmentsGetAchievmentsPoints",innerAchievmentsJavaObject);}
			set {javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsSetAchievmentsPoints",innerAchievmentsJavaObject, value);}
		}
		public string AchievmentsDes {
			get {return javaUnityApplicasaAchievments.CallStatic<string>("ApplicasaAchievmentsGetAchievmentsDes", innerAchievmentsJavaObject);}
			set {javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsSetAchievmentsDes", innerAchievmentsJavaObject, value);}
		}

#else

		public string AchievmentsID {
			get {return "";}
			set { }
		}
		public DateTime AchievmentsLastUpdate {
			get {return new DateTime();}
		}
		public int AchievmentsPoints {
			get {return 0;}
			set { }
		}
		public string AchievmentsDes {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsSaveWithBlock(System.IntPtr achievments, Action callback);
		public void Save(Action action) {
			ApplicasaAchievmentsSaveWithBlock(innerAchievments, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsIncreaseFieldInt(System.IntPtr achievments, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsIncreaseFieldFloat(System.IntPtr achievments, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaAchievmentsIncreaseFieldInt(innerAchievments, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaAchievmentsIncreaseFieldFloat(innerAchievments, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsDeleteWithBlock(System.IntPtr achievments, Action callback);
		public void Delete(Action action) {
			ApplicasaAchievmentsDeleteWithBlock(innerAchievments, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsUploadFile(System.IntPtr achievments, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaAchievmentsUploadFile(innerAchievments, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsSaveWithBlock", innerAchievmentsJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsIncreaseFieldInt", innerAchievmentsJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsIncreaseFieldFloat", innerAchievmentsJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsDeleteWithBlock", innerAchievmentsJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsUploadFile", innerAchievmentsJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaAchievmentsGetById(string id, QueryKind queryKind, GetAchievmentsFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetAchievmentsFinished callback) {
			ApplicasaAchievmentsGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetAchievmentsArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetAchievmentsArrayFinished callback) {
			ApplicasaAchievmentsGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaAchievmentsGetLocalArrayWithRawSqlQuery(string rawQuery, GetAchievmentsArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetAchievmentsArrayFinished callback) {
			ApplicasaAchievmentsGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern AchievmentsArray ApplicasaAchievmentsGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Achievments[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetAchievmentsArray(ApplicasaAchievmentsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			AchievmentsArray achievmentsArray = ApplicasaAchievmentsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalAchievments = GetAchievmentsArray(achievmentsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetAchievmentsArrayIEnumerator(AchievmentsArray achievmentsArray) {
			finalAchievments = GetAchievmentsArray(achievmentsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaAchievmentsUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaAchievmentsUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetAchievmentsFinished callback) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetAchievmentsArrayFinished callback) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetAchievmentsArrayFinished callback) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaAchievments.CallStatic("ApplicasaAchievmentsGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Achievments[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaAchievments.CallStatic<AndroidJavaObject[]>("ApplicasaAchievmentsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Achievments[] achievmentsInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Achievments[] achievmentstemp = new Achievments[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					achievmentstemp[j] = new Achievments(tempObj.GetRawObject(),tempObj);
				}
				if (achievmentsInner == null)
					achievmentsInner = achievmentstemp;
				else{
				   Achievments[] firstOne = achievmentsInner;
				    achievmentsInner = new Achievments[firstOne.Length+achievmentstemp.Length];
					firstOne.CopyTo(achievmentsInner,0);
					achievmentstemp.CopyTo(achievmentsInner,firstOne.Length);
				}
				
			}
			return achievmentsInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
				
				int count = javaUnityApplicasaAchievments.CallStatic<int>("ApplicasaAchievmentsUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaAchievments==null)
				javaUnityApplicasaAchievments = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaAchievments");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaAchievments.CallStatic<AndroidJavaObject[]>("ApplicasaAchievmentsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Achievments[] achievmentsInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Achievments[] achievmentstemp = new Achievments[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					achievmentstemp[j] = new Achievments(tempObj.GetRawObject(),tempObj);
				}
				if (achievmentsInner == null)
					achievmentsInner = achievmentstemp;
				else{
				   Achievments[] firstOne = achievmentsInner;
				    achievmentsInner = new Achievments[firstOne.Length+achievmentstemp.Length];
					firstOne.CopyTo(achievmentsInner,0);
					achievmentstemp.CopyTo(achievmentsInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalAchievments = achievmentsInner;
		}
		
		public static  IEnumerator GetAchievmentsArrayIEnumerator(AchievmentsArray achievmentsArray) {
		
			Achievments[] achievmentsInner = new Achievments[achievmentsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(achievmentsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					achievmentsInner[count] = new Achievments(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalAchievments = achievmentsInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Achievments[]  achievmentsInner = new Achievments[0];
			    finalAchievments = achievmentsInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetAchievmentsFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetAchievmentsArrayFinished callback) {
			callback(true,new Error(),new AchievmentsArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetAchievmentsArrayFinished callback) {
			callback(true,new Error(),new AchievmentsArray());
		}
		
		public static Achievments[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Achievments[] achievments = new Achievments[0];
		    
			return achievments;
		}	
		
		public static  IEnumerator GetAchievmentsArrayIEnumerator(AchievmentsArray achievmentsArray) {
			yield return new WaitForSeconds(0.2f);
			Achievments[]  achievmentsInner = new Achievments[0];
			finalAchievments = achievmentsInner;
		}
#endif
		
		#endregion
	}
}

