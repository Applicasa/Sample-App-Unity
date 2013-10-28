//
//  SPVirtualCurrencyConnector.h
//  SponsorPay iOS SDK
//
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPVirtualCurrencyServerConnector;

/* Handler that can be run when a successful answer to the delta of coins request (fetchDeltaOfCoins) is received.
 
 @param removeAfterExecuting A reference to a Boolean value. The block can set the value to YES if the block must run only once and be removed after it's called for the first time. This is useful to register a handler that will be run only on the next successful VCS callback, and ont on subsequent ones. This is an out-only argument. You should only ever set this Boolean to YES within the block.
 
 @see addFetchDeltaOfCoinsCompletionBlock

 */
typedef void (^SPVCSDeltaOfCoinsRequestCompletionBlock)(double deltaOfCoins,
                                                        NSString *latestTransactionId,
                                                        BOOL *removeAfterExecuting);

typedef enum {
    NO_ERROR,
    ERROR_NO_INTERNET_CONNECTION,
    ERROR_INVALID_RESPONSE,
    ERROR_INVALID_RESPONSE_SIGNATURE,
    SERVER_RETURNED_ERROR,
    ERROR_OTHER
} SPVirtualCurrencyRequestErrorType;

/** Defines selectors that a delegate of SPVirtualCurrencyServerConnector can implement for being notified of answers to requests and triggered errors.
 */
@protocol SPVirtualCurrencyConnectionDelegate <NSObject>
@required

/** Sent when SPVirtualCurrencyServerConnector receives an answer from the server for the amount of coins newly earned by the user.
 @param connector SPVirtualCurrencyServerConnector instance of SPVirtualCurrencyServerConnector that sent this message.
 @param deltaOfCoins Amount of coins earned by the user.
 @param transactionId Transaction ID of the last known operation involving your virtual currency for this user.
 */
- (void)virtualCurrencyConnector:(SPVirtualCurrencyServerConnector *)connector
  didReceiveDeltaOfCoinsResponse:(double)deltaOfCoins
             latestTransactionId:(NSString *)transactionId;

/** Sent when SPVirtualCurrencyServerConnector detects an error condition.
 @param connector SPVirtualCurrencyServerConnector instance of SPVirtualCurrencyServerConnector that sent this message.
 @param error Type of the triggered error. @see SPVirtualCurrencyRequestErrorType
 @param errorCode if this is an error received from the back-end, error code as reported by the server.
 @param errorMessage if this is an error received from the back-end, error message as reported by the server.
 */
- (void)virtualCurrencyConnector:(SPVirtualCurrencyServerConnector *)connector
                 failedWithError:(SPVirtualCurrencyRequestErrorType)error
                       errorCode:(NSString *)errorCode
                    errorMessage:(NSString *)errorMessage;
@end

/**
 The SPVirtualCurrencyServerConnector class provides functionality to query SponsorPay's Virtual Currency Servers to obtain the number of virtual coins the user has earned.
 
 It keeps track of the last time the amount of earned coins was requested for a given user, reporting newly earned amounts between successive requests, even across application sessions.
 
 The client is authenticated to the virtual currency server by signing URL requests with the secret token or key that SponsorPay has assigned to your publisher account, and that you must provide when initializing the SDK (@see SponsorPaySDK).
 
 Answers to the requests are asynchronously reported to your registered delegate through the selectors defined in the SPVirtualCurrencyConnectionDelegate protocol.
 */
@interface SPVirtualCurrencyServerConnector : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/** @name Authenticating the request and the signature */

/** The token to access your account on SponsorPay's virtual currency server.
 This token is used to sign requests to and verify responses from the SponsorPay currency server.
 */
@property (retain) NSString *secretToken;

/** Signature of the last response received from the server
 This is used in combination with secretToken to validate the authenticity of the response.
 */
@property (retain) NSString *responseSignature;

/** @name Obtaining the last transaction ID */

/** Latest transaction ID for your user and app IDs, as reported by the server.
 This is used to keep track of new transactions between invocations to fetchDeltaOfCoins.
 */
@property (retain, nonatomic) NSString *latestTransactionId;

/** @name Being notified asyncronously of server responses and errors */

/** Delegate to be notified of answers to requests and error conditions.
 Answers to the requests are asynchronously reported to your registered delegate through the selectors defined in the SPVirtualCurrencyConnectionDelegate protocol.
*/
@property (unsafe_unretained) id<SPVirtualCurrencyConnectionDelegate> delegate;

/** Adds a completion handler that will be run when a successful answer to fetchDeltaOfCoins is received.
  
 Though you could use this method to obtain the same functionality that registering a SPVirtualCurrencyConnectionDelegate offers for being notified of the amount of coins earned by the user, relying on the delegate is the recommended way of being notified of the results of the request, as it can handle error conditions.
 
 The supplied handler will be run in the main thread. Multiple completion handlers can be specified in successive calls and they will run in the order in which they were added.
 
 @param completionBlock Block to be run when a successful answer to the delta of coins request is received.
 */
- (void)addFetchDeltaOfCoinsCompletionBlock:(SPVCSDeltaOfCoinsRequestCompletionBlock)completionBlock;

/** Fetches the amount of coins earned since the last time this method was invoked for the current user ID / app ID combination.
 
 This involves a network call which will be performed in the background. When the answer from the server is received, your registered delegate will be notified.
 */
- (void)fetchDeltaOfCoins;

/** @name - **/

+ (void)overrideVCSBaseURLWithURLString:(NSString *)overridingURL;
+ (void)restoreDefaultVCSBaseURL;

+ (NSString *)descriptionForErrorType:(SPVirtualCurrencyRequestErrorType) errorType;

@end

FOUNDATION_EXPORT NSString *const SPVCSPayoffReceivedNotification;
FOUNDATION_EXPORT NSString *const SPVCSPayoffAmountKey;
FOUNDATION_EXPORT NSString *const SPVCSTransactionIdKey;

