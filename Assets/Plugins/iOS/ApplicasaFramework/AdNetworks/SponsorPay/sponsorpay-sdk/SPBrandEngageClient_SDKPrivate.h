//
//  SPBrandEngageClient_SDKPrivate.h
//  SponsorPay iOS SDK
//
//  Copyright 2011-2013 SponsorPay. All rights reserved.
//

#import "SPBrandEngageClient.h"
#import "mediation/SPMediationCoordinator.h"

@interface SPBrandEngageClient (SDKPrivate)

@property (readwrite, retain, nonatomic) NSString *appId;
@property (readwrite, retain, nonatomic) NSString *userId;
@property (readwrite, retain, nonatomic) NSString *currencyName;
@property (readwrite, retain, nonatomic) SPMediationCoordinator *mediationCoordinator;

@end
