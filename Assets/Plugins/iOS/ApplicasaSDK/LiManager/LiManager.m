
//
//  LiManager.m
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa. All rights reserved.
//

#import "LiManager.h"
#import "LiConfig.h"
#import <LiCore/LiCore.h>
#import <LiCore/LiKitPromotions.h>


#import "User.h"
#import "VirtualCurrency.h"
#import "VirtualGoodCategory.h"
#import "VirtualGood.h"
#import <LiCore/LiKitIAP.h>



#define kNotificationString @"ConflictFound"


@implementation LiManager

+ (void) setObjectDictionary{
	NSMutableArray *array = [[NSMutableArray alloc] init];
        
	
	[array addObject:[NSDictionary dictionaryWithObject:[User getFields] forKey:[User getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[VirtualCurrency getFields] forKey:[VirtualCurrency getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[VirtualGoodCategory getFields] forKey:[VirtualGoodCategory getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[VirtualGood getFields] forKey:[VirtualGood getClassName]]];

	[array addObject:[LiKitPromotions getAnalyticsFieldsDictionary]];
	[array addObject:[LiKitPromotions getProfileSettingsFieldsDictionary]];
	[array addObject:[LiKitPromotions getPromotionsFieldsDictionary]];
	[array addObject:[LiKitIAP getIAPActionFieldsDictionary]];


    
	[LiCore initObjectsDictionary:array];

	[array release];
}


+ (void) setForeignKeysDictionary{
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

	[dic setValuesForKeysWithDictionary:[LiKitIAP getIAPFKsDictionary]];
		
	
	[dic setObject:[User getForeignKeys] forKey:[User getClassName]];
	[dic setObject:[VirtualCurrency getForeignKeys] forKey:[VirtualCurrency getClassName]];
	[dic setObject:[VirtualGoodCategory getForeignKeys] forKey:[VirtualGoodCategory getClassName]];
	[dic setObject:[VirtualGood getForeignKeys] forKey:[VirtualGood getClassName]];


		
	[LiCore initForeignKeysWithDictionary:dic];
	
	[dic release];
}

+ (void) initDatabase{
    [self setObjectDictionary];
    [self setForeignKeysDictionary];
}

+ (void) conflictFoundBetweenLocalItem:(NSDictionary *)localItem andServerItem:(NSDictionary *)serverItem OfClass:(NSString *)className{
	NSString *notificationName = [NSString stringWithFormat:@"%@%@",className,kNotificationString];
	[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:[NSArray arrayWithObjects:localItem,serverItem, nil] userInfo:nil];
}

+ (int) getSchemaDate{
	return SCHEMA_DATE;
}

+ (NSString *) getApplicationId{
	return APPLICATION_ID;
}

+ (BOOL) isPushEnabled{
	return ENABLE_PUSH;
}

+ (BOOL) shouldConfirmPushOnStart{
	return SHOULD_CONFIRM_PUSH_ON_START;
}

+ (BOOL) isDebugEnabled{
	return ENABLE_DEBUG;
}

+ (float) getSDKVersion{
	return SDK_VERSION;
}

+ (float) getFrameworkVersion{
	return FRAMEWORK_VERSION;
}

+ (BOOL) isLocationEnabled{
	return ENABLE_LOCATION;
}

+ (BOOL) isOfflineEnabled{
	return ENABLE_OFFLINE;
}

+ (NSString *) getSecretKey{
	return SECRET_KEY;
}

+ (BOOL) isSandboxEnabled{
	return ENABLE_SANDBOX;
}

+ (NSString *) getSchemaVersion{
	return SCHEMA_VERISON;
}



+ (BOOL) isChartboostEnabled{
 return ENABLE_CHARTBOOST;
}
+ (NSString *) getChartboostId{
 return CHARTBOOST_ID;
}
+ (NSString *) getChartboostSignature{
 return CHARTBOOST_SIGNATURE;
}

+(int)getSessionPauseTime{
    return SESSION_PAUSE_TIME;
}

@end
