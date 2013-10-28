//
//  LiCore.h
//  Framework-iOS
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LiCore/NSDate+SQLiteDate.h>
#import <LiCore/LiCoreDelegate.h>
#import <LiCore/LiObjRequest.h>
#import <LiCore/LiUtilities.h>
#import <LiCore/LiResponse.h>
#import <LiCore/LiObjOrder.h>
#import <LiCore/LiFilters.h>
#import <LiCore/LiObject.h>
#import <LiCore/LiQuery.h>
#import <LiCore/LiFilters.h>

#define LI_VERSION @"3.4.0.3"
#define FRAMEWORK_SCHEMA_VERSION @"1.2" 



@class User;
@interface LiCore : NSObject

// for adobe Air initCall
+(void) initLiCoreManager;


// Push Notification

// Method that send the device token to LiCore server
+ (void) registerDeviceToken:(NSData *)deviceToken;
// Method that notify about failed to get Token
+ (void) failToRegisterDeviceToken;

// Location Services

// Method to get the current location
+ (void) getCurrentLocation:(id <LiCoreLocationDelegate>)delegate;
// Method to update the current User location (only once)
+ (void) updateUserLocation:(id <LiCoreUpdateLocationDelegate>)delegate;
// Method to auto update the current User location
+ (void) startUpdatingUserLocationWithDelegate:(id <LiCoreUpdateLocationDelegate>)delegate;
// Method to stop the current User location update
+ (void) stopUpdatingUserLocation;
// A Method to set the CLLocatinoManager's distanceFilter
+ (void) setDistanceFilter:(CLLocationDistance)distanceFilter;
// A Method to set the CLLocatinoManager's desireAccuracy
+ (void) setDesireAccuracy:(CLLocationAccuracy)desireAccuracy;


+ (BOOL) clearContentOfObject:(NSString *)object WithFilter:(LiFilters *)filter Error:(NSError **)error;

+ (User *) getCurrentUser;
+ (NSDateFormatter *) liSqliteDateFormatter;

+ (void) initObjectsDictionary:(NSArray *)array;
+ (void) initForeignKeysWithDictionary:(NSDictionary *)dictionary;

+ (BOOL) isDoneLoading;

#pragma mark - Caching Methods

+ (void) deleteAllCachedImages;

+ (void) resetDevice;

+(void)displayAlert;

+(NSString *)getVersion;

// return the server time
+ (NSTimeInterval) getServerTime;


@end