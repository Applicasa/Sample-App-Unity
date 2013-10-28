//
//  SPToast.h
//  SPToast (iToast)
//
//  Created by Diallo Mamadou Bobo on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum SPToastGravity {
	SPToastGravityTop = 1000001,
	SPToastGravityBottom,
	SPToastGravityCenter
}SPToastGravity;

enum SPToastDuration {
	SPToastDurationLong = 10000,
	SPToastDurationShort = 1000,
	SPToastDurationNormal = 3000
}SPToastDuration;

typedef enum SPToastType {
	SPToastTypeInfo = -100000,
	SPToastTypeNotice,
	SPToastTypeWarning,
	SPToastTypeError,
	SPToastTypeNone // For internal use only (to force no image)
}SPToastType;


@class SPToastSettings;

@interface SPToast : NSObject {
	SPToastSettings *_settings;
	NSInteger offsetLeft;
	NSInteger offsetTop;
	
	NSTimer *timer;
	
	UIView *view;
	NSString *text;
}

- (void) show;
- (void) show:(SPToastType) type;
- (SPToast *) setDuration:(NSInteger ) duration;
- (SPToast *) setGravity:(SPToastGravity) gravity 
			 offsetLeft:(NSInteger) left
			 offsetTop:(NSInteger) top;
- (SPToast *) setGravity:(SPToastGravity) gravity;
- (SPToast *) setPostion:(CGPoint) position;

+ (SPToast *) makeText:(NSString *) text;

-(SPToastSettings *) theSettings;

@end



@interface SPToastSettings : NSObject<NSCopying>{
	NSInteger duration;
	SPToastGravity gravity;
	CGPoint postition;
	SPToastType toastType;
	
	NSDictionary *images;
	
	BOOL positionIsSet;
}


@property(assign) NSInteger duration;
@property(assign) SPToastGravity gravity;
@property(assign) CGPoint postition;
@property(readonly) NSDictionary *images;


- (void) setImage:(UIImage *)img forType:(SPToastType) type;
+ (SPToastSettings *) getSharedSettings;
						  
@end