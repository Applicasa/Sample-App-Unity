using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;


namespace Applicasa {
	
	public class Filter {
		
#if UNITY_ANDROID
		private static AndroidJavaClass javaUnityApplicasaFilter;
		public AndroidJavaObject innerFilterJavaObject;
#endif
		
		public Filter(IntPtr filterPtr) {
			innerFilter = filterPtr;
#if UNITY_ANDROID
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");

			innerFilterJavaObject= new AndroidJavaObject("applicasa.LiCore.communication.LiFilters",innerFilter);
		
#endif
		}
		
#if UNITY_ANDROID
		public Filter(IntPtr filterPtr, AndroidJavaObject filterJavaObject) {
			innerFilter = filterPtr;
			innerFilterJavaObject = filterJavaObject;
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");
		}
#endif
		
#region Class Methods and Members
		public System.IntPtr innerFilter;
		
#if UNITY_IPHONE&&!UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterNot(System.IntPtr filter);
		public Filter NOT() {
			return new Filter(ApplicasaFilterNot (innerFilter));
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public Filter NOT() {
			AndroidJavaObject tempJavaObject=javaUnityApplicasaFilter.CallStatic<AndroidJavaObject>("ApplicasaFilterNOT", innerFilterJavaObject);	
			Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);
			return filter;
		}
# else
		public Filter NOT() {
			return this;
		}
#endif
		
#endregion
		
#region Static Methods
#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldInt(Fields field, OPERATORS op, int val);
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldFloat(Fields field, OPERATORS op, float val);
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldBool(Fields field, OPERATORS op, bool val);
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldString(Fields field, OPERATORS op, string val);
		public static Filter GetFilter(Fields field, OPERATORS op, int val) {
			Filter filter = new Filter(ApplicasaFilterByFieldInt(field, op, val));
			return filter;
		}
		public static Filter GetFilter(Fields field, OPERATORS op, float val) {
			Filter filter = new Filter(ApplicasaFilterByFieldFloat(field, op, val));
			return filter;
		}
		public static Filter GetFilter(Fields field, OPERATORS op, bool val) {
			Filter filter = new Filter(ApplicasaFilterByFieldBool(field, op, val));
			return filter;
		}
		public static Filter GetFilter(Fields field, OPERATORS op, string val) {
			Filter filter = new Filter(ApplicasaFilterByFieldString(field, op, val));
			return filter;
		}
		
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByOperand(IntPtr OperandA, COMPLEX_OPERATORS op, IntPtr val);
		public static Filter GetFilter(Filter OperandA, COMPLEX_OPERATORS op, Filter OperandB) {
			return new Filter(ApplicasaFilterByOperand(OperandA.innerFilter, op, OperandB.innerFilter));
		}
		
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldArrayInt(Fields field, int[] array, int arrayLen);
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldArrayFloat(Fields field, float[] array, int arrayLen);
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldArrayBool(Fields field, bool[] array, int arrayLen);
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaFilterByFieldArrayString(Fields field, string[] array, int arrayLen);
		public static Filter GetFilter(Fields field, int[] array) {
			return new Filter(ApplicasaFilterByFieldArrayInt(field, array, array.Length));
		}
		public static Filter GetFilter(Fields field, float[] array) {
			return new Filter(ApplicasaFilterByFieldArrayFloat(field, array, array.Length));
		}
		public static Filter GetFilter(Fields field, bool[] array) {
			return new Filter(ApplicasaFilterByFieldArrayBool(field, array, array.Length));
		}
		public static Filter GetFilter(Fields field, string[] array) {
			return new Filter(ApplicasaFilterByFieldArrayString(field, array, array.Length));
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static Filter GetFilter(Fields field, OPERATORS op, int val) {
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");
			AndroidJavaObject tempJavaObject=javaUnityApplicasaFilter.CallStatic<AndroidJavaObject>("ApplicasaFilterGetFilterInt", (int)field, field.ToString(), (int)op, val);			
			Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);

			return filter;
		}
		
		public static Filter GetFilter(Fields field, OPERATORS op, float val) {
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");
			AndroidJavaObject tempJavaObject=javaUnityApplicasaFilter.CallStatic<AndroidJavaObject>("ApplicasaFilterGetFilterFloat", (int)field, field.ToString(), (int)op, val);
			Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);
			return filter;
		}
		
		public static Filter GetFilter(Fields field, OPERATORS op, bool val) {
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");
			AndroidJavaObject tempJavaObject=javaUnityApplicasaFilter.CallStatic<AndroidJavaObject>("ApplicasaFilterGetFilterBool", (int)field, field.ToString(), (int)op, val);
			Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);
			return filter;
		}
		
		public static Filter GetFilter(Fields field, OPERATORS op, string val) {
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");
			AndroidJavaObject tempJavaObject=javaUnityApplicasaFilter.CallStatic<AndroidJavaObject>("ApplicasaFilterGetFilterString", (int)field, field.ToString(), (int)op, val);
			Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);
			return filter;
		}
		
		public static Filter GetFilter(Filter OperandA, COMPLEX_OPERATORS op, Filter OperandB) {
			if(javaUnityApplicasaFilter==null)
				javaUnityApplicasaFilter = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFilter");
			AndroidJavaObject tempJavaObject=javaUnityApplicasaFilter.CallStatic<AndroidJavaObject>("ApplicasaFilterGetFilterComplex", OperandA.innerFilterJavaObject, (int)op, OperandB.innerFilterJavaObject);
			Filter filter = new Filter(tempJavaObject.GetRawObject(), tempJavaObject);
			return filter;
		}
#else
        public static Filter GetFilter(Fields field, OPERATORS op, int val) {
			return new Filter(new IntPtr(0));
		}
		
		public static Filter GetFilter(Fields field, OPERATORS op, float val) {
			return new Filter(new IntPtr(0));
		}
		
		public static Filter GetFilter(Fields field, OPERATORS op, bool val) {
			return new Filter(new IntPtr(0));
		}
		
		public static Filter GetFilter(Fields field, OPERATORS op, string val) {
			return new Filter(new IntPtr(0));
		}
		
		public static Filter GetFilter(Filter OperandA, COMPLEX_OPERATORS op, Filter OperandB) {
			return new Filter(new IntPtr(0));
		}	
#endif
		
#endregion
	}
}
