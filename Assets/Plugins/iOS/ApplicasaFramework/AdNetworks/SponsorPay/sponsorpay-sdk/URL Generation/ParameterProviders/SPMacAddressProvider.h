//
//  SPMacAddressProvider.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/1/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPURLParametersProvider.h"

@interface SPMacAddressProvider : NSObject <SPURLParametersProvider>

@property (readonly) NSString *macAddressPlain;

@end
