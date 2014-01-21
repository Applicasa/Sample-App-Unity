//
// Chat.cs
// Created by Applicasa 
// 1/21/2014
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Chat {	
		public static Chat[] finalChat;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaChat;
	
        public AndroidJavaObject innerChatJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetChatFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetChatArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetChatFinished(bool success, Error error, IntPtr chatPtr);
		public delegate void GetChatArrayFinished(bool success, Error error, ChatArray chatArrayPtr);
		
		public Chat(IntPtr chatPtr) {
			innerChat = chatPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			if(innerChatJavaObject==null)
				innerChatJavaObject = new AndroidJavaObject("com.applicasa.Chat.Chat",innerChat);
#endif
		}
		
#if UNITY_ANDROID 
		public Chat(IntPtr chatPtr, AndroidJavaObject chatJavaObject) {
			innerChat = chatPtr;
			innerChatJavaObject = chatJavaObject;
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaChat();
		#endif
		public Chat() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaChat==null)
			javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
		   innerChatJavaObject = new AndroidJavaObject("com.applicasa.Chat.Chat");
		   innerChat = innerChatJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerChat = ApplicasaChat();
		#endif
		  }

		public struct ChatArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Chat[] GetChatArray(ChatArray chatArray) {
			
			Chat[] chatInner = new Chat[chatArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(chatArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					chatInner[count] = new Chat(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return chatInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Chat[] GetChatArray(ChatArray chatArray) {
			Chat[] chats = new Chat[chatArray.ArraySize];

			for (int i=0; i < chatArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (chatArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				chats[i] = new Chat(newPtr);
			}
			return chats;
		}
#else
		public static Chat[] GetChatArray(ChatArray chatArray) {
			Chat[] chats = new Chat[0];
			return chats;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Chat()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerChat);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerChat;
		
			#region Class Members
#if UNITY_IPHONE

		public string ChatID {
			get {return ApplicasaChatGetChatID(innerChat);}
			set {ApplicasaChatSetChatID(innerChat, value);}
		}
		public DateTime ChatLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaChatGetChatLastUpdate(innerChat));}
		}
		public bool ChatIsSender {
			get {return ApplicasaChatGetChatIsSender(innerChat);}
			set {ApplicasaChatSetChatIsSender(innerChat, value);}
		}
		public User ChatSender {
			get {return new User(ApplicasaChatGetChatSender(innerChat));}
			set {ApplicasaChatSetChatSender(innerChat, value.innerUser);}
		}
		public string ChatText {
			get {return ApplicasaChatGetChatText(innerChat);}
			set {ApplicasaChatSetChatText(innerChat, value);}
		}
		public User ChatReciepent {
			get {return new User(ApplicasaChatGetChatReciepent(innerChat));}
			set {ApplicasaChatSetChatReciepent(innerChat, value.innerUser);}
		}
		public string ChatGhjgjgj {
			get {return ApplicasaChatGetChatGhjgjgj(innerChat);}
			set {ApplicasaChatSetChatGhjgjgj(innerChat, value);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaChatGetChatID(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern void ApplicasaChatSetChatID(System.IntPtr chat, string chatID);
	[DllImport("__Internal")]
	private static extern double ApplicasaChatGetChatLastUpdate(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern bool ApplicasaChatGetChatIsSender(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern void ApplicasaChatSetChatIsSender(System.IntPtr chat, bool chatIsSender);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaChatGetChatSender(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern void ApplicasaChatSetChatSender(System.IntPtr chat, IntPtr chatSender);
	[DllImport("__Internal")]
	private static extern string ApplicasaChatGetChatText(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern void ApplicasaChatSetChatText(System.IntPtr chat, string chatText);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaChatGetChatReciepent(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern void ApplicasaChatSetChatReciepent(System.IntPtr chat, IntPtr chatReciepent);
	[DllImport("__Internal")]
	private static extern string ApplicasaChatGetChatGhjgjgj(System.IntPtr chat);
	[DllImport("__Internal")]
	private static extern void ApplicasaChatSetChatGhjgjgj(System.IntPtr chat, string chatGhjgjgj);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string ChatID {
			get {return javaUnityApplicasaChat.CallStatic<string>("ApplicasaChatGetChatID", innerChatJavaObject);}
			set {javaUnityApplicasaChat.CallStatic("ApplicasaChatSetChatID", innerChatJavaObject, value);}
		}
		public DateTime ChatLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaChat.CallStatic<double>("ApplicasaChatGetChatLastUpdate",innerChatJavaObject));}
		}
		public bool ChatIsSender {
			get {return javaUnityApplicasaChat.CallStatic<bool>("ApplicasaChatGetChatIsSender",innerChatJavaObject);}
			set {javaUnityApplicasaChat.CallStatic("ApplicasaChatSetChatIsSender",innerChatJavaObject, value);}
		}
		public User ChatSender {
			get {
				AndroidJavaObject temp = javaUnityApplicasaChat.CallStatic<AndroidJavaObject>("ApplicasaChatGetChatSender",innerChatJavaObject);
				return new User(temp.GetRawObject(),temp);}
			set {javaUnityApplicasaChat.CallStatic("ApplicasaChatSetChatSender",innerChatJavaObject, value.innerUserJavaObject);}
		}
		public string ChatText {
			get {return javaUnityApplicasaChat.CallStatic<string>("ApplicasaChatGetChatText", innerChatJavaObject);}
			set {javaUnityApplicasaChat.CallStatic("ApplicasaChatSetChatText", innerChatJavaObject, value);}
		}
		public User ChatReciepent {
			get {
				AndroidJavaObject temp = javaUnityApplicasaChat.CallStatic<AndroidJavaObject>("ApplicasaChatGetChatReciepent",innerChatJavaObject);
				return new User(temp.GetRawObject(),temp);}
			set {javaUnityApplicasaChat.CallStatic("ApplicasaChatSetChatReciepent",innerChatJavaObject, value.innerUserJavaObject);}
		}
		public string ChatGhjgjgj {
			get {return javaUnityApplicasaChat.CallStatic<string>("ApplicasaChatGetChatGhjgjgj",innerChatJavaObject);}
			set {javaUnityApplicasaChat.CallStatic("ApplicasaChatSetChatGhjgjgj",innerChatJavaObject, value);}
		}

#else

		public string ChatID {
			get {return "";}
			set { }
		}
		public DateTime ChatLastUpdate {
			get {return new DateTime();}
		}
		public bool ChatIsSender {
			get {return false;}
			set { }
		}
		public User ChatSender {
			get {return null;}
			set { }
		}
		public string ChatText {
			get {return "";}
			set { }
		}
		public User ChatReciepent {
			get {return null;}
			set { }
		}
		public string ChatGhjgjgj {
			get {return "";}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaChatSaveWithBlock(System.IntPtr chat, Action callback);
		public void Save(Action action) {
			ApplicasaChatSaveWithBlock(innerChat, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaChatIncreaseFieldInt(System.IntPtr chat, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaChatIncreaseFieldFloat(System.IntPtr chat, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaChatIncreaseFieldInt(innerChat, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaChatIncreaseFieldFloat(innerChat, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaChatDeleteWithBlock(System.IntPtr chat, Action callback);
		public void Delete(Action action) {
			ApplicasaChatDeleteWithBlock(innerChat, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaChatUploadFile(System.IntPtr chat, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaChatUploadFile(innerChat, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaChat.CallStatic("ApplicasaChatSaveWithBlock", innerChatJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			javaUnityApplicasaChat.CallStatic("ApplicasaChatIncreaseFieldInt", innerChatJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			javaUnityApplicasaChat.CallStatic("ApplicasaChatIncreaseFieldFloat", innerChatJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaChat.CallStatic("ApplicasaChatDeleteWithBlock", innerChatJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaChat.CallStatic("ApplicasaChatUploadFile", innerChatJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
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
		private static extern void ApplicasaChatGetById(string id, QueryKind queryKind, GetChatFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetChatFinished callback) {
			ApplicasaChatGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaChatGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetChatArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetChatArrayFinished callback) {
			ApplicasaChatGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaChatGetLocalArrayWithRawSqlQuery(string rawQuery, GetChatArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetChatArrayFinished callback) {
			ApplicasaChatGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern ChatArray ApplicasaChatGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Chat[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetChatArray(ApplicasaChatGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			ChatArray chatArray = ApplicasaChatGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalChat = GetChatArray(chatArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetChatArrayIEnumerator(ChatArray chatArray) {
			finalChat = GetChatArray(chatArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaChatUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaChatUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetChatFinished callback) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaChat.CallStatic("ApplicasaChatGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetChatArrayFinished callback) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaChat.CallStatic("ApplicasaChatGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetChatArrayFinished callback) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaChat.CallStatic("ApplicasaChatGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Chat[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaChat.CallStatic<AndroidJavaObject[]>("ApplicasaChatGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Chat[] chatInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Chat[] chattemp = new Chat[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					chattemp[j] = new Chat(tempObj.GetRawObject(),tempObj);
				}
				if (chatInner == null)
					chatInner = chattemp;
				else{
				   Chat[] firstOne = chatInner;
				    chatInner = new Chat[firstOne.Length+chattemp.Length];
					firstOne.CopyTo(chatInner,0);
					chattemp.CopyTo(chatInner,firstOne.Length);
				}
				
			}
			return chatInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
				
				int count = javaUnityApplicasaChat.CallStatic<int>("ApplicasaChatUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaChat==null)
				javaUnityApplicasaChat = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaChat");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaChat.CallStatic<AndroidJavaObject[]>("ApplicasaChatGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Chat[] chatInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Chat[] chattemp = new Chat[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					chattemp[j] = new Chat(tempObj.GetRawObject(),tempObj);
				}
				if (chatInner == null)
					chatInner = chattemp;
				else{
				   Chat[] firstOne = chatInner;
				    chatInner = new Chat[firstOne.Length+chattemp.Length];
					firstOne.CopyTo(chatInner,0);
					chattemp.CopyTo(chatInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalChat = chatInner;
		}
		
		public static  IEnumerator GetChatArrayIEnumerator(ChatArray chatArray) {
		
			Chat[] chatInner = new Chat[chatArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(chatArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					chatInner[count] = new Chat(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalChat = chatInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Chat[]  chatInner = new Chat[0];
			    finalChat = chatInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetChatFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetChatArrayFinished callback) {
			callback(true,new Error(),new ChatArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetChatArrayFinished callback) {
			callback(true,new Error(),new ChatArray());
		}
		
		public static Chat[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Chat[] chat = new Chat[0];
		    
			return chat;
		}	
		
		public static  IEnumerator GetChatArrayIEnumerator(ChatArray chatArray) {
			yield return new WaitForSeconds(0.2f);
			Chat[]  chatInner = new Chat[0];
			finalChat = chatInner;
		}
#endif
		
		#endregion
	}
}

