//
// Foo.cs
// Created by Applicasa 
// 10/30/2013
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Foo {	
		public static Foo[] finalFoo;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaFoo;
	
        public AndroidJavaObject innerFooJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetFooFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetFooArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetFooFinished(bool success, Error error, IntPtr fooPtr);
		public delegate void GetFooArrayFinished(bool success, Error error, FooArray fooArrayPtr);
		
		public Foo(IntPtr fooPtr) {
			innerFoo = fooPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			if(innerFooJavaObject==null)
				innerFooJavaObject = new AndroidJavaObject("com.applicasa.Foo.Foo",innerFoo);
#endif
		}
		
#if UNITY_ANDROID 
		public Foo(IntPtr fooPtr, AndroidJavaObject fooJavaObject) {
			innerFoo = fooPtr;
			innerFooJavaObject = fooJavaObject;
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaFoo();
		#endif
		public Foo() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaFoo==null)
			javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
		   innerFooJavaObject = new AndroidJavaObject("com.applicasa.Foo.Foo");
		   innerFoo = innerFooJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerFoo = ApplicasaFoo();
		#endif
		  }

		public struct FooArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Foo[] GetFooArray(FooArray fooArray) {
			
			Foo[] fooInner = new Foo[fooArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(fooArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					fooInner[count] = new Foo(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return fooInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Foo[] GetFooArray(FooArray fooArray) {
			Foo[] foos = new Foo[fooArray.ArraySize];

			for (int i=0; i < fooArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (fooArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				foos[i] = new Foo(newPtr);
			}
			return foos;
		}
#else
		public static Foo[] GetFooArray(FooArray fooArray) {
			Foo[] foos = new Foo[0];
			return foos;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Foo()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerFoo);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerFoo;
		
			#region Class Members
#if UNITY_IPHONE

		public string FooID {
			get {return ApplicasaFooGetFooID(innerFoo);}
			set {ApplicasaFooSetFooID(innerFoo, value);}
		}
		public DateTime FooLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaFooGetFooLastUpdate(innerFoo));}
		}
		public string FooName {
			get {return ApplicasaFooGetFooName(innerFoo);}
			set {ApplicasaFooSetFooName(innerFoo, value);}
		}
		public string FooDescription {
			get {return ApplicasaFooGetFooDescription(innerFoo);}
			set {ApplicasaFooSetFooDescription(innerFoo, value);}
		}
		public bool FooBoolean {
			get {return ApplicasaFooGetFooBoolean(innerFoo);}
			set {ApplicasaFooSetFooBoolean(innerFoo, value);}
		}
		public DateTime FooDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaFooGetFooDate(innerFoo));}
			set {ApplicasaFooSetFooDate(innerFoo, value.Ticks);}
		}
		public string FooImage {
			get {return ApplicasaFooGetFooImage(innerFoo);}
			set {ApplicasaFooSetFooImage(innerFoo, value);}
		}
		public string FooFile {
			get {return ApplicasaFooGetFooFile(innerFoo);}
			set {ApplicasaFooSetFooFile(innerFoo, value);}
		}
		public User FooOwner {
			get {return new User(ApplicasaFooGetFooOwner(innerFoo));}
			set {ApplicasaFooSetFooOwner(innerFoo, value.innerUser);}
		}
		public Location FooLocation {
			get {return ApplicasaFooGetFooLocation(innerFoo);}
			set {ApplicasaFooSetFooLocation(innerFoo, value);}
		}
		public int FooNumber {
			get {return ApplicasaFooGetFooNumber(innerFoo);}
			set {ApplicasaFooSetFooNumber(innerFoo, value);}
		}
		public int FooAge {
			get {return ApplicasaFooGetFooAge(innerFoo);}
			set {ApplicasaFooSetFooAge(innerFoo, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaFooGetFooID(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooID(System.IntPtr foo, string fooID);
	[DllImport("__Internal")]
	private static extern double ApplicasaFooGetFooLastUpdate(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern string ApplicasaFooGetFooName(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooName(System.IntPtr foo, string fooName);
	[DllImport("__Internal")]
	private static extern string ApplicasaFooGetFooDescription(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooDescription(System.IntPtr foo, string fooDescription);
	[DllImport("__Internal")]
	private static extern bool ApplicasaFooGetFooBoolean(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooBoolean(System.IntPtr foo, bool fooBoolean);
	[DllImport("__Internal")]
	private static extern double ApplicasaFooGetFooDate(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooDate(System.IntPtr foo, double fooDate);
	[DllImport("__Internal")]
	private static extern string ApplicasaFooGetFooImage(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooImage(System.IntPtr foo, string fooImage);
	[DllImport("__Internal")]
	private static extern string ApplicasaFooGetFooFile(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooFile(System.IntPtr foo, string fooFile);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaFooGetFooOwner(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooOwner(System.IntPtr foo, IntPtr fooOwner);
	[DllImport("__Internal")]
	private static extern Location ApplicasaFooGetFooLocation(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooLocation(System.IntPtr foo, Location fooLocation);
	[DllImport("__Internal")]
	private static extern int ApplicasaFooGetFooNumber(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooNumber(System.IntPtr foo, int fooNumber);
	[DllImport("__Internal")]
	private static extern int ApplicasaFooGetFooAge(System.IntPtr foo);
	[DllImport("__Internal")]
	private static extern void ApplicasaFooSetFooAge(System.IntPtr foo, int fooAge);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string FooID {
			get {return javaUnityApplicasaFoo.CallStatic<string>("ApplicasaFooGetFooID", innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooID", innerFooJavaObject, value);}
		}
		public DateTime FooLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaFoo.CallStatic<double>("ApplicasaFooGetFooLastUpdate",innerFooJavaObject));}
		}
		public string FooName {
			get {return javaUnityApplicasaFoo.CallStatic<string>("ApplicasaFooGetFooName", innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooName", innerFooJavaObject, value);}
		}
		public string FooDescription {
			get {return javaUnityApplicasaFoo.CallStatic<string>("ApplicasaFooGetFooDescription", innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooDescription", innerFooJavaObject, value);}
		}
		public bool FooBoolean {
			get {return javaUnityApplicasaFoo.CallStatic<bool>("ApplicasaFooGetFooBoolean",innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooBoolean",innerFooJavaObject, value);}
		}
		public DateTime FooDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaFoo.CallStatic<double>("ApplicasaFooGetFooDate",innerFooJavaObject));}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooDate", innerFooJavaObject, (long)value.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds);}
		}
		public string FooImage {
			get {return javaUnityApplicasaFoo.CallStatic<string>("ApplicasaFooGetFooImage",innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooImage",innerFooJavaObject, value);}
		}
		public string FooFile {
			get {return javaUnityApplicasaFoo.CallStatic<string>("ApplicasaFooGetFooFile",innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooFile",innerFooJavaObject, value);}
		}
		public User FooOwner {
			get {
				AndroidJavaObject temp = javaUnityApplicasaFoo.CallStatic<AndroidJavaObject>("ApplicasaFooGetFooOwner",innerFooJavaObject);
				return new User(temp.GetRawObject(),temp);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooOwner",innerFooJavaObject, value.innerUserJavaObject);}
		}
		public Location FooLocation {
			get {				Location _location=new Location();				_location.Latitude=javaUnityApplicasaFoo.CallStatic<double>("ApplicasaFooGetFooLocationLatitude", innerFooJavaObject);				_location.Longitude=javaUnityApplicasaFoo.CallStatic<double>("ApplicasaFooGetFooLocationLongitude",innerFooJavaObject);				return _location;			}			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooLocation",  innerFooJavaObject, value.Latitude, value.Longitude);}		}
		public int FooNumber {
			get {return javaUnityApplicasaFoo.CallStatic<int>("ApplicasaFooGetFooNumber",innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooNumber",innerFooJavaObject, value);}
		}
		public int FooAge {
			get {return javaUnityApplicasaFoo.CallStatic<int>("ApplicasaFooGetFooAge",innerFooJavaObject);}
			set {javaUnityApplicasaFoo.CallStatic("ApplicasaFooSetFooAge",innerFooJavaObject, value);}
		}

#else

		public string FooID {
			get {return "";}
			set { }
		}
		public DateTime FooLastUpdate {
			get {return new DateTime();}
		}
		public string FooName {
			get {return "";}
			set { }
		}
		public string FooDescription {
			get {return "";}
			set { }
		}
		public bool FooBoolean {
			get {return false;}
			set { }
		}
		public DateTime FooDate {
			get {return new DateTime();}
			set { }
		}
		public string FooImage {
			get {return "";}
			set { }
		}
		public string FooFile {
			get {return "";}
			set { }
		}
		public User FooOwner {
			get {return null;}
			set { }
		}
		public Location FooLocation {
			get {return new Location();}
			set { }
		}
		public int FooNumber {
			get {return 0;}
			set { }
		}
		public int FooAge {
			get {return 0;}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaFooSaveWithBlock(System.IntPtr foo, Action callback);
		public void Save(Action action) {
			ApplicasaFooSaveWithBlock(innerFoo, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaFooIncreaseFieldInt(System.IntPtr foo, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaFooIncreaseFieldFloat(System.IntPtr foo, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaFooIncreaseFieldInt(innerFoo, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaFooIncreaseFieldFloat(innerFoo, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaFooDeleteWithBlock(System.IntPtr foo, Action callback);
		public void Delete(Action action) {
			ApplicasaFooDeleteWithBlock(innerFoo, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaFooUploadFile(System.IntPtr foo, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaFooUploadFile(innerFoo, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooSaveWithBlock", innerFooJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooIncreaseFieldInt", innerFooJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooIncreaseFieldFloat", innerFooJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooDeleteWithBlock", innerFooJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooUploadFile", innerFooJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaFooGetById(string id, QueryKind queryKind, GetFooFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetFooFinished callback) {
			ApplicasaFooGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaFooGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetFooArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetFooArrayFinished callback) {
			ApplicasaFooGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaFooGetLocalArrayWithRawSqlQuery(string rawQuery, GetFooArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetFooArrayFinished callback) {
			ApplicasaFooGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern FooArray ApplicasaFooGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Foo[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetFooArray(ApplicasaFooGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			FooArray fooArray = ApplicasaFooGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalFoo = GetFooArray(fooArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetFooArrayIEnumerator(FooArray fooArray) {
			finalFoo = GetFooArray(fooArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaFooUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaFooUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetFooFinished callback) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetFooArrayFinished callback) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetFooArrayFinished callback) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaFoo.CallStatic("ApplicasaFooGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Foo[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaFoo.CallStatic<AndroidJavaObject[]>("ApplicasaFooGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Foo[] fooInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Foo[] footemp = new Foo[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					footemp[j] = new Foo(tempObj.GetRawObject(),tempObj);
				}
				if (fooInner == null)
					fooInner = footemp;
				else{
				   Foo[] firstOne = fooInner;
				    fooInner = new Foo[firstOne.Length+footemp.Length];
					firstOne.CopyTo(fooInner,0);
					footemp.CopyTo(fooInner,firstOne.Length);
				}
				
			}
			return fooInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
				
				int count = javaUnityApplicasaFoo.CallStatic<int>("ApplicasaFooUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaFoo==null)
				javaUnityApplicasaFoo = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFoo");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaFoo.CallStatic<AndroidJavaObject[]>("ApplicasaFooGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Foo[] fooInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Foo[] footemp = new Foo[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					footemp[j] = new Foo(tempObj.GetRawObject(),tempObj);
				}
				if (fooInner == null)
					fooInner = footemp;
				else{
				   Foo[] firstOne = fooInner;
				    fooInner = new Foo[firstOne.Length+footemp.Length];
					firstOne.CopyTo(fooInner,0);
					footemp.CopyTo(fooInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalFoo = fooInner;
		}
		
		public static  IEnumerator GetFooArrayIEnumerator(FooArray fooArray) {
		
			Foo[] fooInner = new Foo[fooArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(fooArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					fooInner[count] = new Foo(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalFoo = fooInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Foo[]  fooInner = new Foo[0];
			    finalFoo = fooInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetFooFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetFooArrayFinished callback) {
			callback(true,new Error(),new FooArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetFooArrayFinished callback) {
			callback(true,new Error(),new FooArray());
		}
		
		public static Foo[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Foo[] foo = new Foo[0];
		    
			return foo;
		}	
		
		public static  IEnumerator GetFooArrayIEnumerator(FooArray fooArray) {
			yield return new WaitForSeconds(0.2f);
			Foo[]  fooInner = new Foo[0];
			finalFoo = fooInner;
		}
#endif
		
		#endregion
	}
}

