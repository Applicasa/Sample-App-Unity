//
//  SPPersistence.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 9/28/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPPersistence : NSObject

+ (BOOL)didAdvertiserCallbackSucceed;
+ (void)setDidAdvertiserCallbackSucceed:(BOOL)successValue;

+ (BOOL)didActionCallbackSucceedForActionId:(NSString *)actionId;

+ (void)setDidActionCallbackSucceed:(BOOL)successValue
                        forActionId:(NSString *)actionId;

+ (NSString *)latestVCSTransactionIdForAppId:(NSString *)appId
                                      userId:(NSString *)userId
                          noTransactionValue:(NSString *)noTransactionValue;

+ (void)setLatestVCSTransactionId:(NSString *)transactionId
                         forAppId:(NSString *)appId
                           userId:(NSString *)userId;

+ (id)nestedValueWithPersistenceKey:(NSString *)persistenceKey
                         nestedKeys:(NSArray *)nestedKeys
                  defaultingToValue:(id)defaultValue;

+ (void)setNestedValue:(id)value
     forPersistenceKey:(NSString *)persistenceKey
            nestedKeys:(NSArray *)nestedKeys;

+ (void)resetAllSDKValues;

@end
