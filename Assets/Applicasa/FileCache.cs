using UnityEngine;
using System.Collections;
using System;
using System.Runtime.InteropServices;

namespace Applicasa{
	
	public class FileCache {
		public delegate void GetFileData(bool success, Applicasa.Error error, ByteArray data);
		public struct ByteArray {
	    	public int ArraySize;
	    	public IntPtr Array;
		};
		
#if UNITY_IPHONE
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGetCachedData(string url, GetFileData callback);
		public static void GetCachedData(string url, GetFileData callback) {
			ApplicasaGetCachedData(url, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaGetCachedImage(string url, GetFileData callback);
		public static void GetCachedImage(string url, GetFileData callback) {
			ApplicasaGetCachedImage(url, callback);
		}
		
		public static byte[] GetByteArray(ByteArray byteArray) {
			byte[] data = new byte[byteArray.ArraySize];
			for (int i=0; i < byteArray.ArraySize; i++) {
				byte datum = Marshal.ReadByte (byteArray.Array, i * Marshal.SizeOf(typeof(byte)));
				data[i] = datum;
			}
			return data;
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		private static AndroidJavaClass javaUnityApplicasaFileCache;
		
		[DllImport("Applicasa")]
		private static extern void setGetFileData(GetFileData callback, int uniqueActionID);
		
		public static void GetCachedData(string url, GetFileData callback) {
			if(javaUnityApplicasaFileCache==null)
				javaUnityApplicasaFileCache = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFileCacher");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetFileData(callback,uniqueActionID);
			javaUnityApplicasaFileCache.CallStatic("ApplicasaGetCachedData", url, uniqueActionID);
		}
		
		public static void GetCachedImage(string url, GetFileData callback) {
			if(javaUnityApplicasaFileCache==null)
				javaUnityApplicasaFileCache = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaFileCacher");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetFileData(callback,uniqueActionID);
			javaUnityApplicasaFileCache.CallStatic("ApplicasaGetCachedImage", url, uniqueActionID);			
		}
		
		public static byte[] GetByteArray(ByteArray byteArray) {			
			byte[] data = AndroidJNI.FromByteArray(byteArray.Array);
			return data;
		}
#else
		public static void GetCachedData(string url, GetFileData callback) {
		}
		
		public static void GetCachedImage(string url, GetFileData callback) {
		}
		
		public static byte[] GetByteArray(ByteArray byteArray) {						
			return null;
		}
#endif

	}
}