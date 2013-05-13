//
// LiUserLocation.h
// Created by Applicasa 
// 8/31/2012
//
#import <Foundation/Foundation.h>
#import <LiCore/LiCore.h>
#import "LiBlocks.h"
#import "LiDataTypes.h"

typedef void (^LiBlockLocationAction)(NSError *error, CLLocation *location,Actions action);

@interface LiUserLocation : NSObject <LiCoreLocationDelegate,LiCoreUpdateLocationDelegate>
@property (nonatomic, assign) LiBlockLocationAction locationAction;

/*********************************************************************************
 DEPRECATED METHODS WARNING:
 
 Applicasa is cleaning up its SDK in preparation for upcoming 2.0 release.
 
 Do not use methods marked with DEPRECATED_ATTRIBUTE.
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the final release. You should update your code immediately.
 
 Corrected methods are listed first. Use these methods instead.
 **********************************************************************************/

- (void) getCurrentLocationWithBlock:(LiBlockLocationAction)block;
- (void) updateLocationWithAccuracy:(CLLocationAccuracy)accuracy distanceFilter:(CLLocationDistance)distanceFilter andBlock:(LiBlockLocationAction)block;

- (void) updateLocationAutomaticallyWithAccuracy:(CLLocationAccuracy)accuracy distanceFilter:(CLLocationDistance)distanceFilter andBlock:(LiBlockLocationAction)block;
- (void) updateCurrentUserToCurrentLocation_Auto:(BOOL)automatically DesireAccuracy:(CLLocationAccuracy)desireAccuracy DistanceFilter:(CLLocationDistance)distanceFilter WithBlock:(LiBlockLocationAction)block DEPRECATED_ATTRIBUTE;

- (void) stopAutoUpdate;

@end
