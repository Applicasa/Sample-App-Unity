//
// Languages.h
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
// Languages Class
//
//

#define kLanguagesNotificationString @"LanguagesConflictFound"
#define kShouldLanguagesWorkOffline YES
@interface Languages : LiObject <LiCoreRequestDelegate> {
}

@property (nonatomic, retain) NSString *languagesID;
@property (nonatomic, retain, readonly) NSDate *languagesLastUpdate;
@property (nonatomic, retain) NSString *languagesText;
@property (nonatomic, retain) NSString *languagesLanguageName;

 
// Save Languagesitem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase Languages int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Delete Languages item from Applicasa DB
- (void) deleteWithBlock:(LiBlockAction)block;

// Get Languages item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetLanguagesFinished)block;

// Get Languages Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetLanguagesArrayFinished)block;

// Get Languages Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetLanguagesArrayFinished)block;

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
