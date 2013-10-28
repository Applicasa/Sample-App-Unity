//
// User.h
// Created by Applicasa 
// 10/24/2013
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiKitFacebook.h>
#import <LiCore/LiKitPromotionsConstants.h>
#import <LiCore/UpdateObject.h>



//*************
//
// User Class
//
//

#define kUserNotificationString @"UserConflictFound"
#define kShouldUserWorkOffline YES
@interface User : LiObject <LiCoreRequestDelegate,LiKitFacebookDelegate> {
}

@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain, readonly) NSString *userName;
@property (nonatomic, retain) NSString *userFirstName;
@property (nonatomic, retain) NSString *userLastName;
@property (nonatomic, retain) NSString *userEmail;
@property (nonatomic, retain) NSString *userPhone;
@property (nonatomic, retain, readonly) NSString *userPassword;
@property (nonatomic, retain, readonly) NSDate *userLastLogin;
@property (nonatomic, retain, readonly) NSDate *userRegisterDate;
@property (nonatomic, retain) CLLocation *userLocation;
@property (nonatomic, assign, readonly) BOOL userIsRegistered;
@property (nonatomic, assign, readonly) BOOL userIsRegisteredFacebook;
@property (nonatomic, retain, readonly) NSDate *userLastUpdate;
@property (nonatomic, retain) NSURL *userImage;
@property (nonatomic, assign) int userMainCurrencyBalance;
@property (nonatomic, assign) int userSecondaryCurrencyBalance;
@property (nonatomic, retain, readonly) NSString *userFacebookID;
@property (nonatomic, retain) NSDate *userTempDate;


 
// Save Useritem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase User int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Get User item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetUserFinished)block;

// Get User Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetUserArrayFinished)block;

// Get User Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetUserArrayFinished)block;

// Sync method to get data
+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind;

// A-sync method that receive filter and retreive all data from server
// uses Inner Pager
+ (void) getArrayWithFilter:(LiFilters *)filter withBlock:(UpdateObjectFinished)block;

// Sync method to update Local storage, Returns number of rows that answered the
// call, Light & Full are limited to 1500, More then that Use pager
+ (int) updateLocalStorage:(LiQuery *)query queryKind:(QueryKind)queryKind;


// uploadFile
- (void) uploadFile:(NSData *)data toField:(LiFields)field withFileType:(AMAZON_FILE_TYPES)fileType extension:(NSString *)ext andBlock:(LiBlockAction)block;


+ (User *) getCurrentUser;

#pragma mark - Facebook Methods

- (void) facebookLoginWithBlock:(LiBlockAction)block;
+ (void) facebookFindFriendsWithBlock:(LiBlockFBFriendsAction)block;

+ (void) facebookLogoutWithBlock:(LiBlockAction)block;



#pragma mark - End of Basic SDK

- (void) registerUsername:(NSString *)username andPassword:(NSString *)password withBlock:(LiBlockAction)block;
- (void) registerUserWithUsername:(NSString *)username Password:(NSString *)password WithBlock:(LiBlockAction)block DEPRECATED_ATTRIBUTE;

+ (void) loginWithUsername:(NSString *)username andPassword:(NSString *)password withBlock:(LiBlockAction)block;
+ (void) loginUserWithUsername:(NSString *)username Password:(NSString *)password WithBlock:(LiBlockAction)block DEPRECATED_ATTRIBUTE;

+ (void) updateUsername:(NSString *)newUsername usingPassword:(NSString *)password withBlock:(LiBlockAction)block;
+ (void) updateUsername:(NSString *)newUsername WithPassword:(NSString *)password WithBlock:(LiBlockAction)block DEPRECATED_ATTRIBUTE;

+ (void) updatePassword:(NSString *)newPassword forOldPassword:(NSString *)oldPassword withBlock:(LiBlockAction)block;
+ (void) updatePassword:(NSString *)newPassword OldPassword:(NSString *)oldPassword WithBlock:(LiBlockAction)block DEPRECATED_ATTRIBUTE;

+ (void) logoutWithBlock:(LiBlockAction)block;
+ (void) logOutWithBlock:(LiBlockAction)block DEPRECATED_ATTRIBUTE;

+ (void) forgotPasswordForUsername:(NSString *)username withBlock:(LiBlockAction)block;

#pragma mark - Profile Data Methods

+ (LiSpendingProfile) getCurrentSpendingProfile;

+ (LiUsageProfile) getCurrentUsageProfile;

@end
