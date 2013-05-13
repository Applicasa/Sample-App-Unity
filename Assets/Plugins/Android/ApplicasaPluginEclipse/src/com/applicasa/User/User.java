package com.applicasa.User;
import java.util.ArrayList;
import java.util.List;
import java.util.GregorianCalendar;

import applicasa.LiCore.communication.LiUtility;

import applicasa.LiCore.LiLocation;

import applicasa.LiCore.communication.LiCallback.LiCallbackAction;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiUserGetByIDCallback;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiUserGetArrayCallback;
import com.applicasa.ApplicasaManager.LiManager.LiObject;

import android.database.Cursor;
import applicasa.LiCore.sqlDB.database.LiDbObject;
import applicasa.LiCore.communication.LiRequestConst.QueryKind;
import applicasa.LiCore.communication.LiUtility;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.LiCore.communication.LiObjRequest;
import applicasa.LiCore.communication.LiRequestConst.RequestCallback;
import applicasa.LiCore.communication.LiRequestConst.LiObjResponse;
import applicasa.LiCore.communication.LiFilters;
import applicasa.LiCore.communication.LiQuery;
import applicasa.LiCore.communication.LiFilters.Operation;
import applicasa.LiCore.sqlDB.database.LiCoreDBmanager;
import applicasa.LiJson.LiJSONException;
import applicasa.LiJson.LiJSONObject;


import android.content.Intent;
import applicasa.LiCore.communication.LiCallback;
import applicasa.LiCore.Applicasa;
import applicasa.LiCore.LiLocationCallback;
import applicasa.LiCore.communication.LiCallback.LiCallbackUser;
import applicasa.LiCore.Applicasa.LiSpendingProfile;
import applicasa.LiCore.Applicasa.LiUsageProfile;
import applicasa.LiCore.LiLogger;
import android.app.Activity;
import android.content.Intent;
import android.support.v4.app.Fragment;
import applicasa.kit.facebook.LiFacebookResponse.LiFacebookResponseGetFriends;
import applicasa.kit.facebook.LiFacebookResponse.LiFacebookResponseLogin;
import applicasa.kit.facebook.LiObjFacebookRequest;

public class User extends UserData {
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////													 /////////////////////////////////////////
//////////////////////////////////					    	Save                     /////////////////////////////////////////
//////////////////////////////////													 /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * Saves the Object to Applicasa's Servers
	 * The method saves all of the item's value to the server
	 * If the Object has an ID the operation will update existing object in applicasa's server; otherwise an add operation will be called
	 * 
	 * In Order to Update a specific field Use the method saveFields
	 * @param actionCallback
	 * @return
	 * @throws LiErrorHandler
	 */
	public void save(LiCallbackAction liCallbackAction) 
	{
		LiObjRequest request = new LiObjRequest();
		
		// If Id is of hex representation and not 0, then the itemId is Mongo id
		if (UserID!= "0" && LiUtility.isHex(UserID))
		{
			request.setAction(RequestAction.UPDATE_ACTION);
			request.setRecordID(UserID);
			request.setIncrementedFields(incrementedFields);
			resetIncrementedFields();
		}
		else
		{
			if (liCallbackAction != null)
				liCallbackAction.onFailure(new LiErrorHandler(ApplicasaResponse.RESPONSE_ERROR, "To add A new User Register Request need to be called"));
			return;
		}
		
		request.setClassName(kClassName);
		request.setCallback(callbackHandler);
		request.setEnableOffline(EnableOffline);		
		
		setActionCallback(liCallbackAction,request.requestID);
		// add the Values of the Object Item to the Request
		try
		{
			request.setParametersArrayValue(dictionaryRepresentation(false));
		}catch (LiErrorHandler error)
		{
			if (liCallbackAction != null)
				liCallbackAction.onFailure(error);
				return;
		}
		
		request.startASync();

	}
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                     ///////////////////////////////////////
//////////////////////////////////                           GET                       ///////////////////////////////////////
//////////////////////////////////                                                     ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   

