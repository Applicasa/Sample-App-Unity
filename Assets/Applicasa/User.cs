//
// User.cs
// Created by Applicasa 
// 10/24/2013
//

using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using System;


namespace Applicasa {
	
	public class User {
		public static User[] finalUser;
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaUser;
		
        public AndroidJavaObject innerUserJavaObject;
                
        [DllImport("Applicasa")]
		private static extern void setGetUserFinishedCallback(GetUserFinished callback, int uniqueActionID);
		
		[DllImport("Applicasa")]
		private static extern void setGetUserArrayFinishedCallback(GetUserArrayFinished callback, int uniqueActionID);
		
		[DllImport("Applicasa")]
		private static extern void setFBFriendsActionCallback(FBFriendsAction callback, int uniqueActionID);
		
#endif

		 public struct FBFriend {
			public User UserObj;
			public string Id;
			public string Name;
			public string ImageURL;
		}
		
        public struct PrivateFBFriend {
			public IntPtr UserPtr;
			public string Id;
			public string Name;
			public string ImageURL;
		}
			
		public delegate void GetUserFinished(bool success, Error error, IntPtr userPtr);
		//TODO: Wrap user array in a disposable something
		public delegate void GetUserArrayFinished(bool success, Error error, UserArray userArrayPtr);
		public delegate void FBFriendsAction(bool success, Error error, FBFriendArray friends, Actions action);

		
		public User(IntPtr userPtr) {
			innerUser = userPtr;
		}
		
#if UNITY_ANDROID 
		public User(IntPtr userPtr, AndroidJavaObject userJavaObject) {
			innerUser = userPtr;
			innerUserJavaObject = userJavaObject;
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
		}
#endif
		
		public struct UserArray {
			public int ArraySize;
			public IntPtr Array;
		}
		
