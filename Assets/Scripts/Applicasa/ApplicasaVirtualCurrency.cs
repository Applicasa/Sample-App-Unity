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
	
	private int itemsCount = 0;
	
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
	    }
		void Start () {
		    Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Start");
			instance.m_VirtualCurrencyItems=new List<ButtonVC>();
			#if UNITY_EDITOR
				DisplayExampleItems();
			#else
				//Update User virtual currency balance 
				UpdateVirtualCurrencyBalance ();
		
				//Update User name
				UpdateUserDisplay();
		
				//Load virtual Currencies from Applicasa
				Applicasa.IAP.GetVirtualCurrencies(HandleGetVirtualCurrencies);
				
			
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
			foreach (Applicasa.VirtualCurrency virtualCurrency in virtualCurrencies) {
				
				ButtonVC tempButtonVC = new ButtonVC();
				
				tempButtonVC.price=virtualCurrency.LocalPrice;
				tempButtonVC.virtualCurrency=virtualCurrency;
				
				Applicasa.FileCache.GetCachedImage(virtualCurrency.VirtualCurrencyImageA, HandleImageData);
				while (imageData == null)
					yield return new WaitForSeconds(0.2f);
				tempButtonVC.texture = new Texture2D(100,100);
				tempButtonVC.texture.LoadImage(imageData);
				
				tempButtonVC.rect=new Rect((itemWidth*itemsCount)+(Screen.width*0.02f*(itemsCount+1)),Screen.height*0.25f,itemWidth,itemHeight);	
				m_VirtualCurrencyItems.Add(tempButtonVC);
				imageData = null;
				itemsCount++;
			}
			
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Loaded " + itemsCount.ToString() + " vitrual Currencies and m_VirtualCurrencyItems.Count= "+m_VirtualCurrencyItems.Count.ToString());
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
		int itemWidth = Mathf.FloorToInt(Screen.width/7f);
		int itemHeight = Mathf.FloorToInt(Screen.height/6f);
	     public Vector2 scrollPosition = new Vector2(0,1000);
	
		//For EDITOR Only
		public Texture2D m_ExampleItem;
		
		void OnGUI () {
		
			GUI.depth = 10;
			Rect BackgroundRect = new Rect (
				0,
				0,
				Screen.width,
				Screen.height
			);
		   
			GUI.DrawTexture (BackgroundRect, m_Background);
			GUILayout.BeginArea (BackgroundRect);
			GUILayout.FlexibleSpace ();
		   
			if (itemsCount > m_VirtualCurrencyItems.Count/3){
				float length = m_VirtualCurrencyItems.Count*itemWidth ;
		    	scrollPosition = GUI.BeginScrollView (new Rect (Screen.width*0.02f,Screen.height*0.3f,Screen.width*0.98f,itemHeight*2), 
		 		scrollPosition, new Rect (10, Screen.height*0.3f-itemHeight, length, 50),true,false);
		
				foreach(ButtonVC _buttonVC in m_VirtualCurrencyItems) {
					GUI.Label(new Rect (_buttonVC.rect.x+itemWidth/2-15, _buttonVC.rect.y+itemHeight, 100, 50), _buttonVC.price );

					if(GUIButtonTexture2D(_buttonVC.rect,_buttonVC.texture)){
					//BuyVirtualGood when click on item
						Applicasa.IAP.BuyVirtualCurrency(_buttonVC.virtualCurrency, HandleVirtualCurrencyPurchase);
					}
				}
		    	GUI.EndScrollView ();
				GUILayout.EndArea ();
			}
			else{
				Debug.Log ("LiLog_Unity itemsCount =" + itemsCount.ToString() + "!=  m_VirtualGoodItems.Count "+m_VirtualCurrencyItems.Count.ToString());
			}
		
		// End the scroll view that we began above.
		
		
		
			//Back button
			if(GUIButtonTexture2D(new Rect(Screen.height*0.05f,Screen.height*0.85f,Screen.height*0.2f,Screen.height*0.1f),m_Back)){
				Application.LoadLevel("AppStore");
			}
			
			//Show User name
			GUI.Label(new Rect(Screen.width*0.05f,Screen.height*0.05f,Screen.width,Screen.height*0.05f),"" + UserName);
		
		
			GUI.DrawTexture(new Rect(Screen.height*0.10f,Screen.height*0.1f,15,15),m_Coins);
			//Show User virtual currency balace
			
			GUI.Label(new Rect(Screen.height*0.15f,Screen.height*0.095f,Screen.width,Screen.height*0.05f),"" + UserVirtualcurrencyBalance.ToString ());	
		
		}
	
		//For EDITOR Only
		void DisplayExampleItems()
		{		
			for(int count=0;count<10;count++) {
				ButtonVC tempButtonVC = new ButtonVC();
				tempButtonVC.price="0.99";				
				tempButtonVC.texture=m_ExampleItem;
				tempButtonVC.rect=new Rect((itemWidth*count)+(Screen.width*0.02f*(count+1)),Screen.height*0.25f,itemWidth,itemHeight);
				m_VirtualCurrencyItems.Add(tempButtonVC);
				itemsCount++;
			}
		}
		
		bool GUIButtonTexture2D( Rect r, Texture2D t)
		{
			GUI.DrawTexture( r, t, ScaleMode.StretchToFill);
			return GUI.Button( r, "", "");
		}
		
	#endregion
}
