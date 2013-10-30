//
// Colors.cs
// Created by Applicasa 
// 10/30/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Colors {	
		public static Colors[] finalColors;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaColors;
	
        public AndroidJavaObject innerColorsJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetColorsFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetColorsArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetColorsFinished(bool success, Error error, IntPtr colorsPtr);
		public delegate void GetColorsArrayFinished(bool success, Error error, ColorsArray colorsArrayPtr);
		
		public Colors(IntPtr colorsPtr) {
			innerColors = colorsPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			if(innerColorsJavaObject==null)
				innerColorsJavaObject = new AndroidJavaObject("com.applicasa.Colors.Colors",innerColors);
#endif
		}
		
#if UNITY_ANDROID 
		public Colors(IntPtr colorsPtr, AndroidJavaObject colorsJavaObject) {
			innerColors = colorsPtr;
			innerColorsJavaObject = colorsJavaObject;
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaColors();
		#endif
		public Colors() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaColors==null)
			javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
		   innerColorsJavaObject = new AndroidJavaObject("com.applicasa.Colors.Colors");
		   innerColors = innerColorsJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerColors = ApplicasaColors();
		#endif
		  }

		public struct ColorsArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Colors[] GetColorsArray(ColorsArray colorsArray) {
			
			Colors[] colorsInner = new Colors[colorsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(colorsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					colorsInner[count] = new Colors(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return colorsInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Colors[] GetColorsArray(ColorsArray colorsArray) {
			Colors[] colorss = new Colors[colorsArray.ArraySize];

			for (int i=0; i < colorsArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (colorsArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				colorss[i] = new Colors(newPtr);
			}
			return colorss;
		}
#else
		public static Colors[] GetColorsArray(ColorsArray colorsArray) {
			Colors[] colorss = new Colors[0];
			return colorss;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Colors()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerColors);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerColors;
		
			#region Class Members
#if UNITY_IPHONE

		public string ColorsID {
			get {return ApplicasaColorsGetColorsID(innerColors);}
			set {ApplicasaColorsSetColorsID(innerColors, value);}
		}
		public DateTime ColorsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaColorsGetColorsLastUpdate(innerColors));}
		}
		public int ColorsNumber {
			get {return ApplicasaColorsGetColorsNumber(innerColors);}
			set {ApplicasaColorsSetColorsNumber(innerColors, value);}
		}
		public string ColorsColor {
			get {return ApplicasaColorsGetColorsColor(innerColors);}
			set {ApplicasaColorsSetColorsColor(innerColors, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaColorsGetColorsID(System.IntPtr colors);
	[DllImport("__Internal")]
	private static extern void ApplicasaColorsSetColorsID(System.IntPtr colors, string colorsID);
	[DllImport("__Internal")]
	private static extern double ApplicasaColorsGetColorsLastUpdate(System.IntPtr colors);
	[DllImport("__Internal")]
	private static extern int ApplicasaColorsGetColorsNumber(System.IntPtr colors);
	[DllImport("__Internal")]
	private static extern void ApplicasaColorsSetColorsNumber(System.IntPtr colors, int colorsNumber);
	[DllImport("__Internal")]
	private static extern string ApplicasaColorsGetColorsColor(System.IntPtr colors);
	[DllImport("__Internal")]
	private static extern void ApplicasaColorsSetColorsColor(System.IntPtr colors, string colorsColor);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string ColorsID {
			get {return javaUnityApplicasaColors.CallStatic<string>("ApplicasaColorsGetColorsID", innerColorsJavaObject);}
			set {javaUnityApplicasaColors.CallStatic("ApplicasaColorsSetColorsID", innerColorsJavaObject, value);}
		}
		public DateTime ColorsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaColors.CallStatic<double>("ApplicasaColorsGetColorsLastUpdate",innerColorsJavaObject));}
		}
		public int ColorsNumber {
			get {return javaUnityApplicasaColors.CallStatic<int>("ApplicasaColorsGetColorsNumber",innerColorsJavaObject);}
			set {javaUnityApplicasaColors.CallStatic("ApplicasaColorsSetColorsNumber",innerColorsJavaObject, value);}
		}
		public string ColorsColor {
			get {return javaUnityApplicasaColors.CallStatic<string>("ApplicasaColorsGetColorsColor", innerColorsJavaObject);}
			set {javaUnityApplicasaColors.CallStatic("ApplicasaColorsSetColorsColor", innerColorsJavaObject, value);}
		}

#else

		public string ColorsID {
			get {return "";}
			set { }
		}
		public DateTime ColorsLastUpdate {
			get {return new DateTime();}
		}
		public int ColorsNumber {
			get {return 0;}
			set { }
		}
		public string ColorsColor {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsSaveWithBlock(System.IntPtr colors, Action callback);
		public void Save(Action action) {
			ApplicasaColorsSaveWithBlock(innerColors, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsIncreaseFieldInt(System.IntPtr colors, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsIncreaseFieldFloat(System.IntPtr colors, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaColorsIncreaseFieldInt(innerColors, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaColorsIncreaseFieldFloat(innerColors, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsDeleteWithBlock(System.IntPtr colors, Action callback);
		public void Delete(Action action) {
			ApplicasaColorsDeleteWithBlock(innerColors, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsUploadFile(System.IntPtr colors, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaColorsUploadFile(innerColors, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsSaveWithBlock", innerColorsJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsIncreaseFieldInt", innerColorsJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsIncreaseFieldFloat", innerColorsJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsDeleteWithBlock", innerColorsJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsUploadFile", innerColorsJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaColorsGetById(string id, QueryKind queryKind, GetColorsFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetColorsFinished callback) {
			ApplicasaColorsGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetColorsArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetColorsArrayFinished callback) {
			ApplicasaColorsGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaColorsGetLocalArrayWithRawSqlQuery(string rawQuery, GetColorsArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetColorsArrayFinished callback) {
			ApplicasaColorsGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern ColorsArray ApplicasaColorsGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Colors[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetColorsArray(ApplicasaColorsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			ColorsArray colorsArray = ApplicasaColorsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalColors = GetColorsArray(colorsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetColorsArrayIEnumerator(ColorsArray colorsArray) {
			finalColors = GetColorsArray(colorsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaColorsUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaColorsUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetColorsFinished callback) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetColorsArrayFinished callback) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetColorsArrayFinished callback) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaColors.CallStatic("ApplicasaColorsGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Colors[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaColors.CallStatic<AndroidJavaObject[]>("ApplicasaColorsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Colors[] colorsInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Colors[] colorstemp = new Colors[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					colorstemp[j] = new Colors(tempObj.GetRawObject(),tempObj);
				}
				if (colorsInner == null)
					colorsInner = colorstemp;
				else{
				   Colors[] firstOne = colorsInner;
				    colorsInner = new Colors[firstOne.Length+colorstemp.Length];
					firstOne.CopyTo(colorsInner,0);
					colorstemp.CopyTo(colorsInner,firstOne.Length);
				}
				
			}
			return colorsInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
				
				int count = javaUnityApplicasaColors.CallStatic<int>("ApplicasaColorsUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaColors==null)
				javaUnityApplicasaColors = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaColors");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaColors.CallStatic<AndroidJavaObject[]>("ApplicasaColorsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Colors[] colorsInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Colors[] colorstemp = new Colors[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					colorstemp[j] = new Colors(tempObj.GetRawObject(),tempObj);
				}
				if (colorsInner == null)
					colorsInner = colorstemp;
				else{
				   Colors[] firstOne = colorsInner;
				    colorsInner = new Colors[firstOne.Length+colorstemp.Length];
					firstOne.CopyTo(colorsInner,0);
					colorstemp.CopyTo(colorsInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalColors = colorsInner;
		}
		
		public static  IEnumerator GetColorsArrayIEnumerator(ColorsArray colorsArray) {
		
			Colors[] colorsInner = new Colors[colorsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(colorsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					colorsInner[count] = new Colors(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalColors = colorsInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Colors[]  colorsInner = new Colors[0];
			    finalColors = colorsInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetColorsFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetColorsArrayFinished callback) {
			callback(true,new Error(),new ColorsArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetColorsArrayFinished callback) {
			callback(true,new Error(),new ColorsArray());
		}
		
		public static Colors[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Colors[] colors = new Colors[0];
		    
			return colors;
		}	
		
		public static  IEnumerator GetColorsArrayIEnumerator(ColorsArray colorsArray) {
			yield return new WaitForSeconds(0.2f);
			Colors[]  colorsInner = new Colors[0];
			finalColors = colorsInner;
		}
#endif
		
		#endregion
	}
}

