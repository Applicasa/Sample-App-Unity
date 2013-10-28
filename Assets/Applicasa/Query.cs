using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;


namespace Applicasa {
	
	public class Query {
		
#if UNITY_ANDROID
		private static AndroidJavaClass javaUnityApplicasaQuery;
		
		public AndroidJavaObject innerQueryJavaObject;
#endif

#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaQueryCreate();
		private static System.IntPtr QueryCreate() {
			return ApplicasaQueryCreate();
		}
#endif
		
		public Query() {
#if UNITY_ANDROID
			if(javaUnityApplicasaQuery==null)
				javaUnityApplicasaQuery = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaQuery");
			
			innerQueryJavaObject= javaUnityApplicasaQuery.CallStatic<AndroidJavaObject>("ApplicasaQueryCreate");
#elif UNITY_IPHONE
			innerQuery = QueryCreate();
			
#endif		
}

		
	/*	public Query(IntPtr queryPtr) {
			innerQuery = queryPtr;
#if UNITY_ANDROID
			innerQuery = AndroidJNI.NewGlobalRef(queryPtr);
			innerQueryJavaObject= new AndroidJavaObject(innerQuery);
#endif
		}*/
		
#if UNITY_ANDROID
		public Query(IntPtr queryPtr, AndroidJavaObject queryJavaObject) {
			innerQuery = queryPtr;
			innerQueryJavaObject = queryJavaObject;
			if(javaUnityApplicasaQuery==null)
				javaUnityApplicasaQuery = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaQuery");
		}
#endif
		
#region Class Methods and Members
		public System.IntPtr innerQuery;
		
#region Class Members
#if UNITY_IPHONE
		public Filter filter {
			get {return new Filter(ApplicasaQueryGetFilter(innerQuery));}
			set {ApplicasaQuerySetFilter(innerQuery, value.innerFilter);}
		}
		
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaQueryGetFilter(System.IntPtr query);
		[DllImport("__Internal")]
		private static extern void ApplicasaQuerySetFilter(System.IntPtr query, IntPtr filter);
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public Filter filter {
			get {
				AndroidJavaObject tempJavaObject=javaUnityApplicasaQuery.CallStatic<AndroidJavaObject>("ApplicasaQueryGetFilter", innerQueryJavaObject);
				Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);			
				return filter;}
			set {javaUnityApplicasaQuery.CallStatic("ApplicasaQuerySetFilter", innerQueryJavaObject, value.innerFilterJavaObject);}
		}
#else
		public Filter filter {
			get {return new Filter(new System.IntPtr(0));}
			set {}
		}
#endif
#endregion
#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern void ApplicasaQuerySetGeoFilter(System.IntPtr query, Fields field, Location location, int radius);
		public void SetGeoFilter(Fields field, Location location, int radius) {
			ApplicasaQuerySetGeoFilter(innerQuery, field, location, radius);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaQueryAddOrder(System.IntPtr query, Fields field, SortType sortType);
		public void AddOrder(Fields field, SortType sortType) {
			ApplicasaQueryAddOrder(innerQuery, field, sortType);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaQueryAddPager(System.IntPtr query, uint page, uint recordsPerPage);
		public void AddPager(uint page, uint recordsPerPage) {
			ApplicasaQueryAddPager(innerQuery, page, recordsPerPage);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void SetGeoFilter(Fields field, Location location, int radius) {
			if(javaUnityApplicasaQuery==null)
				javaUnityApplicasaQuery = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaQuery");
			javaUnityApplicasaQuery.CallStatic("ApplicasaQuerySetGeoFilter", innerQueryJavaObject, (int)field, field.ToString(), location.Latitude, location.Longitude, radius);
		}
		
		public void AddOrder(Fields field, SortType sortType) {
			if(javaUnityApplicasaQuery==null)
				javaUnityApplicasaQuery = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaQuery");
			javaUnityApplicasaQuery.CallStatic("ApplicasaQueryAddOrder", innerQueryJavaObject, (int)field, field.ToString(), (int)sortType);
		}
		
		public void AddPager(uint page, uint recordsPerPage) {
			if(javaUnityApplicasaQuery==null)
				javaUnityApplicasaQuery = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaQuery");
			javaUnityApplicasaQuery.CallStatic("ApplicasaQueryAddPager", innerQueryJavaObject, (int)page, (int)recordsPerPage);
		}
#else
		public void SetGeoFilter(Fields field, Location location, int radius) {}
		
		public void AddOrder(Fields field, SortType sortType) {}
		
		public void AddPager(uint page, uint recordsPerPage) {}
#endif
#endregion
	}
}
