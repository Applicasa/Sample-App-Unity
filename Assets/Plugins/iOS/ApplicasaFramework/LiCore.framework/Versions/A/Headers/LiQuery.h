//
//  LiQuery.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 LiCore All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LiCore/LiCoreDelegate.h>
#import <LiCore/LiComplexFilters.h>
#import <LiCore/LiBasicFilters.h>

#import "LiDataTypes.h"

@class LiFilters;
@class LiPager;
@interface LiQuery : NSObject

@property (nonatomic, strong) NSMutableArray *orderArray;
@property (nonatomic, strong) LiFilters *filters;
@property (nonatomic, strong) LiFilters *geoFilter;
@property (nonatomic, strong) LiPager *pager;

- (id) initWithFilter:(LiFilters *)filter;
- (void) setGeoFilterBy:(LiFields)field Location:(CLLocation *)location Radius:(int)radius;
- (void) addOrderByField:(LiFields)field SortType:(SortType)sortType;
- (void) addPagerByPage:(NSUInteger)page RecordsPerPage:(NSUInteger)recordsPerPage;

@end