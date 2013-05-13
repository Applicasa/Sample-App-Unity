
#import "ApplicasaCore.h"
#import "LiObjPushNotification.h"

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