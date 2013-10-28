//
// Foo.h
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
// Foo Class
//
//

#define kFooNotificationString @"FooConflictFound"
#define kShouldFooWorkOffline YES
@class User;
@interface Foo : LiObject <LiCoreRequestDelegate> {
}

@property (nonatomic, retain) NSString *fooID;
@property (nonatomic, retain, readonly) NSDate *fooLastUpdate;
@property (nonatomic, retain) NSString *fooName;
@property (nonatomic, retain) NSString *fooDescription;
@property (nonatomic, assign) BOOL fooBoolean;
@property (nonatomic, retain) NSDate *fooDate;
@property (nonatomic, retain) NSURL *fooImage;
@property (nonatomic, retain) NSURL *fooFile;
@property (nonatomic, retain) CLLocation *fooLocation;
@property (nonatomic, assign) int fooNumber;
@property (nonatomic, assign) int fooAge;
@property (nonatomic, retain) User *fooOwner;

 
// Save Fooitem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase Foo int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Delete Foo item from Applicasa DB
- (void) deleteWithBlock:(LiBlockAction)block;

// Get Foo item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetFooFinished)block;

// Get Foo Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetFooArrayFinished)block;

// Get Foo Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetFooArrayFinished)block;

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
