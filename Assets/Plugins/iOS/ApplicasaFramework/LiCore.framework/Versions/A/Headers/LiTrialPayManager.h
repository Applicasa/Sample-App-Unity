//
//  LiTrialPayManager.h
//  LiCore
//
//  Created by Applicasa on 4/22/13.
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiObject.h"

@interface LiTrialPayManager : NSObject

#define LI_TRIALPAY_VERSION @"1.0.0"

+ (void) getTrialPayActions:(LiThirdPartyResponse)block;
@end
