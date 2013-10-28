//
// LiBlocks.h
// Created by Applicasa 
// 10/24/2013
//


@class LiObjPushNotification;
typedef void (^SendPushFinished)(NSError *error, NSString *message,LiObjPushNotification *pushObject);
typedef void (^LiBlockFBFriendsAction)(NSError *error, NSArray *friends,Actions action);

@class User;

typedef void (^GetUserFinished)(NSError *error, User *object);
typedef void (^GetUserArrayFinished)(NSError *error, NSArray *array);

@class VirtualCurrency;

typedef void (^GetVirtualCurrencyFinished)(NSError *error, VirtualCurrency *object);
typedef void (^GetVirtualCurrencyArrayFinished)(NSError *error, NSArray *array);

@class VirtualGood;

typedef void (^GetVirtualGoodFinished)(NSError *error, VirtualGood *object);
typedef void (^GetVirtualGoodArrayFinished)(NSError *error, NSArray *array);

@class VirtualGoodCategory;

typedef void (^GetVirtualGoodCategoryFinished)(NSError *error, VirtualGoodCategory *object);
typedef void (^GetVirtualGoodCategoryArrayFinished)(NSError *error, NSArray *array);

@class Dynamic;

typedef void (^GetDynamicFinished)(NSError *error, Dynamic *object);
typedef void (^GetDynamicArrayFinished)(NSError *error, NSArray *array);

@class Chat;

typedef void (^GetChatFinished)(NSError *error, Chat *object);
typedef void (^GetChatArrayFinished)(NSError *error, NSArray *array);

@class Achievments;

typedef void (^GetAchievmentsFinished)(NSError *error, Achievments *object);
typedef void (^GetAchievmentsArrayFinished)(NSError *error, NSArray *array);

@class Foo;

typedef void (^GetFooFinished)(NSError *error, Foo *object);
typedef void (^GetFooArrayFinished)(NSError *error, NSArray *array);

@class GameV;

typedef void (^GetGameVFinished)(NSError *error, GameV *object);
typedef void (^GetGameVArrayFinished)(NSError *error, NSArray *array);

@class DataManager;

typedef void (^GetDataManagerFinished)(NSError *error, DataManager *object);
typedef void (^GetDataManagerArrayFinished)(NSError *error, NSArray *array);

@class DataManString;

typedef void (^GetDataManStringFinished)(NSError *error, DataManString *object);
typedef void (^GetDataManStringArrayFinished)(NSError *error, NSArray *array);

@class ScoreB;

typedef void (^GetScoreBFinished)(NSError *error, ScoreB *object);
typedef void (^GetScoreBArrayFinished)(NSError *error, NSArray *array);

@class Levels;

typedef void (^GetLevelsFinished)(NSError *error, Levels *object);
typedef void (^GetLevelsArrayFinished)(NSError *error, NSArray *array);

@class Colors;

typedef void (^GetColorsFinished)(NSError *error, Colors *object);
typedef void (^GetColorsArrayFinished)(NSError *error, NSArray *array);

@class Languages;

typedef void (^GetLanguagesFinished)(NSError *error, Languages *object);
typedef void (^GetLanguagesArrayFinished)(NSError *error, NSArray *array);


