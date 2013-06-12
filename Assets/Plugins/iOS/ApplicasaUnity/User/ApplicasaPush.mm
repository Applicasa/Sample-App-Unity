
#import "ApplicasaCore.h"

#import "LiObjPushNotification.h"
#import "AppController.h"
#import "LiConfig.h"

void UnitySendDeviceToken(NSData* deviceToken);
void UnitySendRemoteNotificationError(NSError* error);
void UnitySendRemoteNotification(NSDictionary* notification);

@implementation AppController (push)

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
    
    LiObjPushNotification * ApplicasaPushGet(const char * message, const char * sound, int badge, const char * tag) {
        return [LiObjPushNotification pushWithMessage:CharPointerToNSString(message) sound:CharPointerToNSString(sound) badge:badge andTag:[NSDictionary dictionary]];
    }
    
    void ApplicasaPushSend(LiObjPushNotification * push, User ** users, int arrayCount , ApplicasaSendPushFinished sendPushFinished) {
        NSMutableArray * userArray = [[[NSMutableArray alloc] initWithCapacity:arrayCount] autorelease];
        for (int i = 0; i < arrayCount; i++) {
            [userArray addObject:users[i]];
        }
        [push sendPushToUsers:userArray withBlock:ApplicasaSendPushFinishedToBlock(sendPushFinished)];
    }
    
}