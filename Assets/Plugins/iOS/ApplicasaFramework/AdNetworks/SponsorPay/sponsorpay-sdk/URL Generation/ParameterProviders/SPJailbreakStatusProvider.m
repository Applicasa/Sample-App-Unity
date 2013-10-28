//
//  SPJailbreakStatusProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/2/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

static NSString *const kSPURLParamKeyJailbroken = @"jailbroken";
static NSString *const kSPURLParamValueJailbrokenYes = @"true";
static NSString *const kSPURLParamValueJailbrokenNo = @"false";

#import "SPJailbreakStatusProvider.h"

static const char* jailbreakApps[] = {
	"/Applications/Cydia.app",
	"/Applications/limera1n.app",
	"/Applications/greenpois0n.app",
	"/Applications/blackra1n.app",
	"/Applications/blacksn0w.app",
	"/Applications/redsn0w.app",
	NULL,
};

@implementation SPJailbreakStatusProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    NSString *isJailbrokenStatusValue = [[self class] isJailbroken] ? kSPURLParamValueJailbrokenYes : kSPURLParamValueJailbrokenNo;
    NSDictionary *jailbreakStatusParams = @{kSPURLParamKeyJailbroken : isJailbrokenStatusValue};

    return jailbreakStatusParams;
}

+ (BOOL) isJailbroken
{
    static BOOL jailbrokenValueCached = NO;
    static BOOL jailbrokenStatus = NO;
    
    if (!jailbrokenValueCached) {
        for (int i = 0; jailbreakApps[i] != NULL; ++i) {
            NSString *appPath = [NSString stringWithUTF8String:jailbreakApps[i]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:appPath]) {
                jailbrokenStatus = YES;
                break;
            }
        }
        jailbrokenValueCached = YES;
	}
    
	return jailbrokenStatus;
}

@end
