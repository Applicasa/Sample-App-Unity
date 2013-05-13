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

+ (void) getTrialPayActions:(LiTrialPayResponse)block;

@end
