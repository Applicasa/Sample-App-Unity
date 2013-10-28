//
//  SPVirtualCurrencyConnector.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 9/23/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import "SPVirtualCurrencyServerConnector.h"
#import "SPVirtualCurrencyServerConnector_SDKPrivate.h"
#import "SPURLGenerator.h"
#import "SPSignature.h"
#import "SPLogger.h"
#import "SPPersistence.h"
#import "SponsorPaySDK.h"


#define SP_VCS_BASE_URL		@"https://api.sponsorpay.com/vcs/v1/"
static NSString *const SP_CURRENCY_DELTA_REQUEST_RESOURCE = @"new_credit.json";

// URL parameters to pass on the query string
static NSString *const URL_PARAM_KEY_APP_ID = @"appid";
static NSString *const URL_PARAM_KEY_USER_ID = @"uid";
static NSString *const URL_PARAM_KEY_LAST_TRANSACTION_ID = @"ltid";
static NSString *const URL_PARAM_KEY_TIMESTAMP = @"timestamp";

static NSString *const SP_VCS_JSON_KEY_DELTA_OF_COINS = @"delta_of_coins";
static NSString *const SP_VCS_JSON_KEY_LATEST_TRANSACTION_ID = @"latest_transaction_id";
static NSString *const SP_VCS_JSON_KEY_ERROR_CODE = @"code";
static NSString *const SP_VCS_JSON_KEY_ERROR_MESSAGE = @"message";

static NSString *const SP_VCS_RESPONSE_SIGNATURE_HEADER = @"X-Sponsorpay-Response-Signature";

static NSString *const SP_VCS_LATEST_TRANSACTION_ID_VALUE_NO_TRANSACTION = @"NO_TRANSACTION";
static NSString *const SP_VCS_LATEST_TRANSACTION_IDS_KEY = @"SPVCSLatestTransactionIds";

NSString *const SPVCSPayoffReceivedNotification = @"SPVCSPayoffReceivedNotification";
NSString *const SPVCSPayoffAmountKey = @"SPVCSPayoffAmountKey";
NSString *const SPVCSTransactionIdKey = @"SPVCSTransactionIdKey";

static NSString *VCSBaseURL = SP_VCS_BASE_URL;

@interface SPVirtualCurrencyServerConnector()

@property (retain) NSString *appId;
@property (retain) NSString *userId;

@property (retain, nonatomic) NSURLConnection *currentConnection;
@property (retain, nonatomic) NSMutableData *responseData;
@property (readonly, nonatomic) NSString *responseString;
@property (assign, nonatomic) NSInteger responseStatusCode;
@property (retain, nonatomic) NSMutableArray *fetchDeltaOfCoinsCompletionBlocks;

@end

@implementation SPVirtualCurrencyServerConnector

#pragma mark - Manually implemented property accessors

- (void)setCurrentConnection:(NSURLConnection *)connection
{
    if (_currentConnection) {
        [_currentConnection cancel];
        [_currentConnection release];
    }
    _currentConnection = [connection retain];
}

- (NSString *)latestTransactionId
{
    return [[self class] persistedLatestTransactionIdForAppId:self.appId userId:self.userId];
}

- (void)setLatestTransactionId:(NSString *)ltid
{
    [[self class] persistLatestTransactionId:ltid forAppId:self.appId userId:self.userId];
}

- (NSString *)responseString
{
    NSString *bodyString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    
    return [bodyString autorelease];
}

#pragma mark - Initializing and deallocating

- (id)init
{
    return [super init];
}

- (void)dealloc
{
    self.responseSignature = nil;
    self.appId = nil;
    self.userId = nil;
    self.secretToken = nil;
    self.delegate = nil;
    self.currentConnection = nil;
    self.responseData = nil;
    self.fetchDeltaOfCoinsCompletionBlocks = nil;
    
    [super dealloc];
}

#pragma mark - VCS services

