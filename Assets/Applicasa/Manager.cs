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
  private static extern float saveCallbackIAP(CallbackInitialize _CallbackInitialize, CallbackInitializeIAP _CallbackInitializeIAP);
  
  [DllImport("Applicasa")]
  private static extern void closeApplicasa();
  
  public static IEnumerator initApplicasa(CallbackInitialize _callbackInitialize) {
#if UNITY_ANDROID   
   saveCallback(_callbackInitialize);  
   using(AndroidJavaClass javaUnityApplicasa = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaLiManager"))
    javaUnityApplicasa.CallStatic("initialize");
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
#else
   _callbackInitializeIAP(true, new Error());
#endif
   yield return null;
  }
  
  public static void Stop() {
#if UNITY_ANDROID && !UNITY_EDITOR
   closeApplicasa();
#endif
  }
 }
}