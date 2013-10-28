using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System;

namespace Applicasa {
	public class PushNotification {
	
		public string message = "";
		public string sound = "";
		public int badge = 0;
		public string tag = "";
		public bool timed = false;
		public int dispatch_time = 0;

#if UNITY_IPHONE
		public IDictionary userInfo;
#endif

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
		private static extern IntPtr ApplicasaPushGet(string message, string sound, int badge);
		public PushNotification(string message, string sound, int badge) {
			innerPush = ApplicasaPushGet(message, sound, badge);
		}
		
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaPushGetWithDispatchTime(string message, string sound, int badge, int dispatchInMin);
		public PushNotification(string message, string sound, int badge,int dispatchInMin) {
			innerPush = ApplicasaPushGetWithDispatchTime(message, sound, badge, dispatchInMin);
		}
#else
		
		public PushNotification(string intputMessage, string intputSound, int intputBadge) {
			if (intputMessage != null)
				message = intputMessage;
			if (intputSound != null)
				sound = intputSound;
			tag = "";
			
			badge = intputBadge;
			
		}
		
			
		public PushNotification(string intputMessage, string intputSound, int intputBadge,int dispatchInMinutes) {
			if (intputMessage != null)
				message = intputMessage;
			if (intputSound != null)
				sound = intputSound;
			tag = "";
			
			badge = intputBadge;
			
			timed = true;
			dispatch_time = dispatchInMinutes;
			
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
			push.userInfo = NotificationServices.GetRemoteNotification(position).userInfo;
			return push;
			//NotificationServices.GetRemoteNotification(position).alertBody;
		}
		
		public static int PendingNotificationCount()
		{
		    return NotificationServices.remoteNotificationCount;
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaClearAllPushMessages();
		public static void ClearRemoteNotifications()
		{
		    NotificationServices.ClearRemoteNotifications();
			ApplicasaClearAllPushMessages();
		}
		

		[DllImport("__Internal")]
		private static extern void addTags(IntPtr innerPush, string key,string param);
		public void addTag(string key,string param) {
			addTags(innerPush, key, param);
		}
		
		public static void registerForPushNotification()
		{
			NotificationServices.RegisterForRemoteNotificationTypes(RemoteNotificationType.Alert|RemoteNotificationType.Badge|RemoteNotificationType.Sound);
		}
		
		public static void unRegisterForPushNotification()
		{
			NotificationServices.UnregisterForRemoteNotifications();
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
			javaUnityApplicasaPushNotification.CallStatic("setTag", "{"+tag+"}");
			javaUnityApplicasaPushNotification.CallStatic("setMessage", message);
			
			javaUnityApplicasaPushNotification.CallStatic("setDispatchInMinutes",dispatch_time);
						
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
		    
		    
		 
		    PushNotification push = new PushNotification(text, sound, badge);
			push.tag = tag;
		 
			return push;
		}
		
		public static int PendingNotificationCount()
		{
		    if(javaUnityApplicasaPushNotification==null)
				javaUnityApplicasaPushNotification = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPushNotification");
				
		    return javaUnityApplicasaPushNotification.CallStatic <int>("ApplicasaPushNotificationsCount");
		}
		
		public static void ClearRemoteNotifications()
		{
			int count = PendingNotificationCount();
			
			for (int position = count; position > 0; position--)
			{
				// remove from queue
		   	 	javaUnityApplicasaPushNotification.CallStatic("ApplicasaPushConsumeMessage",position-1);
			}
		}
		
		
		public void addTag(string key,string param) {
			if (tag.Length == 0)
				tag+="\""+key+"\":\""+param+"\"";
			else
				tag+=",\""+key+"\":\""+param+"\"";
		}
		
		public static void registerForPushNotification()
		{
			if(javaUnityApplicasaPushNotification==null)
				javaUnityApplicasaPushNotification = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPushNotification");
				
			javaUnityApplicasaPushNotification.CallStatic("ApplicasaRegisterToGCM");
		}
		
		public static void unRegisterForPushNotification()
		{
			if(javaUnityApplicasaPushNotification==null)
				javaUnityApplicasaPushNotification = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaPushNotification");
				
			javaUnityApplicasaPushNotification.CallStatic("ApplicasaUnRegisterFromGCM");
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
		
		public static void ClearRemoteNotifications()
		{
			// remove from queue
		    
		}
		
		public void addTag(string key,string param) {
			
		}
		
		public static void registerForPushNotification()
		{
		
		}
#endif
		
#endregion
	}
}
