//
// ScoreB.h
// Created by Applicasa 
// 10/24/2013
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiKitFacebook.h>
#import <LiCore/UpdateObject.h>



//*************
//
// ScoreB Class
//
//

#define kScoreBNotificationString @"ScoreBConflictFound"
#define kShouldScoreBWorkOffline YES
@class User;
@interface ScoreB : LiObject <LiCoreRequestDelegate> {
}

@property (nonatomic, retain) NSString *scoreBID;
@property (nonatomic, retain, readonly) NSDate *scoreBLastUpdate;
@property (nonatomic, assign) int scoreBScore;
@property (nonatomic, retain) User *scoreBUser;

 
// Save ScoreBitem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase ScoreB int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Delete ScoreB item from Applicasa DB
- (void) deleteWithBlock:(LiBlockAction)block;

// Get ScoreB item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetScoreBFinished)block;

// Get ScoreB Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetScoreBArrayFinished)block;

// Get ScoreB Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetScoreBArrayFinished)block;

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
