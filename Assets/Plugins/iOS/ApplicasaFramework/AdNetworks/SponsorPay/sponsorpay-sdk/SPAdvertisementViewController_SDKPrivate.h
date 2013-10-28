//
//  SPAdvertisementViewControllerSubclass.h
//  SponsorPay iOS SDK
//
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAdvertisementViewController.h"

typedef void (^SPViewControllerDisposalBlock)(void);

@interface SPAdvertisementViewController (SDKPrivate)

@property (nonatomic, retain) NSString *appId;
@property (nonatomic, retain) NSString *userId;
@property (readwrite, retain, nonatomic) NSString *currencyName;
@property (copy) SPViewControllerDisposalBlock disposalBlock;

- (id)initWithUserId:(NSString *)userId
               appId:(NSString *)appId
       disposalBlock:(SPViewControllerDisposalBlock)disposalBlock;

@end
