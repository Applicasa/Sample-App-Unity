//
//  SPCredentials.h
//  SponsorPay iOS SDK
//
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCredentials : NSObject <NSCopying>

@property (retain) NSString *appId;
@property (retain) NSString *userId;
@property (retain) NSString *securityToken;
@property (readonly) NSString *credentialsToken;
@property (readonly) NSMutableDictionary *userConfig;

+ (SPCredentials *)credentialsWithAppId:(NSString *)appId
                                 userId:(NSString *)userId
                          securityToken:(NSString *)securityToken;

+ (NSString *)credentialsTokenForAppId:(NSString *)appId
                                userId:(NSString *)userId;

@end
