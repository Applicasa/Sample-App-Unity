//
//  SPURLGenerator.m
//  SponsorPay iOS SDK
//
//  Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <objc/runtime.h>

#import "SPURLGenerator.h"
#import "SPSignature.h"
#import "SPLogger.h"

#import "SPSystemParametersProvider.h"
#import "SPLocaleParametersProvider.h"
#import "SPJailbreakStatusProvider.h"
#import "SPScreenMetricsProvider.h"
#import "SPNetworkParametersProvider.h"
#import "SPHostAppBundleParametersProvider.h"
#import "SPAppleAdvertiserIDProvider.h"
#import "SPSDKVersionProvider.h"
#import "SPMacAddressProvider.h"
#import "SPMD5MacAddressProvider.h"
#import "SPSHA1MacAddressProvider.h"
#import "../SPSystemVersionChecker.h"
#import "NSString+SPURLEncoding.h"

static NSString *const kSPURLParamKeySignature = @"signature";

static NSString *const kSPURLParamKeyAppID = @"appid";
static NSString *const kSPURLParamKeyUserID = @"uid";

NSString *const kSPURLParamKeyAllowCampaign = @"allow_campaign";
NSString *const kSPURLParamValueAllowCampaignOn = @"on";
NSString *const kSPURLParamKeySkin = @"skin";
NSString *const kSPURLParamKeyOffset = @"offset";
NSString *const kSPURLParamKeyBackground = @"background";
NSString *const kSPURLParamKeyCurrencyName = @"currency";

@interface SPURLGenerator()

@property (readonly, retain) NSMutableDictionary *parametersDictionary;
@property (readonly, retain) NSMutableSet *parameterProviders;

@end

@implementation SPURLGenerator {
    NSMutableDictionary *_parametersDictionary;
    NSMutableSet *_parameterProviders;
}

#pragma mark - Initialization and configuration

- (id)initWithBaseURLString:(NSString *)baseURLString
{
    self = [super init];
    
    if (self) {
        self.baseURLString = baseURLString;
    }
    
    return self;
}

- (void)setAppID:(NSString *)appID
{
    [self setParameterWithKey:kSPURLParamKeyAppID stringValue:appID];
}

- (void)setUserID:(NSString *)userID
{
    [self setParameterWithKey:kSPURLParamKeyUserID stringValue:userID];
}

- (void)setParameterWithKey:(NSString *)key stringValue:(NSString *)stringValue
{
    if (stringValue)
        [self.parametersDictionary setObject:stringValue forKey:key];
}

- (void)setParameterWithKey:(NSString *)key integerValue:(int)intValue
{
    [self setParameterWithKey:key
                  stringValue:[NSString stringWithFormat:@"%d", intValue]];
}

- (void)setParametersFromDictionary:(NSDictionary *)dictionary
{
    [dictionary enumerateKeysAndObjectsWithOptions:0
                                        usingBlock:^(id key, id obj, BOOL *stop) {
                                            NSString *value =
                                            [obj isKindOfClass:[NSString class]] ? obj : [obj stringRepresentation];
                                            [self setParameterWithKey:key stringValue:value];
                                        }];
}

- (void)addParametersProvider:(id<SPURLParametersProvider>)paramsProvider
{
    if (paramsProvider)
        [self.parameterProviders addObject:paramsProvider];
}

- (void)addParametersProviderWithClass:(Class)paramsProviderClass
{
    NSAssert(class_conformsToProtocol(paramsProviderClass, @protocol(SPURLParametersProvider)),
             @"Parameters Provider's class %s must conform to the SPURLParametersProvider protocol.",
             class_getName(paramsProviderClass));
    
    id<SPURLParametersProvider> paramsProvider = [[paramsProviderClass alloc] init];
    [self addParametersProvider:paramsProvider];
    [paramsProvider release];
}

- (void)removeParametersProvider:(id<SPURLParametersProvider>)paramsProvider
{
    [self.parameterProviders removeObject:paramsProvider];
}

- (void)removeParameterProviderWithClass:(Class)paramsProviderClass {
    __block id paramsProviderToRemove = nil;
    
    [self.parameterProviders enumerateObjectsWithOptions:NSEnumerationConcurrent
                                              usingBlock:^(id obj, BOOL *stop) {
                                                  if ([obj isMemberOfClass:paramsProviderClass]) {
                                                      paramsProviderToRemove = obj;
                                                      *stop = YES;
                                                  }
                                              }];
    if (paramsProviderToRemove) {
        [self removeParametersProvider:paramsProviderToRemove];
    }
}

# pragma mark - Global custom parameters

static id<SPURLParametersProvider> globalCustomParametersProvider;