    /**
    * A- Synchronized function which returns an object from server by ID
    * @param ID
    * @return
    * @throws LiErrorHandler
    */
    public static void getByID(String Id, QueryKind queryKind, LiUserGetByIDCallback liUserGetByIDCallback)  
    {
        if (Id != null)
        {
        	// Creates new Query
        	LiQuery query= new LiQuery();
        	
        	// Create a where statement expression of ObjectId = 'id';  
	        LiFilters filter = new LiFilters(LiFieldUser.UserID, Operation.EQUAL, Id);	        
	        query.setFilter(filter);
        	
	    	LiObjRequest request = new LiObjRequest();
	        request.setClassName(kClassName);
	
	        request.setAction(RequestAction.GET_ACTION);
	        request.setGet(queryKind);
	       
	        request.setQueryToRequest(query);
	        request.setCallback(callbackHandler);
	        setGetCallback(liUserGetByIDCallback,request.requestID);
	       
	        request.startASync();
        }
    }

    /**
    * A- Synchronized Method to returns an object from server by filters
    * @param ID
    * @return
    * @throws LiErrorHandler
    */
    public static void getArrayWithQuery(LiQuery query ,QueryKind queryKind, LiUserGetArrayCallback liUserGetArrayCallback) 
    {
        LiObjRequest request = new LiObjRequest();
        request.setClassName(kClassName);
        request.setAction(RequestAction.GET_ARRAY);
        request.setGet(queryKind);
        request.setQueryToRequest(query);
        request.setCallback(callbackHandler);
        setGetCallback(liUserGetArrayCallback,request.requestID);
        request.startASync();
    }
   
	public static void getLocalyWithRawSQLQuery(String whereClause, String[] args, LiUserGetArrayCallback liUserGetArrayCallback)
    {
		LiObjRequest request = new LiObjRequest();
        request.setCallback(callbackHandler);
        setGetCallback(liUserGetArrayCallback,request.requestID);
        request.GetWithRawQuery(kClassName, whereClause, args);
    }
	
