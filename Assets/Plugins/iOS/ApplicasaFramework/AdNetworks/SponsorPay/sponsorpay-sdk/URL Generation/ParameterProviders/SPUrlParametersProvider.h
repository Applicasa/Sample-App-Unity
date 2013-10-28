//
//  SPURLParametersProvider.h
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/1/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPURLParametersProvider <NSObject>

@required
- (NSDictionary *)dictionaryWithKeyValueParameters;

@end
