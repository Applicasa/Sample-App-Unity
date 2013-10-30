//
// Languages.cs
// Created by Applicasa 
// 10/30/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Languages {	
		public static Languages[] finalLanguages;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaLanguages;
	
        public AndroidJavaObject innerLanguagesJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetLanguagesFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetLanguagesArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetLanguagesFinished(bool success, Error error, IntPtr languagesPtr);
		public delegate void GetLanguagesArrayFinished(bool success, Error error, LanguagesArray languagesArrayPtr);
		
		public Languages(IntPtr languagesPtr) {
			innerLanguages = languagesPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			if(innerLanguagesJavaObject==null)
				innerLanguagesJavaObject = new AndroidJavaObject("com.applicasa.Languages.Languages",innerLanguages);
#endif
		}
		
#if UNITY_ANDROID 
		public Languages(IntPtr languagesPtr, AndroidJavaObject languagesJavaObject) {
			innerLanguages = languagesPtr;
			innerLanguagesJavaObject = languagesJavaObject;
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaLanguages();
		#endif
		public Languages() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaLanguages==null)
			javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
		   innerLanguagesJavaObject = new AndroidJavaObject("com.applicasa.Languages.Languages");
		   innerLanguages = innerLanguagesJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerLanguages = ApplicasaLanguages();
		#endif
		  }

		public struct LanguagesArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Languages[] GetLanguagesArray(LanguagesArray languagesArray) {
			
			Languages[] languagesInner = new Languages[languagesArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(languagesArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					languagesInner[count] = new Languages(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return languagesInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Languages[] GetLanguagesArray(LanguagesArray languagesArray) {
			Languages[] languagess = new Languages[languagesArray.ArraySize];

			for (int i=0; i < languagesArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (languagesArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				languagess[i] = new Languages(newPtr);
			}
			return languagess;
		}
#else
		public static Languages[] GetLanguagesArray(LanguagesArray languagesArray) {
			Languages[] languagess = new Languages[0];
			return languagess;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Languages()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerLanguages);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerLanguages;
		
			#region Class Members
#if UNITY_IPHONE

		public string LanguagesID {
			get {return ApplicasaLanguagesGetLanguagesID(innerLanguages);}
			set {ApplicasaLanguagesSetLanguagesID(innerLanguages, value);}
		}
		public DateTime LanguagesLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaLanguagesGetLanguagesLastUpdate(innerLanguages));}
		}
		public string LanguagesText {
			get {return ApplicasaLanguagesGetLanguagesText(innerLanguages);}
			set {ApplicasaLanguagesSetLanguagesText(innerLanguages, value);}
		}
		public string LanguagesLanguageName {
			get {return ApplicasaLanguagesGetLanguagesLanguageName(innerLanguages);}
			set {ApplicasaLanguagesSetLanguagesLanguageName(innerLanguages, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaLanguagesGetLanguagesID(System.IntPtr languages);
	[DllImport("__Internal")]
	private static extern void ApplicasaLanguagesSetLanguagesID(System.IntPtr languages, string languagesID);
	[DllImport("__Internal")]
	private static extern double ApplicasaLanguagesGetLanguagesLastUpdate(System.IntPtr languages);
	[DllImport("__Internal")]
	private static extern string ApplicasaLanguagesGetLanguagesText(System.IntPtr languages);
	[DllImport("__Internal")]
	private static extern void ApplicasaLanguagesSetLanguagesText(System.IntPtr languages, string languagesText);
	[DllImport("__Internal")]
	private static extern string ApplicasaLanguagesGetLanguagesLanguageName(System.IntPtr languages);
	[DllImport("__Internal")]
	private static extern void ApplicasaLanguagesSetLanguagesLanguageName(System.IntPtr languages, string languagesLanguageName);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string LanguagesID {
			get {return javaUnityApplicasaLanguages.CallStatic<string>("ApplicasaLanguagesGetLanguagesID", innerLanguagesJavaObject);}
			set {javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesSetLanguagesID", innerLanguagesJavaObject, value);}
		}
		public DateTime LanguagesLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaLanguages.CallStatic<double>("ApplicasaLanguagesGetLanguagesLastUpdate",innerLanguagesJavaObject));}
		}
		public string LanguagesText {
			get {return javaUnityApplicasaLanguages.CallStatic<string>("ApplicasaLanguagesGetLanguagesText", innerLanguagesJavaObject);}
			set {javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesSetLanguagesText", innerLanguagesJavaObject, value);}
		}
		public string LanguagesLanguageName {
			get {return javaUnityApplicasaLanguages.CallStatic<string>("ApplicasaLanguagesGetLanguagesLanguageName", innerLanguagesJavaObject);}
			set {javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesSetLanguagesLanguageName", innerLanguagesJavaObject, value);}
		}

#else

		public string LanguagesID {
			get {return "";}
			set { }
		}
		public DateTime LanguagesLastUpdate {
			get {return new DateTime();}
		}
		public string LanguagesText {
			get {return "";}
			set { }
		}
		public string LanguagesLanguageName {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesSaveWithBlock(System.IntPtr languages, Action callback);
		public void Save(Action action) {
			ApplicasaLanguagesSaveWithBlock(innerLanguages, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesIncreaseFieldInt(System.IntPtr languages, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesIncreaseFieldFloat(System.IntPtr languages, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaLanguagesIncreaseFieldInt(innerLanguages, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaLanguagesIncreaseFieldFloat(innerLanguages, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesDeleteWithBlock(System.IntPtr languages, Action callback);
		public void Delete(Action action) {
			ApplicasaLanguagesDeleteWithBlock(innerLanguages, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesUploadFile(System.IntPtr languages, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaLanguagesUploadFile(innerLanguages, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesSaveWithBlock", innerLanguagesJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesIncreaseFieldInt", innerLanguagesJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesIncreaseFieldFloat", innerLanguagesJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesDeleteWithBlock", innerLanguagesJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesUploadFile", innerLanguagesJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaLanguagesGetById(string id, QueryKind queryKind, GetLanguagesFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetLanguagesFinished callback) {
			ApplicasaLanguagesGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetLanguagesArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetLanguagesArrayFinished callback) {
			ApplicasaLanguagesGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLanguagesGetLocalArrayWithRawSqlQuery(string rawQuery, GetLanguagesArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetLanguagesArrayFinished callback) {
			ApplicasaLanguagesGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern LanguagesArray ApplicasaLanguagesGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Languages[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetLanguagesArray(ApplicasaLanguagesGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			LanguagesArray languagesArray = ApplicasaLanguagesGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalLanguages = GetLanguagesArray(languagesArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetLanguagesArrayIEnumerator(LanguagesArray languagesArray) {
			finalLanguages = GetLanguagesArray(languagesArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaLanguagesUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaLanguagesUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetLanguagesFinished callback) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetLanguagesArrayFinished callback) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetLanguagesArrayFinished callback) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaLanguages.CallStatic("ApplicasaLanguagesGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Languages[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaLanguages.CallStatic<AndroidJavaObject[]>("ApplicasaLanguagesGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Languages[] languagesInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Languages[] languagestemp = new Languages[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					languagestemp[j] = new Languages(tempObj.GetRawObject(),tempObj);
				}
				if (languagesInner == null)
					languagesInner = languagestemp;
				else{
				   Languages[] firstOne = languagesInner;
				    languagesInner = new Languages[firstOne.Length+languagestemp.Length];
					firstOne.CopyTo(languagesInner,0);
					languagestemp.CopyTo(languagesInner,firstOne.Length);
				}
				
			}
			return languagesInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
				
				int count = javaUnityApplicasaLanguages.CallStatic<int>("ApplicasaLanguagesUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaLanguages==null)
				javaUnityApplicasaLanguages = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLanguages");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaLanguages.CallStatic<AndroidJavaObject[]>("ApplicasaLanguagesGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Languages[] languagesInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Languages[] languagestemp = new Languages[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					languagestemp[j] = new Languages(tempObj.GetRawObject(),tempObj);
				}
				if (languagesInner == null)
					languagesInner = languagestemp;
				else{
				   Languages[] firstOne = languagesInner;
				    languagesInner = new Languages[firstOne.Length+languagestemp.Length];
					firstOne.CopyTo(languagesInner,0);
					languagestemp.CopyTo(languagesInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalLanguages = languagesInner;
		}
		
		public static  IEnumerator GetLanguagesArrayIEnumerator(LanguagesArray languagesArray) {
		
			Languages[] languagesInner = new Languages[languagesArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(languagesArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					languagesInner[count] = new Languages(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalLanguages = languagesInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Languages[]  languagesInner = new Languages[0];
			    finalLanguages = languagesInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetLanguagesFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetLanguagesArrayFinished callback) {
			callback(true,new Error(),new LanguagesArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetLanguagesArrayFinished callback) {
			callback(true,new Error(),new LanguagesArray());
		}
		
		public static Languages[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Languages[] languages = new Languages[0];
		    
			return languages;
		}	
		
		public static  IEnumerator GetLanguagesArrayIEnumerator(LanguagesArray languagesArray) {
			yield return new WaitForSeconds(0.2f);
			Languages[]  languagesInner = new Languages[0];
			finalLanguages = languagesInner;
		}
#endif
		
		#endregion
	}
}

