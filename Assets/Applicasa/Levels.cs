//
// Levels.cs
// Created by Applicasa 
// 10/30/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Levels {	
		public static Levels[] finalLevels;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaLevels;
	
        public AndroidJavaObject innerLevelsJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetLevelsFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetLevelsArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetLevelsFinished(bool success, Error error, IntPtr levelsPtr);
		public delegate void GetLevelsArrayFinished(bool success, Error error, LevelsArray levelsArrayPtr);
		
		public Levels(IntPtr levelsPtr) {
			innerLevels = levelsPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			if(innerLevelsJavaObject==null)
				innerLevelsJavaObject = new AndroidJavaObject("com.applicasa.Levels.Levels",innerLevels);
#endif
		}
		
#if UNITY_ANDROID 
		public Levels(IntPtr levelsPtr, AndroidJavaObject levelsJavaObject) {
			innerLevels = levelsPtr;
			innerLevelsJavaObject = levelsJavaObject;
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaLevels();
		#endif
		public Levels() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaLevels==null)
			javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
		   innerLevelsJavaObject = new AndroidJavaObject("com.applicasa.Levels.Levels");
		   innerLevels = innerLevelsJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerLevels = ApplicasaLevels();
		#endif
		  }

		public struct LevelsArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Levels[] GetLevelsArray(LevelsArray levelsArray) {
			
			Levels[] levelsInner = new Levels[levelsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(levelsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					levelsInner[count] = new Levels(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return levelsInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Levels[] GetLevelsArray(LevelsArray levelsArray) {
			Levels[] levelss = new Levels[levelsArray.ArraySize];

			for (int i=0; i < levelsArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (levelsArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				levelss[i] = new Levels(newPtr);
			}
			return levelss;
		}
#else
		public static Levels[] GetLevelsArray(LevelsArray levelsArray) {
			Levels[] levelss = new Levels[0];
			return levelss;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Levels()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerLevels);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerLevels;
		
			#region Class Members
#if UNITY_IPHONE

		public string LevelsID {
			get {return ApplicasaLevelsGetLevelsID(innerLevels);}
			set {ApplicasaLevelsSetLevelsID(innerLevels, value);}
		}
		public DateTime LevelsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaLevelsGetLevelsLastUpdate(innerLevels));}
		}
		public string LevelsGtgtg {
			get {return ApplicasaLevelsGetLevelsGtgtg(innerLevels);}
			set {ApplicasaLevelsSetLevelsGtgtg(innerLevels, value);}
		}
		public string LevelsHTML {
			get {return ApplicasaLevelsGetLevelsHTML(innerLevels);}
			set {ApplicasaLevelsSetLevelsHTML(innerLevels, value);}
		}
		public int LevelsTgtggtg {
			get {return ApplicasaLevelsGetLevelsTgtggtg(innerLevels);}
			set {ApplicasaLevelsSetLevelsTgtggtg(innerLevels, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaLevelsGetLevelsID(System.IntPtr levels);
	[DllImport("__Internal")]
	private static extern void ApplicasaLevelsSetLevelsID(System.IntPtr levels, string levelsID);
	[DllImport("__Internal")]
	private static extern double ApplicasaLevelsGetLevelsLastUpdate(System.IntPtr levels);
	[DllImport("__Internal")]
	private static extern string ApplicasaLevelsGetLevelsGtgtg(System.IntPtr levels);
	[DllImport("__Internal")]
	private static extern void ApplicasaLevelsSetLevelsGtgtg(System.IntPtr levels, string levelsGtgtg);
	[DllImport("__Internal")]
	private static extern string ApplicasaLevelsGetLevelsHTML(System.IntPtr levels);
	[DllImport("__Internal")]
	private static extern void ApplicasaLevelsSetLevelsHTML(System.IntPtr levels, string levelsHTML);
	[DllImport("__Internal")]
	private static extern int ApplicasaLevelsGetLevelsTgtggtg(System.IntPtr levels);
	[DllImport("__Internal")]
	private static extern void ApplicasaLevelsSetLevelsTgtggtg(System.IntPtr levels, int levelsTgtggtg);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string LevelsID {
			get {return javaUnityApplicasaLevels.CallStatic<string>("ApplicasaLevelsGetLevelsID", innerLevelsJavaObject);}
			set {javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsSetLevelsID", innerLevelsJavaObject, value);}
		}
		public DateTime LevelsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaLevels.CallStatic<double>("ApplicasaLevelsGetLevelsLastUpdate",innerLevelsJavaObject));}
		}
		public string LevelsGtgtg {
			get {return javaUnityApplicasaLevels.CallStatic<string>("ApplicasaLevelsGetLevelsGtgtg", innerLevelsJavaObject);}
			set {javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsSetLevelsGtgtg", innerLevelsJavaObject, value);}
		}
		public string LevelsHTML {
			get {return javaUnityApplicasaLevels.CallStatic<string>("ApplicasaLevelsGetLevelsHTML", innerLevelsJavaObject);}
			set {javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsSetLevelsHTML", innerLevelsJavaObject, value);}
		}
		public int LevelsTgtggtg {
			get {return javaUnityApplicasaLevels.CallStatic<int>("ApplicasaLevelsGetLevelsTgtggtg",innerLevelsJavaObject);}
			set {javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsSetLevelsTgtggtg",innerLevelsJavaObject, value);}
		}

#else

		public string LevelsID {
			get {return "";}
			set { }
		}
		public DateTime LevelsLastUpdate {
			get {return new DateTime();}
		}
		public string LevelsGtgtg {
			get {return "";}
			set { }
		}
		public string LevelsHTML {
			get {return "";}
			set { }
		}
		public int LevelsTgtggtg {
			get {return 0;}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsSaveWithBlock(System.IntPtr levels, Action callback);
		public void Save(Action action) {
			ApplicasaLevelsSaveWithBlock(innerLevels, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsIncreaseFieldInt(System.IntPtr levels, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsIncreaseFieldFloat(System.IntPtr levels, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaLevelsIncreaseFieldInt(innerLevels, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaLevelsIncreaseFieldFloat(innerLevels, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsDeleteWithBlock(System.IntPtr levels, Action callback);
		public void Delete(Action action) {
			ApplicasaLevelsDeleteWithBlock(innerLevels, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsUploadFile(System.IntPtr levels, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaLevelsUploadFile(innerLevels, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsSaveWithBlock", innerLevelsJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsIncreaseFieldInt", innerLevelsJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsIncreaseFieldFloat", innerLevelsJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsDeleteWithBlock", innerLevelsJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsUploadFile", innerLevelsJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaLevelsGetById(string id, QueryKind queryKind, GetLevelsFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetLevelsFinished callback) {
			ApplicasaLevelsGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetLevelsArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetLevelsArrayFinished callback) {
			ApplicasaLevelsGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLevelsGetLocalArrayWithRawSqlQuery(string rawQuery, GetLevelsArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetLevelsArrayFinished callback) {
			ApplicasaLevelsGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern LevelsArray ApplicasaLevelsGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Levels[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetLevelsArray(ApplicasaLevelsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			LevelsArray levelsArray = ApplicasaLevelsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalLevels = GetLevelsArray(levelsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetLevelsArrayIEnumerator(LevelsArray levelsArray) {
			finalLevels = GetLevelsArray(levelsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaLevelsUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaLevelsUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetLevelsFinished callback) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetLevelsArrayFinished callback) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetLevelsArrayFinished callback) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaLevels.CallStatic("ApplicasaLevelsGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Levels[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaLevels.CallStatic<AndroidJavaObject[]>("ApplicasaLevelsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Levels[] levelsInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Levels[] levelstemp = new Levels[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					levelstemp[j] = new Levels(tempObj.GetRawObject(),tempObj);
				}
				if (levelsInner == null)
					levelsInner = levelstemp;
				else{
				   Levels[] firstOne = levelsInner;
				    levelsInner = new Levels[firstOne.Length+levelstemp.Length];
					firstOne.CopyTo(levelsInner,0);
					levelstemp.CopyTo(levelsInner,firstOne.Length);
				}
				
			}
			return levelsInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
				
				int count = javaUnityApplicasaLevels.CallStatic<int>("ApplicasaLevelsUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaLevels==null)
				javaUnityApplicasaLevels = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLevels");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaLevels.CallStatic<AndroidJavaObject[]>("ApplicasaLevelsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Levels[] levelsInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Levels[] levelstemp = new Levels[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					levelstemp[j] = new Levels(tempObj.GetRawObject(),tempObj);
				}
				if (levelsInner == null)
					levelsInner = levelstemp;
				else{
				   Levels[] firstOne = levelsInner;
				    levelsInner = new Levels[firstOne.Length+levelstemp.Length];
					firstOne.CopyTo(levelsInner,0);
					levelstemp.CopyTo(levelsInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalLevels = levelsInner;
		}
		
		public static  IEnumerator GetLevelsArrayIEnumerator(LevelsArray levelsArray) {
		
			Levels[] levelsInner = new Levels[levelsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(levelsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					levelsInner[count] = new Levels(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalLevels = levelsInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Levels[]  levelsInner = new Levels[0];
			    finalLevels = levelsInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetLevelsFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetLevelsArrayFinished callback) {
			callback(true,new Error(),new LevelsArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetLevelsArrayFinished callback) {
			callback(true,new Error(),new LevelsArray());
		}
		
		public static Levels[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Levels[] levels = new Levels[0];
		    
			return levels;
		}	
		
		public static  IEnumerator GetLevelsArrayIEnumerator(LevelsArray levelsArray) {
			yield return new WaitForSeconds(0.2f);
			Levels[]  levelsInner = new Levels[0];
			finalLevels = levelsInner;
		}
#endif
		
		#endregion
	}
}

