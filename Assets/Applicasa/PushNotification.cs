using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;

namespace Applicasa {
	public class PushNotification {
	
		public string message = "";
		public string sound = "";
		public int badge = 0;
		public string tag = "";
		
#if UNITY_ANDROID
		private static AndroidJavaClass javaUnityApplicasaPushNotification;
#endif
		public delegate void SendPushFinished(bool success, Error error, string message, IntPtr pushPtr);
		
		public delegate void delegateApplicasaPushNotification(PushNotification val);
		
		public static event delegateApplicasaPushNotification ApplicasaPushNotificationEvent;
		
		public static void methodApplicasaPushNotification(string val) {
			if(ApplicasaPushNotificationEvent!=null)
				ApplicasaPushNotificationEvent(pullMessage(0));
		}
		
#if UNITY_IPHONE && !UNITY_EDITOR
		//TODO: Tag shouldn't be string
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaPushGet(string message, string sound, int badge, string tag);
		public PushNotification(string message, string sound, int badge, string tag) {
			innerPush = ApplicasaPushGet(message, sound, badge, tag);
		}
#else
		//TODO: Tag shouldn't be string
		public PushNotification(string intputNessage, string intputSound, int intputBadge, string intputTag) {
			if (intputNessage != null)
				message = intputNessage;
			if (intputSound != null)
				sound = intputSound;
			if (intputTag != null)
				tag = intputTag;
			
			badge = intputBadge;
			
		}
#endif
		
		#region Class Methods and Members
		
		public IntPtr innerPush;
		
#if UNITY_IPHONE && !UNITY_EDITOR
		
		public PushNotification() {
			
		}
		[DllImport("__Internal")]
		private static extern void ApplicasaPushSend(IntPtr innerPush, IntPtr[] users, int arrayCount, SendPushFinished sendPushFinished);
		public void Send(User[] users, int arrayCount, SendPushFinished sendPushFinished) {
			IntPtr[] userArray = new IntPtr[users.Length];
			for (int i = 0; i < users.Length; i++) {
				userArray[i] = users[i].innerUser;
			}
			ApplicasaPushSend(innerPush, userArray, userArray.Length, sendPushFinished);
		}
		
		/**
		 * You may call NotificationServices Manually
		 */
		public static PushNotification pullMessage(int position)
		{
		    PushNotification push = new PushNotification();
		    push.message = NotificationServices.GetRemoteNotification(position).alertBody;
		    push.sound = NotificationServices.GetRemoteNotification(position).soundName;
		    push.tag = NotificationServices.GetRemoteNotification(position).userInfo.ToString();
			return push;
			//NotificationServices.GetRemoteNotification(position).alertBody;
		}
		
		public static int PendingNotificationCount()
		{
		    return NotificationServices.remoteNotificationCount;
		}
		
#elif UNITY_ANDROID && !UNITY_EDITOR

		public void Send(User[] users, int arrayCount, SendPushFinished sendPushFinished) {
			if(javaUnityApplicasaPushNotification==null)
				javaUnityApplicasaPushNotification = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPushNotification");
			
			// CREATE NEW MESSAGE
			javaUnityApplicasaPushNotification.CallStatic("ApplicasaPushSend");
			
			// add recipients
			for (int i = 0; i < users.Length; i++) {
				javaUnityApplicasaPushNotification.CallStatic("ApplicasaAddRecipient", users[i].UserID);
			}
			
			javaUnityApplicasaPushNotification.CallStatic("setBadge", badge);
			javaUnityApplicasaPushNotification.CallStatic("setSound", sound);
			javaUnityApplicasaPushNotification.CallStatic("setTag", tag);
			javaUnityApplicasaPushNotification.CallStatic("setMessage", message);
			
			// Send the Notification
			javaUnityApplicasaPushNotification.CallStatic("sendPush");
			
		}
		
		// 0- Base
		public static PushNotification pullMessage(int position)
		{
			if(javaUnityApplicasaPushNotification==null)
				javaUnityApplicasaPushNotification = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPushNotification");
			
			
			string text = javaUnityApplicasaPushNotification.CallStatic <string>("ApplicasaPushGetMessage",position);
		    int badge = javaUnityApplicasaPushNotification.CallStatic <int>("ApplicasaPushGetBadge",position);
		    string sound =  javaUnityApplicasaPushNotification.CallStatic <string>("ApplicasaPushGetSound",position);
		    string tag =  javaUnityApplicasaPushNotification.CallStatic <string>("ApplicasaPushGetTag",position);
		    
		    // remove from queue
		    javaUnityApplicasaPushNotification.CallStatic("ApplicasaPushConsumeMessage",position);
		 
		    PushNotification push = new PushNotification(text, sound, badge, tag);
		 
			return push;
		}
		
		public static int PendingNotificationCount()
		{
		    if(javaUnityApplicasaPushNotification==null)
				javaUnityApplicasaPushNotification = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPushNotification");
				
		    return javaUnityApplicasaPushNotification.CallStatic <int>("ApplicasaPushNotificationsCount");
		}
		
#else
		public void Send(User[] users, int arrayCount, SendPushFinished sendPushFinished) 
		{
			
		}
		
		public static PushNotification pullMessage(int position)
		{
			return null;
		}
		
		public static int PendingNotificationCount()
		{
		    return 0;
		}
#endif
		
#endregion
	}
}