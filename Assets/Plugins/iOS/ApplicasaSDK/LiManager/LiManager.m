
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
#import "Dynamic.h"
#import "Chat.h"
#import "Achievments.h"
#import "Foo.h"
#import "GameV.h"
#import "DataManager.h"
#import "DataManString.h"
#import "ScoreB.h"
#import "Levels.h"
#import "Colors.h"
#import "Languages.h"
#import "Cards.h"
#import "VirtualGood.h"
#import <LiCore/LiKitIAP.h>



#define kNotificationString @"ConflictFound"


@implementation LiManager

+ (void) setObjectDictionary{
	NSMutableArray *array = [[NSMutableArray alloc] init];
        
	
	[array addObject:[NSDictionary dictionaryWithObject:[User getFields] forKey:[User getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[VirtualCurrency getFields] forKey:[VirtualCurrency getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[VirtualGoodCategory getFields] forKey:[VirtualGoodCategory getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Dynamic getFields] forKey:[Dynamic getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Chat getFields] forKey:[Chat getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Achievments getFields] forKey:[Achievments getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Foo getFields] forKey:[Foo getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[GameV getFields] forKey:[GameV getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[DataManager getFields] forKey:[DataManager getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[DataManString getFields] forKey:[DataManString getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[ScoreB getFields] forKey:[ScoreB getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Levels getFields] forKey:[Levels getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Colors getFields] forKey:[Colors getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Languages getFields] forKey:[Languages getClassName]]];
	[array addObject:[NSDictionary dictionaryWithObject:[Cards getFields] forKey:[Cards getClassName]]];
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
	[dic setObject:[Dynamic getForeignKeys] forKey:[Dynamic getClassName]];
	[dic setObject:[Chat getForeignKeys] forKey:[Chat getClassName]];
	[dic setObject:[Achievments getForeignKeys] forKey:[Achievments getClassName]];
	[dic setObject:[Foo getForeignKeys] forKey:[Foo getClassName]];
	[dic setObject:[GameV getForeignKeys] forKey:[GameV getClassName]];
	[dic setObject:[DataManager getForeignKeys] forKey:[DataManager getClassName]];
	[dic setObject:[DataManString getForeignKeys] forKey:[DataManString getClassName]];
	[dic setObject:[ScoreB getForeignKeys] forKey:[ScoreB getClassName]];
	[dic setObject:[Levels getForeignKeys] forKey:[Levels getClassName]];
	[dic setObject:[Colors getForeignKeys] forKey:[Colors getClassName]];
	[dic setObject:[Languages getForeignKeys] forKey:[Languages getClassName]];
	[dic setObject:[Cards getForeignKeys] forKey:[Cards getClassName]];
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

+(int)getSessionPauseTime{
    return SESSION_PAUSE_TIME;
}

+(BOOL)shouldDecodeTags
{
    return SHOULD_DECODE_HTML_XML_TAGS;
}

+ (BOOL) isMMediaEnabled{
    return ENABLE_MMEDIA;
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

+ (BOOL) isSponsorPayEnabled
{
    return ENABLE_SPONSORPAY;
}
+ (NSString *) getSponsorPayAppId
{
    return SPONSORPAY_APPID;
}
+ (NSString *) getSponsorPaySecurityToken
{
    return SPONSORPAY_SECURITY_TOKEN;
}

//AppNext
+ (BOOL) isAppnextEnabled
{
    return ENABLE_APPNEXT;
}

//Aarki
+ (BOOL) isAarkiEnabled
{
    return ENABLE_AARKI;
}
+ (NSString *) getAarkiClientSecurityKey
{
    return AARKI_CLIENT_SECURITY_KEY;
}


//SuperSonic
+ (BOOL) isSupersonicAdsEnabled
{
    return ENABLE_SUPERSONICADS;
}

+ (NSString *) getSupersonicAdsId
{
    return SUPERSONIC_APPID;
}




@end