		public struct FBFriendArray {
			public int ArraySize;
			public IntPtr Array;
			
		}

#if UNITY_ANDROID && !UNITY_EDITOR	
			public static User[] GetUserArray(UserArray userArray) {
			
			User[] userInner = new User[userArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(userArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					userInner[count] = new User(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return userInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static User[] GetUserArray(UserArray userArray) {
			User[] users = new User[userArray.ArraySize];

			for (int i=0; i < userArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (userArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				users[i] = new User(newPtr);
			}
			return users;
		}
#else
		public static User[] GetUserArray(UserArray userArray) {
			User[] users = new User[0];
			return users;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern PrivateFBFriend ApplicasaUserGetFacebookFriend(System.IntPtr fbFriend);
		public static FBFriend[] GetFacebookFriends(FBFriendArray fbFriendArray) {
			PrivateFBFriend[] pfbFriends = new PrivateFBFriend[fbFriendArray.ArraySize];
			FBFriend[] fbFriends = new FBFriend[fbFriendArray.ArraySize];
			for (int i=0; i < fbFriendArray.ArraySize; i++) {
				IntPtr newPtr = Marshal.ReadIntPtr (fbFriendArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				pfbFriends[i] = ApplicasaUserGetFacebookFriend(newPtr);
				fbFriends[i].Id = pfbFriends[i].Id;
				fbFriends[i].Name = pfbFriends[i].Name;
				fbFriends[i].ImageURL = pfbFriends[i].ImageURL;
				if (pfbFriends[i].UserPtr.ToInt32() != 0)
					fbFriends[i].UserObj = new User(pfbFriends[i].UserPtr);
			}
			return fbFriends;
		}
		
		public static FBFriend[] FBFriends;
		public static IEnumerator GetFacebookFriendsIEnumerator(FBFriendArray fbFriendArray) {
			FBFriends = GetFacebookFriends(fbFriendArray);
			yield return new WaitForSeconds(0.2f);	
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		
		
		public static FBFriend[] GetFacebookFriends(FBFriendArray fbFriendArray) {
			FBFriend[] fbFriends = new FBFriend[fbFriendArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(fbFriendArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					using(AndroidJavaObject tempObj = InnerArray[j])
					{
						fbFriends[count].Id = tempObj.Get<string>("mFacebookID");
						fbFriends[count].Name = tempObj.Get<string>("mFacebookName");
						fbFriends[count].ImageURL = tempObj.Get<string>("mFacebookImage");
						bool hasUser=false;
						hasUser=tempObj.Get<bool>("mHasApplicasaUser");
						if(hasUser)
						{						
							AndroidJavaObject tempUserJavaObject = tempObj.Get<AndroidJavaObject>("user");
							fbFriends[count].UserObj = new User(tempObj.GetRawObject(), tempObj);			
						}
						count++;
					}
				}
			}
			return fbFriends;
		}
		
		
		public static FBFriend[] FBFriends;
		public static IEnumerator GetFacebookFriendsIEnumerator(FBFriendArray fbFriendArray) {

		
	     	FBFriend[] fbFriends = new FBFriend[fbFriendArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(fbFriendArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					using(AndroidJavaObject tempObj = InnerArray[j])
					{
						fbFriends[count].Id = tempObj.Get<string>("mFacebookID");
						fbFriends[count].Name = tempObj.Get<string>("mFacebookName");
						fbFriends[count].ImageURL = tempObj.Get<string>("mFacebookImage");
						bool hasUser=false;
						hasUser=tempObj.Get<bool>("mHasApplicasaUser");
						if(hasUser)
						{						
							AndroidJavaObject tempUserJavaObject = tempObj.Get<AndroidJavaObject>("user");
							fbFriends[count].UserObj = new User(tempObj.GetRawObject(), tempObj);			
						}
						count++;
					}
				}
				yield return new WaitForSeconds(0.2f);
			}
			FBFriends = fbFriends;
		}
		
#else
		public static FBFriend[] GetFacebookFriends(FBFriendArray fbFriendArray) {
			FBFriend[] fbFriends = new FBFriend[0];
			return fbFriends;
		}	
		
		public static FBFriend[] FBFriends;
		public static IEnumerator GetFacebookFriendsIEnumerator(FBFriendArray fbFriendArray) {
			yield return new WaitForSeconds(4f);
			FBFriend[] fbFriends = new FBFriend[0];
			FBFriends = fbFriends;
		}
#endif
#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~User()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerUser);
		}
#endif		
#region Class Methods and Members
		public System.IntPtr innerUser;

        	#region Class Members
#if UNITY_IPHONE

		public string UserID {
			get {return ApplicasaUserGetUserID(innerUser);}
			set {ApplicasaUserSetUserID(innerUser, value);}
		}
		public string UserName {
			get {return ApplicasaUserGetUserName(innerUser);}
		}
		public string UserFirstName {
			get {return ApplicasaUserGetUserFirstName(innerUser);}
			set {ApplicasaUserSetUserFirstName(innerUser, value);}
		}
		public string UserLastName {
			get {return ApplicasaUserGetUserLastName(innerUser);}
			set {ApplicasaUserSetUserLastName(innerUser, value);}
		}
		public string UserEmail {
			get {return ApplicasaUserGetUserEmail(innerUser);}
			set {ApplicasaUserSetUserEmail(innerUser, value);}
		}
		public string UserPhone {
			get {return ApplicasaUserGetUserPhone(innerUser);}
			set {ApplicasaUserSetUserPhone(innerUser, value);}
		}
		public string UserPassword {
			get {return ApplicasaUserGetUserPassword(innerUser);}
		}
		public DateTime UserLastLogin {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaUserGetUserLastLogin(innerUser));}
		}
		public DateTime UserRegisterDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaUserGetUserRegisterDate(innerUser));}
		}
		public Location UserLocation {
			get {return ApplicasaUserGetUserLocation(innerUser);}
			set {ApplicasaUserSetUserLocation(innerUser, value);}
		}
		public bool UserIsRegistered {
			get {return ApplicasaUserGetUserIsRegistered(innerUser);}
		}
		public bool UserIsRegisteredFacebook {
			get {return ApplicasaUserGetUserIsRegisteredFacebook(innerUser);}
		}
		public DateTime UserLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaUserGetUserLastUpdate(innerUser));}
		}
		public string UserImage {
			get {return ApplicasaUserGetUserImage(innerUser);}
			set {ApplicasaUserSetUserImage(innerUser, value);}
		}
		public int UserMainCurrencyBalance {
			get {return ApplicasaUserGetUserMainCurrencyBalance(innerUser);}
			set {ApplicasaUserSetUserMainCurrencyBalance(innerUser, value);}
		}
		public int UserSecondaryCurrencyBalance {
			get {return ApplicasaUserGetUserSecondaryCurrencyBalance(innerUser);}
			set {ApplicasaUserSetUserSecondaryCurrencyBalance(innerUser, value);}
		}
		public string UserFacebookID {
			get {return ApplicasaUserGetUserFacebookID(innerUser);}
		}
		public DateTime UserTempDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaUserGetUserTempDate(innerUser));}
			set {ApplicasaUserSetUserTempDate(innerUser, value.Ticks);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserID(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserID(System.IntPtr user, string userID);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserName(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserFirstName(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserFirstName(System.IntPtr user, string userFirstName);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserLastName(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserLastName(System.IntPtr user, string userLastName);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserEmail(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserEmail(System.IntPtr user, string userEmail);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserPhone(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserPhone(System.IntPtr user, string userPhone);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserPassword(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern double ApplicasaUserGetUserLastLogin(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern double ApplicasaUserGetUserRegisterDate(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern Location ApplicasaUserGetUserLocation(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserLocation(System.IntPtr user, Location userLocation);
	[DllImport("__Internal")]
	private static extern bool ApplicasaUserGetUserIsRegistered(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern bool ApplicasaUserGetUserIsRegisteredFacebook(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern double ApplicasaUserGetUserLastUpdate(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserImage(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserImage(System.IntPtr user, string userImage);
	[DllImport("__Internal")]
	private static extern int ApplicasaUserGetUserMainCurrencyBalance(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserMainCurrencyBalance(System.IntPtr user, int userMainCurrencyBalance);
	[DllImport("__Internal")]
	private static extern int ApplicasaUserGetUserSecondaryCurrencyBalance(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserSecondaryCurrencyBalance(System.IntPtr user, int userSecondaryCurrencyBalance);
	[DllImport("__Internal")]
	private static extern string ApplicasaUserGetUserFacebookID(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern double ApplicasaUserGetUserTempDate(System.IntPtr user);
	[DllImport("__Internal")]
	private static extern void ApplicasaUserSetUserTempDate(System.IntPtr user, double userTempDate);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string UserID {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserID", innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserID", innerUserJavaObject, value);}
		}
		public string UserName {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserName", innerUserJavaObject);}
		}
		public string UserFirstName {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserFirstName", innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserFirstName", innerUserJavaObject, value);}
		}
		public string UserLastName {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserLastName", innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserLastName", innerUserJavaObject, value);}
		}
		public string UserEmail {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserEmail", innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserEmail", innerUserJavaObject, value);}
		}
		public string UserPhone {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserPhone", innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserPhone", innerUserJavaObject, value);}
		}
		public string UserPassword {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserPassword", innerUserJavaObject);}
		}
		public DateTime UserLastLogin {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaUser.CallStatic<double>("ApplicasaUserGetUserLastLogin",innerUserJavaObject));}
		}
		public DateTime UserRegisterDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaUser.CallStatic<double>("ApplicasaUserGetUserRegisterDate",innerUserJavaObject));}
		}
		public Location UserLocation {
			get {				Location _location=new Location();				_location.Latitude=javaUnityApplicasaUser.CallStatic<double>("ApplicasaUserGetUserLocationLatitude", innerUserJavaObject);				_location.Longitude=javaUnityApplicasaUser.CallStatic<double>("ApplicasaUserGetUserLocationLongitude",innerUserJavaObject);				return _location;			}			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserLocation",  innerUserJavaObject, value.Latitude, value.Longitude);}		}
		public bool UserIsRegistered {
			get {return javaUnityApplicasaUser.CallStatic<bool>("ApplicasaUserGetUserIsRegistered",innerUserJavaObject);}
		}
		public bool UserIsRegisteredFacebook {
			get {return javaUnityApplicasaUser.CallStatic<bool>("ApplicasaUserGetUserIsRegisteredFacebook",innerUserJavaObject);}
		}
		public DateTime UserLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaUser.CallStatic<double>("ApplicasaUserGetUserLastUpdate",innerUserJavaObject));}
		}
		public string UserImage {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserImage",innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserImage",innerUserJavaObject, value);}
		}
		public int UserMainCurrencyBalance {
			get {return javaUnityApplicasaUser.CallStatic<int>("ApplicasaUserGetUserMainCurrencyBalance",innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserMainCurrencyBalance",innerUserJavaObject, value);}
		}
		public int UserSecondaryCurrencyBalance {
			get {return javaUnityApplicasaUser.CallStatic<int>("ApplicasaUserGetUserSecondaryCurrencyBalance",innerUserJavaObject);}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserSecondaryCurrencyBalance",innerUserJavaObject, value);}
		}
		public string UserFacebookID {
			get {return javaUnityApplicasaUser.CallStatic<string>("ApplicasaUserGetUserFacebookID", innerUserJavaObject);}
		}
		public DateTime UserTempDate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaUser.CallStatic<double>("ApplicasaUserGetUserTempDate",innerUserJavaObject));}
			set {javaUnityApplicasaUser.CallStatic("ApplicasaUserSetUserTempDate", innerUserJavaObject, (long)value.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds);}
		}

