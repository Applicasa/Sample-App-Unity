//
//  SPNetworkParametersProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/2/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPNetworkParametersProvider.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>


static NSString *const kSPURLParamKey_NetworkConnectionType = @"network_connection_type";
static NSString *const kSPURLParamValue_NetworkConnectionTypeCellular = @"cellular";
static NSString *const kSPURLParamValue_NetworkConnectionTypeWiFi = @"wifi";

static NSString *const kSPURLParamKey_CarrierName = @"carrier_name";
static NSString *const kSPURLParamKeyCarrierCountry = @"carrier_country";

@implementation SPNetworkParametersProvider

- (NSDictionary *)dictionaryWithKeyValueParameters
{
    SCNetworkReachabilityRef spReachability = SCNetworkReachabilityCreateWithName(NULL, "sponsorpay.com");
    SCNetworkReachabilityFlags spReachabilityFlags;
    SCNetworkReachabilityGetFlags(spReachability, &spReachabilityFlags);
    BOOL connectionIsWan = spReachabilityFlags & ((1 << 18) != 0);
    CFRelease(spReachability);
    
    NSString *connectionTypeValue = connectionIsWan ? kSPURLParamValue_NetworkConnectionTypeCellular : kSPURLParamValue_NetworkConnectionTypeWiFi;
    
    CTTelephonyNetworkInfo *networkInfo = [[[CTTelephonyNetworkInfo alloc] init] autorelease];
    CTCarrier *currentCarrier = [networkInfo subscriberCellularProvider];

    NSString *currentCarrierName = @"", *currentCarrierISOCountryCode = @"";
    
    if (currentCarrier && currentCarrier.carrierName && currentCarrier.isoCountryCode) {
        currentCarrierName = currentCarrier.carrierName;
        currentCarrierISOCountryCode = currentCarrier.isoCountryCode;
    }
    
    NSDictionary *networkParameters = @{
    kSPURLParamKey_NetworkConnectionType : connectionTypeValue,
    kSPURLParamKey_CarrierName : currentCarrierName,
    kSPURLParamKeyCarrierCountry : currentCarrierISOCountryCode
    };
    
    return networkParameters;
}

@end
