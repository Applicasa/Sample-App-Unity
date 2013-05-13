//
// User+Location.m
// Created by Applicasa 
// 8/31/2012
//

#import "LiUserLocation.h"

@implementation LiUserLocation
@synthesize locationAction;

- (void) getCurrentLocationWithBlock:(LiBlockLocationAction)block{
    [LiCore getCurrentLocation:self];
}

- (void) updateLocationWithAccuracy:(CLLocationAccuracy)accuracy distanceFilter:(CLLocationDistance)distanceFilter andBlock:(LiBlockLocationAction)block {
    [LiCore setDesireAccuracy:accuracy];
    [LiCore setDistanceFilter:distanceFilter];
    self.locationAction = Block_copy(block);
    [LiCore updateUserLocation:self];
}

- (void) updateLocationAutomaticallyWithAccuracy:(CLLocationAccuracy)accuracy distanceFilter:(CLLocationDistance)distanceFilter andBlock:(LiBlockLocationAction)block{
    [LiCore setDesireAccuracy:accuracy];
    [LiCore setDistanceFilter:distanceFilter];
    self.locationAction = Block_copy(block);
    [LiCore startUpdatingUserLocationWithDelegate:self];
}

- (void) stopAutoUpdate{
    [LiCore stopUpdatingUserLocation];
}

#pragma mark - LiCore Location Delegate
- (void) LiCoreDidFinishGetCurrentLocation:(CLLocation *)location Error:(NSError *)error{
    self.locationAction(error,location,GetLocation);
    Block_release(self.locationAction);;
}

#pragma mark - LiCore Update Location Delegate

- (void) LiCoreDidFailToUpdateLocation:(NSError *)error{
    self.locationAction(error,nil,UpdateLocation);
}

- (void) LiCoreDidUpdateLocation:(CLLocation *)location{
    self.locationAction(nil,location,UpdateLocation);
}

#pragma mark - Deprecated Methods
/*********************************************************************************
 DEPRECATED METHODS:
 
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the next release. You should update your code immediately.
 **********************************************************************************/

- (void) updateCurrentUserToCurrentLocation_Auto:(BOOL)automatically DesireAccuracy:(CLLocationAccuracy)desireAccuracy DistanceFilter:(CLLocationDistance)distanceFilter WithBlock:(LiBlockLocationAction)block {
    if (automatically) {
        // Tells LiCore to keep location automatically updated
        [self updateLocationAutomaticallyWithAccuracy:desireAccuracy distanceFilter:distanceFilter andBlock:block];
    }
    else {
        // Tells LiCore to just update location this time
        [self updateLocationWithAccuracy:desireAccuracy distanceFilter:distanceFilter andBlock:block];
    }
}

@end
