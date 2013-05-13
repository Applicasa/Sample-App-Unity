using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ApplicasaStore : MonoBehaviour {
	
	// Singleton
	public static ApplicasaStore instance;
	
	//The current user virtual currency balance
	public static int UserVirtualcurrencyBalance=0;
	
	//The current user name
	public static string UserName="Anonymous";
	
	//List of virtual goods buttons
	public List<ButtonVG> m_VirtualGoodItems;
	
	//Virtual good button 
	public class ButtonVG{
		public Rect rect;
		public Texture2D texture;
		public string price;
		public Applicasa.VirtualGood virtualGood;
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
			instance.m_VirtualGoodItems=new List<ButtonVG>();
			#if UNITY_EDITOR
				DisplayExampleItems();
			#else
				//Load virtual goods from Applicasa
				Applicasa.IAP.GetVirtualGoods (Applicasa.VirtualGoodType.All, HandleGetVirtualGood);
			
				//Update User virtual currency balance 
				UpdateVirtualCurrencyBalance ();
		
				//Update User name
				UpdateUserDisplay();
			#endif
		}
		
		//Load virtual goods from Applicasa
		[MonoPInvokeCallback (typeof ( Applicasa.VirtualGood.GetVirtualGoodArrayFinished))]
		public static void HandleGetVirtualGood (bool success, Applicasa.Error error, Applicasa.VirtualGood.VirtualGoodArray virtualGoodArrayPtr)
		{
			if (success) {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get virtual goods success");
				Applicasa.VirtualGood[] virtualGoods = Applicasa.VirtualGood.GetVirtualGoodArray (virtualGoodArrayPtr);
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Virtual Goods item count = " + virtualGoods.Length);
				//Load Store Items to list
				instance.StartCoroutine (instance.LoadVirtualGoods (virtualGoods));
			} else {
				Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Get virtual good error " + error.Id + "-" + error.Message);
			}
		}
		
		//Load Store Items to list
		public IEnumerator LoadVirtualGoods (Applicasa.VirtualGood[] virtualGoods)
		{
			
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Loading " + virtualGoods.Length + " virtual goods");
			m_VirtualGoodItems.Clear();
			int count = 0;
			foreach (Applicasa.VirtualGood virtualGood in virtualGoods) {
				
				ButtonVG tempButtonVG = new ButtonVG();
				
				tempButtonVG.price=virtualGood.VirtualGoodMainCurrency.ToString();
				tempButtonVG.virtualGood=virtualGood;
			
				Applicasa.FileCache.GetCachedImage(virtualGood.VirtualGoodImageA, HandleImageData);
				while (imageData == null)
					yield return new WaitForSeconds(0.2f);
				tempButtonVG.texture = new Texture2D(100,100);
				tempButtonVG.texture.LoadImage(imageData);
				
				tempButtonVG.rect=new Rect((itemWidth*count)+(Screen.width*0.02f*(count+1)),Screen.height*0.25f,itemWidth,itemHeight);	
				m_VirtualGoodItems.Add(tempButtonVG);
				
				imageData = null;
			
				count++;
			}
			
			
		
			Debug.Log ("LiLog_Unity " + System.DateTime.Now.ToShortTimeString() + ": Loaded " + count + " vitrual goods");
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
		public static void HandleVirtualGoodPurchase(bool success, Applicasa.Error error, string itemId, Applicasa.Actions action) {
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
		public Texture2D m_Background,m_Back,m_GetCoins,m_Coins;
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
		
			foreach(ButtonVG _buttonVG in m_VirtualGoodItems) {
				if(GUIButtonTexture2D(_buttonVG.rect,_buttonVG.texture)){
					//BuyVirtualGood when click on item
					Applicasa.IAP.BuyVirtualGood(_buttonVG.virtualGood, 1, Applicasa.Currency.MainCurrency, HandleVirtualGoodPurchase);
					
				}
			}
			GUILayout.EndArea ();
			//Back button
			if(GUIButtonTexture2D(new Rect(Screen.height*0.05f,Screen.height*0.85f,Screen.height*0.2f,Screen.height*0.1f),m_Back)){
				Application.LoadLevel("AppMenu");
			}
			//Get more coins button
			if(GUIButtonTexture2D(new Rect(Screen.width*0.80f,Screen.height*0.85f,Screen.height*0.2f,Screen.height*0.1f),m_GetCoins)){
				Application.LoadLevel("AppGetCoins");
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
				ButtonVG tempButtonVG = new ButtonVG();
				tempButtonVG.price="1";				
				tempButtonVG.texture=m_ExampleItem;
				tempButtonVG.rect=new Rect((itemWidth*count)+(Screen.width*0.02f*(count+1)),Screen.height*0.25f,itemWidth,itemHeight);
				m_VirtualGoodItems.Add(tempButtonVG);							
			}
		}
		
		bool GUIButtonTexture2D( Rect r, Texture2D t)
		{
			GUI.DrawTexture( r, t, ScaleMode.StretchToFill);
			return GUI.Button( r, "", "");
		}
		
	#endregion
}
