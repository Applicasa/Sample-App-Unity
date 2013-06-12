//
//  LiObjFBFriend.h
//  LiCore
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
// 

#import <UIKit/UIKit.h>

@class User;
@interface LiObjFBFriend : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *facebookID;
@property (nonatomic, strong) NSString *facebookName;
@property (nonatomic, strong) NSURL *facebookImage;
@property (nonatomic) BOOL hasApplicasaUser;

+ (LiObjFBFriend *) friendWithDictionary:(NSDictionary *)dictionary;

@end
