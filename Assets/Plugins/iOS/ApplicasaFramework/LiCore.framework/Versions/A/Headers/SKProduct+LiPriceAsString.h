//
//  SKProduct+LiPriceAsString.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import <StoreKit/StoreKit.h>
void loadCategorySKProduct();

@interface SKProduct (LiPriceAsString)

- (NSString *) priceAsString;

@end
