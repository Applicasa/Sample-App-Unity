//
//  TargetedNotificationFilter.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 1/27/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPTargetedNotificationFilter.h"

@implementation SPTargetedNotificationFilter

+   (BOOL)instanceWithAppId:(NSString *)appId
                     userId:(NSString *)userId
shouldRespondToNotification:(NSNotification *)notification
{
    NSDictionary *notificationInfo = notification.userInfo;
    NSString *targetAppId = notificationInfo[SPAppIdKey];
    NSString *targetUserId = notificationInfo[SPUserIdKey];
    
    // For the notification to be targetted to a specific instance it must contain
    // both a valid app ID and a valid user ID
    BOOL validAppId = NO, validUserId = NO;
    
    BOOL nullAppId =  !targetAppId || [targetAppId isKindOfClass:[NSNull class]];
    BOOL nullUserId = !targetUserId || [targetUserId isKindOfClass:[NSNull class]];
    
    if (!nullAppId && !nullUserId) {
        validAppId = [targetAppId isKindOfClass:[NSString class]];
        validUserId = [targetUserId isKindOfClass:[NSString class]];
    }
    
    // If IDs are valid, we'll only react to this notification if it's targeted at us
    if (validAppId && validUserId)
        return [targetAppId isEqualToString:appId] && [targetUserId isEqualToString:userId];
    else
        return YES;
}

@end
