//
// VirtualGoodCategory.h
// Created by Applicasa 
// 6/24/2013
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

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/
 
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

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind;

+ (void) getArrayWithFilter:(LiFilters *)filter withBlock:(UpdateObjectFinished)block;

// uploadFile
- (void) uploadFile:(NSData *)data toField:(LiFields)field withFileType:(AMAZON_FILE_TYPES)fileType extension:(NSString *)ext andBlock:(LiBlockAction)block;


#pragma mark - End of Basic SDK

@end
