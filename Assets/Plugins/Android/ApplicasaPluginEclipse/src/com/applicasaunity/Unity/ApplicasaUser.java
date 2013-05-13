//
// User.java
// Created by Applicasa 
// 5/13/2013
//

package com.applicasaunity.Unity;


import java.util.List;

import com.applicasa.ApplicasaManager.LiCallbackQuery.LiUserGetArrayCallback;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiUserGetByIDCallback;
import com.applicasa.ApplicasaManager.LiManager.LiObject;
import com.applicasa.User.User;
import com.applicasa.User.UserData.LiFieldUser;



import com.unity3d.player.UnityPlayer;
import android.app.Activity;
import android.content.Intent;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiQuery;
import applicasa.LiCore.communication.LiCallback.LiCallbackAction;
import applicasa.LiCore.communication.LiCallback.LiCallbackUser;
import applicasa.LiCore.communication.LiRequestConst.LiObjResponse;
import applicasa.LiCore.communication.LiRequestConst.QueryKind;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.kit.facebook.LiFacebookResponse.LiFacebookResponseGetFriends;
import applicasa.kit.facebook.LiObjFacebookFriends;


public class ApplicasaUser {
	
    static {
        System.loadLibrary("Applicasa");
    } 
	
	public static User currentUser;
	
	
	

public static String ApplicasaUserGetUserID(Object user)
{
	return ((User)user).UserID;
}
public static void ApplicasaUserSetUserID(Object user, String userID)
	{
	((User)user).UserID = userID;
}
public static String ApplicasaUserGetUserName(Object user)
{
	return ((User)user).UserName;
}
public static String ApplicasaUserGetUserFirstName(Object user)
{
	return ((User)user).UserFirstName;
}
public static void ApplicasaUserSetUserFirstName(Object user, String userFirstName)
	{
	((User)user).UserFirstName = userFirstName;
}
public static String ApplicasaUserGetUserLastName(Object user)
{
	return ((User)user).UserLastName;
}
public static void ApplicasaUserSetUserLastName(Object user, String userLastName)
	{
	((User)user).UserLastName = userLastName;
}
public static String ApplicasaUserGetUserEmail(Object user)
{
	return ((User)user).UserEmail;
}
public static void ApplicasaUserSetUserEmail(Object user, String userEmail)
	{
	((User)user).UserEmail = userEmail;
}
public static String ApplicasaUserGetUserPhone(Object user)
{
	return ((User)user).UserPhone;
}
public static void ApplicasaUserSetUserPhone(Object user, String userPhone)
	{
	((User)user).UserPhone = userPhone;
}
public static String ApplicasaUserGetUserPassword(Object user)
{
	return ((User)user).UserPassword;
}
public static double ApplicasaUserGetUserLastLogin(Object user)
{
	return ((User)user).UserLastLogin.getTimeInMillis();
}
public static double ApplicasaUserGetUserRegisterDate(Object user)
{
	return ((User)user).UserRegisterDate.getTimeInMillis();
}
public static double ApplicasaUserGetUserLocationLatitude(Object user)
{
	return ((User)user).UserLocation.getLatitude();
}
public static double ApplicasaUserGetUserLocationLongitude(Object user)
{
	return ((User)user).UserLocation.getLongitude();
}
public static void ApplicasaUserSetUserLocation(Object user, double latitude, double longitude)
{
	((User)user).UserLocation.setLatitude(latitude);
	((User)user).UserLocation.setLongitude(longitude);
}
public static boolean ApplicasaUserGetUserIsRegistered(Object user)
{
	return ((User)user).UserIsRegistered;
}
public static boolean ApplicasaUserGetUserIsRegisteredFacebook(Object user)
{
	return ((User)user).UserIsRegisteredFacebook;
}
public static double ApplicasaUserGetUserLastUpdate(Object user)
{
	return ((User)user).UserLastUpdate.getTimeInMillis();
}
public static String ApplicasaUserGetUserImage(Object user)
{
	return ((User)user).UserImage;
}
public static void ApplicasaUserSetUserImage(Object user, String userImage)
{
	((User)user).UserImage = userImage;
}
public static int ApplicasaUserGetUserMainCurrencyBalance(Object user)
{
return ((User)user).UserMainCurrencyBalance;
}
public static void ApplicasaUserSetUserMainCurrencyBalance(Object user, int userMainCurrencyBalance)
	{
	((User)user).UserMainCurrencyBalance = userMainCurrencyBalance;
}
public static int ApplicasaUserGetUserSecondaryCurrencyBalance(Object user)
{
return ((User)user).UserSecondaryCurrencyBalance;
}
public static void ApplicasaUserSetUserSecondaryCurrencyBalance(Object user, int userSecondaryCurrencyBalance)
	{
	((User)user).UserSecondaryCurrencyBalance = userSecondaryCurrencyBalance;
}
public static String ApplicasaUserGetUserFacebookID(Object user)
{
	return ((User)user).UserFacebookID;
}



