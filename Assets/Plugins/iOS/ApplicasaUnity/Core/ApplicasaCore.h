//
//  ApplicasaCore.h
//  Unity-iPhone
//
#import "LiCore/LiCoreDelegate.h"
#import "LiCore/LiObject.h"
#import "LiCore/Promotion.h"
#import "User.h"
#import "IAP.h"
#import <LiCore/TPAction.h>

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
//	bool hasApplicasaUser;
    char* Name;
    char* ImageURL;
};

struct ApplicasaThirdPartyActionArray {
    int ArraySize;
    TPAction** Array;
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

struct ApplicasaDynamicArray {
int ArraySize;
Dynamic** Array;
};

struct ApplicasaChatArray {
int ArraySize;
Chat** Array;
};

struct ApplicasaAchievmentsArray {
int ArraySize;
Achievments** Array;
};

struct ApplicasaFooArray {
int ArraySize;
Foo** Array;
};

struct ApplicasaGameVArray {
int ArraySize;
GameV** Array;
};

struct ApplicasaDataManagerArray {
int ArraySize;
DataManager** Array;
};

struct ApplicasaDataManStringArray {
int ArraySize;
DataManString** Array;
};

struct ApplicasaScoreBArray {
int ArraySize;
ScoreB** Array;
};

struct ApplicasaLevelsArray {
int ArraySize;
Levels** Array;
};

struct ApplicasaColorsArray {
int ArraySize;
Colors** Array;
};

struct ApplicasaLanguagesArray {
int ArraySize;
Languages** Array;
};

struct ApplicasaCardsArray {
int ArraySize;
Cards** Array;
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

typedef void (*ApplicasaGetThirdPartyActionArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaThirdPartyActionArray array);



typedef void (*ApplicasaGetDynamicFinished)(bool success, struct ApplicasaError error, Dynamic *object);
typedef void (*ApplicasaGetDynamicArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaDynamicArray array);

typedef void (*ApplicasaGetChatFinished)(bool success, struct ApplicasaError error, Chat *object);
typedef void (*ApplicasaGetChatArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaChatArray array);

typedef void (*ApplicasaGetAchievmentsFinished)(bool success, struct ApplicasaError error, Achievments *object);
typedef void (*ApplicasaGetAchievmentsArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaAchievmentsArray array);

typedef void (*ApplicasaGetFooFinished)(bool success, struct ApplicasaError error, Foo *object);
typedef void (*ApplicasaGetFooArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaFooArray array);

typedef void (*ApplicasaGetGameVFinished)(bool success, struct ApplicasaError error, GameV *object);
typedef void (*ApplicasaGetGameVArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaGameVArray array);

typedef void (*ApplicasaGetDataManagerFinished)(bool success, struct ApplicasaError error, DataManager *object);
typedef void (*ApplicasaGetDataManagerArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaDataManagerArray array);

typedef void (*ApplicasaGetDataManStringFinished)(bool success, struct ApplicasaError error, DataManString *object);
typedef void (*ApplicasaGetDataManStringArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaDataManStringArray array);

typedef void (*ApplicasaGetScoreBFinished)(bool success, struct ApplicasaError error, ScoreB *object);
typedef void (*ApplicasaGetScoreBArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaScoreBArray array);

typedef void (*ApplicasaGetLevelsFinished)(bool success, struct ApplicasaError error, Levels *object);
typedef void (*ApplicasaGetLevelsArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaLevelsArray array);

typedef void (*ApplicasaGetColorsFinished)(bool success, struct ApplicasaError error, Colors *object);
typedef void (*ApplicasaGetColorsArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaColorsArray array);

typedef void (*ApplicasaGetLanguagesFinished)(bool success, struct ApplicasaError error, Languages *object);
typedef void (*ApplicasaGetLanguagesArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaLanguagesArray array);

typedef void (*ApplicasaGetCardsFinished)(bool success, struct ApplicasaError error, Cards *object);
typedef void (*ApplicasaGetCardsArrayFinished)(bool success, struct ApplicasaError error, struct ApplicasaCardsArray array);



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

LiThirdPartyResponse ApplicasaGetThirdPartyActionArrayFinishedToBlock(ApplicasaGetThirdPartyActionArrayFinished function);

GetDynamicFinished ApplicasaGetDynamicFinishedToBlock(ApplicasaGetDynamicFinished function);
GetDynamicArrayFinished ApplicasaGetDynamicArrayFinishedToBlock(ApplicasaGetDynamicArrayFinished function);

GetChatFinished ApplicasaGetChatFinishedToBlock(ApplicasaGetChatFinished function);
GetChatArrayFinished ApplicasaGetChatArrayFinishedToBlock(ApplicasaGetChatArrayFinished function);

GetAchievmentsFinished ApplicasaGetAchievmentsFinishedToBlock(ApplicasaGetAchievmentsFinished function);
GetAchievmentsArrayFinished ApplicasaGetAchievmentsArrayFinishedToBlock(ApplicasaGetAchievmentsArrayFinished function);

GetFooFinished ApplicasaGetFooFinishedToBlock(ApplicasaGetFooFinished function);
GetFooArrayFinished ApplicasaGetFooArrayFinishedToBlock(ApplicasaGetFooArrayFinished function);

GetGameVFinished ApplicasaGetGameVFinishedToBlock(ApplicasaGetGameVFinished function);
GetGameVArrayFinished ApplicasaGetGameVArrayFinishedToBlock(ApplicasaGetGameVArrayFinished function);

GetDataManagerFinished ApplicasaGetDataManagerFinishedToBlock(ApplicasaGetDataManagerFinished function);
GetDataManagerArrayFinished ApplicasaGetDataManagerArrayFinishedToBlock(ApplicasaGetDataManagerArrayFinished function);

GetDataManStringFinished ApplicasaGetDataManStringFinishedToBlock(ApplicasaGetDataManStringFinished function);
GetDataManStringArrayFinished ApplicasaGetDataManStringArrayFinishedToBlock(ApplicasaGetDataManStringArrayFinished function);

GetScoreBFinished ApplicasaGetScoreBFinishedToBlock(ApplicasaGetScoreBFinished function);
GetScoreBArrayFinished ApplicasaGetScoreBArrayFinishedToBlock(ApplicasaGetScoreBArrayFinished function);

GetLevelsFinished ApplicasaGetLevelsFinishedToBlock(ApplicasaGetLevelsFinished function);
GetLevelsArrayFinished ApplicasaGetLevelsArrayFinishedToBlock(ApplicasaGetLevelsArrayFinished function);

GetColorsFinished ApplicasaGetColorsFinishedToBlock(ApplicasaGetColorsFinished function);
GetColorsArrayFinished ApplicasaGetColorsArrayFinishedToBlock(ApplicasaGetColorsArrayFinished function);

GetLanguagesFinished ApplicasaGetLanguagesFinishedToBlock(ApplicasaGetLanguagesFinished function);
GetLanguagesArrayFinished ApplicasaGetLanguagesArrayFinishedToBlock(ApplicasaGetLanguagesArrayFinished function);

GetCardsFinished ApplicasaGetCardsFinishedToBlock(ApplicasaGetCardsFinished function);
GetCardsArrayFinished ApplicasaGetCardsArrayFinishedToBlock(ApplicasaGetCardsArrayFinished function);





SendPushFinished ApplicasaSendPushFinishedToBlock(ApplicasaSendPushFinished function);
GetCachedImageFinished ApplicasaGetFileDataToImageBlock(ApplicasaGetFileData function);
GetCachedDataFinished ApplicasaGetFileDataToDataBlock(ApplicasaGetFileData function);

extern "C" {
bool ApplicasaIsDoneLoading();
long ApplicasaGetServerTime();
LiObjFBFriend* GetfbFriend(int i);
int GetfbFriendArraySize();
void ReleaseFriendsArray();
}