package com.applicasa.ApplicasaManager;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import applicasa.LiCore.Push.LiPushIntentService;
import applicasa.LiCore.Push.LiPushManager;

public class LiGCMReceiver extends BroadcastReceiver {

	String TAG = "LiGCMReceiver";
	@Override
    public final void onReceive(Context context, Intent intent) {
		Log.w(TAG, "Push Received");

		LiPushManager pushManager = new LiPushManager(intent);
		
		// ring tone file must be located in assets/raw/
		pushManager.setDefaultRingtone(true); 
		// Set Default Ring tone
		pushManager.setDefaultViberation(true);
		
		/**
		 * Select the Activity that will be called when push message received e.g. "MainActivity.class"
		 * @param pushClass
		 * Enter class and remove comment 
		 */
		pushManager.setNotificationClass( LiGCMActivity.class , context.getPackageName());

		
		/** 
		* Sets the specific Icon for the push message
		* remove the Comment
		*/
		pushManager.setIcon(context.getResources().getIdentifier("app_icon", "drawable", context.getPackageName()));
		
		
		pushManager.setStatusBarText("New Message Received");
		pushManager.setMessageTitleText(pushManager.getAlertFromIntent());
		
		LiPushIntentService.runIntentInService(context, intent, pushManager);
        
        setResult(Activity.RESULT_OK, null, null);
    }
}
