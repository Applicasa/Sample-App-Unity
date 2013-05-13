//
// LiDataTypes.h
// Created by Applicasa 
// 5/13/2013
//


typedef enum {
	All = 1,
	NonInventoryItems,
	InventoryItems
} VirtualGoodType;

typedef enum {
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
	VirtualGoodIsDeal,
	VirtualGoodConsumable,
	VirtualGoodIsStoreItem,
	VirtualGoodInAppleStore,
	VirtualGoodInGoogleStore,
	VirtualGoodLastUpdate,
	VirtualGoodMainCategory,
	//VirtualGoodCategory
	VirtualGoodCategory_None,
	VirtualGoodCategoryID,
	VirtualGoodCategoryName,
	VirtualGoodCategoryLastUpdate,
	VirtualGoodCategoryPos
}LiFields;

