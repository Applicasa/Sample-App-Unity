//
//  LiBasicFilters.h
//  LiCore
//
//  Created by Applicasa on 12/30/12.
//  Copyright (c) 2012 Applicasa.com  All rights reserved.
//

#import <LiCore/LiCore.h>

@interface LiBasicFilters : LiFilters{
    OPERATORS _operator;
}

- (id) initFilterWithField:(LiFields)_field Value:(id)_value Operator:(OPERATORS)__operator;
@end
