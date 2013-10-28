using UnityEngine;
using System.Collections;
using Applicasa;
public class ApplicasaMenu : MonoBehaviour {
	// Singleton
	public static ApplicasaMenu instance;
	
	//The current user virtual currency balance
	public static int UserVirtualcurrencyBalance=0;
		
	//The current user name
	public static string UserName = "Anonymous";
	
	        /**
         Instruction to raise custom events.
         The "Egg" sample app implemented custom events that will raise the different ad network possible (TrialPay, MMedia, SupersonicAds, SponsorPay Appnext and Chartboost)

         To raise different AdNetwork just change the name of the variable "customEvent" below.
         use the the following names to raise the different ad network:

         1. TrialPay:
                A. MainCurrency ------------------->OfferwallMainCurrency
                 B. SecondaryCurrency -------------->OfferwallSecondaryCurrency
         2. Millennial Media ------------------>@"MMedia"
         3. SupersonicAds
                 A. SupersonicAds BrandConnect ----->@"SuperSonicBrand"
                 B. SupersonicAds offerwall -------->@"SuperSonic"
         3. SponsorPay
                 A. SponsorPay BrandEngage --------->@"SponsorPayBrand"
                 B. SponsorPay offerwall ----------->@"SponsorPay"
         4.Appnext ---------------------------->@"Appnext"
         5.Chartboost ------------------------->@"Chartboost"
         
         **/
	
	private static string customEvent = "MMedia";
	#region Promotions
		void Start()
		{
			
			// Start handling Promotions - There are two methods of handling promotions (polling the server).
			// The first method is to poll the server with "GetAvailablePromos" 
			// Option1: 
			//Applicasa.PromotionManager.GetAvailablePromos (PromotionCallback);
			
			// The second method is to register a delegate callback to be called when a new promotion is available.
			// Option2: 
			Applicasa.PromotionManager.SetLiKitPromotionDelegateAndCheckPromotions(PromotionsAvailable,true);
		
			// To request supersonic to display demo campaings.
			Applicasa.PromotionManager.ShowDemoCampaigns();
		
			//Update User virtual currency balace
			UpdateVirtualCurrencyBalance ();
		
			//Update User name
			UpdateUserDisplay();
			
		}
	
			
		[MonoPInvokeCallback (typeof (Applicasa.Promotion.GetPromotionArrayFinished))]
		public static void PromotionCallback (bool success, Applicasa.Error error, Applicasa.Promotion.PromotionArray promotionArrayPtr)
		{
			if (success) {
				Applicasa.Promotion[] promotions = Applicasa.Promotion.GetPromotionArray (promotionArrayPtr);
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Got " + promotions.Length + " promotions");
				if (promotions.Length > 0) 
					promotions [0].Show (PromoResult);
			} else {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Couldn't get promotions");
			}
		}
	 
