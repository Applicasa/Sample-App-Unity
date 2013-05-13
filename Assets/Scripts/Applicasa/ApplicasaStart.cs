using UnityEngine;
using System.Collections;

public class ApplicasaStart : MonoBehaviour {
	
	const string MenuScene = "AppMenu";
	
	void Awake ()
	{	
		DontDestroyOnLoad(this);
	}
	
	// Use this for initialization
	void Start () {
		//Option 1: Wait to Applicasa init with IAP (IAP = In-App-Purchase)
		StartCoroutine (Applicasa.Manager.initApplicasaIAP(ApplicasaInitDidFinishCallback));
		//Option 2: Wait to Applicasa init without IAP
		//StartCoroutine (Applicasa.Manager.initApplicasa(ApplicasaInitDidFinishCallback));
	}
	
	
	// This is the Finish Applicasa init with IAP callback. Note the MonoPInvokeCallback decoration.
	[MonoPInvokeCallback (typeof (Applicasa.Manager.CallbackInitialize))]
	public static void ApplicasaInitDidFinishCallback (bool success, Applicasa.Error error)
	{
		if (success) {
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa init Finish ");
			Application.LoadLevel(MenuScene);
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
			Applicasa.Session.SessionEnd ();
			Debug.Log("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa Session Ended");
		}
	#endregion
	
	
}