	 /** Synchronized Method to returns an object from server by filters
	 * @param ID
	 * @return the list of items or null in case on an error
	 * @throws LiErrorHandler
	 */
	 public static List<User> getArrayWithQuery(LiQuery query ,QueryKind queryKind) throws LiErrorHandler 
	 {
		 LiObjRequest request = new LiObjRequest();
		 request.setClassName(kClassName);
		 request.setAction(RequestAction.GET_ARRAY);
		 request.setGet(queryKind);
		 request.setQueryToRequest(query);
		 LiObjResponse response = request.startSync();
		 
		 if (response.LiRespType.equals(ApplicasaResponse.RESPONSE_SUCCESSFUL))
		 {
		  Cursor cursor = request.getCursor();
		  return buildUserFromCursor(request.requestID, cursor);
		 }
		 
		 return null;
	 }
   
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////												     /////////////////////////////////////////
//////////////////////////////////						Upload File                  /////////////////////////////////////////
//////////////////////////////////													 /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
  /**
  * Method to Upload file 
  * @param liFieldUser - The field to be updated with the file name in Applicasa server 
  * @param filePath - the path to the uploaded file
  * @param userActionCallBack - call back to indicate when the upload was completed
  * @return
  * @throws LiErrorHandler
  */
	public void updloadFile(LiFieldUser liFieldUser, String filePath, LiCallbackAction liCallbackAction) 
	{
		LiObjRequest request = new LiObjRequest();
		
		request.setAction(RequestAction.UPLOAD_FILE);
		request.setClassName(User.kClassName);
		request.setRecordID(UserID);
		
		request.setFileFieldName(liFieldUser);
		request.setFilePath(filePath);
		request.setAddedObject(this);
		request.setCallback(callbackHandler);
		setActionCallback(liCallbackAction,request.requestID);
		
		
		request.startASync();
	}
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////												     /////////////////////////////////////////
//////////////////////////////////					Callback Handler                 /////////////////////////////////////////
//////////////////////////////////												     /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
		
static RequestCallback callbackHandler = new RequestCallback() {
		
		public void onCompleteGet(String requestID, Cursor cursor) {
			// TODO Auto-generated method stub
			List<User> returnList = new ArrayList<User>();

			returnList = buildUserFromCursor(requestID, cursor);

			Object callback = userCallbacks.get(requestID);
			if (callback != null && callback instanceof LiUserGetArrayCallback )
			{
				userCallbacks.remove(requestID);
				((LiUserGetArrayCallback)callback).onGetUserComplete(returnList);
			}
			if (callback != null && callback instanceof LiUserGetByIDCallback )
			{
				userCallbacks.remove(requestID);
				((LiUserGetByIDCallback)callback).onGetUserComplete(returnList.get(0));
			}
			
		}
		
		public void LiException(String requestID,LiErrorHandler ex) {
			// TODO Auto-generated method stub
			Object callback = userCallbacks.get(requestID);
			if (callback != null && callback instanceof LiUserGetArrayCallback )
			{
				userCallbacks.remove(requestID);
				((LiUserGetArrayCallback)callback).onGetUserFailure(ex);
			}
			else if (callback != null && callback instanceof LiUserGetByIDCallback )
			{
				userCallbacks.remove(requestID);
				((LiUserGetByIDCallback)callback).onGetUserFailure(ex);
			}
			else if (callback != null && callback instanceof LiCallbackAction )
			{
				userCallbacks.remove(requestID);
				((LiCallbackAction)callback).onFailure(ex);
			}
		}

		public void onCompleteAction(String requestID, LiObjResponse response) {
			// TODO Auto-generated method stub
			Object callback = userCallbacks.get(requestID);
			if (callback != null )
			{
				userCallbacks.remove(requestID);
				
				if (response.action == RequestAction.ADD_ACTION)
					((User)response.addedObject).UserID = response.newObjID;
				if (response.action == RequestAction.UPLOAD_FILE)
					((User)response.addedObject).setUserFieldbySortType((LiFieldUser)response.field, response.newObjID);
					
				((LiCallbackAction)callback).onComplete(response.LiRespType, response.LiRespMsg, response.action,response.newObjID, LiObject.getLiObject(response.className));
			}
		}
	};
	
	
	 /**
	 * 
	 * @param requestID
	 * @param cursor
	 * @deprecated use buildUserFromCursor
	 * @return
	 */
	@Deprecated
	public static List<User> BuildUserFromCursor(String requestID, Cursor cursor)
	{
		return buildUserFromCursor(requestID, cursor);
	}

	/**
	 * 
	 * @param requestID
	 * @param cursor
	 * @return
	 */
	public static List<User> buildUserFromCursor(String requestID ,Cursor cursor)
	{
		List<User> returnList = new ArrayList<User>();
		if (cursor.getCount() == 0 ) {}// nothing received
		else
		{
			cursor.moveToFirst();
			ArrayList<String> idsList = LiObjRequest.IdsMap.get(requestID);
            ArrayList<String> idsToDelete = new ArrayList<String>();
            
            String id;
            while (!cursor.isAfterLast())
            {
                id = cursor.getString(0);
                if (idsList == null || idsList.contains(id))
                {
                    returnList.add(new User(cursor));                    
                }
                else
                {
                    idsToDelete.add(id);
                }
				cursor.moveToNext();
            }
            if (!idsToDelete.isEmpty())
			{
				LiObjRequest.DeleteUnlistedIds(kClassName,requestID, idsToDelete);
			}
			idsList = null;
			idsToDelete = null;			
		}	
		cursor.close();
		
		return returnList;
		
	}
	
	private static void setGetCallback(LiUserGetByIDCallback userGetByIDCallback, String reqID) {
		// TODO Auto-generated method stub
		userCallbacks.put(reqID,userGetByIDCallback);
	}
	
	private static void setGetCallback(LiUserGetArrayCallback userGetCallback, String reqID) {
		// TODO Auto-generated method stub
		userCallbacks.put(reqID, userGetCallback);
	}

	private static void setActionCallback(LiCallbackAction ActionCallback, String reqID) {
		// TODO Auto-generated method stub
		userCallbacks.put(reqID, ActionCallback);
	}
		