		// Here we get the list of promotions. In this example we just show the first available one (if any).
		[MonoPInvokeCallback (typeof (Applicasa.Promotion.PromotionsAvailable))]
		public static void PromotionsAvailable (Applicasa.Promotion.PromotionArray promotionArrayPtr)
		{
				Applicasa.Promotion[] promotions = Applicasa.Promotion.GetPromotionArray (promotionArrayPtr);
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": " + promotions.Length + " Available promotions");
				if (promotions.Length > 0) 
					promotions [0].Show (PromoResult);
		}
		
		
	    [MonoPInvokeCallback (typeof (Applicasa.ThirdPartyAction.GetThirdPartyActionArrayFinished))]
		public static void GetThirdPartyActionArray(bool success, Applicasa.Error error, Applicasa.ThirdPartyAction[] result)
		{
			UpdateVirtualCurrencyBalance ();
		     Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": GetTrialPayActionArray number of actions = "+(result==null?"0":result.Length.ToString()));
		}
	    // We must provide a callback for the promotion result.
		[MonoPInvokeCallback (typeof (Applicasa.Promotion.PromotionResultDelegate))]
		public static void PromoResult (Applicasa.PromotionAction promoAction, Applicasa.PromotionResult result,  Applicasa.PromotionResultInfo info)
		{
			//Update User virtual currency balace
			Applicasa.ThirdPartyAction.GetThirdPartyActions(GetThirdPartyActionArray);
			UpdateVirtualCurrencyBalance ();
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Got Promotion Result");
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": info is "+info.stringResult);
		}
		
	#endregion
	
	#region Facebook
	
	
		[MonoPInvokeCallback (typeof (Applicasa.Action))]
		public static void FacebookLoginCallback (bool success, Applicasa.Error error, string itemID, Applicasa.Actions action)
		{
			if (success) {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa Logged In");
				UpdateUserDisplay();
				UpdateVirtualCurrencyBalance();
				Application.LoadLevel("AppFacebookScene");
			} else {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Applicasa didn't Log In");
			}
		}
	
	#endregion
	
	
	#region StatusBar
		//Update User virtual currency balance 
		static IEnumerator UpdateVirtualCurrencyBalance ()
		{
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get Current User Main Balance");
			UserVirtualcurrencyBalance = Applicasa.IAP.GetCurrentUserMainBalance ();
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Balance = " + UserVirtualcurrencyBalance);	
			return null;
		}
	    //Update User name 
		static IEnumerator UpdateUserDisplay ()
		{
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get Current User name");
			UserName = Applicasa.User.GetCurrentUser().UserFirstName + " " + Applicasa.User.GetCurrentUser().UserLastName;
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Name = " + UserName);	
			return null;
			
		}
	
	#endregion	
	
	
	#region GUI
		public Texture2D m_Background, m_Play, m_Facebook, m_Store,m_Coins;
	    public Texture2D m_RaisePromotion, m_Egg;

		int buttonWidth = Mathf.FloorToInt(Screen.width/6f);
		int buttonHeight = Mathf.FloorToInt(Screen.height/6f);
	
		void OnGUI ()
		{	
		
			GUI.depth = 10;
			Rect BackgroundRectLeft = new Rect (
				0,
				0,
				Screen.width*0.2f,
				Screen.height
			);
		    Rect BackgroundRectMiddle = new Rect (
				Screen.width*0.2f,
				0,
				Screen.width*0.40f,
				Screen.height
			);
			Rect BackgroundRectRight = new Rect (
				Screen.width*0.6f,
				0,
				Screen.width*0.4f,
				Screen.height
			);
			GUI.DrawTexture (BackgroundRectLeft, m_Background);
			
					
	
		    GUI.DrawTexture (BackgroundRectMiddle, m_Background);
			GUI.DrawTexture (BackgroundRectMiddle, m_Egg);
		
			GUILayout.BeginArea (BackgroundRectMiddle);
			
			GUILayout.FlexibleSpace ();
			GUILayout.FlexibleSpace ();
			
			GUILayout.EndArea ();
		
		
			GUI.DrawTexture (BackgroundRectRight, m_Background);
			GUILayout.BeginArea (BackgroundRectRight);					
		
			GUILayout.FlexibleSpace ();
			//Store button
			GUILayout.FlexibleSpace ();
			if (MenuButton (m_Store)) {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": go to store");
				Application.LoadLevel("AppStore");
			}
			
			GUILayout.FlexibleSpace ();
			//Facebook button
			if (MenuButton (m_Facebook)) {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": FacebookUser=" + Applicasa.User.GetCurrentUser ().UserID.ToString() + "Is Reg?" + Applicasa.User.GetCurrentUser ().UserIsRegisteredFacebook);
				Applicasa.User.FacebookLogin (FacebookLoginCallback);	
			}
		
		   //Raise SponsorPayBrand
			GUILayout.FlexibleSpace ();
			if (MenuButton (m_RaisePromotion)) {
				Applicasa.PromotionManager.RaiseCustomEvent(customEvent);
			}
			GUILayout.FlexibleSpace ();
		//Play button
			if (MenuButton (m_Play)) {
				//Your game here :)

			}

	
			GUILayout.FlexibleSpace ();
			GUILayout.EndArea ();
		
			//Show User name
			GUI.Label(new Rect(Screen.width*0.05f,Screen.height*0.05f,Screen.width,Screen.height*0.05f),"" + UserName);
		
		
			GUI.DrawTexture(new Rect(Screen.height*0.10f,Screen.height*0.1f,15,15),m_Coins);
			//Show User virtual currency balace
			
			GUI.Label(new Rect(Screen.height*0.15f,Screen.height*0.095f,Screen.width,Screen.height*0.05f),"" + UserVirtualcurrencyBalance.ToString ());	
			
		
			

		}
	
		public void FbLogInButtonAction(){
  			Debug.Log("Enter your LogIn code here");
  			Applicasa.User.FacebookLogin(FacebookLoginCallback);
		 }

		
		bool MenuButton (Texture2D icon)
		{
			bool wasPressed = false;
			
			GUILayout.BeginHorizontal ();
			GUILayout.FlexibleSpace ();
			
			Rect rect = GUILayoutUtility.GetRect (buttonWidth, buttonHeight, GUILayout.Width (buttonWidth), GUILayout.Height (buttonHeight));
			
			switch (Event.current.type) {
			case EventType.MouseUp:
				if (rect.Contains (Event.current.mousePosition)) {
					wasPressed = true;
				}
				break;
			case EventType.Repaint:
				GUI.DrawTexture (rect, icon);
				break;
			}
			
			GUILayout.FlexibleSpace ();
			GUILayout.EndHorizontal ();
			
			return wasPressed;
		}
	
	#endregion	
	
	#region push Android
	void OnEnable()
 	{
 	 	Applicasa.PushNotification.ApplicasaPushNotificationEvent+=ApplicasaListenToPush;
 	}
 
 	void OnDisable()
 	{
  		Applicasa.PushNotification.ApplicasaPushNotificationEvent-=ApplicasaListenToPush;
 	}
 
 	void ApplicasaListenToPush(Applicasa.PushNotification thePush)
 	{
  		string message =  thePush.message;
 		Debug.Log ("LiLog_Unity push message " +message);
 	}
	#endregion
	

}
