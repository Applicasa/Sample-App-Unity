using UnityEngine;
using System.Collections;
public class ApplicasaStart : MonoBehaviour {
	
	const string MenuScene = "AppMenu";
	
	void Awake ()
	{	
		DontDestroyOnLoad(this);
	}
	
	private static bool finishedInit=false;
	
	// Use this for initialization
	void Start () {
		//Option 1: Wait to Applicasa init with IAP (IAP = In-App-Purchase)
		StartCoroutine (Applicasa.Manager.initApplicasaIAP(ApplicasaInitDidFinishCallback));
		
		//Option 2: Wait to Applicasa init without IAP
		//StartCoroutine (Applicasa.Manager.initApplicasa(ApplicasaInitDidFinishCallback));
	}
	
	void Update()
	{
    	if(finishedInit)
		{
            Application.LoadLevel(MenuScene);
			finishedInit = false;
		}
#if UNITY_ANDROID
		// when clicking on the back escape button
		if (Input.GetKeyUp(KeyCode.Escape))
			Applicasa.Manager.Stop();
#endif
		
		// Handle Push
		if (Applicasa.PushNotification.PendingNotificationCount() > 0)
		{
			Debug.Log ("LiLog_Unity you have " +Applicasa.PushNotification.PendingNotificationCount()+ " :messages waiting for you ");
						
			/* 
			 //You can loop over the promotions
			for (int i = 0; i <Applicasa.PushNotification.PendingNotificationCount();i++)
			{
				// To pull the messages use 
				PushNotification push = Applicasa.PushNotification.pullMessage(i);
				// do what you want with the received push message
			}
			
			// To clear all the messages use
			Applicasa.PushNotification.ClearRemoteNotifications();
			
			*/
		}
		
	}
	
	// This is the Finish Applicasa init with IAP callback. Note the MonoPInvokeCallback decoration.
	[MonoPInvokeCallback (typeof (Applicasa.Manager.CallbackInitializeIAP))]
	public static  void ApplicasaInitDidFinishCallback (bool success, Applicasa.Error error)
	{		
		if (success) {
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa init Finish ");
			finishedInit = true;
		} else {
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Couldn't initialize Applicasa ");
		}
	}
	#region Analytics
	// Pause and resume the session
	void OnApplicationPause (bool pause)
	{
		if (pause) {
			Applicasa.Session.SessionPause ();
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa Session Paused");
		} else {
			Applicasa.Session.SessionResume ();
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa Session Resumed");
		}
	}
	 
	// End session
	void OnApplicationQuit ()
	{
	
	}
	#endregion
	
	
}
