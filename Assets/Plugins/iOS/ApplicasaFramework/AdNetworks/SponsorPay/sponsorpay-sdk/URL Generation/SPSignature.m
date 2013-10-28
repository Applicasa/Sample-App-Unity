//
//  SPSignature.m
//  SponsorPay iOS SDK
//
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import "SPSignature.h"
#import "SPLogger.h"
#include <CommonCrypto/CommonDigest.h>

@implementation SPSignature

+ (NSString *)signatureForString:(NSString *)text secretToken:(NSString *)token
{
    
    NSString *textPlusToken = token ? [text stringByAppendingString:token] : text;
    
    return [SPSignature formattedSHA1forString:textPlusToken lowerCase:YES];
}

+ (BOOL)isSignatureValid:(NSString *)signature
                      forText: (NSString *)text
                  secretToken:(NSString *)token
{
    NSString *calculatedSignature = [SPSignature signatureForString:text
                                                        secretToken:token];
    return [signature isEqualToString:calculatedSignature];
}

+ (NSString *)formattedSHA1forString:(NSString *)text {
    return [SPSignature formattedSHA1forString:text lowerCase:NO];
}

+ (NSString *)formattedSHA1forString:(NSString *)text lowerCase:(BOOL)lowerCase {
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        NSMutableString	*hexDigest = [NSMutableString stringWithCapacity:10];
        NSString *formatString = lowerCase ? @"%02x" : @"%02X";
        /* SHA-1 hash has been calculated and stored in 'digest'. */
        for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [hexDigest appendString:[NSString stringWithFormat:formatString, digest[i]]];
        }
        
		return hexDigest;
    }
    
    return nil;
}

+ (NSString *)formattedMD5forString:(NSString *)text {
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
    bool didMD5Succeed = CC_MD5(textData.bytes, textData.length, digest);
    if (!didMD5Succeed) {
        [SPLogger log:@"MD5 digest generation failed"];
        return nil;
    }
    NSMutableString	*hexDigest = [NSMutableString stringWithCapacity:10];
	
	
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hexDigest appendString:[NSString stringWithFormat:@"%02X", digest[i]]];
    }
    
	return hexDigest;
}
@end
