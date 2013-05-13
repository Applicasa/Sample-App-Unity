//
//  UpdateObject.h
//  
//
//  Created by Applicasa on 4/24/13.
//  Copyright (c) 2013 Applicasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>


typedef void (^UpdateObjectFinished)(NSError *error, int pages);
@class LiQuery;
@interface UpdateObject : NSObject <LiCoreRequestDelegate> {
}

+ (void) getArrayWithQuery:(LiQuery *)query andWithClassName:(NSString *)kClassName withBlock:(UpdateObjectFinished)block;

@end
