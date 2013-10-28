//
//  SPCredentials.m
//  SponsorPay iOS SDK
//
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPCredentials.h"

@implementation SPCredentials {
    NSMutableDictionary *_userConfig;
}

@synthesize userConfig = _userConfig;

#pragma mark - Initialization and deallocation

- (id)init
{
    self = [super init];
    if (self) {
        _userConfig = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    return self;
}

- (void)dealloc
{
    self.appId = nil;
    self.userId = nil;
    self.securityToken = nil;
    
    [_userConfig release];
    _userConfig = nil;
    
    [super dealloc];
}

#pragma mark - Token generation

- (NSString *)credentialsToken
{
    return [[self class] credentialsTokenForAppId:self.appId
                                           userId:self.userId];
}

#pragma mark - Overridden NSObject methods to enable usage as a dictionary key

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [[object credentialsToken] isEqualToString:self.credentialsToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    SPCredentials *copiedCredentials = [[SPCredentials allocWithZone:zone] init];
    copiedCredentials.appId = self.appId;
    copiedCredentials.userId = self.userId;
    copiedCredentials.securityToken = self.securityToken;
    
    return copiedCredentials;
}

#pragma mark - 

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ {appId=%@ userId=%@ securityToken=%@ userConfig=%@}",
            [super description], self.appId, self.userId, self.securityToken, self.userConfig];
}

#pragma mark - Factory class methods

+ (SPCredentials *)credentialsWithAppId:(NSString *)appId
                                 userId:(NSString *)userId
                          securityToken:(NSString *)securityToken
{
    SPCredentials *credentials = [[SPCredentials alloc] init];
    credentials.appId = appId;
    credentials.userId = userId;
    credentials.securityToken = securityToken;
    
    return [credentials autorelease];
}

+ (NSString *)credentialsTokenForAppId:(NSString *)appId
                                userId:(NSString *)userId
{
    return [NSString stringWithFormat:@"SponsorPayCredentials:%@:%@", appId, userId];
}

@end