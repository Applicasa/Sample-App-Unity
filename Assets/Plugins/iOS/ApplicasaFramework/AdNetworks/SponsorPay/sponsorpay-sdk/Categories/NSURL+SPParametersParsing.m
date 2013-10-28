//
//  NSURL+Parsing.m
//  SponsoPay iOS SDK
//
//  Created by David Davila on 8/9/12.
//  Copyright (c) 2012 David Davila. All rights reserved.
//

#import "NSURL+SPParametersParsing.h"
#import "LoadableCategory.h"

MAKE_CATEGORIES_LOADABLE(NSURL_SPParametersParsing)


@implementation NSURL (SPParametersParsing)

- (NSDictionary *)SPQueryDictionary {
	
	NSString *query = [self query];
	
    // Explode based on outter glue
    NSArray *firstExplode = [query componentsSeparatedByString:@"&"];
    NSArray *secondExplode;
	
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode = [(NSString *)[firstExplode objectAtIndex:i] componentsSeparatedByString:@"="];
        if ([secondExplode count] == 2) {
			[returnDictionary setObject:[secondExplode objectAtIndex:1] forKey:[secondExplode objectAtIndex:0]];
        }
    }
	
    return returnDictionary;
}


@end
