//
//  SPResourceLoader.m
//  SponsorPaySample
//
//  Created by David Davila on 7/30/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPResourceLoader.h"
#import "SPLogger.h"

@implementation SPResourceLoader

+ (NSBundle *)frameworkBundle
{
    static NSBundle* frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"SponsorPaySDK.bundle"];
        frameworkBundle = [[NSBundle bundleWithPath:frameworkBundlePath] retain];
    });
    return frameworkBundle;
}


+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *foundImage = [UIImage imageNamed:name];

    if (!foundImage) {
        foundImage = [UIImage imageWithContentsOfFile:[[[self class] frameworkBundle] pathForResource:name ofType:@"png"]];
        [SPLogger log:@"Grabbing resource from SDK bundle: %@", foundImage];
    }
    
    return foundImage;
}

@end
