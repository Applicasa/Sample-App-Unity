//
//  PushManager.h
//  Applicasa
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiObjPushNotification;

@interface LiPushManager : NSObject

+ (void)sendPush:(LiObjPushNotification *)pushNotification UsersArray:(NSArray *)Users;

@end
