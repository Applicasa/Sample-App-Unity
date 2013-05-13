using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ApplicasaVirtualCurrency : MonoBehaviour {

	// Singleton
	public static ApplicasaVirtualCurrency instance;
	
	//The current user virtual currency balance
	public static int UserVirtualcurrencyBalance=0;
	
	//The current user name
	public static string UserName="Anonymous";
	
	//List of virtual goods buttons
	public List<ButtonVC> m_VirtualCurrencyItems;
	
	//Virtual good button 
	public class ButtonVC{
		public Rect rect;
		public Texture2D texture;
		public string price;
		public Applicasa.VirtualCurrency virtualCurrency;
	}
	
	//image helper
	private static byte[] imageData = null;
	
	#region Get Store
		void Awake ()
		{
			instance = this;
	
			instance.m_VirtualCurrencyItems=new List<ButtonVC>();
			#if UNITY_EDITOR
				DisplayExampleItems();
			#else
				//Load virtual Currencies from Applicasa
				Applicasa.IAP.GetVirtualCurrencies(HandleGetVirtualCurrencies);
				
				//Update User virtual currency balance 
				UpdateVirtualCurrencyBalance ();
		
				//Update User name
				UpdateUserDisplay();
			#endif
		}
		
		//Load virtual goods from Applicasa
		[MonoPInvokeCallback (typeof ( Applicasa.VirtualCurrency.GetVirtualCurrencyArrayFinished))]
		public static void HandleGetVirtualCurrencies (bool success, Applicasa.Error error, Applicasa.VirtualCurrency.VirtualCurrencyArray virtualCurrencyArrayPtr)
		{
			if (success) {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get virtual currencies success");
				Applicasa.VirtualCurrency[] virtualCurrencies = Applicasa.VirtualCurrency.GetVirtualCurrencyArray (virtualCurrencyArrayPtr);
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Virtual currencies item count = " + virtualCurrencies.Length);
				//Load Store Items to list
				instance.StartCoroutine (instance.LoadVirtualCurrencies (virtualCurrencies));
			} else {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get virtual currency error " + error.Id + "-" + error.Message);
			}
		}
		
		//Load Store Items to list
		public IEnumerator LoadVirtualCurrencies (Applicasa.VirtualCurrency[] virtualCurrencies)
		{
			
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Loading " + virtualCurrencies.Length + " virtual currencies");
			m_VirtualCurrencyItems.Clear();
			int count = 0;
			foreach (Applicasa.VirtualCurrency virtualCurrency in virtualCurrencies) {
				
				ButtonVC tempButtonVC = new ButtonVC();
				
				tempButtonVC.price=virtualCurrency.VirtualCurrencyPrice.ToString();
				tempButtonVC.virtualCurrency=virtualCurrency;
				
				Applicasa.FileCache.GetCachedImage(virtualCurrency.VirtualCurrencyImageA, HandleImageData);
				while (imageData == null)
					yield return new WaitForSeconds(0.2f);
				tempButtonVC.texture = new Texture2D(100,100);
				tempButtonVC.texture.LoadImage(imageData);
				
				tempButtonVC.rect=new Rect((itemWidth*count)+(Screen.width*0.02f*(count+1)),Screen.height*0.25f,itemWidth,itemHeight);	
				m_VirtualCurrencyItems.Add(tempButtonVC);
				
				imageData = null;
				count++;
			}
			
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Loaded " + count + " vitrual Currencies");
			yield return null;
		}
	
		//Load Image From Data
		[MonoPInvokeCallback (typeof ( Applicasa.FileCache.GetFileData))]
		private static void HandleImageData(bool success, Applicasa.Error error, Applicasa.FileCache.ByteArray data) {
			if (success) {
				imageData = Applicasa.FileCache.GetByteArray(data);
			} else {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get image error " + error.Id + "-" + error.Message);
				imageData = new byte[0];
			}
		}

	#endregion
	
	#region Purchase
		
		[MonoPInvokeCallback (typeof ( Applicasa.Action))]
		public static void HandleVirtualCurrencyPurchase(bool success, Applicasa.Error error, string itemId, Applicasa.Actions action) {
			if (success) {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Store Purchase success");
				//Update User virtual currency balance 
				UpdateVirtualCurrencyBalance ();
			} else {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Store Purchase error: " + error.Id + "-" + error.Message);
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
		public Texture2D m_Background,m_Back,m_Coins;
		int itemWidth = Mathf.FloorToInt(Screen.height*0.3f);
		int itemHeight = Mathf.FloorToInt(Screen.height*0.3f);
		//For EDITOR Only
		public Texture2D m_ExampleItem;
		
		void OnGUI () {
		
			GUI.depth = 10;
			Rect BackgroundRect = new Rect (
				(Screen.width - Screen.width) * 0.5f,
				(Screen.height - Screen.height) * 0.5f,
				Screen.width,
				Screen.height
			);
			GUI.DrawTexture (BackgroundRect, m_Background);
			GUILayout.BeginArea (BackgroundRect);
			GUILayout.FlexibleSpace ();
		
			foreach(ButtonVC _buttonVC in m_VirtualCurrencyItems) {
				if(GUIButtonTexture2D(_buttonVC.rect,_buttonVC.texture)){
					//BuyVirtualGood when click on item
					Applicasa.IAP.BuyVirtualCurrency(_buttonVC.virtualCurrency, HandleVirtualCurrencyPurchase);
				}
			}
			GUILayout.EndArea ();
			//Back button
			if(GUIButtonTexture2D(new Rect(Screen.height*0.05f,Screen.height*0.85f,Screen.height*0.2f,Screen.height*0.1f),m_Back)){
				Application.LoadLevel("AppStore");
			}
			
			GUI.DrawTexture(new Rect(Screen.height*0.05f,Screen.height*0.05f,15,15),m_Coins);
			//Show User virtual currency balace
			GUI.Label(new Rect(Screen.height*0.15f,Screen.height*0.05f,Screen.width,Screen.height*0.05f),"" + UserVirtualcurrencyBalance.ToString ());	
			//Show User name
			GUI.Label(new Rect(Screen.width*0.85f,Screen.height*0.05f,Screen.width,Screen.height*0.05f),"" + UserName);
		
		}
	
		//For EDITOR Only
		void DisplayExampleItems()
		{		
			for(int count=0;count<3;count++) {
				ButtonVC tempButtonVC = new ButtonVC();
				tempButtonVC.price="0.99";				
				tempButtonVC.texture=m_ExampleItem;
				tempButtonVC.rect=new Rect((itemWidth*count)+(Screen.width*0.02f*(count+1)),Screen.height*0.25f,itemWidth,itemHeight);
				m_VirtualCurrencyItems.Add(tempButtonVC);							
			}
		}
		
		bool GUIButtonTexture2D( Rect r, Texture2D t)
		{
			GUI.DrawTexture( r, t, ScaleMode.StretchToFill);
			return GUI.Button( r, "", "");
		}
		
	#endregion
}
