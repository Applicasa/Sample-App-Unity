#import "ApplicasaCore.h"

#import "LiObjPushNotification.h"

#import "LiConfig.h"

#ifdef UNITY_4_2_0
#import "UnityAppController.h"
#else
#import "AppController.h"
#endif



void UnitySendDeviceToken(NSData* deviceToken);
void UnitySendRemoteNotificationError(NSError* error);
void UnitySendRemoteNotification(NSDictionary* notification);

#ifdef UNITY_4_2_0
@implementation UnityAppController (push)
#else
@implementation AppController (push)
#endif

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [LiCore registerDeviceToken:deviceToken];
    UnitySendDeviceToken(deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    [LiCore failToRegisterDeviceToken];
    UnitySendRemoteNotificationError(error);
}

/*
 
 // If you wish to display a simple alert in xCode level
 - (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
 {
 UnitySendRemoteNotification(userInfo);
 LiObjPushNotification *pushInstance = [LiObjPushNotification pushWithDictionary:userInfo];
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Received" message:pushInstance.message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
 [alert show];
 }
 */

@end

extern "C" {
    
    void ApplicasaClearAllPushMessages()
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
    
    LiObjPushNotification * ApplicasaPushGet(const char * message, const char * sound, int badge) {
        return [LiObjPushNotification pushWithMessage:CharPointerToNSString(message) sound:CharPointerToNSString(sound) badge:badge andTag:[NSMutableDictionary dictionary]];
    }
    
	LiObjPushNotification * ApplicasaPushGetWithDispatchTime(const char * message, const char * sound, int badge, int dispatchInMin) {
        return [LiObjPushNotification pushWithMessage:CharPointerToNSString(message) sound:CharPointerToNSString(sound) badge:badge andTag:[NSMutableDictionary dictionary] andDispatchInMinutes:(double)dispatchInMin];
    }
	
    void ApplicasaPushSend(LiObjPushNotification * push, User ** users, int arrayCount , ApplicasaSendPushFinished sendPushFinished) {
        NSMutableArray * userArray = [[[NSMutableArray alloc] initWithCapacity:arrayCount] autorelease];
        for (int i = 0; i < arrayCount; i++) {
            [userArray addObject:users[i]];
        }
        [push sendPushToUsers:userArray withBlock:ApplicasaSendPushFinishedToBlock(sendPushFinished)];
    }
    
    void addTags(LiObjPushNotification * push, const char * key, const char * value)
    {
        [push.tag setObject:CharPointerToNSString(value) forKey:CharPointerToNSString(key)];
    }
}