//
//  SPToast.m
//  SPToast (iToast)
//
//  Created by Diallo Mamadou Bobo on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SPToast.h"
#import <QuartzCore/QuartzCore.h>

static SPToastSettings *sharedSettings = nil;

@implementation SPToast


- (id) initWithText:(NSString *) tex{
	if (self = [super init]) {
		text = [tex copy];
	}
	
	return self;
}

- (void) show{
	[self show:SPToastTypeNone];
}

- (void) show:(SPToastType) type{
	
	SPToastSettings *theSettings = _settings;
	
	if (!theSettings) {
		theSettings = [SPToastSettings getSharedSettings];
	}
	
	UIImage *image = [theSettings.images valueForKey:[NSString stringWithFormat:@"%i", type]];
	
	UIFont *font = [UIFont systemFontOfSize:16];
    
	// Set correct orientation/location regarding device orientation
	UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    int widthConstraint = UIInterfaceOrientationIsPortrait(orientation) ? 280 : 460;
    CGSize toastConstraint = CGSizeMake(widthConstraint, 60);
	CGSize textSize = [text sizeWithFont:font constrainedToSize:toastConstraint];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 5, textSize.height + 5)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.font = font;
	label.text = text;
	label.numberOfLines = 0;
	label.shadowColor = [UIColor darkGrayColor];
	label.shadowOffset = CGSizeMake(1, 1);
	
	UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
	if (image) {
		v.frame = CGRectMake(0, 0, image.size.width + textSize.width + 15, MAX(textSize.height, image.size.height) + 10);
		label.center = CGPointMake(image.size.width + 10 + (v.frame.size.width - image.size.width - 10) / 2, v.frame.size.height / 2);
	} else {
		v.frame = CGRectMake(0, 0, textSize.width + 10, textSize.height + 10);
		label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
	}
	CGRect lbfrm = label.frame;
	lbfrm.origin.x = ceil(lbfrm.origin.x);
	lbfrm.origin.y = ceil(lbfrm.origin.y);
	label.frame = lbfrm;
	[v addSubview:label];
	[label release];
	
	if (image) {
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		imageView.frame = CGRectMake(5, (v.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
		[v addSubview:imageView];
		[imageView release];
	}
	
	v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
	v.layer.cornerRadius = 5;
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	
	CGPoint point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
	
	switch (orientation) {
		case UIDeviceOrientationPortrait:
		{
			if (theSettings.gravity == SPToastGravityTop) {
				point = CGPointMake(window.frame.size.width / 2, 45);
			} else if (theSettings.gravity == SPToastGravityBottom) {
				point = CGPointMake(window.frame.size.width / 2, window.frame.size.height - 45);
			} else if (theSettings.gravity == SPToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x + offsetLeft, point.y + offsetTop);
			break;
		}
		case UIDeviceOrientationPortraitUpsideDown:
		{
			v.transform = CGAffineTransformMakeRotation(M_PI);
			
			float width = window.frame.size.width;
			float height = window.frame.size.height;
			
			if (theSettings.gravity == SPToastGravityTop) {
				point = CGPointMake(width / 2, height - 45);
			} else if (theSettings.gravity == SPToastGravityBottom) {
				point = CGPointMake(width / 2, 45);
			} else if (theSettings.gravity == SPToastGravityCenter) {
				point = CGPointMake(width/2, height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x - offsetLeft, point.y - offsetTop);
			break;
		}
		case UIDeviceOrientationLandscapeLeft:
		{
			v.transform = CGAffineTransformMakeRotation(M_PI/2); //rotation in radians
			
			if (theSettings.gravity == SPToastGravityTop) {
				point = CGPointMake(window.frame.size.width - 45, window.frame.size.height / 2);
			} else if (theSettings.gravity == SPToastGravityBottom) {
				point = CGPointMake(45,window.frame.size.height / 2);
			} else if (theSettings.gravity == SPToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x - offsetTop, point.y - offsetLeft);
			break;
		}
		case UIDeviceOrientationLandscapeRight:
		{
			v.transform = CGAffineTransformMakeRotation(-M_PI/2);
			
			if (theSettings.gravity == SPToastGravityTop) {
				point = CGPointMake(45, window.frame.size.height / 2);
			} else if (theSettings.gravity == SPToastGravityBottom) {
				point = CGPointMake(window.frame.size.width - 45, window.frame.size.height/2);
			} else if (theSettings.gravity == SPToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x + offsetTop, point.y + offsetLeft);
			break;
		}
		default:
			break;
	}

	v.center = point;
	
	NSTimer *timer1 = [NSTimer timerWithTimeInterval:((float)theSettings.duration)/1000
											 target:self selector:@selector(hideToast:) 
										   userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];

    if ([v respondsToSelector:@selector(setAccessibilityIdentifier:)]) {
        [v setAccessibilityIdentifier:@"ToastView"];
    }

	[window addSubview:v];
	
	view = [v retain];
    
	[v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}

- (void) hideToast:(NSTimer*)theTimer{
	[UIView beginAnimations:nil context:NULL];
	view.alpha = 0;
	[UIView commitAnimations];
	
	NSTimer *timer2 = [NSTimer timerWithTimeInterval:500 
											 target:self selector:@selector(hideToast:) 
										   userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
}

- (void) removeToast:(NSTimer*)theTimer{
	[view removeFromSuperview];
}


+ (SPToast *) makeText:(NSString *) _text{
	SPToast *toast = [[[SPToast alloc] initWithText:_text] autorelease];
	
	return toast;
}


- (SPToast *) setDuration:(NSInteger ) duration{
	[self theSettings].duration = duration;
	return self;
}

- (SPToast *) setGravity:(SPToastGravity) gravity 
			 offsetLeft:(NSInteger) left
			  offsetTop:(NSInteger) top{
	[self theSettings].gravity = gravity;
	offsetLeft = left;
	offsetTop = top;
	return self;
}

- (SPToast *) setGravity:(SPToastGravity) gravity{
	[self theSettings].gravity = gravity;
	return self;
}

- (SPToast *) setPostion:(CGPoint) _position{
	[self theSettings].postition = CGPointMake(_position.x, _position.y);
	
	return self;
}

-(SPToastSettings *) theSettings{
	if (!_settings) {
		_settings = [[SPToastSettings getSharedSettings] copy];
	}
	
	return _settings;
}

@end


@implementation SPToastSettings
@synthesize duration;
@synthesize gravity;
@synthesize postition;
@synthesize images;

- (void) setImage:(UIImage *) img forType:(SPToastType) type{
	if (type == SPToastTypeNone) {
		// This should not be used, internal use only (to force no image)
		return;
	}
	
	if (!images) {
		images = [[NSMutableDictionary alloc] initWithCapacity:4];
	}
	
	if (img) {
		NSString *key = [NSString stringWithFormat:@"%i", type];
		[images setValue:img forKey:key];
	}
}


+ (SPToastSettings *) getSharedSettings{
	if (!sharedSettings) {
		sharedSettings = [SPToastSettings new];
		sharedSettings.gravity = SPToastGravityCenter;
		sharedSettings.duration = SPToastDurationShort;
	}
	
	return sharedSettings;
	
}

- (id) copyWithZone:(NSZone *)zone{
	SPToastSettings *copy = [SPToastSettings new];
	copy.gravity = self.gravity;
	copy.duration = self.duration;
	copy.postition = self.postition;
	
	NSArray *keys = [self.images allKeys];
	
	for (NSString *key in keys){
		[copy setImage:[images valueForKey:key] forType:[key intValue]];
	}
	
	return copy;
}

@end