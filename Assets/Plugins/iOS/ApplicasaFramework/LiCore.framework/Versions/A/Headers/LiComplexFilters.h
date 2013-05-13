//
//  LiComplexFilters.h
//  LiCore
//
//  Created by Applicasa on 12/30/12.
//  Copyright (c) 2012 Applicasa.com  All rights reserved.
//

#import <LiCore/LiCore.h>


@interface LiComplexFilters : LiFilters

@property (nonatomic, assign) COMPLEX_OPERATORS complexOperator;

- (id) initWithOperandA:(LiFilters *)_operandA OperandB:(LiFilters *)_operandB Operator:(COMPLEX_OPERATORS)_operator;

@property (nonatomic, strong) LiFilters *operandA;
@property (nonatomic, strong) LiFilters *operandB;

@end
