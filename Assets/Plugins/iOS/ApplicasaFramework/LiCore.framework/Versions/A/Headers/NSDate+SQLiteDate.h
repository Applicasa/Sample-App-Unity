//
//  NSDate+SQLiteDate.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import <Foundation/Foundation.h>

void loadCategory();

@interface NSDate (SQLiteDate)

+ (NSDate *) dateWithMongoDictionary:(NSDictionary *)dictionary;
+ (NSDate *) dateWithSQLiteRepresentation: (NSString *) myString;
+ (NSDate *) dateWithSQLiteRepresentation: (NSString *) myString timeZone: (NSString *) myTimeZone;
+ (NSString *) sqlLiteDateFormat;
+ (NSString *) sqlLiteDateFormatWithTimeZone;
+ (NSDateFormatter *) sqlLiteDateFormatter;
+ (NSDateFormatter *) sqlLiteDateFormatterWithTimezone;
- (NSString *) sqlLiteDateRepresentation;
- (NSTimeInterval) unixTime;
- (NSTimeInterval) julianDay;




@end
