//
//  SPSignature.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 9/28/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSignature : NSObject

+ (NSString *)signatureForString:(NSString *)text secretToken:(NSString *)token;
+ (BOOL)isSignatureValid:(NSString *)signature
                      forText: (NSString *)text
                  secretToken:(NSString *)token;
+ (NSString *)formattedSHA1forString:(NSString *)text;
+ (NSString *)formattedSHA1forString:(NSString *)text lowerCase:(BOOL)lowerCase ;
+ (NSString *)formattedMD5forString:(NSString *)text;

@end