- (void)fetchDeltaOfCoins
{
    NSString *resourceUrl = [VCSBaseURL stringByAppendingString:SP_CURRENCY_DELTA_REQUEST_RESOURCE];
    
    SPURLGenerator *urlGenerator = [SPURLGenerator URLGeneratorWithBaseURLString:resourceUrl];
    
    [urlGenerator setParameterWithKey:URL_PARAM_KEY_APP_ID stringValue:self.appId];
    [urlGenerator setParameterWithKey:URL_PARAM_KEY_USER_ID stringValue:self.userId];
    [urlGenerator setParameterWithKey:URL_PARAM_KEY_LAST_TRANSACTION_ID
                          stringValue:self.latestTransactionId];
    
    NSNumber *timestamp = [NSNumber numberWithDouble:[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] ];
    [urlGenerator setParameterWithKey:URL_PARAM_KEY_TIMESTAMP integerValue:[timestamp integerValue]];

    NSURL *urlForVCSRequest = [urlGenerator signedURLWithSecretToken:self.secretToken];
    
    [SPLogger log:@"VCS request will be sent with url: %@", urlForVCSRequest];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urlForVCSRequest
                                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                        timeoutInterval:60.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        self.currentConnection = connection;
        self.responseData = [NSMutableData data];
    } else {
        [SPLogger log:@"Connection to SP VCS initialization failed (%@)", connection];
        [self notifyOfError:ERROR_OTHER errorCode:nil errorMessage:nil];
    }
    
    [connection release];
}


#pragma mark - NSURLConnectionDelegate and NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.responseStatusCode = httpResponse.statusCode;
    NSDictionary *responseHeaders = [httpResponse allHeaderFields];
    self.responseSignature = [responseHeaders objectForKey:SP_VCS_RESPONSE_SIGNATURE_HEADER];
    
    [SPLogger log:@"Received response from SP VCS with status code: %d", self.responseStatusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [SPLogger log:@"Connection to SP VCS failed with error: %@", error];
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        [self notifyOfError:ERROR_NO_INTERNET_CONNECTION errorCode:nil errorMessage:nil];
    } else {
        [self notifyOfError:ERROR_OTHER errorCode:nil errorMessage:nil];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [SPLogger log:@"Connection to SP VCS finished loading. Body: %@", self.responseString];
    
    [self processDeltaOfCoinsResponse];
    
    self.responseData = nil;
}

#pragma mark - Response processing

- (void)processDeltaOfCoinsResponse
{
    NSError *parseResponseError = nil;
    id responseAsJson = [self parseJSONResponseWithError:&parseResponseError];
    
    if (parseResponseError) {
        [SPLogger log:@"Parsing SP VCS response as JSON failed. Error is: %@", parseResponseError];
        [self notifyOfError:ERROR_INVALID_RESPONSE errorCode:nil errorMessage:nil];
        return;
    }

    if (![responseAsJson respondsToSelector:@selector(objectForKey:)]) {
        [SPLogger log:@"Parsing SP VCS response failed. It doesn't look like a valid dictionary"];
        [self notifyOfError:ERROR_INVALID_RESPONSE errorCode:nil errorMessage:nil];
        return;
    }

    if (self.responseStatusCode != 200) { // server returned error
        NSString *errorCode = [responseAsJson objectForKey:SP_VCS_JSON_KEY_ERROR_CODE];
        NSString *errorMessage = [responseAsJson objectForKey:SP_VCS_JSON_KEY_ERROR_MESSAGE];
        
        [self notifyOfError:SERVER_RETURNED_ERROR errorCode:errorCode errorMessage:errorMessage];
        return;
    }

    
    BOOL isSignatureValid = [SPSignature isSignatureValid:self.responseSignature
                                                  forText:self.responseString
                                              secretToken:self.secretToken];
    if (!isSignatureValid) {
        [self notifyOfError:ERROR_INVALID_RESPONSE_SIGNATURE
                          errorCode:nil
                       errorMessage:nil];
        return;
    }
    
    NSString *deltaOfCoins = [responseAsJson objectForKey:SP_VCS_JSON_KEY_DELTA_OF_COINS];
    NSString *transactionId = [responseAsJson objectForKey:SP_VCS_JSON_KEY_LATEST_TRANSACTION_ID];
    
    if (deltaOfCoins == nil || transactionId == nil) {
        [SPLogger log:@"Parsing SP VCS response failed: missing expected keys."];
        [self notifyOfError:ERROR_INVALID_RESPONSE errorCode:nil errorMessage:nil];
        return;
    }

    self.latestTransactionId = transactionId;

    [self notifyOfDeltaOfCoinsResponseReceivedWithAmount:deltaOfCoins
                                  latestTransactionId:transactionId];
    
    
}

- (id)parseJSONResponseWithError:(NSError **)error
{
    id responseAsJson = nil;
    responseAsJson = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                        options:0 error:error];
    return responseAsJson;
}

#pragma mark - Callback handling

- (void)notifyOfError:(SPVirtualCurrencyRequestErrorType)error
            errorCode:(NSString *)errorCode
         errorMessage:(NSString *)errorMessage
{
    if (self.delegate) {
        [self.delegate virtualCurrencyConnector:self failedWithError:error
                                      errorCode:errorCode
                                   errorMessage:errorMessage];
    }
}

