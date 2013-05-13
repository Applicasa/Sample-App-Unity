package com.applicasaunity.Unity;

import android.content.Context;
import android.os.Handler;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiObjRequest.LiCallbackInitialize;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPInitialize;
import com.applicasa.ApplicasaManager.LiManager;
import com.unity3d.player.UnityPlayer;

public class ApplicasaLiManager  {
	
    static {
        System.loadLibrary("Applicasa");
    } 
	
	public static Context _context;
	
	public static Handler mainHandler;
	
	public static Runnable myRunnable;
	
	//native response calls
	public native static void responseCallbackInit(boolean success, String errorMessage, int errorType);
	public native static void responseCallbackIAP(boolean success, String errorMessage, int errorType);

	
	public static void initialize()
	{
		_context=UnityPlayer.currentActivity;
		// Get a handler that can be used to post to the main thread
		mainHandler = new Handler(_context.getMainLooper());
		myRunnable = new Runnable() {
			
			@Override
			public void run() {
				LiManager.initialize(_context, new LiCallbackInitialize() {
					@Override
					public void onFailure(LiErrorHandler error) {
						responseCallbackInit(false, error.errorMessage, ApplicasaResponse.toInt(error.errorType));//,obj);
					}
					
					@Override
					public void onCompleteInitialize() {
						responseCallbackInit(true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL));//,obj);
					}
				});
			}
		};
		mainHandler.post(myRunnable);
	}
	
	public static void initialize(Context context, boolean iap, final Object obj) 
	{
		_context=context;
		// Get a handler that can be used to post to the main thread
		Handler mainHandler = new Handler(_context.getMainLooper());
		
		Runnable myRunnable = new Runnable() {
					
			@Override
			public void run() {
				LiManager.initialize(_context, new LiCallbackInitialize() {
					
					@Override
					public void onFailure(LiErrorHandler error) {
						responseCallbackInit(false, error.errorMessage, ApplicasaResponse.toInt(error.errorType));//,obj);
					}
					
					@Override
					public void onCompleteInitialize() {
						responseCallbackInit(true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL));//,obj);
					}
				}, new LiCallbackIAPInitialize() {
					
					@Override
                     public void onSuccessfullyInit() {
                        responseCallbackIAP(true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL));
                    }
					
					@Override
					public void errorReceiver(String errorStr, LiErrorHandler error) {
						responseCallbackIAP(false, error.errorMessage, ApplicasaResponse.toInt(error.errorType));
					}
				});	
			}
		};
		mainHandler.post(myRunnable);
	}

}
