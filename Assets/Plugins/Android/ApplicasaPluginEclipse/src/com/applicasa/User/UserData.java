package com.applicasa.User;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import applicasa.LiCore.LiLocation;
import applicasa.LiCore.LiField;
import applicasa.LiJson.LiJSONObject;

public class UserData {


	protected static Map<String, LiFieldUser> stringMap = new HashMap<String, LiFieldUser>();
	LiJSONObject incrementedFields = new LiJSONObject();
	public static boolean EnableOffline = true;
	public enum LiFieldUser implements LiField
	{
		User_None
	, UserID
	, UserName
	, UserFirstName
	, UserLastName
	, UserEmail
	, UserPhone
	, UserLastLogin
	, UserRegisterDate
	, UserLocation
	, UserIsRegistered
	, UserIsRegisteredFacebook
	, UserLastUpdate
	, UserImage
	, UserMainCurrencyBalance
	, UserSecondaryCurrencyBalance

	;

		private LiFieldUser() {
			stringMap.put(this.toString(), this);
		}

		public static LiFieldUser getLiFieldUser(String key) {
			return stringMap.get(key);
	}
	}

	protected static Map<String, Object > userCallbacks = new HashMap<String, Object>();
	//Class Name 
	public final static String kClassName                =  "User";
	
	////
	//// Class fields name - Static Fields
	////
	////
	////
		public String UserID;
	
		public String UserName;
	
		public String UserFirstName;
	
		public String UserLastName;
	
		public String UserEmail;
	
		public String UserPhone;
	
		public String UserPassword;
	
		public GregorianCalendar UserLastLogin;
	
		public GregorianCalendar UserRegisterDate;
	
		public LiLocation UserLocation;
	
		public Boolean UserIsRegistered;
	
		public Boolean UserIsRegisteredFacebook;
	
		public GregorianCalendar UserLastUpdate;
	
		public String UserImage;
	
		public int UserMainCurrencyBalance;
	
		public int UserSecondaryCurrencyBalance;
	
		public String UserFacebookID;
	
		public double DistanceFromCurrent;
	
		public String getUserID() {
			return UserID;
		}
		
		public void setUserID(String UserID) {
			this.UserID = UserID;
		}
		
		public String getUserName() {
			return UserName;
		}
		
		public void setUserName(String UserName) {
			this.UserName = UserName;
		}
		
		public String getUserFirstName() {
			return UserFirstName;
		}
		
		public void setUserFirstName(String UserFirstName) {
			this.UserFirstName = UserFirstName;
		}
		
		public String getUserLastName() {
			return UserLastName;
		}
		
		public void setUserLastName(String UserLastName) {
			this.UserLastName = UserLastName;
		}
		
		public String getUserEmail() {
			return UserEmail;
		}
		
		public void setUserEmail(String UserEmail) {
			this.UserEmail = UserEmail;
		}
		
		public String getUserPhone() {
			return UserPhone;
		}
		
		public void setUserPhone(String UserPhone) {
			this.UserPhone = UserPhone;
		}
		
		public String getUserPassword() {
			return UserPassword;
		}
		
		public void setUserPassword(String UserPassword) {
			this.UserPassword = UserPassword;
		}
		
		public GregorianCalendar getUserLastLogin() {
			return UserLastLogin;
		}
		
		public void setUserLastLogin(GregorianCalendar UserLastLogin) {
			this.UserLastLogin = UserLastLogin;
		}
		
		public GregorianCalendar getUserRegisterDate() {
			return UserRegisterDate;
		}
		
		public void setUserRegisterDate(GregorianCalendar UserRegisterDate) {
			this.UserRegisterDate = UserRegisterDate;
		}
		
		public LiLocation getUserLocation() {
			return UserLocation;
		}
		
		public void setUserLocation(LiLocation UserLocation) {
			this.UserLocation = UserLocation;
		}
		
		public Boolean getUserIsRegistered() {
			return UserIsRegistered;
		}
		
		public void setUserIsRegistered(Boolean UserIsRegistered) {
			this.UserIsRegistered = UserIsRegistered;
		}
		