- (void)notifyOfDeltaOfCoinsResponseReceivedWithAmount:(NSString *)amount
                                   latestTransactionId:(NSString *)transactionId
{
    double amountAsDouble = [self amountAsDouble:amount];
    
    if (self.delegate)
        [self.delegate virtualCurrencyConnector:self
                 didReceiveDeltaOfCoinsResponse:amountAsDouble
                            latestTransactionId:transactionId];

    [self runCompletionBlocksWithAmount:amountAsDouble transactionId:transactionId];
    
    if (amountAsDouble > 0.0)
        [self postPayoffReceivedNotificationWithAmount:amountAsDouble transactionId:transactionId];
}

- (double)amountAsDouble:(NSString *)amount
{
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [[numberFormatter numberFromString:amount] doubleValue];
}

- (void)runCompletionBlocksWithAmount:(double)amount transactionId:(NSString *)transactionId
{
    if (self.fetchDeltaOfCoinsCompletionBlocks) {
        for (NSInteger i = self.fetchDeltaOfCoinsCompletionBlocks.count - 1; i >=0; i--) {
            SPVCSDeltaOfCoinsRequestCompletionBlock completionBlock =
            [self.fetchDeltaOfCoinsCompletionBlocks objectAtIndex:i];
            BOOL mustRemoveBlock;
            
            completionBlock(amount, transactionId, &mustRemoveBlock);
            
            if (mustRemoveBlock)
                [self.fetchDeltaOfCoinsCompletionBlocks removeObjectAtIndex:i];
        }
    }
}

- (void)postPayoffReceivedNotificationWithAmount:(double)amount transactionId:(NSString *)transactionId
{
    [SPLogger log:@"VCS Connector posting payoff received notification with amount=%f, "
     "appId=%@ userId=@ notification key=%@",
     amount, self.appId, self.userId, SPVCSPayoffReceivedNotification];
    
    NSDictionary *notificationInfo = @{
        SPAppIdKey : self.appId,
        SPUserIdKey : self.userId,
        SPVCSPayoffAmountKey: [NSNumber numberWithDouble:amount],
        SPVCSTransactionIdKey: transactionId
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:SPVCSPayoffReceivedNotification
                                                        object:self
                                                      userInfo:notificationInfo];
}

- (void)addFetchDeltaOfCoinsCompletionBlock:(SPVCSDeltaOfCoinsRequestCompletionBlock)completionBlock
{
    if (!self.fetchDeltaOfCoinsCompletionBlocks) {
        self.fetchDeltaOfCoinsCompletionBlocks = [NSMutableArray arrayWithCapacity:1];
    }
    [self.fetchDeltaOfCoinsCompletionBlocks addObject:[[completionBlock copy] autorelease]];
}

#pragma mark - Persistence

+ (NSString *)persistedLatestTransactionIdForAppId:(NSString *)appId
                                            userId:(NSString *)userId
{
    return [SPPersistence latestVCSTransactionIdForAppId:appId
                                                  userId:userId
                                      noTransactionValue:SP_VCS_LATEST_TRANSACTION_ID_VALUE_NO_TRANSACTION];
}

+ (void)persistLatestTransactionId:(NSString *)transactionId
                          forAppId:(NSString *)appId
                            userId:(NSString *)userId
{
    [SPPersistence setLatestVCSTransactionId:transactionId
                                    forAppId:appId
                                      userId:userId];
}

#pragma mark - VCS base URL override

+ (void)overrideVCSBaseURLWithURLString:(NSString *)overridingURL
{
    [VCSBaseURL release];
    VCSBaseURL = [overridingURL retain];
}

+ (void)restoreDefaultVCSBaseURL
{
    [self overrideVCSBaseURLWithURLString:SP_VCS_BASE_URL];
}

+ (NSString *)descriptionForErrorType:(SPVirtualCurrencyRequestErrorType)errorType
{
    switch (errorType)
    {
        case NO_ERROR:
            return @"NO_ERROR";
        case ERROR_NO_INTERNET_CONNECTION:
            return @"ERROR_NO_INTERNET_CONNECTION";
        case ERROR_INVALID_RESPONSE:
            return @"ERROR_INVALID_RESPONSE";
        case ERROR_INVALID_RESPONSE_SIGNATURE:
            return @"ERROR_INVALID_RESPONSE_SIGNATURE";
        case SERVER_RETURNED_ERROR:
            return @"SERVER_RETURNED_ERROR";
        case ERROR_OTHER:
            return @"ERROR_OTHER";
        default:
            return @"UNKNOWN";
    }
}

@end
