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
@property (nonatomic, retain) NSMutableDictionary *tag;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *sound;

@property (nonatomic) BOOL timed;
@property (nonatomic,retain) NSDate *dispatch_time;

//An async method to send the push message to array of User instances
- (void) sendPushToUsers:(NSArray *)users withBlock:(SendPushFinished)block;

#pragma mark - Initializtion

//autorelease instance to send the push
+ (LiObjPushNotification *) pushWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag;

//init instance to send the push
- (id) initWithMessage:(NSString *)theMessage sound:(NSString *)theBadge badge:(NSInteger)theSound andTag:(NSDictionary *)theTag;


//methods for timed messages
//autorelease instance to send the push
+ (LiObjPushNotification *) pushWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag andDispatchInMinutes:(double) theDispatchMinutes;

//init instance to send the push
-(id)initWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag andDispatchInMinutes:(double) dispatchInMinutes;


//init instance when push recieved
- (id) initWithDictionary:(NSDictionary *)dictionary;
//autorelease instance when push recieved
+ (LiObjPushNotification *) pushWithDictionary:(NSDictionary *)dictionary;

@end
