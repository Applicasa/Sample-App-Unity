//
//  SPMacAddressProvider.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/1/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SPMacAddressProvider.h"
#import "SPLogger.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

static NSString *const  kURLParamKeyMACAddress = @"mac_address";

static NSString *const kSPErrorDomain = @"SPErrorDomain";
static NSString *const kSPErrorLoggableDescription = @"SPErrorLoggableDescription";

@implementation SPMacAddressProvider

@synthesize macAddressPlain = _macAddressPlain;

- (NSString *)macAddressPlain {
    if (!_macAddressPlain)
        [self fetchAndCachePlainMacAddress];
    
    return _macAddressPlain;
}

- (void)fetchAndCachePlainMacAddress
{
    [_macAddressPlain release];
    _macAddressPlain = nil;
    
    NSError *errorFetchingMacAddress = nil;
    _macAddressPlain = [[SPMacAddressProvider fetchPlainMacAddressOrFailWithError:&errorFetchingMacAddress] retain];
    if (errorFetchingMacAddress) {
        [SPLogger log:@"Error fetching MAC address: %@",
         [errorFetchingMacAddress.userInfo objectForKey:kSPErrorLoggableDescription]];
    }

    if (!_macAddressPlain)
        _macAddressPlain = @"";
}

+ (NSString *)fetchPlainMacAddressOrFailWithError:(NSError **)error {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        if (error)
            *error = [NSError errorWithDomain:kSPErrorDomain code:-1 userInfo:[NSDictionary dictionaryWithObject:@"if_nametoindex error" forKey:kSPErrorLoggableDescription]];
        return nil;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        if (error)
            *error = [NSError errorWithDomain:kSPErrorDomain code:-1 userInfo:[NSDictionary dictionaryWithObject:@"sysctl 1 error" forKey:kSPErrorLoggableDescription]];
        return nil;
    }
    
    if ((buf = malloc(len)) == NULL) {
        if (error)
            *error = [NSError errorWithDomain:kSPErrorDomain code:-1 userInfo:[NSDictionary dictionaryWithObject:@"malloc error" forKey:kSPErrorLoggableDescription]];
        return nil;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        if (error)
            *error = [NSError errorWithDomain:kSPErrorDomain code:-1 userInfo:[NSDictionary dictionaryWithObject:@"sysctl 2 error" forKey:kSPErrorLoggableDescription]];
        free(buf);
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *macAddress = [[NSString alloc]
                            initWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                            *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    
    return [macAddress autorelease];
}

- (void)dealloc {
    [_macAddressPlain release];
    [super dealloc];
}

- (NSDictionary *)dictionaryWithKeyValueParameters {
    return [NSDictionary dictionaryWithObject:self.macAddressPlain forKey:kURLParamKeyMACAddress];
}

@end