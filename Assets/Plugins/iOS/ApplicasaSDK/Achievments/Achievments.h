//
// Achievments.h
// Created by Applicasa 
// 10/30/2013
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiKitFacebook.h>
#import <LiCore/UpdateObject.h>



//*************
//
// Achievments Class
//
//

#define kAchievmentsNotificationString @"AchievmentsConflictFound"
#define kShouldAchievmentsWorkOffline YES
@interface Achievments : LiObject <LiCoreRequestDelegate> {
}

@property (nonatomic, retain) NSString *achievmentsID;
@property (nonatomic, retain, readonly) NSDate *achievmentsLastUpdate;
@property (nonatomic, assign) int achievmentsPoints;
@property (nonatomic, retain) NSString *achievmentsDes;

 
// Save Achievmentsitem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase Achievments int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Delete Achievments item from Applicasa DB
- (void) deleteWithBlock:(LiBlockAction)block;

// Get Achievments item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetAchievmentsFinished)block;

// Get Achievments Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetAchievmentsArrayFinished)block;

// Get Achievments Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetAchievmentsArrayFinished)block;

// Sync method to get data
+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind;

// A-sync method that receive filter and retreive all data from server
// uses Inner Pager
+ (void) getArrayWithFilter:(LiFilters *)filter withBlock:(UpdateObjectFinished)block;

// Sync method to update Local storage, Returns number of rows that answered the
// call, Light & Full are limited to 1500, More then that Use pager
+ (int) updateLocalStorage:(LiQuery *)query queryKind:(QueryKind)queryKind;

// uploadFile
- (void) uploadFile:(NSData *)data toField:(LiFields)field withFileType:(AMAZON_FILE_TYPES)fileType extension:(NSString *)ext andBlock:(LiBlockAction)block;


#pragma mark - End of Basic SDK

@end
