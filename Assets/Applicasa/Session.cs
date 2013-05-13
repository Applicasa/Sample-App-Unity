using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {

	public class Session {
		
	 	public enum GameResult {
		    LiGameResultLose = 0,
		    LiGameResultWin
		}

#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionSessionStart();
		public static void SessionStart() {
			ApplicasaSessionSessionStart();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionSessionPause();
		public static void SessionPause() {
			ApplicasaSessionSessionPause();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionSessionResume();
		public static void SessionResume() {
			ApplicasaSessionSessionResume();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionSessionEnd();
		public static void SessionEnd() {
			ApplicasaSessionSessionEnd();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionGameStart(string gameName);
		public static void GameStart(string gameName) {
			ApplicasaSessionGameStart(gameName);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionGamePause();
		public static void GamePause() {
			ApplicasaSessionGamePause();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionGameResume();
		public static void GameResume() {
			ApplicasaSessionGameResume();
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaSessionGameFinishedWithResult(GameResult gameResult, int mainCurrencyBalance, int secondaryCurrencyBalance, int finalScore, int bonus);
		public static void GameFinished(GameResult gameResult, int mainCurrencyBalance, int secondaryCurrencyBalance, int finalScore, int bonus) {
			ApplicasaSessionGameFinishedWithResult(gameResult, mainCurrencyBalance, secondaryCurrencyBalance, finalScore, bonus);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		private static AndroidJavaClass javaUnityApplicasaSession;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetSessionEnd callback, int uniqueActionID);
		
		public delegate void GetSessionEnd(bool success, Error error, System.IntPtr userPtr);
		
		public static void SessionStart() {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionSessionStart");
		}
		
		public static void SessionPause() {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionSessionPause");
		}
		
		public static void SessionResume() {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionSessionResume");
		}
		
		public static void SessionEnd() {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionSessionEnd");
		}
		
		public static void SessionEndWithCallback(GetSessionEnd callback) {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionSessionEndWithCallback",uniqueActionID);
		}
		
		public static void GameStart(string gameName) {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionGameStart", gameName);
		}
		
		public static void GamePause() {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionGamePause");
		}
		
		public static void GameResume() {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionGameResume");
		}
		
		public static void GameFinished(GameResult gameResult, int mainCurrencyBalance, int secondaryCurrencyBalance, int finalScore, int bonus) {
			if(javaUnityApplicasaSession==null)
				javaUnityApplicasaSession = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiSession");
			javaUnityApplicasaSession.CallStatic("ApplicasaSessionGameFinishedWithResult", (int)gameResult, mainCurrencyBalance, secondaryCurrencyBalance, finalScore, bonus);
		}
#else
		public delegate void GetSessionEnd(bool success, Error error, System.IntPtr userPtr);
		
		public static void SessionStart() {
		}
		
		public static void SessionPause() {
		}
		
		public static void SessionResume() {
		}
		
		public static void SessionEnd() {
		}
		
		public static void SessionEndWithCallback(GetSessionEnd callback) {
			callback(true,new Error(),new System.IntPtr());
		}
		
		public static void GameStart(string gameName) {			
		}
		
		public static void GamePause() {
		}
		
		public static void GameResume() {			
		}
		
		public static void GameFinished(GameResult gameResult, int mainCurrencyBalance, int secondaryCurrencyBalance, int finalScore, int bonus) {			
		}
#endif
	}
}
