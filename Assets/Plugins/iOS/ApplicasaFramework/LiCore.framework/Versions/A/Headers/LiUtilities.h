//
//  LiUtilities.h
//  Applicasa
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//

//
//  NSData+Base64.h
//  base64
//
//  Created by Matt Gallagher on 2009/06/03.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#define Li_INT_MIN -2147483648

#define kINTEGER_TYPE @"INTEGER"
#define kREAL_TYPE @"REAL"
#define kTEXT_TYPE @"TEXT"
#define kDATETIME_TYPE @"DATETIME"
#define kPRIMARY_KEY @"PRIMARY KEY"
#define kResult @"Result"
#define kLiTrue     [LiBoolean liTrueVal]
#define kLiFalse    [LiBoolean liFalseVal]
#define TypeAndDefaultValue(type,val) [NSString stringWithFormat:@"%@ NOT NULL DEFAULT %@ ",type,val]

#define KeyWithHeader(key,header) [NSString stringWithFormat:@"%@%@",key,header]

void *LiNewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *LiNewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

@interface NSData (Base64)

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

@end

//  LiUIImage+Resize.h
//  Applicasa
//

@interface UIImage (ApplicasaResize)

- (UIImage *)applicasaResizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

@end

@interface NSMutableDictionary (CustomizedValues)

- (void) addValue:(NSString *)value forKey:(NSString *)key;
- (void) addIntValue:(NSInteger)value forKey:(NSString *)key;
- (void) addBoolValue:(BOOL)value forKey:(NSString *)key;
- (void) addFloatValue:(float)value forKey:(NSString *)key;
- (void) addURLValue:(NSURL *)url forKey:(NSString *)key;
- (void) addDateValue:(NSDate *)date forKey:(NSString *)key;
- (void) addGeoValue:(CLLocation *)geo forKey:(NSString *)key;
- (void) addForeignKeyValue:(NSDictionary *)dictionary forKey:(NSString *)key;

@end

@interface NSDate (LiISOParser)

- (NSString *) isoText;

@end

@interface NSString (LiISOParser)

- (NSDate *) isoDate;
- (id) liJSONValue;

@end

@interface NSString (LiEscapedCharcters)

- (NSString *) escapedCharctersValue;

@end


typedef void (^GetCachedImageFinished)(NSError *error, UIImage *image);
typedef void (^GetCachedDataFinished)(NSError *error, NSData *data);

@interface NSURL (LiCache)

- (void) getCachedImageWithBlock:(GetCachedImageFinished)block;
- (void) getCachedDataWithBlock:(GetCachedDataFinished)block;
- (void) cache;
- (void) deleteCache;

@end

@interface LiBoolean : NSObject <NSCopying>{
    BOOL val;
}

- (id) initWithVal:(BOOL)value;
- (BOOL) value;
- (BOOL) boolValue;

+ (LiBoolean *) liTrueVal;
+ (LiBoolean *) liFalseVal;

@end