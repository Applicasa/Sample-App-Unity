//
//  SPFlurryAdapter.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 6/17/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTPNVideoAdapter.h"
#import "SPLogger.h"

#ifdef SPFlurrySDKAvailable_4_2_1
#define FlurryProtocol , FlurryAdDelegate
#else
#define FlurryProtocol
#endif

@interface SPFlurryAdapter : NSObject <SPTPNVideoAdapter FlurryProtocol>

@property (retain) NSString *flurryAPIKey;
@property (retain) NSString *videoAdsSpace;

- (id)initWithAPIKey:(NSString *)APIKey
       videoAdsSpace:(NSString *)videoAdsSpace;

@end
