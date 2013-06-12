//
//  ApplicasaCore.h
//  Unity-iPhone
//
#import "LiCore/LiCoreDelegate.h"
#import "LiCore/LiObject.h"
#import "LiCore/Promotion.h"
#import "User.h"
#import "IAP.h"


#define NSStringToCharPointer( _x_ ) ( _x_ != NULL && [_x_ isKindOfClass:[NSString class]] ) ? strdup( [_x_ UTF8String] ) : NULL
#define CharPointerToNSString( _x_ ) ( _x_ != NULL ) ? [NSString stringWithUTF8String:_x_] : [NSString stringWithUTF8String:""]

void IncreasePromoCounter();
bool DecreasePromoCounter();

typedef enum {
  PromotionResultDataTypeString = 0,
  PromotionResultDataTypeInt,
  PromotionResultDataTypeVirtualCurrency,
  PromotionResultDataTypeVirtualGood
} PromotionResultDataType;
 
struct PromotionResultInfo {
   PromotionResultDataType type;
   char* stringResult;
   int intResult;
   VirtualGood* virtualGoodResult;
   VirtualCurrency* virtualCurrencyResult;
};
 struct FBFriend {
    User* UserPtr;
    char* Id;
	bool hasApplicasaUser;
    char* Name;
    char* ImageURL;
};

struct ApplicasaUserArray {
    int ArraySize;
    User** Array;
};

struct ApplicasaFBFriendArray {
    int ArraySize;
    LiObjFBFriend** Array;
};

struct ApplicasaVirtualCurrencyArray {
    int ArraySize;
    VirtualCurrency** Array;
};

struct ApplicasaVirtualGoodArray {
    int ArraySize;
    VirtualGood** Array;
};

struct ApplicasaVirtualGoodCategoryArray {
    int ArraySize;
    VirtualGoodCategory** Array;
};

struct ApplicasaPromotionArray {
    int ArraySize;
    Promotion** Array;
};

struct ApplicasaByteArray {
    int ArraySize;
    Byte* Array;
};

struct ApplicasaError {
    int Id;
    char* Message;
};

struct ApplicasaLocation {
    double Latitude;
    double Longitude;
};

struct ApplicasaSKProduct {
    char* LocalizedDescription;
    char* LocalizedTitle;
    char* Price;
    char* ProductIdentifier;
};





//char* ApplicasaMakeStringCopy (const char* string) {
//    if (string == NULL) return NULL;
//    char * res = (char*)malloc(strlen(string) + 1);
//    strcpy(res, string);
//    return res;
//}

// ApplicasaError - NSError*, char * - NSString*, int-Actions



typedef void (*ApplicasaAction)(bool success, struct ApplicasaError error, char *itemID, Actions action);
typedef void (*ApplicasaGetUserFinished)(bool success, struct ApplicasaError error, User *object);
typedef void (*ApplicasaGetUserArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaUserArray array);
typedef void (*ApplicasaFBFriendsAction)(bool success, struct ApplicasaError error, struct ApplicasaFBFriendArray friends,  Actions action);
typedef void (*ApplicasaGetVirtualCurrencyArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaVirtualCurrencyArray array);
typedef void (*ApplicasaGetVirtualGoodArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaVirtualGoodArray array);
typedef void (*ApplicasaGetVirtualGoodCategoryFinished)(bool success, struct ApplicasaError error, VirtualGoodCategory *object);
typedef void (*ApplicasaGetVirtualGoodCategoryArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaVirtualGoodCategoryArray array);
typedef void (*ApplicasaGetPromotionArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaPromotionArray array);
typedef void (*ApplicasaPromotionResult)(LiPromotionAction promoAction,LiPromotionResult result, PromotionResultInfo info);
typedef void (*ApplicasaPromotionsAvailable)(struct ApplicasaPromotionArray promotions);



typedef void (*ApplicasaSendPushFinished)(bool success, struct ApplicasaError error, char *message,LiObjPushNotification *pushObject);
typedef void (*ApplicasaGetFileData)(bool success, ApplicasaError error, ApplicasaByteArray data);


LiBlockAction ApplicasaActionToBlock(ApplicasaAction function);
LiBlockFBFriendsAction ApplicasaFBFriendsActionToBlock(ApplicasaFBFriendsAction function);
GetUserFinished ApplicasaGetUserFinishedToBlock(ApplicasaGetUserFinished function);
GetUserArrayFinished ApplicasaGetUserArrayFinishedToBlock(ApplicasaGetUserArrayFinished function);
GetVirtualCurrencyArrayFinished ApplicasaGetVirtualCurrencyArrayFinishedToBlock(ApplicasaGetVirtualCurrencyArrayFinished function);
GetVirtualGoodArrayFinished ApplicasaGetVirtualGoodArrayFinishedToBlock(ApplicasaGetVirtualGoodArrayFinished function);
GetVirtualGoodCategoryFinished ApplicasaGetVirtualGoodCategoryFinishedToBlock(ApplicasaGetVirtualGoodCategoryFinished function);
GetVirtualGoodCategoryArrayFinished ApplicasaGetVirtualGoodCategoryArrayFinishedToBlock(ApplicasaGetVirtualGoodCategoryArrayFinished function);
GetPromotionArrayFinished ApplicasaGetPromotionArrayFinishedToBlock(ApplicasaGetPromotionArrayFinished function);
PromotionResultBlock ApplicasaPromotionResultToBlock(ApplicasaPromotionResult function);





SendPushFinished ApplicasaSendPushFinishedToBlock(ApplicasaSendPushFinished function);
GetCachedImageFinished ApplicasaGetFileDataToImageBlock(ApplicasaGetFileData function);
GetCachedDataFinished ApplicasaGetFileDataToDataBlock(ApplicasaGetFileData function);

extern "C" {
bool ApplicasaIsDoneLoading();
long ApplicasaGetServerTime();
}