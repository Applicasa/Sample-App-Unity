//
//  LiErrorDescriptions.h
//  Applicasa
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//


typedef enum LiErrors{
    REFRESH_FACEBOOK_TOKEN = 38,
    INVALID_KEYS = 1000, // VERIFY KEYS IN LiConfig.h file
    CONNECTION_PROBLEMS =1002, // no internet connection
    LOCATION_SERVICE_DISABLED= 1004, // location service disabled, to use locaiton services go to LiConfig.h and enable it
    FAILED_UPDATE_RECORD_AFTER_UPLOAD = 1005, //failed updating the record after a successful upload file
    INVALID_GEO_VALUES = 1008, // input values are invalid
    EMPTY_REQUEST = 1013, // request was sent without data
    ARRAY_OUT_OF_BOUNDS = 1014,
    OFFLINE_ACTIONS_DISABLED = 1030, // offline actions arent cached and wont be sent to applicasa
    FACEBOOK_ERROR = 1040,
    MISSING_RECEIPIETNTS= 1050, // WHEN SENDING PUSH AND NOT SETTING THE USER
    FILE_NOT_FOUND = 1060, // CALED WHEN TRYING TO UPLOAD FILE THAT DOESNT EXIST
    
    //IAP
    APPLE_DOESNT_APPROVE_THE_PURCHASE = 1100, // WILL BE CALLED IF TRYING TO PURCHASE ITEM ON SANDBOX MODE WITH A REGULAR USER
    PRODUCT_VERIFICATION_FAILED = 1101, // RETURNED IF TRYING TO PURCHASE A PRODUCT THAT APPLE DIDNT VERIFY. CHECK YOUR ITEM ON ITUNES CONNECT AND MAKE SURE THAT THE PRODUCT ID IS SET CORRECTLY ON APPLICASA
    PURCHASE_CANCELLED = 1102, // purchase was cancled
    ITEM_NOT_DEFINE_CORRECTLY = 1200, //please go to applicasa dashboard and make sure items are set correctly
    CANT_PURCHASE_WITHOUT_INTERNET_CONNECTION = 1201,// trying to purchase with real money without internet connection
    INSUFFICIENT_BALANCE = 1202, // user doesnt have enough balance to perform the action
    INSUFFICIENT_QUANTITY = 1203,// user doesnt have enough quantity to perform the action
    CANT_CONSUME_RELEATED_PRODUCT = 1205, // user cant consume related product
    PRODUCT_ALREADY_OWNED_BY_USER = 1207, // user already own this non consumable product
    QUANTITY_LIMIT = 1208, // user reached the maximum quantity he can own
    CAN_NOT_USE_THIS_PRIDUCT = 1209, //CALLED WHEN TRYING TO USE A PRODUCT THAT IS NOT CONSUMABLE
    IDENTIFIER_MISSING = 1210, // CALLED IF TRYING TO PURCHASE PRODUCT FROM APPLE WITH MISSING PRODUCT ID
    MISCONFIGURED_REAL_MONEY_VIRTUALGOOD = 1211,// CALLED IF TRYING TO BUY WITH REAL MONEY VIRTUAL GOOD THAT IS NOT SET CORRECTLY
    AMOUT_MUST_BE_POSITIVE = 1212,
    QUANTITY_MUST_BE_POSITIVE = 1213
} LiErrors;

#ifndef Applicasa_LiErrorDescriptions_h
#define Applicasa_LiErrorDescriptions_h

#define SuccessMessage        @"Successful"

#define Error1000_Description @"Can't register device, Check your Application Key & Application ID"
#define Error1002_Description @"Server unavailble - check your internet connection"
#define Error1003_Description @"You need to stop the auto update first"
#define Error1004_Description @"\"Enable Location\" in LiConfig.h is NO"
#define Error1005_Description @"Upload File/Image Succeed\nBut Update Record Failed"
#define Error1008_Description @"negative horizontal Accuracy"
#define Error1013_Description @"Request received empty data"
#define Error1014_Description @"array out of bound"


#define Error1030_Description @"Applicasa is Offline and no offilne actions are allowed"
#define Error1040_Description @"Failed to get facebook access token"

#define Error1050_Description @"Push Sent to empty User array"

#define Error1060_Description @"File Not Found"

#define Error1100_Description @"Apple doesn't approve this purchase"
#define Error1101_Description @"Product wasnt verified with apple, try to revalidate store"
#define Error1102_Description @"Purchase cancelled"

#define Error1200_Description @"VirtualCurrency not define appropriately"
#define Error1201_Description @"Can't Commit AppStore Purchase in offline mode"
#define Error1202_Description @"You don't have enough balance"
#define Error1203_Description @"You don't have enough quantity of this product"
#define Error1205_Description @"Its impossible to consume Related product"
#define Error1207_Description @"This product isn't consumable and had purchased before"

#define Error1208_Description @"This product quantity reached its limit"
#define Error1209_Description @"This product can't be used"
#define Error1210_Description @"Can't purchase this VirtualGood from AppStore, Identifier is missing"
#define Error1211_Description @"This Virtualgood Cant be purchased with Real Money, please set Product identifier."

#define Error1212_Description @"Amount must be positive"
#define Error1213_Description @"Qunatity must be positive"


#define Error1300_Description @"Attempt to post nil image"
#define Error1301_Description @"Inappropriate object sent to selector, should be LiObjFBFeed instance"

#endif


