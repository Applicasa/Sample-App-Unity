#import <Foundation/Foundation.h>

@interface LiManager : NSObject

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/

+ (void) initDatabase;

+ (void) conflictFoundBetweenLocalItem:(NSDictionary *)localItem andServerItem:(NSDictionary *)serverItem OfClass:(NSString *)className;

// Checking SDK Settings
+ (int) getSchemaDate;

+ (float) getSDKVersion;

+ (float) getFrameworkVersion;

// Checking Application Settings
+ (NSString *) getApplicationId;

+ (NSString *) getSecretKey;

// Checking Behavior Settings
+ (BOOL) isPushEnabled;

+ (BOOL) shouldConfirmPushOnStart;

+ (BOOL) isDebugEnabled;

+ (BOOL) isLocationEnabled;

+ (BOOL) isOfflineEnabled;

+ (BOOL) isSandboxEnabled;

+ (NSString *) getSchemaVersion;

+ (BOOL) isChartboostEnabled;
+ (NSString *) getChartboostId;
+ (NSString *) getChartboostSignature;


@end
