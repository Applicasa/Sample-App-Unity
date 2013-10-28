//
//  SPVungleAdapter.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 5/30/13.
// Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTPNVideoAdapter.h"
#import "../AdNetworkSettings.h"

#ifdef SPVungleSDKAvailable_1_3_2
#define VungleProtocol , VGVunglePubDelegate
#else
#define VungleProtocol
#endif


@interface SPVungleAdapter : NSObject <SPTPNVideoAdapter VungleProtocol>

- (id)initWithAppId:appId;

@end