	/** Synchronized Method that updates local storage according to request
	 * @return the item Count, if count of 1500 is the max number of values returned by the server.
	 * @throws LiErrorHandler
	 */
	 public static int updateLocalStorage(LiQuery query ,QueryKind queryKind) throws LiErrorHandler 
	 {
		 int recordsCount = 0;
		 LiObjRequest request = new LiObjRequest();
		 request.setClassName(kClassName);
		 request.setAction(RequestAction.GET_ARRAY);
		 request.setGet(queryKind);
		 request.setQueryToRequest(query);
		 LiObjResponse response = request.startSync();
		 
		 if (response.LiRespType.equals(ApplicasaResponse.RESPONSE_SUCCESSFUL))
		 {
			 Cursor cursor = request.getCursor();
			 if(cursor == null)
				return 0;
				
			 if (queryKind.compareTo(QueryKind.PAGER) != 0)
			 {
				 deleteItems(request.requestID,cursor);
			 }
			 
			 recordsCount = cursor.getCount();
			 cursor.close();
			 cursor = null;
		 }
		 
		 return recordsCount;
	 }
	 
	 public static void deleteItems(final String requestID ,final Cursor cursor)
	 {
		 new Thread(new Runnable() {
			
			public void run() {
					// TODO Auto-generated method stub
					if (cursor == null || cursor.getCount() == 0 ) {}// nothing received
					else
					{
						cursor.moveToFirst();
						ArrayList<String> idsList = LiObjRequest.IdsMap.get(requestID);
						ArrayList<String> idsToDelete = new ArrayList<String>();
						
						String id;
						while (!cursor.isAfterLast())
						{
							id = cursor.getString(0);
							if (idsList != null && !idsList.contains(id))
							{
								idsToDelete.add(id);
							}
							cursor.moveToNext();
						}
						if (!idsToDelete.isEmpty())
						{
							LiObjRequest.DeleteUnlistedIds(kClassName,requestID, idsToDelete);
						}
						idsList = null;
						idsToDelete = null;			
					}
				}
			}).run();
		}
 /** End of Basic SDK **/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                        ////////////////////////////////////
//////////////////////////////////                     Facebook functions                 ////////////////////////////////////
//////////////////////////////////                                                        ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/**
     * login user to facebook
     * @param activity
     * @param liFacebookResponse
     */
    public static void loginWithFacebookUserFromActivity(Activity activity, LiFacebookResponseLogin liFacebookResponse)
    {
        LiObjFacebookRequest request = new LiObjFacebookRequest();
        
        request.setAction(RequestAction.LOGIN_WITH_FB);
        request.setClassName(kClassName);
        
        request.setFacebookCallback(liFacebookResponse);
        request.startFacebookRequest(activity);
    }
    
    /**
     * login user to facebook
     * @param Fragment
     * @param liFacebookResponse
     */
    public static void loginWithFacebookUserFromFragment(Fragment fragment, LiFacebookResponseLogin liFacebookResponse)
    {
        LiObjFacebookRequest request = new LiObjFacebookRequest();
        
        request.setAction(RequestAction.LOGIN_WITH_FB);
        request.setClassName(kClassName);
        
        request.setFacebookCallback(liFacebookResponse);
        request.startFacebookRequest(fragment);
    }
    
    /**
     * Returns fb user's friends list
     * @param activity - in case there's a need to prompt login web view
     * @param liFacebookResponse
     */
    public static void getFacebookFriendsWithUser(Activity activity,LiFacebookResponseGetFriends liFacebookResponse)
    {
        LiObjFacebookRequest request = new LiObjFacebookRequest();
        
        request.setAction(RequestAction.GET_FACEBOOK_FRIENDS);
        request.setClassName(kClassName);
        
        request.setFacebookCallback(liFacebookResponse);
        request.startFacebookRequest(activity);
    }
    
 

