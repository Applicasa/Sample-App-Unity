//
// ScoreB.cs
// Created by Applicasa 
// 1/21/2014
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class ScoreB {	
		public static ScoreB[] finalScoreB;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaScoreB;
	
        public AndroidJavaObject innerScoreBJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetScoreBFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetScoreBArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetScoreBFinished(bool success, Error error, IntPtr scoreBPtr);
		public delegate void GetScoreBArrayFinished(bool success, Error error, ScoreBArray scoreBArrayPtr);
		
		public ScoreB(IntPtr scoreBPtr) {
			innerScoreB = scoreBPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			if(innerScoreBJavaObject==null)
				innerScoreBJavaObject = new AndroidJavaObject("com.applicasa.ScoreB.ScoreB",innerScoreB);
#endif
		}
		
#if UNITY_ANDROID 
		public ScoreB(IntPtr scoreBPtr, AndroidJavaObject scoreBJavaObject) {
			innerScoreB = scoreBPtr;
			innerScoreBJavaObject = scoreBJavaObject;
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaScoreB();
		#endif
		public ScoreB() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaScoreB==null)
			javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
		   innerScoreBJavaObject = new AndroidJavaObject("com.applicasa.ScoreB.ScoreB");
		   innerScoreB = innerScoreBJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerScoreB = ApplicasaScoreB();
		#endif
		  }

		public struct ScoreBArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static ScoreB[] GetScoreBArray(ScoreBArray scoreBArray) {
			
			ScoreB[] scoreBInner = new ScoreB[scoreBArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(scoreBArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					scoreBInner[count] = new ScoreB(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return scoreBInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static ScoreB[] GetScoreBArray(ScoreBArray scoreBArray) {
			ScoreB[] scoreBs = new ScoreB[scoreBArray.ArraySize];

			for (int i=0; i < scoreBArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (scoreBArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				scoreBs[i] = new ScoreB(newPtr);
			}
			return scoreBs;
		}
#else
		public static ScoreB[] GetScoreBArray(ScoreBArray scoreBArray) {
			ScoreB[] scoreBs = new ScoreB[0];
			return scoreBs;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~ScoreB()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerScoreB);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerScoreB;
		
			#region Class Members
#if UNITY_IPHONE

		public string ScoreBID {
			get {return ApplicasaScoreBGetScoreBID(innerScoreB);}
			set {ApplicasaScoreBSetScoreBID(innerScoreB, value);}
		}
		public DateTime ScoreBLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaScoreBGetScoreBLastUpdate(innerScoreB));}
		}
		public int ScoreBScore {
			get {return ApplicasaScoreBGetScoreBScore(innerScoreB);}
			set {ApplicasaScoreBSetScoreBScore(innerScoreB, value);}
		}
		public User ScoreBUser {
			get {return new User(ApplicasaScoreBGetScoreBUser(innerScoreB));}
			set {ApplicasaScoreBSetScoreBUser(innerScoreB, value.innerUser);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaScoreBGetScoreBID(System.IntPtr scoreB);
	[DllImport("__Internal")]
	private static extern void ApplicasaScoreBSetScoreBID(System.IntPtr scoreB, string scoreBID);
	[DllImport("__Internal")]
	private static extern double ApplicasaScoreBGetScoreBLastUpdate(System.IntPtr scoreB);
	[DllImport("__Internal")]
	private static extern int ApplicasaScoreBGetScoreBScore(System.IntPtr scoreB);
	[DllImport("__Internal")]
	private static extern void ApplicasaScoreBSetScoreBScore(System.IntPtr scoreB, int scoreBScore);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaScoreBGetScoreBUser(System.IntPtr scoreB);
	[DllImport("__Internal")]
	private static extern void ApplicasaScoreBSetScoreBUser(System.IntPtr scoreB, IntPtr scoreBUser);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string ScoreBID {
			get {return javaUnityApplicasaScoreB.CallStatic<string>("ApplicasaScoreBGetScoreBID", innerScoreBJavaObject);}
			set {javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBSetScoreBID", innerScoreBJavaObject, value);}
		}
		public DateTime ScoreBLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaScoreB.CallStatic<double>("ApplicasaScoreBGetScoreBLastUpdate",innerScoreBJavaObject));}
		}
		public int ScoreBScore {
			get {return javaUnityApplicasaScoreB.CallStatic<int>("ApplicasaScoreBGetScoreBScore",innerScoreBJavaObject);}
			set {javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBSetScoreBScore",innerScoreBJavaObject, value);}
		}
		public User ScoreBUser {
			get {
				AndroidJavaObject temp = javaUnityApplicasaScoreB.CallStatic<AndroidJavaObject>("ApplicasaScoreBGetScoreBUser",innerScoreBJavaObject);
				return new User(temp.GetRawObject(),temp);}
			set {javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBSetScoreBUser",innerScoreBJavaObject, value.innerUserJavaObject);}
		}

#else

		public string ScoreBID {
			get {return "";}
			set { }
		}
		public DateTime ScoreBLastUpdate {
			get {return new DateTime();}
		}
		public int ScoreBScore {
			get {return 0;}
			set { }
		}
		public User ScoreBUser {
			get {return null;}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBSaveWithBlock(System.IntPtr scoreB, Action callback);
		public void Save(Action action) {
			ApplicasaScoreBSaveWithBlock(innerScoreB, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBIncreaseFieldInt(System.IntPtr scoreB, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBIncreaseFieldFloat(System.IntPtr scoreB, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaScoreBIncreaseFieldInt(innerScoreB, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaScoreBIncreaseFieldFloat(innerScoreB, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBDeleteWithBlock(System.IntPtr scoreB, Action callback);
		public void Delete(Action action) {
			ApplicasaScoreBDeleteWithBlock(innerScoreB, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBUploadFile(System.IntPtr scoreB, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaScoreBUploadFile(innerScoreB, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBSaveWithBlock", innerScoreBJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBIncreaseFieldInt", innerScoreBJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBIncreaseFieldFloat", innerScoreBJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBDeleteWithBlock", innerScoreBJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBUploadFile", innerScoreBJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaScoreBGetById(string id, QueryKind queryKind, GetScoreBFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetScoreBFinished callback) {
			ApplicasaScoreBGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetScoreBArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetScoreBArrayFinished callback) {
			ApplicasaScoreBGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaScoreBGetLocalArrayWithRawSqlQuery(string rawQuery, GetScoreBArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetScoreBArrayFinished callback) {
			ApplicasaScoreBGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern ScoreBArray ApplicasaScoreBGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static ScoreB[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetScoreBArray(ApplicasaScoreBGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			ScoreBArray scoreBArray = ApplicasaScoreBGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalScoreB = GetScoreBArray(scoreBArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetScoreBArrayIEnumerator(ScoreBArray scoreBArray) {
			finalScoreB = GetScoreBArray(scoreBArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaScoreBUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaScoreBUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetScoreBFinished callback) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetScoreBArrayFinished callback) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetScoreBArrayFinished callback) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaScoreB.CallStatic("ApplicasaScoreBGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static ScoreB[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaScoreB.CallStatic<AndroidJavaObject[]>("ApplicasaScoreBGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			ScoreB[] scoreBInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				ScoreB[] scoreBtemp = new ScoreB[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					scoreBtemp[j] = new ScoreB(tempObj.GetRawObject(),tempObj);
				}
				if (scoreBInner == null)
					scoreBInner = scoreBtemp;
				else{
				   ScoreB[] firstOne = scoreBInner;
				    scoreBInner = new ScoreB[firstOne.Length+scoreBtemp.Length];
					firstOne.CopyTo(scoreBInner,0);
					scoreBtemp.CopyTo(scoreBInner,firstOne.Length);
				}
				
			}
			return scoreBInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
				
				int count = javaUnityApplicasaScoreB.CallStatic<int>("ApplicasaScoreBUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaScoreB==null)
				javaUnityApplicasaScoreB = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaScoreB");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaScoreB.CallStatic<AndroidJavaObject[]>("ApplicasaScoreBGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			ScoreB[] scoreBInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				ScoreB[] scoreBtemp = new ScoreB[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					scoreBtemp[j] = new ScoreB(tempObj.GetRawObject(),tempObj);
				}
				if (scoreBInner == null)
					scoreBInner = scoreBtemp;
				else{
				   ScoreB[] firstOne = scoreBInner;
				    scoreBInner = new ScoreB[firstOne.Length+scoreBtemp.Length];
					firstOne.CopyTo(scoreBInner,0);
					scoreBtemp.CopyTo(scoreBInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalScoreB = scoreBInner;
		}
		
		public static  IEnumerator GetScoreBArrayIEnumerator(ScoreBArray scoreBArray) {
		
			ScoreB[] scoreBInner = new ScoreB[scoreBArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(scoreBArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					scoreBInner[count] = new ScoreB(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalScoreB = scoreBInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				ScoreB[]  scoreBInner = new ScoreB[0];
			    finalScoreB = scoreBInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetScoreBFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetScoreBArrayFinished callback) {
			callback(true,new Error(),new ScoreBArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetScoreBArrayFinished callback) {
			callback(true,new Error(),new ScoreBArray());
		}
		
		public static ScoreB[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			ScoreB[] scoreB = new ScoreB[0];
		    
			return scoreB;
		}	
		
		public static  IEnumerator GetScoreBArrayIEnumerator(ScoreBArray scoreBArray) {
			yield return new WaitForSeconds(0.2f);
			ScoreB[]  scoreBInner = new ScoreB[0];
			finalScoreB = scoreBInner;
		}
#endif
		
		#endregion
	}
}

