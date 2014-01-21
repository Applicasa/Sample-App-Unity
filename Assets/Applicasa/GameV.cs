//
// GameV.cs
// Created by Applicasa 
// 1/21/2014
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class GameV {	
		public static GameV[] finalGameV;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaGameV;
	
        public AndroidJavaObject innerGameVJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetGameVFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetGameVArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetGameVFinished(bool success, Error error, IntPtr gameVPtr);
		public delegate void GetGameVArrayFinished(bool success, Error error, GameVArray gameVArrayPtr);
		
		public GameV(IntPtr gameVPtr) {
			innerGameV = gameVPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			if(innerGameVJavaObject==null)
				innerGameVJavaObject = new AndroidJavaObject("com.applicasa.GameV.GameV",innerGameV);
#endif
		}
		
#if UNITY_ANDROID 
		public GameV(IntPtr gameVPtr, AndroidJavaObject gameVJavaObject) {
			innerGameV = gameVPtr;
			innerGameVJavaObject = gameVJavaObject;
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaGameV();
		#endif
		public GameV() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaGameV==null)
			javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
		   innerGameVJavaObject = new AndroidJavaObject("com.applicasa.GameV.GameV");
		   innerGameV = innerGameVJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerGameV = ApplicasaGameV();
		#endif
		  }

		public struct GameVArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static GameV[] GetGameVArray(GameVArray gameVArray) {
			
			GameV[] gameVInner = new GameV[gameVArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(gameVArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					gameVInner[count] = new GameV(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return gameVInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static GameV[] GetGameVArray(GameVArray gameVArray) {
			GameV[] gameVs = new GameV[gameVArray.ArraySize];

			for (int i=0; i < gameVArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (gameVArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				gameVs[i] = new GameV(newPtr);
			}
			return gameVs;
		}
#else
		public static GameV[] GetGameVArray(GameVArray gameVArray) {
			GameV[] gameVs = new GameV[0];
			return gameVs;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~GameV()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerGameV);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerGameV;
		
			#region Class Members
#if UNITY_IPHONE

		public string GameVID {
			get {return ApplicasaGameVGetGameVID(innerGameV);}
			set {ApplicasaGameVSetGameVID(innerGameV, value);}
		}
		public DateTime GameVLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaGameVGetGameVLastUpdate(innerGameV));}
		}
		public int GameVValue {
			get {return ApplicasaGameVGetGameVValue(innerGameV);}
			set {ApplicasaGameVSetGameVValue(innerGameV, value);}
		}
		public string GameVFunction {
			get {return ApplicasaGameVGetGameVFunction(innerGameV);}
			set {ApplicasaGameVSetGameVFunction(innerGameV, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaGameVGetGameVID(System.IntPtr gameV);
	[DllImport("__Internal")]
	private static extern void ApplicasaGameVSetGameVID(System.IntPtr gameV, string gameVID);
	[DllImport("__Internal")]
	private static extern double ApplicasaGameVGetGameVLastUpdate(System.IntPtr gameV);
	[DllImport("__Internal")]
	private static extern int ApplicasaGameVGetGameVValue(System.IntPtr gameV);
	[DllImport("__Internal")]
	private static extern void ApplicasaGameVSetGameVValue(System.IntPtr gameV, int gameVValue);
	[DllImport("__Internal")]
	private static extern string ApplicasaGameVGetGameVFunction(System.IntPtr gameV);
	[DllImport("__Internal")]
	private static extern void ApplicasaGameVSetGameVFunction(System.IntPtr gameV, string gameVFunction);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string GameVID {
			get {return javaUnityApplicasaGameV.CallStatic<string>("ApplicasaGameVGetGameVID", innerGameVJavaObject);}
			set {javaUnityApplicasaGameV.CallStatic("ApplicasaGameVSetGameVID", innerGameVJavaObject, value);}
		}
		public DateTime GameVLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaGameV.CallStatic<double>("ApplicasaGameVGetGameVLastUpdate",innerGameVJavaObject));}
		}
		public int GameVValue {
			get {return javaUnityApplicasaGameV.CallStatic<int>("ApplicasaGameVGetGameVValue",innerGameVJavaObject);}
			set {javaUnityApplicasaGameV.CallStatic("ApplicasaGameVSetGameVValue",innerGameVJavaObject, value);}
		}
		public string GameVFunction {
			get {return javaUnityApplicasaGameV.CallStatic<string>("ApplicasaGameVGetGameVFunction", innerGameVJavaObject);}
			set {javaUnityApplicasaGameV.CallStatic("ApplicasaGameVSetGameVFunction", innerGameVJavaObject, value);}
		}

#else

		public string GameVID {
			get {return "";}
			set { }
		}
		public DateTime GameVLastUpdate {
			get {return new DateTime();}
		}
		public int GameVValue {
			get {return 0;}
			set { }
		}
		public string GameVFunction {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVSaveWithBlock(System.IntPtr gameV, Action callback);
		public void Save(Action action) {
			ApplicasaGameVSaveWithBlock(innerGameV, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVIncreaseFieldInt(System.IntPtr gameV, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVIncreaseFieldFloat(System.IntPtr gameV, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaGameVIncreaseFieldInt(innerGameV, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaGameVIncreaseFieldFloat(innerGameV, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVDeleteWithBlock(System.IntPtr gameV, Action callback);
		public void Delete(Action action) {
			ApplicasaGameVDeleteWithBlock(innerGameV, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVUploadFile(System.IntPtr gameV, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaGameVUploadFile(innerGameV, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVSaveWithBlock", innerGameVJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVIncreaseFieldInt", innerGameVJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVIncreaseFieldFloat", innerGameVJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVDeleteWithBlock", innerGameVJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVUploadFile", innerGameVJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaGameVGetById(string id, QueryKind queryKind, GetGameVFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetGameVFinished callback) {
			ApplicasaGameVGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetGameVArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetGameVArrayFinished callback) {
			ApplicasaGameVGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGameVGetLocalArrayWithRawSqlQuery(string rawQuery, GetGameVArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetGameVArrayFinished callback) {
			ApplicasaGameVGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern GameVArray ApplicasaGameVGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static GameV[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetGameVArray(ApplicasaGameVGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			GameVArray gameVArray = ApplicasaGameVGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalGameV = GetGameVArray(gameVArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetGameVArrayIEnumerator(GameVArray gameVArray) {
			finalGameV = GetGameVArray(gameVArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaGameVUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaGameVUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetGameVFinished callback) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetGameVArrayFinished callback) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetGameVArrayFinished callback) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaGameV.CallStatic("ApplicasaGameVGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static GameV[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaGameV.CallStatic<AndroidJavaObject[]>("ApplicasaGameVGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			GameV[] gameVInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				GameV[] gameVtemp = new GameV[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					gameVtemp[j] = new GameV(tempObj.GetRawObject(),tempObj);
				}
				if (gameVInner == null)
					gameVInner = gameVtemp;
				else{
				   GameV[] firstOne = gameVInner;
				    gameVInner = new GameV[firstOne.Length+gameVtemp.Length];
					firstOne.CopyTo(gameVInner,0);
					gameVtemp.CopyTo(gameVInner,firstOne.Length);
				}
				
			}
			return gameVInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
				
				int count = javaUnityApplicasaGameV.CallStatic<int>("ApplicasaGameVUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaGameV==null)
				javaUnityApplicasaGameV = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaGameV");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaGameV.CallStatic<AndroidJavaObject[]>("ApplicasaGameVGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			GameV[] gameVInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				GameV[] gameVtemp = new GameV[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					gameVtemp[j] = new GameV(tempObj.GetRawObject(),tempObj);
				}
				if (gameVInner == null)
					gameVInner = gameVtemp;
				else{
				   GameV[] firstOne = gameVInner;
				    gameVInner = new GameV[firstOne.Length+gameVtemp.Length];
					firstOne.CopyTo(gameVInner,0);
					gameVtemp.CopyTo(gameVInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalGameV = gameVInner;
		}
		
		public static  IEnumerator GetGameVArrayIEnumerator(GameVArray gameVArray) {
		
			GameV[] gameVInner = new GameV[gameVArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(gameVArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					gameVInner[count] = new GameV(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalGameV = gameVInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				GameV[]  gameVInner = new GameV[0];
			    finalGameV = gameVInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetGameVFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetGameVArrayFinished callback) {
			callback(true,new Error(),new GameVArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetGameVArrayFinished callback) {
			callback(true,new Error(),new GameVArray());
		}
		
		public static GameV[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			GameV[] gameV = new GameV[0];
		    
			return gameV;
		}	
		
		public static  IEnumerator GetGameVArrayIEnumerator(GameVArray gameVArray) {
			yield return new WaitForSeconds(0.2f);
			GameV[]  gameVInner = new GameV[0];
			finalGameV = gameVInner;
		}
#endif
		
		#endregion
	}
}

