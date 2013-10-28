//
//  SPURLGenerator.m
//  SponsorPay iOS SDK
//
//  Copyright 2011-2013 SponsorPay. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SPURLParametersProvider.h"

//#define kSPShouldNotSendPlainMACAddress
//#define kSPShouldNotSendMD5MacAddress
//#define kSPShouldNotSendSHA1MacAddress

FOUNDATION_EXPORT NSString *const kSPURLParamKeyAllowCampaign;
FOUNDATION_EXPORT NSString *const kSPURLParamValueAllowCampaignOn;
FOUNDATION_EXPORT NSString *const kSPURLParamKeySkin;
FOUNDATION_EXPORT NSString *const kSPURLParamKeyOffset;
FOUNDATION_EXPORT NSString *const kSPURLParamKeyBackground;
FOUNDATION_EXPORT NSString *const kSPURLParamKeyCurrencyName;

@interface SPURLGenerator : NSObject

@property (retain, nonatomic) NSString *baseURLString;

- (id)initWithBaseURLString:(NSString *)baseURLString;

+ (SPURLGenerator *)URLGeneratorWithBaseURLString:(NSString *)baseUrl;

- (void)setAppID:(NSString *)appID;

- (void)setUserID:(NSString *)userID;

- (void)setParameterWithKey:(NSString *)key stringValue:(NSString *)value;

- (void)setParameterWithKey:(NSString *)key integerValue:(int)value;

- (void)setParametersFromDictionary:(NSDictionary *)dictionary;

- (void)addParametersProvider:(id<SPURLParametersProvider>)paramsProvider;

+ (void)setGlobalCustomParametersProvider:(id<SPURLParametersProvider>)provider;


- (NSURL *)generatedURL;

- (NSURL *)signedURLWithSecretToken:(NSString *)secretToken;

@end
