//
//  LiKitFacebookDelegate.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@protocol LiKitFacebookDelegate <NSObject>

- (void) FBdidLoginUser:(User *)user ResponseType:(int)responseType ResponseMessage:(NSString *)responseMessage;
- (void) FBdidFindFacebookFriends:(NSArray *)friends ResponseType:(int)responseType ResponseMessage:(NSString *)responseMessage;


@end
