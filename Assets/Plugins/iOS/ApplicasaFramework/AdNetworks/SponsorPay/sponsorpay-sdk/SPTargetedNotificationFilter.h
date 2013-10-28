//
//  TargetedNotificationFilter.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 1/27/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SponsorPaySDK.h" // SPAppIdKey and SPUserIdKey


@interface SPTargetedNotificationFilter : NSObject

+   (BOOL)instanceWithAppId:(NSString *)appId
                     userId:(NSString *)userId
shouldRespondToNotification:(NSNotification *)notification;

@end