	//native response calls
		public static native void responseCallbackGetUserFinished(int uniqueGetUserFinishedID, boolean success, String errorMessage, int errorType, User userPtr);
		public static native void responseCallbackGetUserArrayFinished(int uniqueGetUserArrayFinishedID, boolean success, String errorMessage, int errorType, int listSize, List<User> userArrayPtr);
		public static native void responseCallbackFBFriendsAction(int uniqueFBFriendsActionID, boolean success, String errorMessage, int errorType, int listSize, List<LiObjFacebookFriends> FB_friends, int action);
		
		
		public static void ApplicasaUserSaveWithBlock(User user, final int uniqueActionID) 
		{
			user.save(new LiCallbackAction() {
				
				@Override
				public void onFailure(LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", RequestAction.NONE.ordinal());
				}
				
				@Override
				public void onComplete(ApplicasaResponse applicasaResponse, String message,
						RequestAction action, String itemID, LiObject arg4) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), itemID, action.ordinal());					
				}
			});
		}
		
		
		
		public static void ApplicasaUserFacebookLoginWithBlock(final int uniqueActionID) {			
			Facebook_Login.uniqueActionID=uniqueActionID;
			Intent myIntent = new Intent(UnityPlayer.currentActivity, Facebook_Login.class);
			UnityPlayer.currentActivity.startActivity(myIntent);
		}
		
		public static void waitForFacebook(Activity facebookActivity, int uniqueActionID, boolean success, String errorMessage, int errorType, String itemID, int action) {
			facebookActivity.finish();
			ApplicasaCore.responseCallbackAction(uniqueActionID, success, errorMessage, errorType, itemID, action);
		}
		
		
		
		
		public static void ApplicasaRegisterUsername(User user, String username, String password, final int uniqueActionID) 
	    {
			user.registerUser(username, password, new LiCallbackUser() {
				
				@Override
				public void onSuccessfull(RequestAction action) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), "", action.ordinal());
				}
				
				@Override
				public void onFailure(RequestAction action, LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", action.ordinal());
				}
			});
	    }
		
		public static void ApplicasaLoginWithUsername(String UserName, String UserPassword, final int uniqueActionID)  
	    {
			User.loginUser(UserName, UserPassword, new LiCallbackUser() {
				
				@Override
				public void onSuccessfull(RequestAction action) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), "", action.ordinal());
				}
				
				@Override
				public void onFailure(RequestAction action, LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", action.ordinal());
				}
			});
	    }
		
		public static void ApplicasaUpdateUsername(String newUserName, String UserPassword, final int uniqueActionID) 
	    {
			User.updateUserame(newUserName, UserPassword, new LiCallbackUser() {
				
				@Override
				public void onSuccessfull(RequestAction action) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), "", action.ordinal());
				}
				
				@Override
				public void onFailure(RequestAction action, LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", action.ordinal());
				}
			});
	    }
		
		public static void ApplicasaUpdatePassword(String UserPassword, String newUserPassword, final int uniqueActionID)
	    {
			User.updateUserPassword(UserPassword, newUserPassword, new LiCallbackUser() {
				
				@Override
				public void onSuccessfull(RequestAction action) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), "", action.ordinal());
				}
				
				@Override
				public void onFailure(RequestAction action, LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", action.ordinal());
				}
			});
	    }
		
		public static void ApplicasaLogoutWithBlock( final int uniqueActionID) 
	    {
			User.logoutUser(new LiCallbackUser() {
				
				@Override
				public void onSuccessfull(RequestAction action) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), "", action.ordinal());
				}
				
				@Override
				public void onFailure(RequestAction action, LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", action.ordinal());
				}
			});
	    }
		
		public static void ApplicasaForgotPasswordForUsername(String username, final int uniqueActionID) 
	    {
			User.forgotPassword(username, new LiCallbackUser() {
				
				@Override
				public void onSuccessfull(RequestAction action) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), "", action.ordinal());
				}
				
				@Override
				public void onFailure(RequestAction action, LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", action.ordinal());
				}
			});
	    }
				
		public static User getCurrentUser()
	    {			
			currentUser  = User.getCurrentUser();
			return currentUser;
	    }

		
		
		public static void ApplicasaUserGetById(String Id, QueryKind queryKind, final int uniqueGetUserFinishedID)
		{
			User.getByID(Id, queryKind, new LiUserGetByIDCallback() {

				@Override
				public void onGetUserComplete(User items) {
					responseCallbackGetUserFinished(uniqueGetUserFinishedID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items);
				}

				@Override
				public void onGetUserFailure(LiErrorHandler error) {
					responseCallbackGetUserFinished(uniqueGetUserFinishedID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), null);
				}
				
			});
		}
		
		
		public static void ApplicasaUserGetArrayWithQuery(LiQuery query ,QueryKind queryKind, final int uniqueGetUserArrayFinishedID)
		{
			User.getArrayWithQuery(query, queryKind, new LiUserGetArrayCallback() {

				@Override
				public void onGetUserComplete(List<User> items) {
					responseCallbackGetUserArrayFinished(uniqueGetUserArrayFinishedID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), items);
				}

				@Override
				public void onGetUserFailure(LiErrorHandler error) {
					responseCallbackGetUserArrayFinished(uniqueGetUserArrayFinishedID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
				}
				
			});
		}
		
		public static void ApplicasaUserGetLocalArrayWithRawSqlQuery(String whereClause, final int uniqueGetUserArrayFinishedID)
		{
			User.getLocalyWithRawSQLQuery(whereClause, null, new LiUserGetArrayCallback() {

				@Override
				public void onGetUserComplete(List<User> items) {
					responseCallbackGetUserArrayFinished(uniqueGetUserArrayFinishedID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), items);
				}

				@Override
				public void onGetUserFailure(LiErrorHandler error) {
					responseCallbackGetUserArrayFinished(uniqueGetUserArrayFinishedID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
				}
				
			});
		}
				
		 public static List<User> ApplicasaUserGetArrayWithQuerySync(Object query, int queryKind) {
			try {
			return User.getArrayWithQuery((LiQuery)query, QueryKind.values()[queryKind]);
			} catch (LiErrorHandler e) {
				e.printStackTrace();
				return null;
			}
		}
		
		
		public static void ApplicasaUserFacebookFindFriendsWithBlock(final int uniqueFBFriendsActionID)
		{
			User.getFacebookFriendsWithUser(UnityPlayer.currentActivity, new LiFacebookResponseGetFriends() {

				@Override
				public void onFBError(LiErrorHandler error) {
					responseCallbackFBFriendsAction(uniqueFBFriendsActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null, RequestAction.NONE.ordinal());
				}

				@Override
				public void onGetFriendsResponse(LiObjResponse response,
						List<LiObjFacebookFriends> friends) {
					responseCallbackFBFriendsAction(uniqueFBFriendsActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), friends.size(), friends, response.action.ordinal());
				}
				
			});
		}
		
		public static void ApplicasaUserIncreaseFieldInt(Object user, int fieldInt, String fieldStr, int val) {
			try {
				((User)user).increment((LiFieldUser)ApplicasaCore.getField(fieldInt,fieldStr), val);
			} catch (LiErrorHandler e) {
				e.printStackTrace();
			}
		}
		
		public static void ApplicasaUserIncreaseFieldFloat(Object user, int fieldInt, String fieldStr, float val) {
			try {
				((User)user).increment((LiFieldUser)ApplicasaCore.getField(fieldInt,fieldStr), val);
			} catch (LiErrorHandler e) {
				e.printStackTrace();
			}
		}
		
		public static void ApplicasaUserUploadFile(Object user, Object data, int fieldInt, String fieldStr, int fileType, String extension, final int uniqueActionID) {
			((User)user).updloadFile((LiFieldUser)ApplicasaCore.getField(fieldInt,fieldStr), "", new LiCallbackAction() {
				
				@Override
				public void onFailure(LiErrorHandler error) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", RequestAction.NONE.ordinal());
				}
				
				@Override
				public void onComplete(ApplicasaResponse applicasaResponse, String message,
						RequestAction action, String itemID, LiObject arg4) {
					ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), itemID, action.ordinal());
				}
			});
		}
						
}

