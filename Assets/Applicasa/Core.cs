using UnityEngine;
using System.Collections;
using System;
using System.Runtime.InteropServices;

[System.AttributeUsage(System.AttributeTargets.Method)]
	public sealed class MonoPInvokeCallbackAttribute : Attribute {
		public MonoPInvokeCallbackAttribute (Type t) {}
	}

namespace Applicasa {
		
	public enum IAP_STATUS {
		FAIL = 0,
		SUCCESS = 1,
		RUNNING = 2,
		SUCCESS_INIT_BUT_FAILED_VERIFY_VIRTUAL_CURRENCY
	}

	public enum Errors {
		//iOS
		PurchaseNotApproved = 1100,
		PurchaseCancelled = 1102,
		//Android & iOS
		IapActionReceiptNotValid = 200,
		IapActionReceiptReceiptAlreadyExists = 201
 }

	/// <summary>
	/// This is an internal class. Do not use it.
	/// </summary>
 public class Core {

#if UNITY_IPHONE&&!UNITY_EDITOR	
  [DllImport("__Internal")]
  public static extern void ApplicasaDeallocPointer(System.IntPtr item);
  public static void DeallocPointer(System.IntPtr item)
 {
		ApplicasaDeallocPointer(item);
 }
#endif

#if UNITY_ANDROID&&!UNITY_EDITOR
  [DllImport("Applicasa")]
  public static extern void setActionCallback(Action callback, int uniqueActionID);
  public static int currentCallbackID=1;  
#endif
   
#if UNITY_IPHONE&&!UNITY_EDITOR
  [DllImport("__Internal")]
  private static extern bool ApplicasaIsDoneLoading();
#endif
  public static bool isDoneLoading() {
#if UNITY_IPHONE&&!UNITY_EDITOR
   return Core.ApplicasaIsDoneLoading();
#else
   return true;
#endif
  }
  
#if UNITY_IPHONE&&!UNITY_EDITOR
  [DllImport("__Internal")]
  private static extern Applicasa.IAP_STATUS ApplicasaIAPStatus();
#endif
  public static IAP_STATUS IAPStatus() { 
#if UNITY_IPHONE&&!UNITY_EDITOR
   return Core.ApplicasaIAPStatus();
#else
   return IAP_STATUS.SUCCESS;
#endif
  }
  
#if UNITY_IPHONE&&!UNITY_EDITOR
  [DllImport("__Internal")]
  private static extern Applicasa.IAP_STATUS ApplicasaReValidateStatus();
#endif
  public static IAP_STATUS ReValidateStatus() {
#if UNITY_IPHONE&&!UNITY_EDITOR
   return Core.ApplicasaReValidateStatus();
#else
   return IAP_STATUS.SUCCESS;
#endif
  }
	
		
#if UNITY_IPHONE&&!UNITY_EDITOR
	[DllImport("__Internal")]
	private static extern long ApplicasaGetServerTime();
#endif
		
    public static long GetServerTime() {
#if UNITY_ANDROID &&!UNITY_EDITOR
		using(AndroidJavaClass javaUnityApplicasaCore = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCore"))
		return javaUnityApplicasaCore.CallStatic<long>("ApplicasaGetServerTime");
#elif UNITY_IPHONE && !UNITY_EDITOR
		return ApplicasaGetServerTime();
#else
		return -1;
#endif
   }
}	
		
	public delegate void Action(bool success, Error error, string itemID, Actions action);
	
	public struct Error {
		public int Id;
		public string Message;
	}
	
	public struct Location {
		public double Latitude;
		public double Longitude;
	}
	
	public struct SKProduct {
		public string LocalizedDescription;
		public string LocalizedTitle;
		public string Price;
		public string ProductIdentifier;
	}
	
	public enum QueryKind{
	    LOCAL = 0,
	    FULL = 1,
	    LIGHT,
	    LIGHT_WITH_PAGER
	}
	
	public enum AMAZON_FILE_TYPES{
	    Image = 1,
	    TEXT
	}
	
	public enum Actions {
	    RegisterAppDevice = 1,
	    UpdateDevice,
	    
	    AUD_Action,
	    Fetch_Action,
	    
	    //CURD + GetArray
	    Add,
	    Get,
	    Update,
	    Delete,
	    GetArray,
	    