		public Boolean getUserIsRegisteredFacebook() {
			return UserIsRegisteredFacebook;
		}
		
		public void setUserIsRegisteredFacebook(Boolean UserIsRegisteredFacebook) {
			this.UserIsRegisteredFacebook = UserIsRegisteredFacebook;
		}
		
		public GregorianCalendar getUserLastUpdate() {
			return UserLastUpdate;
		}
		
		public void setUserLastUpdate(GregorianCalendar UserLastUpdate) {
			this.UserLastUpdate = UserLastUpdate;
		}
		
		public String getUserImage() {
			return UserImage;
		}
		
		public void setUserImage(String UserImage) {
			this.UserImage = UserImage;
		}
		
		public int getUserMainCurrencyBalance() {
			return UserMainCurrencyBalance;
		}
		
		public void setUserMainCurrencyBalance(int UserMainCurrencyBalance) {
			this.UserMainCurrencyBalance = UserMainCurrencyBalance;
		}
		
		public int getUserSecondaryCurrencyBalance() {
			return UserSecondaryCurrencyBalance;
		}
		
		public void setUserSecondaryCurrencyBalance(int UserSecondaryCurrencyBalance) {
			this.UserSecondaryCurrencyBalance = UserSecondaryCurrencyBalance;
		}
		
		public String getUserFacebookID() {
			return UserFacebookID;
		}
		
		public void setUserFacebookID(String UserFacebookID) {
			this.UserFacebookID = UserFacebookID;
		}
		
		public static String getUserSortField(UserData.LiFieldUser field)
		{
			return field.toString();
		}
	public Object getUserFieldbySortType(UserData.LiFieldUser field)
	{
		switch (field){
			case User_None:
				return UserID;
				
			case UserID:
				return UserID;
				
			case UserName:
				return UserName;
				
			case UserFirstName:
				return UserFirstName;
				
			case UserLastName:
				return UserLastName;
				
			case UserEmail:
				return UserEmail;
				
			case UserPhone:
				return UserPhone;
				
			case UserLastLogin:
				return UserLastLogin;
				
			case UserRegisterDate:
				return UserRegisterDate;
				
			case UserIsRegistered:
					return UserIsRegistered;
					
			case UserIsRegisteredFacebook:
					return UserIsRegisteredFacebook;
					
			case UserLastUpdate:
				return UserLastUpdate;
				
			case UserImage:
				return UserImage;
				
			case UserMainCurrencyBalance:
				return UserMainCurrencyBalance;
				
			case UserSecondaryCurrencyBalance:
				return UserSecondaryCurrencyBalance;
				
			default:
				return "";
		}
		
	}
	
	protected boolean setUserFieldbySortType(UserData.LiFieldUser field, Object value)
	{
		switch (field){
			case User_None:
				break;
				
			case UserID:
					UserID = (String)value;
					break;
					
			case UserName:
					UserName = (String)value;
					break;
					
			case UserFirstName:
					UserFirstName = (String)value;
					break;
					
			case UserLastName:
					UserLastName = (String)value;
					break;
					
			case UserEmail:
					UserEmail = (String)value;
					break;
					
			case UserPhone:
					UserPhone = (String)value;
					break;
					
			case UserLastLogin:
					UserLastLogin = (GregorianCalendar)value;
					break;
				
			case UserRegisterDate:
					UserRegisterDate = (GregorianCalendar)value;
					break;
				
			case UserLocation:
					UserLocation = (LiLocation)value;
					break;
					
			case UserIsRegistered:
					UserIsRegistered = (Boolean)value;
					break;
					
			case UserIsRegisteredFacebook:
					UserIsRegisteredFacebook = (Boolean)value;
					break;
					
			case UserLastUpdate:
					UserLastUpdate = (GregorianCalendar)value;
					break;
				
			case UserImage:
					UserImage = (String)value;
					break;
					
			case UserMainCurrencyBalance:
					UserMainCurrencyBalance = (Integer)value;
					break;
					
			case UserSecondaryCurrencyBalance:
					UserSecondaryCurrencyBalance = (Integer)value;
					break;
					
			default:
				break;
		}
		return true;
	}
}