	/**
   * method to Handle Fb activity result 
   * @param requestCode
   * @param resultCode
   * @param data
   */
  public static void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data)
  {
		Applicasa.onActivityResult(activity, requestCode, resultCode, data);
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////                                                   ////////////////////////////////////////
///////////////////////////////////                             User                  ////////////////////////////////////////
///////////////////////////////////                                                   ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
    * Login user with User Name and Password
    * Use method loginUser
    */
  	@Deprecated
    public static void logInUserWithUserName(String UserName, String UserPassword, LiCallbackUser liCallbackUser)
    {
  		loginUser( UserName,  UserPassword,  liCallbackUser);
    }
    
  	/**
     * Login user with User Name and Password
     * @param UserName
     * @param UserPassword
     * @return
     * @throws LiErrorHandler
     * Use method logInUser
     */
    public static void loginUser(String UserName, String UserPassword, LiCallbackUser liCallbackUser)  
    {
        if (UserName == null || UserName =="" || UserPassword == null ) 
        {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.LOGIN_USER, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
        LiObjRequest request = new LiObjRequest();
        request.setAction(RequestAction.LOGIN_USER);
        request.setClassName(kClassName);
        try {
            request.addParametersArrayValue(LiObjRequest.POST_USER_NAME, UserName);
            request.addParametersArrayValue(LiObjRequest.POST_USER_PASS, UserPassword);
        } catch (LiErrorHandler e) {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.LOGIN_USER, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
        request.setCallback(liCallbackUser);
    
        request.startASync();
    }

    /** 
    * Register a User, adds Password and other information
    * @param item
    */
    public void registerUser(String username, String password, LiCallbackUser liCallbackUser) 
    {
        if (username== null || username =="" || password == null ) 
        {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.REGISTER_USER, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
    
        LiObjRequest request = new LiObjRequest();
        request.setAction(RequestAction.REGISTER_USER);
        request.setClassName(kClassName);
      
        try {
             //Add other UserData to Paramentes Array
            request.setParametersArrayValue(dictionaryRepresentation(false));
            request.addParametersArrayValue(LiObjRequest.POST_USER_NAME, username);
            request.addParametersArrayValue(LiObjRequest.POST_USER_PASS, password);
        } catch (LiErrorHandler e) {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.REGISTER_USER, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
        
        request.setCallback(liCallbackUser);
    
        request.startASync();
    }

      /**
    * Update user's UserName from input new username and  current password
    * @param UserName
    * @param newUserName
    * @return
    */
    public static void updateUserame(String newUserName, String UserPassword, LiCallbackUser liCallbackUser) 
    {
        if (newUserName== null || newUserName =="" || UserPassword == null ) 
        {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.UPDATE_USER_USERNAME, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
    
    
        LiObjRequest request = new LiObjRequest();
        request.setAction(RequestAction.UPDATE_USER_USERNAME);
        request.setClassName(kClassName);
        
        try {
            request.addParametersArrayValue(LiObjRequest.POST_USER_NAME_NEW, newUserName);
            request.addParametersArrayValue(LiObjRequest.POST_USER_PASS, UserPassword);
        } catch (LiErrorHandler e) {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.UPDATE_USER_USERNAME, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
        request.setCallback(liCallbackUser);
        request.startASync();
    }


    /**
    * Update user's Password to given password
    * @param UserPassword
    * @return
    */
    public static void updateUserPassword(String UserPassword, String newUserPassword, LiCallbackUser liCallbackUser)
    {
        if (UserPassword == null || newUserPassword == null ) 
        {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.UPDATE_USER_PASSWORD, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
    
        LiObjRequest request = new LiObjRequest();
        request.setAction(RequestAction.UPDATE_USER_PASSWORD);
        request.setClassName(kClassName);
                
        try {
            request.addParametersArrayValue(LiObjRequest.POST_USER_PASS,UserPassword);
            request.addParametersArrayValue(LiObjRequest.POST_USER_PASS_NEW,newUserPassword);
        } catch (LiErrorHandler e) {
            if (liCallbackUser!= null)
                liCallbackUser.onFailure(RequestAction.UPDATE_USER_USERNAME, new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR));
            return;
        }
        
        request.setCallback(liCallbackUser);
        request.startASync();
    }

    /**
    * Logout user and set new User given from server
    * @return
    */
    public static void logoutUser( LiCallbackUser liCallbackUser) 
    {
        LiObjRequest request = new LiObjRequest();
        request.setAction(RequestAction.LOGOUT_USER);
        request.setClassName(kClassName);
        request.setCallback(liCallbackUser);
        request.startASync();
      
    }
    
	/**
     * Sends email to this user with a new password
     * @param username
     * @param liCallbackUser
     */
    public static void forgotPassword(String username, LiCallbackUser liCallbackUser) 
    {
        LiObjRequest request = new LiObjRequest();
        request.setAction(RequestAction.FORGOT_PASSWORD);
        request.setClassName(kClassName);
        try {
				request.addParametersArrayValue(LiFieldUser.UserName, username);
		} catch (LiErrorHandler error) {
			// TODO Auto-generated catch block
			if (liCallbackUser!= null)
			{
				liCallbackUser.onFailure(RequestAction.FORGOT_PASSWORD, error);
				return;
			}
		}
		request.setCallback(liCallbackUser);
        request.startASync();
    }
	
	/**
    * @return the current User
    */
    public static User getCurrentUser()
    {
		return Applicasa.getCurrentUser();
    }
	
	/**
    * Register User To GCM
    */
    public static void RegisterToGCM()
    {
		Applicasa.registerToGCM();
    }
    
    /**
    * UnRegister User To GCM
    */
    public static void UnRegisterFromGCM()
    {
		Applicasa.unRegisterFromGCM();
    }
	
	public static LiSpendingProfile getCurrentUserSpendingProfile()
	{
		return Applicasa.getUserSpendingProfile();
	}
	 
	public static LiUsageProfile getCurrentUserUsageProfile()
	{
		return Applicasa.getUserUsageProfile();
	}

	/**
    * 
    * @return true if user is register to GCM, otherwise false.
    */
    public static boolean isRegisterToGCM()
    {
    	return Applicasa.isRegisterToGCM();
    }
 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////                                                   ////////////////////////////////////////
///////////////////////////////////                    Init Method                    ////////////////////////////////////////
///////////////////////////////////                    Don't ALTER                    ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public User()
	{
		this.UserID = "0";
		this.UserName = "";
		this.UserFirstName = "";
		this.UserLastName = "";
		this.UserEmail = "";
		this.UserPhone = "";
		this.UserPassword = "";
		(this.UserLastLogin = new GregorianCalendar()).setTimeInMillis(0);
		(this.UserRegisterDate = new GregorianCalendar()).setTimeInMillis(0);
		this.UserLocation = new LiLocation(0, 0);
		this.UserIsRegistered = false;
		this.UserIsRegisteredFacebook = false;
		(this.UserLastUpdate = new GregorianCalendar()).setTimeInMillis(0);
		this.UserImage = "";
		this.UserMainCurrencyBalance = 0;
		this.UserSecondaryCurrencyBalance = 0;
		this.UserFacebookID = "";
	}

	public User(Cursor cursor) 
	{
		initWithCursor(cursor);
	}
	
	public User(Cursor cursor,String header,int level) 
	{
		initWithCursor(cursor,header,level);
	}
	
	public User(String UserID)
	{
		this.UserID = UserID;
	}

	/**
	* Init Object with Cursor
	* @param corsor
	* @return
	*/
	public User initWithCursor(Cursor cursor)
	{
		return initWithCursor(cursor,"",0);
	}
	
	/**
	* Init Object with Cursor
	* @param corsor
	* @return
	*/
	public User initWithCursor(Cursor cursor,String header,int level)
	{
		int columnIndex;
	
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserID.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserID = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserName.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserName = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserFirstName.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserFirstName = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserLastName.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserLastName = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserEmail.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserEmail = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserPhone.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserPhone = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserLastLogin.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			long dateStr = cursor.getLong(columnIndex);
			GregorianCalendar gc= new GregorianCalendar();
			gc.setTimeInMillis(dateStr);
			this.UserLastLogin = gc;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserRegisterDate.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			long dateStr = cursor.getLong(columnIndex);
			GregorianCalendar gc= new GregorianCalendar();
			gc.setTimeInMillis(dateStr);
			this.UserRegisterDate = gc;
		}
		
		float Longitude = 0, Latitude  = 0;
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserLocation.toString()+"Long");
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			 Longitude= cursor.getFloat(columnIndex);
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserLocation.toString()+"Lat");
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			 Latitude= cursor.getFloat(columnIndex);
		this.UserLocation = new LiLocation(Longitude, Latitude);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserIsRegistered.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.UserIsRegistered = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserIsRegisteredFacebook.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			this.UserIsRegisteredFacebook = cursor.getInt(columnIndex)==1?true:false;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserLastUpdate.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
		{
			long dateStr = cursor.getLong(columnIndex);
			GregorianCalendar gc= new GregorianCalendar();
			gc.setTimeInMillis(dateStr);
			this.UserLastUpdate = gc;
		}
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserImage.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserImage = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserMainCurrencyBalance.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserMainCurrencyBalance = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiFieldUser.UserSecondaryCurrencyBalance.toString());
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserSecondaryCurrencyBalance = cursor.getInt(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiObjRequest.UserFacebookID);
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.UserFacebookID = cursor.getString(columnIndex);
		
		columnIndex = cursor.getColumnIndex(header + LiObjRequest.DistanceFromCurrent);
		if (columnIndex != LiCoreDBmanager.COLUMN_NOT_EXIST)
			this.DistanceFromCurrent = LiUtility.convertPartialDistanceToKm(cursor.getDouble(columnIndex));
		
	
		return this;
	}
	
	/**
	* Initialize values with Object
	* @param item
	* @return
	*/
	public String initWithObject(User item)
	{
		this.UserID			= item.UserID;
		this.UserName			= item.UserName;
		this.UserFirstName			= item.UserFirstName;
		this.UserLastName			= item.UserLastName;
		this.UserEmail			= item.UserEmail;
		this.UserPhone			= item.UserPhone;
		this.UserPassword			= item.UserPassword;
		this.UserLastLogin			= item.UserLastLogin;
		this.UserRegisterDate			= item.UserRegisterDate;
		this.UserLocation			= item.UserLocation;
		this.UserIsRegistered			= item.UserIsRegistered;
		this.UserIsRegisteredFacebook			= item.UserIsRegisteredFacebook;
		this.UserLastUpdate			= item.UserLastUpdate;
		this.UserImage			= item.UserImage;
		this.UserMainCurrencyBalance			= item.UserMainCurrencyBalance;
		this.UserSecondaryCurrencyBalance			= item.UserSecondaryCurrencyBalance;
		this.UserFacebookID			= item.UserFacebookID;
	
		return UserID;
	}
	
	/**
	* Function to add the given object fields to the request parameters list
	* @param item
	* @param request
	* @return
	*/
/**
* Initialize Dictionary with User item instance
* @param dictionary
* @return
*/
public LiJSONObject dictionaryRepresentation(boolean withFK) throws LiErrorHandler {

	try{
		LiJSONObject dictionary = new LiJSONObject();
		dictionary.put(LiFieldUser.UserID, UserID);
	
		dictionary.put(LiFieldUser.UserName, UserName);
	
		dictionary.put(LiFieldUser.UserFirstName, UserFirstName);
	
		dictionary.put(LiFieldUser.UserLastName, UserLastName);
	
		dictionary.put(LiFieldUser.UserEmail, UserEmail);
	
		dictionary.put(LiFieldUser.UserPhone, UserPhone);
	
		dictionary.put(LiFieldUser.UserLastLogin, LiUtility.convertDateToDictionaryRepresenataion(UserLastLogin));
	
		dictionary.put(LiFieldUser.UserRegisterDate, LiUtility.convertDateToDictionaryRepresenataion(UserRegisterDate));
	
		dictionary.put(LiFieldUser.UserLocation, UserLocation.getJsonArrayRepresentation());
	
		dictionary.put(LiFieldUser.UserIsRegistered, UserIsRegistered);
	
		dictionary.put(LiFieldUser.UserIsRegisteredFacebook, UserIsRegisteredFacebook);
	
		dictionary.put(LiFieldUser.UserLastUpdate, LiUtility.convertDateToDictionaryRepresenataion(UserLastUpdate));
	
		dictionary.put(LiFieldUser.UserImage, UserImage);
	
		dictionary.put(LiFieldUser.UserMainCurrencyBalance, UserMainCurrencyBalance);
	
		dictionary.put(LiFieldUser.UserSecondaryCurrencyBalance, UserSecondaryCurrencyBalance);
	
		dictionary.put(LiObjRequest.UserFacebookID, UserFacebookID);
		return dictionary;
		}
		catch (LiJSONException ex)
		{
			throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR, ex.getMessage());
		}
	}
	
	public static LiDbObject createDB() throws LiJSONException{
		LiDbObject dbObject = new LiDbObject();
		dbObject.put("LiClassName", kClassName);
		dbObject.put(LiFieldUser.UserID, LiCoreDBmanager.PRIMARY_KEY,-1);
		dbObject.put(LiFieldUser.UserName, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldUser.UserFirstName, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldUser.UserLastName, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldUser.UserEmail, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldUser.UserPhone, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldUser.UserLastLogin, LiCoreDBmanager.DATE,0);
		dbObject.put(LiFieldUser.UserRegisterDate, LiCoreDBmanager.DATE,0);
		dbObject.put(LiFieldUser.UserLocation, LiCoreDBmanager.LOCATION,"[0,0]");
		dbObject.put(LiFieldUser.UserIsRegistered, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldUser.UserIsRegisteredFacebook, LiCoreDBmanager.BOOL,false);
		dbObject.put(LiFieldUser.UserLastUpdate, LiCoreDBmanager.DATE,0);
		dbObject.put(LiFieldUser.UserImage, LiCoreDBmanager.TEXT,"");
		dbObject.put(LiFieldUser.UserMainCurrencyBalance, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiFieldUser.UserSecondaryCurrencyBalance, LiCoreDBmanager.INTEGER,0);
		dbObject.put(LiObjRequest.UserFacebookID, LiCoreDBmanager.TEXT);
	return dbObject;
}
	public void increment(LiFieldUser liFieldUser) throws LiErrorHandler
	{
		increment(liFieldUser, 1);
	}
		 
	public void increment(LiFieldUser liFieldUser, Object value) throws LiErrorHandler
	{
		if (liFieldUser.equals(LiFieldUser.UserMainCurrencyBalance) || liFieldUser.equals(LiFieldUser.UserSecondaryCurrencyBalance) )
		{
			LiLogger.logWarning(kClassName, "Can't Increase User balance using Increment Method. please use LiStore class");
			return;
		}
		String key = liFieldUser.toString();
		float oldValueFloat = 0;
		int oldValueInt = 0;
		Object incrementedField = getUserFieldbySortType(liFieldUser);
		try {
			if (incrementedField instanceof Integer)
			{
				int incInt;
				if (value instanceof Integer)
					incInt = (Integer)value;
				else
					 throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR, "Incremented Value isn't of the same type as the requested field");
				int total = (Integer)incrementedField+incInt;
				setUserFieldbySortType(liFieldUser, total);
				if (incrementedFields.has(liFieldUser.toString()))
					oldValueInt = (Integer)incrementedFields.remove(key);
	
				incrementedFields.put(key, (oldValueInt+incInt));
			}
			else if (incrementedField instanceof Float)
			{
				float incFloat;
				 if (value instanceof Float)
					incFloat = (Float)value;
				 else
					incFloat = Float.valueOf((Integer)value);
				float total = (Float)incrementedField+incFloat;
				setUserFieldbySortType(liFieldUser, total);
					if (incrementedFields.has(liFieldUser.toString()))
						oldValueFloat = (Float)incrementedFields.remove(key);
				incrementedFields.put(key, (oldValueFloat+incFloat));
			}
			else
				throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR,"Can't increase, Specified field is not Int or Float");
		} catch (LiJSONException e) {
			// TODO Auto-generated catch block
			throw new LiErrorHandler(ApplicasaResponse.INPUT_VALUES_ERROR,"Can't increase, Recheck inserted Values");
		}
	}
		 
	private void resetIncrementedFields() {
		// TODO Auto-generated method stub
		incrementedFields = new LiJSONObject();
	}
	

}
