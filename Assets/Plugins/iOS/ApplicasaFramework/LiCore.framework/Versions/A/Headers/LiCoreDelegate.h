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
    GetTrialPayActions,
    
    //Social
    SendPush,
    
    //Analitycs
    UpdateAnalytics,
    
    GetServerTime
    
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

@protocol LiCoreLocationDelegate <NSObject>
@required

- (void) LiCoreDidFinishGetCurrentLocation:(CLLocation *)location Error:(NSError *)error;

@end

@protocol LiCoreUpdateLocationDelegate <NSObject>

@optional

- (void) LiCoreDidUpdateLocation:(CLLocation *)location;
- (void) LiCoreDidFailToUpdateLocation:(NSError *)error;

@end

@class User;

@protocol LiCoreInitializeDelegate <NSObject>

@optional

- (void) finishedInitializeLiCoreFrameworkWithUser:(User *)user isFirstLoad:(BOOL)isFirst;
- (void) liCoreHasNewUser:(User *)user;
- (void) finishedIntializedLiKitIAPWithVirtualCurrencies:(NSArray *)virtualCurrencies VirtualGoods:(NSArray *)virtualGoods;

- (void) finishedCachingFilesOfType:(LiMaterialCacher)cachedfiles;

@end