+(void)setGlobalCustomParametersProvider:(id<SPURLParametersProvider>)provider
{
    [globalCustomParametersProvider release];
    globalCustomParametersProvider = [provider retain];
}

#pragma mark - URL generation

- (NSURL *)generatedURL
{
    return [NSURL URLWithString:[self generatedURLString]];
}

- (NSString *)generatedURLString
{
    return [self.baseURLString stringByAppendingString:[self stringOfEncodedParameters]];
}

- (NSString *)signedURLWithSecretToken:(NSString *)secretToken
{
    return [NSURL URLWithString:[self signedURLStringWithSecretToken:secretToken]];
}

- (NSString *)signedURLStringWithSecretToken:(NSString *)secretToken
{
    return [NSString stringWithFormat:@"%@%@=%@", [self generatedURLString],
            kSPURLParamKeySignature, [self signatureWithToken:secretToken]];
}

- (NSString *)stringOfEncodedParameters
{
    [self setParametersFromProviders];
    
    NSMutableString *encodedParams = [NSMutableString stringWithCapacity:255];
    [encodedParams appendString:@"?"];
    for (NSString *currKey in self.parametersDictionary) {
        NSString *currValue = [[self.parametersDictionary objectForKey:currKey] SPURLEncodedString];
        [encodedParams appendFormat:@"%@=%@&", currKey, currValue];
    }
    
    return encodedParams;
}

- (void)setParametersFromProviders
{
    [self.parameterProviders enumerateObjectsWithOptions:0
                                              usingBlock:^(id parametersProvider, BOOL *stop) {
                                                  [self setParametersFromDictionary:
                                                   [parametersProvider dictionaryWithKeyValueParameters]];
                                              }];
    
    if(globalCustomParametersProvider) {
        [self setParametersFromDictionary:[globalCustomParametersProvider dictionaryWithKeyValueParameters]];
    }
}

- (NSString *)signatureWithToken:(NSString *)token
{
    NSArray *paramKeys = [self.parametersDictionary allKeys];
    NSArray *orderedParamKeys = [paramKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *concatenatedOrderedParams = [[NSMutableString alloc] initWithCapacity:255];
    NSEnumerator *e = [orderedParamKeys objectEnumerator];
    for (NSString *paramKey = [e nextObject]; nil!=paramKey; paramKey = [e nextObject]) {
        NSString *paramValue = [self.parametersDictionary objectForKey:paramKey];
        NSString *keyValueParam = [NSString stringWithFormat:@"%@=%@&", paramKey, paramValue];
        [concatenatedOrderedParams appendString:keyValueParam];
    }
    
    NSString *signature  = [SPSignature signatureForString:concatenatedOrderedParams secretToken:token];
    [concatenatedOrderedParams release];
    return signature;
}

#pragma mark - Housekeeping

- (NSMutableDictionary *)parametersDictionary
{
    if (!_parametersDictionary) {
        _parametersDictionary = [[NSMutableDictionary dictionaryWithCapacity:10] retain];
    }
    return _parametersDictionary;
}

- (NSMutableSet *)parameterProviders
{
    if (!_parameterProviders) {
        _parameterProviders = [[NSMutableSet alloc] initWithCapacity:14];
    }
    return _parameterProviders;
}

- (void)dealloc
{
    self.baseURLString = nil;
    [_parametersDictionary release];
    [_parameterProviders release];
    [super dealloc];
}

#pragma mark - Static factory

+ (SPURLGenerator *)URLGeneratorWithBaseURLString:(NSString *)baseUrl
{
    SPURLGenerator *urlGenerator = [[SPURLGenerator alloc] initWithBaseURLString:baseUrl];
    
    [urlGenerator addParametersProviderWithClass:[SPSystemParametersProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPLocaleParametersProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPJailbreakStatusProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPScreenMetricsProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPNetworkParametersProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPHostAppBundleParametersProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPAppleAdvertiserIDProvider class]];
    [urlGenerator addParametersProviderWithClass:[SPSDKVersionProvider class]];

    if (![SPSystemVersionChecker runningOniOS7OrNewer]) {
#ifndef kSPShouldNotSendPlainMACAddress
        [urlGenerator addParametersProviderWithClass:[SPMacAddressProvider class]];
#endif
    
#ifndef kSPShouldNotSendMD5MacAddress
        [urlGenerator addParametersProviderWithClass:[SPMD5MacAddressProvider class]];
#endif
    
#ifndef kSPShouldNotSendSHA1MacAddress
        [urlGenerator addParametersProviderWithClass:[SPSHA1MacAddressProvider class]];
#endif
    }
    return [urlGenerator autorelease];
}

@end
