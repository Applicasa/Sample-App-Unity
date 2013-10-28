//
//  NSString+Escaping.h
//  SponsoPay iOS SDK
//
//  Created by David Davila on 8/9/12.
//  Copyright (c) 2012 David Davila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SPURLEncoding)

- (NSString*)SPURLEncodedString;

- (NSString*)SPURLDecodedString;

@end
