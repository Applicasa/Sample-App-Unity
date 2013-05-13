package com.applicasaunity.Unity;

import com.applicasa.User.User;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;

import applicasa.LiCore.LiErrorHandler;
import applicasa.kit.facebook.LiFacebookResponse.LiFacebookResponseLogin;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;

public class Facebook_Login extends Activity {

	public static int uniqueActionID;
	
	private int CallBackuniqueActionID;
	private boolean success;
	private String errorMessage;
	private int errorType;
	private String itemID;
	private int action;
	
	static {
        System.loadLibrary("Applicasa");
    }
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if(uniqueActionID==0)
			{
				finish();
				return;
			}
		User.loginWithFacebookUserFromActivity(this, new LiFacebookResponseLogin() {

				@Override
				public void onFBError(LiErrorHandler error) {
					CallBackuniqueActionID=uniqueActionID;
					success=false;
					errorMessage=error.errorMessage;
					errorType=ApplicasaResponse.toInt(error.errorType);
					itemID="";
					action=RequestAction.NONE.ordinal();
					Facebook_Login.this.finish();
				}

				@Override
				public void onFBLoginResponse(User user) {
					CallBackuniqueActionID=uniqueActionID;
					success=true;
					errorMessage="Success";
					errorType=ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL);
					itemID="";
					action=RequestAction.NONE.ordinal();
					Facebook_Login.this.finish();
				}
				
			});
		  
		
	}
	
	  @Override
	  public void onActivityResult(int requestCode, int resultCode, Intent data) {
	      User.onActivityResult(this, requestCode, resultCode, data);
	  }
	  
	  @Override
	  protected void onDestroy() {
		  super.onDestroy();
		  if(uniqueActionID==0)
			{
				finish();
				return;
			}
		  ApplicasaCore.responseCallbackAction(CallBackuniqueActionID, success, errorMessage, errorType, itemID, action);
	  }
}