#else

		public string UserID {
			get {return "";}
			set { }
		}
		public string UserName {
			get {return "";}
		}
		public string UserFirstName {
			get {return "";}
			set { }
		}
		public string UserLastName {
			get {return "";}
			set { }
		}
		public string UserEmail {
			get {return "";}
			set { }
		}
		public string UserPhone {
			get {return "";}
			set { }
		}
		public string UserPassword {
			get {return "";}
		}
		public DateTime UserLastLogin {
			get {return new DateTime();}
		}
		public DateTime UserRegisterDate {
			get {return new DateTime();}
		}
		public Location UserLocation {
			get {return new Location();}
			set { }
		}
		public bool UserIsRegistered {
			get {return false;}
		}
		public bool UserIsRegisteredFacebook {
			get {return false;}
		}
		public DateTime UserLastUpdate {
			get {return new DateTime();}
		}
		public string UserImage {
			get {return "";}
			set { }
		}
		public int UserMainCurrencyBalance {
			get {return 0;}
			set { }
		}
		public int UserSecondaryCurrencyBalance {
			get {return 0;}
			set { }
		}
		public string UserFacebookID {
			get {return "";}
		}
		public DateTime UserTempDate {
			get {return new DateTime();}
			set { }
		}
#endif
#endregion


#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaRegisterUsername(System.IntPtr user, string username, string password, Action callback);
		public void Register(string username, string password, Action action) {
			ApplicasaRegisterUsername(innerUser, username, password, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserSaveWithBlock(System.IntPtr user, Action callback);
		public void Save(Action action) {
			ApplicasaUserSaveWithBlock(innerUser, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserIncreaseFieldInt(System.IntPtr user, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaUserIncreaseFieldFloat(System.IntPtr user, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaUserIncreaseFieldInt(innerUser, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaUserIncreaseFieldFloat(innerUser, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserUploadFile(System.IntPtr user, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaUserUploadFile(innerUser, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR		
		public void Register(string username, string password, Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaRegisterUsername", innerUserJavaObject, username, password, uniqueActionID);
		}
		
		public void Save(Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserSaveWithBlock", innerUserJavaObject, uniqueActionID);
		}
		
		public void IncreaseField(Fields field, int val) {
			javaUnityApplicasaUser.CallStatic("ApplicasaUserIncreaseFieldInt", innerUserJavaObject, (int)field, field.ToString(), val);
		}
		
		public void IncreaseField(Fields field, float val) {
			javaUnityApplicasaUser.CallStatic("ApplicasaUserIncreaseFieldFloat", innerUserJavaObject, (int)field, field.ToString(), val);
		}
		
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserUploadFile", innerUserJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
		}
#else
		public void Register(string username, string password, Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public void Save(Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public void IncreaseField(Fields field, int val) {
			
		}
		
		public void IncreaseField(Fields field, float val) {
			
		}
		
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			action(true,new Error(),"",Actions.Update);
		}		
#endif
#endregion
		
#region Static Methods
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaLoginWithUsername(string username, string password, Action callback);
		public static void Login(string username, string password, Action action) {
			ApplicasaLoginWithUsername(username, password, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUpdateUsername(string newUsername, string password, Action callback);
		public static void UpdateUsername(string newUsername, string password, Action action) {
			ApplicasaUpdateUsername(newUsername, password, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUpdatePassword(string newPassword, string oldPassword, Action callback);
		public static void UpdatePassword(string newPassword, string oldPassword, Action action) {
			ApplicasaUpdatePassword(newPassword, oldPassword, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaLogoutWithBlock(Action callback);
		public static void Logout(Action action) {
			ApplicasaLogoutWithBlock(action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaForgotPasswordForUsername(string username, Action callback);
		public static void ForgotPassword(string username, Action action) {
			ApplicasaForgotPasswordForUsername(username, action);
		}
		
		[DllImport("__Internal")]
		private static extern System.IntPtr ApplicasaGetCurrentUser();
		public static User GetCurrentUser() {
			User user = new User(ApplicasaGetCurrentUser());
			return user;
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserGetById(string id, QueryKind queryKind, GetUserFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetUserFinished callback) {
			ApplicasaUserGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetUserArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetUserArrayFinished callback) {
			ApplicasaUserGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserGetLocalArrayWithRawSqlQuery(string rawQuery, GetUserArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetUserArrayFinished callback) {
			ApplicasaUserGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}

		[DllImport("__Internal")]
		private static extern UserArray ApplicasaUserGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static User[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetUserArray(ApplicasaUserGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			UserArray userArray = ApplicasaUserGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalUser = GetUserArray(userArray);
			yield return new WaitForSeconds(0.2f);
		}
		
		public static  IEnumerator GetUserArrayIEnumerator(UserArray userArray) {
			finalUser = GetUserArray(userArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaUserUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaUserUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserFacebookFindFriendsWithBlock(FBFriendsAction callback);
		public static void FacebookFindFriends(FBFriendsAction callback) {
			ApplicasaUserFacebookFindFriendsWithBlock(callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserFacebookLoginWithBlock(System.IntPtr user, Action callback);
		public static void FacebookLogin(Action action) {
			ApplicasaUserFacebookLoginWithBlock(GetCurrentUser().innerUser, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaUserFacebookLogoutWithBlock(Action callback);
		public static void FacebookLogout(Action callback) {
			ApplicasaUserFacebookLogoutWithBlock(callback);
		}
		
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void Login(string username, string password, Action action) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);			
			javaUnityApplicasaUser.CallStatic("ApplicasaLoginWithUsername", username, password, uniqueActionID);
		}
		
		public static void UpdateUsername(string newUsername, string password, Action action) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUpdateUsername", newUsername, password, uniqueActionID);
		}
		
		public static void UpdatePassword(string newPassword, string oldPassword, Action action) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUpdatePassword", newPassword, oldPassword, uniqueActionID);
		}
		
		public static void Logout(Action action) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaLogoutWithBlock", uniqueActionID);
		}
		
		public static void ForgotPassword(string username, Action action) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaForgotPasswordForUsername",username, uniqueActionID);
		}
		
        public static User GetCurrentUser() {
            if(javaUnityApplicasaUser==null)
                javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
           // User user = new User(AndroidJNI.NewGlobalRef(javaUnityApplicasaUser.CallStatic<AndroidJavaObject>("getCurrentUser").GetRawObject()));
			
			AndroidJavaObject currentUser= javaUnityApplicasaUser.CallStatic<AndroidJavaObject>("getCurrentUser");
            User user = new User(currentUser.GetRawObject(),currentUser);
			
            return user;
        }

		
		
		public static void GetById(string id, QueryKind queryKind, GetUserFinished callback) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueGetUserFinishedID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetUserFinishedCallback(callback,uniqueGetUserFinishedID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserGetById", id, queryKind, uniqueGetUserFinishedID);
		}
		
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetUserArrayFinished callback) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueGetUserArrayFinishedID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetUserArrayFinishedCallback(callback,uniqueGetUserArrayFinishedID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserGetArrayWithQuery", query.innerQuery, queryKind, uniqueGetUserArrayFinishedID);
		}
		
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetUserArrayFinished callback) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueGetUserArrayFinishedID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetUserArrayFinishedCallback(callback,uniqueGetUserArrayFinishedID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserGetLocalArrayWithRawSqlQuery", rawQuery, uniqueGetUserArrayFinishedID);
		}
		
		public static User[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaUser.CallStatic<AndroidJavaObject[]>("ApplicasaUserGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			User[] userInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				User[] usertemp = new User[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					usertemp[j] = new User(tempObj.GetRawObject(),tempObj);
				}
				if (userInner == null)
					userInner = usertemp;
				else{
				   User[] firstOne = userInner;
				    userInner = new User[firstOne.Length+usertemp.Length];
					firstOne.CopyTo(userInner,0);
					usertemp.CopyTo(userInner,firstOne.Length);
				}
				
			}
			return userInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
				
				int count = javaUnityApplicasaUser.CallStatic<int>("ApplicasaUserUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaUser.CallStatic<AndroidJavaObject[]>("ApplicasaUserGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			User[] userInner = null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				User[] usertemp = new User[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					usertemp[j] = new User(tempObj.GetRawObject(),tempObj);
				}
				if (userInner == null)
					userInner = usertemp;
				else{
				   User[] firstOne = userInner;
				    userInner = new User[firstOne.Length+usertemp.Length];
					firstOne.CopyTo(userInner,0);
					usertemp.CopyTo(userInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalUser = userInner;
		}
		
		public static  IEnumerator GetUserArrayIEnumerator(UserArray userArray) {
		
			User[] userInner = new User[userArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(userArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					userInner[count] = new User(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalUser = userInner;
		}
		
		public static void FacebookFindFriends(FBFriendsAction callback) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueFBFriendsActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setFBFriendsActionCallback(callback,uniqueFBFriendsActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserFacebookFindFriendsWithBlock", uniqueFBFriendsActionID);
		}
		
		public static void FacebookLogin(Action action) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserFacebookLoginWithBlock", uniqueActionID);
		}
		
		public static void FacebookLogout(Action callback) {
			if(javaUnityApplicasaUser==null)
				javaUnityApplicasaUser = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaUser");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(callback,uniqueActionID);
			javaUnityApplicasaUser.CallStatic("ApplicasaUserFacebookLogoutWithBlock", uniqueActionID);
		}
#else

		public static void Login(string username, string password, Action action) {
			action(true,new Error(),"",Actions.Update);
		}

		public static void UpdateUsername(string newUsername, string password, Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public static void UpdatePassword(string newPassword, string oldPassword, Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public static void Logout(Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public static void ForgotPassword(string username, Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public static User GetCurrentUser() {			
			return null;
		}
		
		public static void GetById(string id, QueryKind queryKind, GetUserFinished callback) {
			callback(true,new Error(),new IntPtr());
		}
		
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetUserArrayFinished callback) {
			callback(true,new Error(),new UserArray());
		}
		
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetUserArrayFinished callback) {
			callback(true,new Error(),new UserArray());
		}

		public static User[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return new User[0];
		}		
		
		

		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				User[]  userInner = new User[0];
			    finalUser = userInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}

		
		public static void FacebookFindFriends(FBFriendsAction callback) {
			callback(true,new Error(),new FBFriendArray(),Actions.Update);
		}
		
		public static void FacebookLogin(Action action) {
			action(true,new Error(),"",Actions.Update);
		}
		
		public static void FacebookLogout(Action callback) {
			callback(true,new Error(),"",Actions.Update);
		}
		
		public static  IEnumerator GetUserArrayIEnumerator(UserArray userArray) {
				yield return new WaitForSeconds(0.2f);
				User[]  userInner = new User[0];
			    finalUser = userInner;
		}
#endif		
#endregion

	}
}