	    //User - Actions
	    Register,
	    Login,
	    Logout,
	    UpdateUserName,
	    UpdatePassword,
	    ForgotPassword,
	    
	    //Files
	    GetAmazonCredentials,
	    
	    //Location
	    GetLocation,
	    UpdateLocation,
	    
	    //FB
	    LoginWithFacebook,
	    FacebookFriends,
	    
	    //Upload Image
	    UploadFile,
	    
	    //IAP
	    IAPGetStore,
	    DoIapAction,
	    GetInventoy,
	    SaveForCurrentUser,
	    
	    //Promotions
	    GetProfileData,
	    GetProfileSettings,
	    GetPromotions,
	    UpdateProfileData,
	    
	    //Social
	    SendPush,
	    
	    //Analitycs
	    UpdateAnalytics
	}

   public enum Fields {
	None = 0,
	//User
	User_None,
	UserID,
	UserName,
	UserFirstName,
	UserLastName,
	UserEmail,
	UserPhone,
	UserPassword,
	UserLastLogin,
	UserRegisterDate,
	UserLocation,
	UserIsRegistered,
	UserIsRegisteredFacebook,
	UserLastUpdate,
	UserImage,
	UserMainCurrencyBalance,
	UserSecondaryCurrencyBalance,
	UserFacebookID,
	//VirtualCurrency
	VirtualCurrency_None,
	VirtualCurrencyID,
	VirtualCurrencyTitle,
	VirtualCurrencyAppleIdentifier,
	VirtualCurrencyGoogleIdentifier,
	VirtualCurrencyDescription,
	VirtualCurrencyPrice,
	VirtualCurrencyIOSBundleMin,
	VirtualCurrencyIOSBundleMax,
	VirtualCurrencyAndroidBundleMin,
	VirtualCurrencyAndroidBundleMax,
	VirtualCurrencyPos,
	VirtualCurrencyCredit,
	VirtualCurrencyKind,
	VirtualCurrencyImageA,
	VirtualCurrencyImageB,
	VirtualCurrencyImageC,
	VirtualCurrencyIsDeal,
	VirtualCurrencyInAppleStore,
	VirtualCurrencyInGoogleStore,
	VirtualCurrencyLastUpdate,
	//VirtualGood
	VirtualGood_None,
	VirtualGoodID,
	VirtualGoodTitle,
	VirtualGoodDescription,
	VirtualGoodAppleIdentifier,
	VirtualGoodGoogleIdentifier,
	VirtualGoodMainCurrency,
	VirtualGoodSecondaryCurrency,
	VirtualGoodRelatedVirtualGood,
	VirtualGoodStoreItemPrice,
	VirtualGoodIOSBundleMin,
	VirtualGoodIOSBundleMax,
	VirtualGoodAndroidBundleMin,
	VirtualGoodAndroidBundleMax,
	VirtualGoodPos,
	VirtualGoodMaxForUser,
	VirtualGoodUserInventory,
	VirtualGoodQuantity,
	VirtualGoodImageA,
	VirtualGoodImageB,
	VirtualGoodImageC,
	VirtualGoodMainCategory,
	VirtualGoodIsDeal,
	VirtualGoodConsumable,
	VirtualGoodIsStoreItem,
	VirtualGoodInAppleStore,
	VirtualGoodInGoogleStore,
	VirtualGoodLastUpdate,
	//VirtualGoodCategory
	VirtualGoodCategory_None,
	VirtualGoodCategoryID,
	VirtualGoodCategoryName,
	VirtualGoodCategoryLastUpdate,
	VirtualGoodCategoryPos
}


	
	
	public enum EventTypes {
    // App session events
    appStart = 1100,
    appStop,
    appPause,
    appResume,
    
    // User-based session events
    userFirstSession = 1200,
    userReturnSession,
    userLogin,
    userLogout,
    userRegister,
    
    // Game events
    gameStarted = 1300,
    gameWin,
    gameLose,
    gamePause,
    gameResume,
    
    // IAP
    
    // VirtualCurrency-based events
    virtualCurrencyBought = 1400,
    virtualCurrencyGiven,
    virtualCurrencyUsed,
    virtualCurrencyFirstPurchase,
    
    // VirtualGood-based events
    virtualGoodBought = 1500,
    virtualGoodGiven,
    virtualGoodUsed,
    virtualGoodFirstPurchase,
    
