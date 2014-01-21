//
//  LiObjPushNotification.m
//  Framework-iOS
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//

#import "LiObjPushNotification.h"
#import "User.h"
#import <LiCore/LiPushManager.h>

@implementation LiObjPushNotification
@synthesize message;
@synthesize sound;
@synthesize badge;
@synthesize pushID;
@synthesize tag;
@synthesize timed;
@synthesize dispatch_time;
@synthesize contentAvailable;

-(void)dealloc{
    [message release];
    [sound release];
    [tag release];
    [super dealloc];
}

#pragma mark - init Method

+ (LiObjPushNotification *)pushWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag{
    return [[[LiObjPushNotification alloc]initWithMessage:theMessage sound:theSound badge:theBadge andTag:theTag]autorelease];
}

-(id)initWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag{
    return  [LiObjPushNotification pushWithMessage:theMessage sound:theSound badge:theBadge andTag:theTag andContentAvailable:0];
}


//autorelease instance to send the push
+ (LiObjPushNotification *) pushWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag andContentAvailable:(int)theContentAvailable{
    return [[LiObjPushNotification alloc]initWithMessage:theMessage sound:theSound badge:theBadge andTag:theTag andContentAvailable:theContentAvailable];
}

//init instance to send the push
- (id) initWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge  andTag:(NSMutableDictionary *)theTag andContentAvailable:(int)theContentAvailable
{
    if (self=[super init]){
        if (theMessage){
            self.message = theMessage;
        } else {
            self.message = @"";
        }
        self.badge = theBadge;
        self.sound = theSound;
        self.tag = theTag;
        
        self.contentAvailable = (theContentAvailable == 0 || theContentAvailable == 1)?theContentAvailable:0;
        self.timed = FALSE;
    }
    return self;
}

//methods for timed messages
+ (LiObjPushNotification *) pushWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag andDispatchInMinutes:(double) theDispatchMinutes{
    return [[[LiObjPushNotification alloc]initWithMessage:theMessage sound:theSound badge:theBadge andTag:theTag andDispatchInMinutes:theDispatchMinutes]autorelease];
}

-(id)initWithMessage:(NSString *)theMessage sound:(NSString *)theSound badge:(NSInteger)theBadge andTag:(NSMutableDictionary *)theTag andDispatchInMinutes:(double) dispatchInMinutes{
    if (self=[super init]){
        if (theMessage){
            self.message = theMessage;
        } else {
            self.message = @"";
        }
        self.badge = theBadge;
        self.sound = theSound;
        self.tag = theTag;
        self.timed = TRUE;
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        
        self.dispatch_time = [[NSDate dateWithTimeIntervalSince1970:timeInterval+dispatchInMinutes*60]autorelease];
        
    }
    return self;
}


-(id) initWithDictionary:(NSDictionary *)dictionary{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSDictionary *apsDic = [mutableDic objectForKey:@"aps"];
    [mutableDic removeObjectForKey:@"aps"];
    
    LiObjPushNotification * item =[self initWithMessage:[apsDic objectForKey:@"alert"] sound:[apsDic objectForKey:@"sound"] badge:[[apsDic objectForKey:@"badge"] intValue] andTag:mutableDic];
    if ([apsDic objectForKey:@"content-available"])
        [item setContentAvailable:[[apsDic objectForKey:@"content-available"] intValue]];
    
    return item;
}

+ (LiObjPushNotification *) pushWithDictionary:(NSDictionary *)dictionary{
    return [[[self alloc] initWithDictionary:dictionary]autorelease];
}

- (void) sendPushToUsers:(NSArray *)users withBlock:(SendPushFinished)block{
    pushBlock = Block_copy(block);
    [LiPushManager sendPush:self UsersArray:users];
}

#pragma mark - LiObjRequest Delegate

- (void) requestDidFinished:(LiObjRequest *)request{
    NSInteger responseType = request.response.responseType;
    NSString *responseMessage = request.response.responseMessage;
    //NSDictionary *responseData = request.response.responseData;
    
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
    
    pushBlock(error,responseMessage,self);
    Block_release(pushBlock);
    
}
@end
