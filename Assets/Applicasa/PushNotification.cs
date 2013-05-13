using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;

namespace Applicasa {
	public class PushNotification {
		
		public delegate void SendPushFinished(bool success, Error error, string message, IntPtr pushPtr);
		
#if UNITY_IPHONE
		//TODO: Tag shouldn't be string
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaPushGet(string message, string sound, int badge, string tag);
		public PushNotification(string message, string sound, int badge, string tag) {
			innerPush = ApplicasaPushGet(message, sound, badge, tag);
		}
#else
		//TODO: Tag shouldn't be string
		public PushNotification(string message, string sound, int badge, string tag) {
			
		}
#endif
		
		#region Class Methods and Members
		
		public IntPtr innerPush;
		
#if UNITY_IPHONE
		[DllImport("__Internal")]
		private static extern void ApplicasaPushSend(IntPtr innerPush, IntPtr[] users, int arrayCount, SendPushFinished sendPushFinished);
		public void Send(User[] users, int arrayCount, SendPushFinished sendPushFinished) {
			IntPtr[] userArray = new IntPtr[users.Length];
			for (int i = 0; i < users.Length; i++) {
				userArray[i] = users[i].innerUser;
			}
			ApplicasaPushSend(innerPush, userArray, userArray.Length, sendPushFinished);
		}
#else
		public void Send(User[] users, int arrayCount, SendPushFinished sendPushFinished) {
			
		}
#endif
		
		#endregion
	}
}
