//Internal Applicasa class
using UnityEngine;
using System.Collections;

public class ApplicasaListener : MonoBehaviour {

	public delegate void delegateApplicasaNotification(string val);
	
	public static event delegateApplicasaNotification ApplicasaNotificationEvent;
	
	
	void Awake () {
		DontDestroyOnLoad (gameObject);
	}
	
	public void methodApplicasaNotification(string val) {
		if(ApplicasaNotificationEvent!=null)
			ApplicasaNotificationEvent(val);
	}
}
