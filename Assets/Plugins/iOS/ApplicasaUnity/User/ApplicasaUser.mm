//
// User.mm
// Created by Applicasa 
// 1/21/2014
//


#import "ApplicasaCore.h"
#import "User.h"
#import "LiDataTypes.h"

#ifdef UNITY_4_2_0
#import "UnityAppController.h"
#else
#import "AppController.h"
#endif

#ifdef UNITY_4_2_0
@implementation UnityAppController (liFacebook)
#else
@implementation AppController (liFacebook)
#endif

- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [LiKitFacebook handleOpenURL:url];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [LiKitFacebook handleOpenURL:url];
}

@end

extern "C" {




const char* ApplicasaUserGetUserID(User* user) {
	return NSStringToCharPointer(user.userID);
}
void ApplicasaUserSetUserID(User* user, const char * userID) {
	user.userID = CharPointerToNSString(userID);
}
const char* ApplicasaUserGetUserName(User* user) {
	return NSStringToCharPointer(user.userName);
}
const char* ApplicasaUserGetUserFirstName(User* user) {
	return NSStringToCharPointer(user.userFirstName);
}
void ApplicasaUserSetUserFirstName(User* user, const char * userFirstName) {
	user.userFirstName = CharPointerToNSString(userFirstName);
}
const char* ApplicasaUserGetUserLastName(User* user) {
	return NSStringToCharPointer(user.userLastName);
}
void ApplicasaUserSetUserLastName(User* user, const char * userLastName) {
	user.userLastName = CharPointerToNSString(userLastName);
}
const char* ApplicasaUserGetUserEmail(User* user) {
	return NSStringToCharPointer(user.userEmail);
}
void ApplicasaUserSetUserEmail(User* user, const char * userEmail) {
	user.userEmail = CharPointerToNSString(userEmail);
}
const char* ApplicasaUserGetUserPhone(User* user) {
	return NSStringToCharPointer(user.userPhone);
}
void ApplicasaUserSetUserPhone(User* user, const char * userPhone) {
	user.userPhone = CharPointerToNSString(userPhone);
}
const char* ApplicasaUserGetUserPassword(User* user) {
	return NSStringToCharPointer(user.userPassword);
}
const double ApplicasaUserGetUserLastLogin(User* user) {
	return ((double)user.userLastLogin.timeIntervalSince1970);
}
const double ApplicasaUserGetUserRegisterDate(User* user) {
	return ((double)user.userRegisterDate.timeIntervalSince1970);
}
const struct ApplicasaLocation ApplicasaUserGetUserLocation(User* user) {
	CLLocation* loc = user.userLocation;
	struct ApplicasaLocation location;
	location.Latitude = loc.coordinate.latitude;
	location.Longitude = loc.coordinate.longitude;
	return location;
}
void ApplicasaUserSetUserLocation(User* user, struct ApplicasaLocation loc) {
	user.userLocation = [[[CLLocation alloc] initWithLatitude:loc.Latitude longitude:loc.Longitude] autorelease];
}
const bool ApplicasaUserGetUserIsRegistered(User* user) {
	return user.userIsRegistered;
}
const bool ApplicasaUserGetUserIsRegisteredFacebook(User* user) {
	return user.userIsRegisteredFacebook;
}
const double ApplicasaUserGetUserLastUpdate(User* user) {
	return ((double)user.userLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaUserGetUserImage(User* user) {
	return NSStringToCharPointer([user.userImage absoluteString]);
}
void ApplicasaUserSetUserImage(User* user,const char* url) {
	user.userImage = [NSURL URLWithString:CharPointerToNSString(url)];
}
const int ApplicasaUserGetUserMainCurrencyBalance(User* user) {
	return user.userMainCurrencyBalance;
}
void ApplicasaUserSetUserMainCurrencyBalance(User* user,int userMainCurrencyBalance) {
	user.userMainCurrencyBalance = userMainCurrencyBalance;
}
const int ApplicasaUserGetUserSecondaryCurrencyBalance(User* user) {
	return user.userSecondaryCurrencyBalance;
}
void ApplicasaUserSetUserSecondaryCurrencyBalance(User* user,int userSecondaryCurrencyBalance) {
	user.userSecondaryCurrencyBalance = userSecondaryCurrencyBalance;
}
const char* ApplicasaUserGetUserFacebookID(User* user) {
	return NSStringToCharPointer(user.userFacebookID);
}
const double ApplicasaUserGetUserTempDate(User* user) {
	return ((double)user.userTempDate.timeIntervalSince1970);
}
void ApplicasaUserSetUserTempDate(User* user, double userTempDate) {
	user.userTempDate =  [NSDate dateWithTimeIntervalSince1970:userTempDate];
}




void ApplicasaRegisterUsername(User* user, const char * username, const char * password, ApplicasaAction callback)
{
    [user registerUsername:CharPointerToNSString(username) andPassword:CharPointerToNSString(password) withBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUserSaveWithBlock(User* user, ApplicasaAction callback) {
    [user saveWithBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUserIncreaseFieldInt(User* user, LiFields field, int val) {
    [user increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaUserIncreaseFieldFloat(User* user, LiFields field, float val) {
    [user increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaUserUploadFile(User* user, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, char* extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [user uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUserFacebookLoginWithBlock(User* user, ApplicasaAction callback) {
    [user facebookLoginWithBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUserFacebookLogoutWithBlock(ApplicasaAction callback) {
    [User facebookLogoutWithBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUserFacebookFindFriendsWithBlock(ApplicasaFBFriendsAction callback) {
    [User facebookFindFriendsWithBlock:ApplicasaFBFriendsActionToBlock(callback)];
}

void ApplicasaLoginWithUsername( const char * username, const char * password, ApplicasaAction callback)
{
    [User loginWithUsername:CharPointerToNSString(username) andPassword:CharPointerToNSString(password) withBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUpdateUsername( const char * newUsername, const char * password, ApplicasaAction callback)
{
    [User updateUsername:CharPointerToNSString(newUsername) usingPassword:CharPointerToNSString(password) withBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaUpdatePassword( const char * newPassword, const char * oldPassword, ApplicasaAction callback)
{
    [User updatePassword:CharPointerToNSString(newPassword) forOldPassword:CharPointerToNSString(oldPassword) withBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaLogoutWithBlock( ApplicasaAction callback)
{
    [User logoutWithBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaForgotPasswordForUsername( const char * username, ApplicasaAction callback)
{
    [User forgotPasswordForUsername:CharPointerToNSString(username) withBlock:ApplicasaActionToBlock(callback)];
}

User* ApplicasaGetCurrentUser() {
    return [LiCore getCurrentUser];
}

void ApplicasaUserGetById(const char* idString, QueryKind queryKind, ApplicasaGetUserFinished callback) {
    [User getById:CharPointerToNSString(idString) queryKind:queryKind withBlock:ApplicasaGetUserFinishedToBlock(callback) ];
}

void ApplicasaUserGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetUserArrayFinished callback) {
    [User getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetUserArrayFinishedToBlock(callback)];
}

void ApplicasaUserGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetUserArrayFinished callback) {
    [User getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetUserArrayFinishedToBlock(callback)];
}
    
int ApplicasaUserUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [User updateLocalStorage:query queryKind:queryKind];
}

ApplicasaUserArray ApplicasaUserGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [User getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    User** userArray = (User**)malloc(sizeof(User*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            userArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaUserArray userStruct;
    userStruct.Array = userArray;
    userStruct.ArraySize = arraySize;
   
    return userStruct;
}
 
 
 struct FBFriend ApplicasaUserGetFacebookFriend(LiObjFBFriend * fbFriend) {
    struct FBFriend fbFriendStruct;
    fbFriendStruct.Id = NSStringToCharPointer(fbFriend.facebookID);
    fbFriendStruct.Name = NSStringToCharPointer(fbFriend.facebookName);
    fbFriendStruct.ImageURL = NSStringToCharPointer([fbFriend.facebookImage absoluteString]);
    if (fbFriend.user && fbFriend.user.userID)
        fbFriendStruct.UserPtr = fbFriend.user;
    else
        fbFriendStruct.UserPtr = nil;
   
    return fbFriendStruct;
}
    
struct FBFriend  ApplicasaUserGetFacebookFriendByIndex(int i)
{
	LiObjFBFriend * fbFriend = GetfbFriend(i);
	if (i == GetfbFriendArraySize())
		ReleaseFriendsArray();
		
	return ApplicasaUserGetFacebookFriend(fbFriend);
}
    
    LiSpendingProfile ApplicasaUserGetCurrentSpendingProfile() {
        return [User getCurrentSpendingProfile];
    }
    
    LiUsageProfile ApplicasaUserGetCurrentUsageProfile() {
        return [User getCurrentUsageProfile];
        
    }

}
