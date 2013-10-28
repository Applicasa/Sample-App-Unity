//
//  SPPersistence.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 9/28/11.
//  Copyright (c) 2011 SponsorPay. All rights reserved.
//

#import "SPPersistence.h"

// TODO make constant strings
#define SP_ADVERTISER_CALLBACK_SUCCESS_KEY                        @"SPDidAdvertiserCallbackSucceed"
#define SP_ACTION_CALLBACK_SUCCESS_KEY                            @"SPDidActionCallbackSucceed"
#define SP_VCS_LATEST_TRANSACTION_IDS_KEY                         @"SPVCSLatestTransactionIds"


@implementation SPPersistence

+ (BOOL)didAdvertiserCallbackSucceed
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SP_ADVERTISER_CALLBACK_SUCCESS_KEY]; 
}

+ (void)setDidAdvertiserCallbackSucceed:(BOOL)successValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:successValue forKey:SP_ADVERTISER_CALLBACK_SUCCESS_KEY];
    [defaults synchronize];
}

+ (BOOL)didActionCallbackSucceedForActionId:(NSString *)actionId
{
    if (!actionId) {
        return NO;
    }
    
    NSNumber *persistedValue = [self nestedValueWithPersistenceKey:SP_ACTION_CALLBACK_SUCCESS_KEY
                                                        nestedKeys:@[actionId]
                                                 defaultingToValue:[NSNumber numberWithBool:NO]];
    return [persistedValue boolValue];
}

+ (void)setDidActionCallbackSucceed:(BOOL)successValue
                        forActionId:(NSString *)actionId
{
    NSNumber *boxedSuccessValue = [NSNumber numberWithBool:successValue];
    [self setNestedValue:boxedSuccessValue
       forPersistenceKey:SP_ACTION_CALLBACK_SUCCESS_KEY
              nestedKeys:@[actionId]];
}

+ (NSString *)latestVCSTransactionIdForAppId:(NSString *)appId
                                      userId:(NSString *)userId
                          noTransactionValue:(NSString *)noTransactionValue
{
    NSDictionary *fetchedTransactionIds =
    [[NSUserDefaults standardUserDefaults] dictionaryForKey:SP_VCS_LATEST_TRANSACTION_IDS_KEY];
    
    NSDictionary *transactionIdsForApp = [fetchedTransactionIds objectForKey:appId];
    NSString *transactionIdForAppAndUser = [transactionIdsForApp objectForKey:userId];
    
    if (!transactionIdForAppAndUser) {
        transactionIdForAppAndUser = noTransactionValue;
    }

    return [self nestedValueWithPersistenceKey:SP_VCS_LATEST_TRANSACTION_IDS_KEY
                                    nestedKeys:@[appId, userId]
                             defaultingToValue:noTransactionValue];
}


+ (void)setLatestVCSTransactionId:(NSString *)transactionId
                         forAppId:(NSString *)appId
                           userId:(NSString *)userId
{
    if (!transactionId || !appId || !userId) {
        return;
    }
    
    [self setNestedValue:transactionId
       forPersistenceKey:SP_VCS_LATEST_TRANSACTION_IDS_KEY
              nestedKeys:@[appId, userId]];
}

+ (id)nestedValueWithPersistenceKey:(NSString *)persistenceKey
                         nestedKeys:(NSArray *)nestedKeys
                  defaultingToValue:(id)defaultValue
{
    NSDictionary *outerDictionary =
    [[NSUserDefaults standardUserDefaults] dictionaryForKey:persistenceKey];
    
    id value = outerDictionary;
    
    for (NSString *key in nestedKeys) {
        if (![value respondsToSelector:@selector(objectForKey:)])
            break;
        value = [value objectForKey:key];
    }
    
    if (!value) {
        value = defaultValue;
    }
    
    return value;
}

+ (void)setNestedValue:(id)value
     forPersistenceKey:(NSString *)persistenceKey
            nestedKeys:(NSArray *)nestedKeys
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSMutableArray *extractedDictionaries = [NSMutableArray arrayWithCapacity:nestedKeys.count];

    id extractedItem = [defaults dictionaryForKey:persistenceKey];

    for (NSString *key in nestedKeys) {
        if (![extractedItem respondsToSelector:@selector(objectForKey:)]) // nil or non-dictionary value?
            break;
        [extractedDictionaries addObject:extractedItem];
        extractedItem = extractedItem[key];
    }

    id valueToSet = value;
    NSMutableDictionary *currentMutableDictionary;
    NSUInteger idx = nestedKeys.count;
    
    for (NSString *key in [nestedKeys reverseObjectEnumerator]) {
        if (--idx < extractedDictionaries.count) {
            currentMutableDictionary = [NSMutableDictionary dictionaryWithDictionary:extractedDictionaries[idx]];
        } else {
            currentMutableDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
        }
        currentMutableDictionary[key] = valueToSet;
        valueToSet = currentMutableDictionary;
    }

    [defaults setObject:valueToSet forKey:persistenceKey];
    [defaults synchronize];
}


+ (void)resetAllSDKValues
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:SP_ADVERTISER_CALLBACK_SUCCESS_KEY];
    [defaults removeObjectForKey:SP_ACTION_CALLBACK_SUCCESS_KEY];
    [defaults removeObjectForKey:SP_VCS_LATEST_TRANSACTION_IDS_KEY];
    
    [defaults synchronize];
}

@end
