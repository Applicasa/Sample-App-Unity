//
//  LiObjPushNotification.h
//  Framework-iOS
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiObjRequest.h>
#import <LiCore/LiCoreDelegate.h>
#import "LiBlocks.h"

@interface LiObjPushNotification : NSObject <LiCoreRequestDelegate> {
    SendPushFinished pushBlock;
}

@property (readonly) NSInteger pushID;
@property (nonatomic) NSInteger badge;
@property (nonatomic, retain) NSDictionary *tag;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sound;

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/

//An async method to send the push message to array of User instances
- (void) sendPushToUsers:(NSArray *)users withBlock:(SendPushFinished)block;

#pragma mark - Initializtion

//autorelease instance to send the push
+ (LiObjPushNotification *) pushWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSDictionary *)theTag;
+ (LiObjPushNotification *) pushWithMessage:(NSString *)theMessage Sound:(NSString *)theSound Badge:(NSInteger)theBadge Tag:(NSDictionary *)theTag DEPRECATED_ATTRIBUTE;

//init instance to send the push
- (id) initWithMessage:(NSString *)theMessage sound:(NSString *)theBadge badge:(NSInteger)theSound andTag:(NSDictionary *)theTag;
- (id) initWithMessage:(NSString *)theMessage Badge:(NSInteger)theBadge Sound:(NSString *)theSound Tag:(NSDictionary *)theTag DEPRECATED_ATTRIBUTE;

//init instance when push recieved
- (id) initWithDictionary:(NSDictionary *)dictionary;
//autorelease instance when push recieved
+ (LiObjPushNotification *) pushWithDictionary:(NSDictionary *)dictionary;

@end
