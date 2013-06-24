using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
 public class Manager {
  public delegate void CallbackInitialize(bool success, Error error);
  public delegate void CallbackInitializeIAP(bool success, Error error);
  
  [DllImport("Applicasa")]
  private static extern float saveCallback(CallbackInitialize _CallbackInitialize);
  [DllImport("Applicasa")]
  private static extern float saveCallback(CallbackInitializeIAP _CallbackInitialize);
  
  [DllImport("Applicasa")]
  private static extern float saveCallbackIAP(CallbackInitialize _CallbackInitialize, CallbackInitializeIAP _CallbackInitializeIAP);
  
  [DllImport("Applicasa")]
  private static extern void closeApplicasa();
  
  public static IEnumerator initApplicasa(CallbackInitialize _callbackInitialize) {
#if UNITY_ANDROID && !UNITY_EDITOR  
   saveCallback(_callbackInitialize);  
   using(AndroidJavaClass javaUnityApplicasa = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiManager"))
    javaUnityApplicasa.CallStatic("initialize");
    initPushListener();
#elif UNITY_IPHONE && !UNITY_EDITOR
   while (!Applicasa.Core.isDoneLoading()) {
    yield return new WaitForSeconds(0.2f);
   }
   _callbackInitialize(true, new Error());
#else
   _callbackInitialize(true, new Error());
#endif
   yield return null;
  }
  
  public static IEnumerator initApplicasaIAP(CallbackInitializeIAP _callbackInitializeIAP) {
#if UNITY_IPHONE && !UNITY_EDITOR
   while (Applicasa.Core.IAPStatus() == Applicasa.IAP_STATUS.RUNNING) {
    yield return new WaitForSeconds(0.2f);
   }
   if (Applicasa.Core.IAPStatus() == Applicasa.IAP_STATUS.SUCCESS)
    _callbackInitializeIAP(true, new Error());
   else
    _callbackInitializeIAP(false, new Error());
#elif UNITY_ANDROID && !UNITY_EDITOR	
	saveCallback(_callbackInitializeIAP);  
    using(AndroidJavaClass javaUnityApplicasa = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiManager"))
    javaUnityApplicasa.CallStatic("initialize");
    initPushListener();
#else
	_callbackInitializeIAP(true, new Error());
#endif
   yield return null;
  }
  
  public static void Stop() {
#if UNITY_ANDROID && !UNITY_EDITOR
	 Applicasa.Session.SessionEndWithCallback(SessionEndCallback);	
	 ApplicasaListener.ApplicasaNotificationEvent-=Applicasa.PushNotification.methodApplicasaPushNotification;
    
#endif
  }
		
		
#if UNITY_ANDROID && !UNITY_EDITOR  
	
	public static void SessionEndCallback(bool success, Error error, System.IntPtr userPtr)
	{
		closeApplicasa();
		Application.Quit();
	}
		
	public static IEnumerator finishedSynchOfflineOperation(CallbackInitialize _callbackInitialize) {
   saveCallback(_callbackInitialize);  
   using(AndroidJavaClass javaUnityApplicasa = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiManager"))
   javaUnityApplicasa.CallStatic("setFinishSyncOfflineOperation");   
    yield return null;
   }

	// Register for push notification while the app is running
	private static ApplicasaListener m_applicasaListenerGameObject;
	private static void initPushListener()
	{
		if(!m_applicasaListenerGameObject)
		{
				m_applicasaListenerGameObject=Object.FindObjectOfType(typeof(ApplicasaListener)) as ApplicasaListener;
		}
		if(!m_applicasaListenerGameObject)
		{
			GameObject temp=new GameObject();
			temp.AddComponent(typeof(ApplicasaListener));
			m_applicasaListenerGameObject=temp.GetComponent(typeof(ApplicasaListener)) as ApplicasaListener;
		}
			m_applicasaListenerGameObject.gameObject.name="ApplicasaNotificationsListenerGameObject";
		ApplicasaListener.ApplicasaNotificationEvent+=Applicasa.PushNotification.methodApplicasaPushNotification;
	 }

 #elif UNITY_IPHONE && !UNITY_EDITOR 
 public static IEnumerator finishedSynchOfflineOperation(CallbackInitialize _callbackInitialize) {
		_callbackInitialize(true, new Error());
		yield return null;
 } 
 
 private static ApplicasaListener m_applicasaListenerGameObject;
  private static void initPushListener()
	{
	
	}
#else
  public static IEnumerator finishedSynchOfflineOperation(CallbackInitialize _callbackInitialize) {
		_callbackInitialize(true, new Error());
		yield return null;
 } 
 
 private static ApplicasaListener m_applicasaListenerGameObject;
private static void initPushListener()
{
	
}
	
#endif
  }
}