    // Balance-based events
    balanceChanged = 1600,
    balanceZero,
    balanceLow,
	balanceChangedBy,
    
    // Inventory-based events
    inventoryDepleted = 1700, // all inventory at zero
    inventoryItemDepleted, // a specific item depleted from inventory
    
    // Level events
    levelStart = 1800,
    levelQuit,
    levelRestart,
    levelPause,
    levelResume,
    levelComplete,
    levelFail,
    levelTooDifficult,
    levelTooEasy,
    
    // Player events
    playerDied = 1900,
    playerDidAction,
    playerAchievement,
    
    // Promo events
    promoDisplayed = 2000,
    promoAccepted,
    promoDismissed,
    
    
    // Score events
    scoreHigh = 2100,
    scoreLow,
    scoreAchieved,
    
    // Choice events
    choiceGood = 2200,
    choiceBad,
    choiceAggressive,
    choiceDefensive,
    choiceNeutral,
    
    // Versus events
    versusStart = 2300,
    versusEnd,
    versusQuit,
    versusWin,
    versusLoss,
    
    // Level-up events
    levelUpCharacter = 2400,
    levelUpItem,
    
    // Unlockable events
    unlockedCharacter = 2500,
    unlockedItem,
    unlockedLevel,
    unlockedSecret,
	
	customEvent = 300
}
	
	public enum SortType {
#if !UNITY_ANDROID
     Ascending = 0,
     Descending
#endif
#if UNITY_ANDROID
     Ascending = 1,
     Descending
#endif
	}
	
	public enum OPERATORS{
	    GreaterThan = 0       // >
	    ,LessThan             // <
	    ,GreaterThanOrEqualTo // >=
	    ,LessThanOrEqualTo    // <=
	    ,Equal                // =
	    ,Like                 // %foo%
	}
	
	public enum COMPLEX_OPERATORS{
	    AND =0
	    ,OR 
	    ,NOT
	}
	
	public enum Currency {
    	MainCurrency = 1,
    	SecondaryCurrency = 2,
		RealMoney
		
    }
	
	public enum VirtualGoodType {
#if !UNITY_ANDROID
		All = 1,
		NonInventoryItems,
		InventoryItems
#endif
#if UNITY_ANDROID
		All = 0,
		InventoryItems,
		NonInventoryItems
#endif
	}
	

	public enum PromotionActionKind {
		 Nothing = 1, //data = nil
		 Link, // data = urls
		 String, // data = string
		 GiveVirtualCurrency, // data = amout + currencyKind
		 GiveVirtualGood, // data = VG id
		 OfferDealVC, // data = VC id & deal details
		 OfferDealVG, // data = VG id & deal details
		 Chartboost,
		 TrialPay
	 }
	 
	 public enum PromotionResult {
#if !UNITY_ANDROID
		 LinkOpened = 1,
		 StringInfo,
		 GiveMainCurrencyVirtualCurrency,
		 GiveSecondaryCurrencyVirtualCurrency,
		 GiveVirtualGood,
		 DealVirtualCurrency,
		 DealVirtualGood,
		 Nothing
#else
		 LinkOpened = 0,
		 StringInfo,
		 GiveMainCurrencyVirtualCurrency,
		 GiveSecondaryCurrencyVirtualCurrency,
		 GiveVirtualGood,
		 DealVirtualCurrency,
		 DealVirtualGood,
		 Nothing
#endif
	 }
	  
	 public enum PromotionAction {
		 Cancel = 0,
		 Pressed,
		 Failed
	 }
	 
	 public struct PromotionResultInfo {
		public PromotionResultDataType type;
		public string stringResult;
		public int intResult;
		public IntPtr virtualGoodResult;
		public IntPtr virtualCurrencyResult;
	 }
	 
	 public enum PromotionResultDataType {
		  String = 0,
		  Int,
		  VirtualCurrency,
		  VirtualGood
	 }
 
	
	public enum UsageProfile {
	    LiUsageProfileNone = 0,
	    LiUsageProfileCivilan,
	    LiUsageProfilePrivate,
	    LiUsageProfileSergeant,
	    LiUsageProfileGeneral
	}

	public enum SpendingProfile {
	    LiSpendingProfileNone = 0,
	    LiSpendingProfileZombie,
	    LiSpendingProfileTourist,
	    LiSpendingProfileTaxPayer,
	    LiSpendingProfileRockefeller
	}
}