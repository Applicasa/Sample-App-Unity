//
// VirtualGoodCategory.h
// Created by Applicasa 
// 1/21/2014
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiKitFacebook.h>
#import <LiCore/LiKitIAP.h>
#import <LiCore/UpdateObject.h>



//*************
//
// VirtualGoodCategory Class
//
//

#define kVirtualGoodCategoryNotificationString @"VirtualGoodCategoryConflictFound"
#define kShouldVirtualGoodCategoryWorkOffline YES
@interface VirtualGoodCategory : LiObject <LiCoreRequestDelegate> {
}

@property (nonatomic, retain) NSString *virtualGoodCategoryID;
@property (nonatomic, retain) NSString *virtualGoodCategoryName;
@property (nonatomic, retain, readonly) NSDate *virtualGoodCategoryLastUpdate;
@property (nonatomic, assign, readonly) int virtualGoodCategoryPos;

 
// Save VirtualGoodCategoryitem to Applicasa DB
- (void) saveWithBlock:(LiBlockAction)block;

// Increase VirtualGoodCategory int and float fields item in Applicasa DB
- (void) increaseField:(LiFields)field byValue:(NSNumber *)value;

// Delete VirtualGoodCategory item from Applicasa DB
- (void) deleteWithBlock:(LiBlockAction)block;

// Get VirtualGoodCategory item from Applicasa DB
+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetVirtualGoodCategoryFinished)block;

// Get VirtualGoodCategory Array from Applicasa DB
// Limit up to 1500 records
// Use The Query's Order and Pager functions to manage the Get method
+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetVirtualGoodCategoryArrayFinished)block;

// Get VirtualGoodCategory Array from Local DB
+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetVirtualGoodCategoryArrayFinished)block;

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
