//
//  LiCoreDelegate.h
//  Applicasa
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#include "sqlite3.h"
#import <LiCore/LiUtilities.h>

typedef enum {
    RegisterAppDevice = 1,
    UpdateDevice,
    InitApplicasa,

    
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
    GetThirdPartyActions,
    
    //Social
    SendPush,
    
    //Analitycs
    UpdateAnalytics,
    
    GetServerTime,
    
    CopyUserToLiveDatabase
    
} Actions;

typedef enum AMAZON_FILE_TYPES{
    Image = 1,
    Text,
    Pdf
}AMAZON_FILE_TYPES;

typedef enum OPERATORS{
    GreaterThan = 0       // >
    ,LessThan             // <
    ,GreaterThanOrEqualTo // >=
    ,LessThanOrEqualTo    // <=
    ,Equal                // =
    ,Like                 // %foo%
    
} OPERATORS;

typedef enum COMPLEX_OPERATORS{
    AND =0
    ,OR 
    ,NOT
    ,IN
} COMPLEX_OPERATORS;

typedef enum {
    Ascending = 0,
    Descending
} SortType;

typedef enum QueryKind{
    LOCAL = 0,
    FULL = 1,
    LIGHT,
    LIGHT_WITH_PAGER
} QueryKind;

@class LiObjRequest;
@protocol LiCoreRequestDelegate <NSObject>;
@optional

- (void) requestDidFinished:(LiObjRequest *)request;
- (id) getObjectDelegate;

@end



@class User;

@protocol LiCoreInitializeDelegate <NSObject>

@optional

// Called once Applicasa finish Framework Initialize, and receive a user from server.
- (void) finishedInitializeLiCoreFrameworkWithUser:(User *)user isFirstLoad:(BOOL)isFirst;

// Called once Applicasa completes Virtual Store init. After this delegate is called your store is set up and your IAP items are verified with apple.
- (void) finishedIntializedLiKitIAPWithVirtualCurrencies:(NSArray *)virtualCurrencies VirtualGoods:(NSArray *)virtualGoods;

// called to notify that the init wasn't completetd, Might be due to missing internet connection.
- (void) failedInitializeLiCoreWithReason:(NSString *)message;

// called every time a user changes, (user will change after logout or login actions).
- (void) liCoreHasNewUser:(User *)user;

// Called once Applicasa completes Caching Store Materials (Virtual Currency Image A , VirtualGood Image A, and Promotions material).
- (void) finishedCachingFilesOfType:(LiMaterialCacher)cachedfiles;

@end

@protocol LiCoreLocationDelegate <NSObject>
@required

- (void) LiCoreDidFinishGetCurrentLocation:(CLLocation *)location Error:(NSError *)error;

@end

@protocol LiCoreUpdateLocationDelegate <NSObject>

@optional

- (void) LiCoreDidUpdateLocation:(CLLocation *)location;
- (void) LiCoreDidFailToUpdateLocation:(NSError *)error;

@end

