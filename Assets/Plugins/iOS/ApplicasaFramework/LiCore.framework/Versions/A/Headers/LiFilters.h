//
//  LiFilters.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCoreDelegate.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"
#import <LiCore/LiCoreDelegate.h>

@class LiGeoFilter;
@class LiBasicFilters;
@class LiComplexFilters;

@interface LiFilters : NSObject
@property (nonatomic, strong) id field;
@property (nonatomic, strong) id value;

- (LiFilters *) NOT;
/*
 Bool val with kLiTrue or kLiFalse
 */
+ (LiFilters *) filterByField:(LiFields)field Operator:(OPERATORS)op Value:(id)value;
+ (LiFilters *) filterByOperandA:(LiFilters *)operandA ComplexOperator:(COMPLEX_OPERATORS)op OperandB:(LiFilters *)operandB;

+ (LiFilters *) filterByField:(LiFields)field InOperatorWithArrayOfValues:(NSArray *)array;
+ (LiFilters *) filterByField:(LiFields)field OrOperatorWithArrayOfValues:(NSArray *)array DEPRECATED_ATTRIBUTE;


@end


@interface LiPager : NSObject{
    NSUInteger page;
    NSUInteger recordsPerPage;
}

+ (LiPager *) pagerWithPage:(NSUInteger)page RecordsPerPage:(NSUInteger)recordsPerPage;

@end