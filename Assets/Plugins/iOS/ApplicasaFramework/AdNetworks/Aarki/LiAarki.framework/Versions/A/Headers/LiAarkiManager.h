//
//  LiAarkiManager.h
//  LiCore
//
//  Created by Or Lavee on 12/3/13.
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PromoView;
@interface LiAarkiManager : NSObject

#define LI_AARKI_VERSION @"1.0.1"

+ (LiAarkiManager *) sharedInstance;
- (void) showAarkiWithPromoView:(PromoView *)view;



@end
