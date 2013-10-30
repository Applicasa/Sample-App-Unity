//
// User.m
// Created by Applicasa 
// 10/30/2013
//

#import "User.h"
#import <LiCore/LiKitPromotions.h>

#define kClassName                  @"User"

#define KEY_userID				@"UserID"
#define KEY_userName				@"UserName"
#define KEY_userFirstName				@"UserFirstName"
#define KEY_userLastName				@"UserLastName"
#define KEY_userEmail				@"UserEmail"
#define KEY_userPhone				@"UserPhone"
#define KEY_userPassword				@"UserPassword"
#define KEY_userLastLogin				@"UserLastLogin"
#define KEY_userRegisterDate				@"UserRegisterDate"
#define KEY_userLocation				@"UserLocation"
#define KEY_userLocationLong				@"UserLocationLong"
#define KEY_userLocationLat				@"UserLocationLat"
#define KEY_userIsRegistered				@"UserIsRegistered"
#define KEY_userIsRegisteredFacebook				@"UserIsRegisteredFacebook"
#define KEY_userLastUpdate				@"UserLastUpdate"
#define KEY_userImage				@"UserImage"
#define KEY_userMainCurrencyBalance				@"UserMainCurrencyBalance"
#define KEY_userSecondaryCurrencyBalance				@"UserSecondaryCurrencyBalance"
#define KEY_userFacebookID				@"UserFacebookID"
#define KEY_userTempDate				@"UserTempDate"

@interface User (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation User

@synthesize userID;
@synthesize userName;
@synthesize userFirstName;
@synthesize userLastName;
@synthesize userEmail;
@synthesize userPhone;
@synthesize userPassword;
@synthesize userLastLogin;
@synthesize userRegisterDate;
@synthesize userLocation;
@synthesize userIsRegistered;
@synthesize userIsRegisteredFacebook;
@synthesize userLastUpdate;
@synthesize userImage;
@synthesize userMainCurrencyBalance;
@synthesize userSecondaryCurrencyBalance;
@synthesize userFacebookID;
@synthesize userTempDate;

enum UserIndexes {
	UserIDIndex = 0,
	UserNameIndex,
	UserFirstNameIndex,
	UserLastNameIndex,
	UserEmailIndex,
	UserPhoneIndex,
	UserPasswordIndex,
	UserLastLoginIndex,
	UserRegisterDateIndex,
	UserLocationLatIndex,
	UserLocationLongIndex,
	UserIsRegisteredIndex,
	UserIsRegisteredFacebookIndex,
	UserLastUpdateIndex,
	UserImageIndex,
	UserMainCurrencyBalanceIndex,
	UserSecondaryCurrencyBalanceIndex,
	UserFacebookIDIndex,
	UserTempDateIndex,};
#define NUM_OF_USER_FIELDS 19



#pragma mark - Save

- (void) saveWithBlock:(LiBlockAction)block{
	LiObjRequest *request = [LiObjRequest requestWithAction:Add ClassName:kClassName];
	request.shouldWorkOffline = kShouldUserWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.userID]){
		request.action = Update;
		[request addValue:userID forKey:KEY_userID];
		if (self.increaseDictionary.count){
			[request.requestParameters setValue:self.increaseDictionary forKey:@"$inc"];
			self.increaseDictionary = nil;
		}
	} 	else {
		[self respondToLiActionCallBack:1023 ResponseMessage:@"Attempt to add User instance" ItemID:@"0" Action:Add Block:block];
		return;
	}	
	request.delegate = self;
	[request startSync:NO];
}

- (void) updateField:(LiFields)field withValue:(NSNumber *)value{
	switch (field) {
		case UserMainCurrencyBalance:
			userMainCurrencyBalance += [value intValue];
			break;
		case UserSecondaryCurrencyBalance:
			userSecondaryCurrencyBalance += [value intValue];
			break;
		default:
			break;
	}
}

#pragma mark - Increase

- (void) increaseField:(LiFields)field byValue:(NSNumber *)value{
	if (field == UserMainCurrencyBalance || field == UserSecondaryCurrencyBalance){
		NSLog(@"Attempt to increase user's balance - please use IAP class methods");
		return;
	}
    if (!self.increaseDictionary)
        self.increaseDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    [self.increaseDictionary setValue:value forKey:[[self class] getFieldName:field]];
    [self updateField:field withValue:value];
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetUserFinished)block{
    __block User *item = [User instance];

    LiFilters *filters = [LiBasicFilters filterByField:UserID Operator:Equal Value:idString];
    LiQuery *query = [[LiQuery alloc]init];
    [query setFilters:filters];
    
    [self getArrayWithQuery:query queryKind:queryKind withBlock:^(NSError *error, NSArray *array) {
        item = nil;
        if (array.count)
            item = [array objectAtIndex:0];
        block(error,item);
    }];   
	[query release];
}


#pragma mark - Get Array

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetUserArrayFinished)block{
    User *item = [User instance];
    
	query = [self setFieldsNameToQuery:query];
    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addIntValue:queryKind forKey:@"DbGetKind"];
    [request setDelegate:item];
    [request addValue:query forKey:@"query"];
    request.shouldWorkOffline = (queryKind == LOCAL);
    
    [request startSync:(queryKind == LOCAL)];
    
    if (queryKind == LOCAL)
        [item requestDidFinished:request];
}

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetUserArrayFinished)block{
    User *item = [User instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    User *item = [User instance];
    
    query = [self setFieldsNameToQuery:query];
    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
    [request addIntValue:queryKind forKey:@"DbGetKind"];
    [request setDelegate:item];
    [request addValue:query forKey:@"query"];
    request.shouldWorkOffline = (queryKind == LOCAL);
    
    [request startSync:YES];
    
    NSInteger responseType = request.response.responseType;   
    
    if (responseType == 1)
    {
        sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
    
        NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
    
        return [User getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
    }
    return nil;
}

+ (int) updateLocalStorage:(LiQuery *)query queryKind:(QueryKind)queryKind
{
    query = [self setFieldsNameToQuery:query];
    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
    [request addIntValue:queryKind forKey:@"DbGetKind"];
    [request addValue:query forKey:@"query"];
    request.shouldWorkOffline = (queryKind == LOCAL);
    
    [request startSync:YES];
    
    NSInteger responseType = request.response.responseType;
    
    if (responseType == 1)
    {
        sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
        int i =0;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            i++;
        }
        return i;
    }
    return  -1;
}

+ (void) getArrayWithFilter:(LiFilters *)filter withBlock:(UpdateObjectFinished)block
{
    LiQuery *query = [[LiQuery alloc] initWithFilter:filter];
    query = [self setFieldsNameToQuery:query];
    [UpdateObject getArrayWithQuery:query andWithClassName:kClassName withBlock:block];
}

#pragma mark - Upload File

- (void) uploadFile:(NSData *)data toField:(LiFields)field withFileType:(AMAZON_FILE_TYPES)fileType extension:(NSString *)ext andBlock:(LiBlockAction)block{

    LiObjRequest *request = [LiObjRequest requestWithAction:UploadFile ClassName:kClassName];
    request.delegate = self;

	[request addValue:userID forKey:KEY_userID];
    [request addValue:ext forKey:@"ext"];
    [request addValue:data forKey:@"data"];
    [request addIntValue:fileType forKey:@"fileType"];
	[request addIntValue:field forKey:@"fileField"];
    [request addValue:[[self class] getFieldName:field] forKey:@"field"];
	[request setBlock:block];
    [request startSync:NO];
}

/*
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
*/
#pragma mark - Applicasa Delegate Methods


- (void) requestDidFinished:(LiObjRequest *)request{
    Actions action = request.action;
    NSInteger responseType = request.response.responseType;
    NSString *responseMessage = request.response.responseMessage;
    NSDictionary *responseData = request.response.responseData;
    
    switch (action) {
         case UploadFile:{
            LiFields fileField = [[request.requestParameters objectForKey:@"fileField"] intValue];
            [self setField:fileField toValue:[responseData objectForKey:kResult]];
        }        
        case Update:{
            NSString *itemID = [responseData objectForKey:KEY_userID];
            if (itemID)
                self.userID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.userID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[User getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];
			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}


+ (id) instanceWithID:(NSString *)ID{
    User *instace = [[User alloc] init];
    instace.userID = ID;
    return [instace autorelease];
}

#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];

    GetUserArrayFinished _block = (GetUserArrayFinished)block;
    
    if (_block)
        _block(error,array);
}

+ (User *) getCurrentUser{
    return [LiCore getCurrentUser];
}

#pragma mark - Facebook Methods

static LiBlockFBFriendsAction fbFriendsAction = NULL;
static LiBlockAction actionBlock = NULL;
static BOOL hasFbFriendsAction = FALSE;
static BOOL hasActionBlock = FALSE;

- (void) setFbFriendsAction:(LiBlockFBFriendsAction)block{
    fbFriendsAction = Block_copy(block);
     hasFbFriendsAction = TRUE;
}

- (void) setActionBlock:(LiBlockAction)block{
    actionBlock = Block_copy(block);
}

- (void) facebookLoginWithBlock:(LiBlockAction)block{
    [self setActionBlock:block];
    hasActionBlock = TRUE;
    [LiKitFacebook loginWithFacebookWithUser:self Delegate:self];
}

+ (void) facebookFindFriendsWithBlock:(LiBlockFBFriendsAction)block{
    User *item = [User instance];
    [item setFbFriendsAction:block];
    [LiKitFacebook findFacebookFriendsWithDelegate:item];
}

+ (void) facebookLogoutWithBlock:(LiBlockAction)block{
    [LiKitFacebook logOut];
    [self logoutWithBlock:block];
}

#pragma mark - FB Kit Delegate

- (void) FBdidLoginUser:(User *)user ResponseType:(int)responseType ResponseMessage:(NSString *)responseMessage{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
    if(hasActionBlock)
    {
        actionBlock(error,(user!=nil)?user.userID:@"",LoginWithFacebook);
        Block_release(actionBlock);
        hasActionBlock = FALSE;
    }
}

- (void) FBdidFindFacebookFriends:(NSArray *)friends ResponseType:(int)responseType ResponseMessage:(NSString *)responseMessage{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
    if(hasFbFriendsAction)
    {
        fbFriendsAction(error,friends,FacebookFriends);
        hasFbFriendsAction = FALSE;
        Block_release(fbFriendsAction);
    }
}

#pragma mark - End of Facebook Methods
#pragma mark -

- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case UserID:
		self.userID = value;
		break;
	case UserFirstName:
		self.userFirstName = value;
		break;
	case UserLastName:
		self.userLastName = value;
		break;
	case UserEmail:
		self.userEmail = value;
		break;
	case UserPhone:
		self.userPhone = value;
		break;
	case UserLocation:
		self.userLocation = value;
		break;
	case UserImage:
		self.userImage = value;
		break;
	case UserMainCurrencyBalance:
		self.userMainCurrencyBalance = [value intValue];
		break;
	case UserSecondaryCurrencyBalance:
		self.userSecondaryCurrencyBalance = [value intValue];
		break;
	case UserTempDate:
		self.userTempDate = value;
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[userID release];
	[userName release];
	[userFirstName release];
	[userLastName release];
	[userEmail release];
	[userPhone release];
	[userPassword release];
	[userLastLogin release];
	[userRegisterDate release];
	[userLocation release];
	[userLastUpdate release];
	[userImage release];
	[userFacebookID release];
	[userTempDate release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.userID				= @"0";
		userName				= [@"" retain];
		self.userFirstName				= @"";
		self.userLastName				= @"";
		self.userEmail				= @"";
		self.userPhone				= @"";
		userPassword				= [@"" retain];
		userLastLogin				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		userRegisterDate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.userLocation				=  [[[CLLocation alloc] initWithLatitude:0 longitude:0] autorelease];
		userIsRegistered				= NO;
		userIsRegisteredFacebook				= NO;
		userLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.userImage				= [NSURL URLWithString:@""];
		self.userMainCurrencyBalance				= 0;
		self.userSecondaryCurrencyBalance				= 0;
		userFacebookID				= [@"" retain];
		self.userTempDate				= [[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease];
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.userID               = [item objectForKey:KeyWithHeader(KEY_userID, header)];
		userName               = [[item objectForKey:KeyWithHeader(KEY_userName, header)] retain];
		self.userFirstName               = [item objectForKey:KeyWithHeader(KEY_userFirstName, header)];
		self.userLastName               = [item objectForKey:KeyWithHeader(KEY_userLastName, header)];
		self.userEmail               = [item objectForKey:KeyWithHeader(KEY_userEmail, header)];
		self.userPhone               = [item objectForKey:KeyWithHeader(KEY_userPhone, header)];
		userPassword               = [[item objectForKey:KeyWithHeader(KEY_userPassword, header)] retain];
		userLastLogin               = [[item objectForKey:KeyWithHeader(KEY_userLastLogin, header)] retain];
		userRegisterDate               = [[item objectForKey:KeyWithHeader(KEY_userRegisterDate, header)] retain];
		self.userLocation               = [[[CLLocation alloc] initWithLatitude:[[item objectForKey:KeyWithHeader(KEY_userLocationLat, header)] floatValue] longitude:[[item objectForKey:KeyWithHeader(KEY_userLocationLong, header)] floatValue]] autorelease];
		userIsRegistered               = [[item objectForKey:KeyWithHeader(KEY_userIsRegistered, header)] boolValue];
		userIsRegisteredFacebook               = [[item objectForKey:KeyWithHeader(KEY_userIsRegisteredFacebook, header)] boolValue];
		userLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_userLastUpdate, header)] retain];
		self.userImage               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_userImage, header)]];
		self.userMainCurrencyBalance               = [[item objectForKey:KeyWithHeader(KEY_userMainCurrencyBalance, header)] integerValue];
		self.userSecondaryCurrencyBalance               = [[item objectForKey:KeyWithHeader(KEY_userSecondaryCurrencyBalance, header)] integerValue];
		userFacebookID               = [[item objectForKey:KeyWithHeader(KEY_userFacebookID, header)] retain];
		self.userTempDate               = [item objectForKey:KeyWithHeader(KEY_userTempDate, header)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(User *)object {
	if (self = [super init]) {

		self.userID               = object.userID;
		userName               = [object.userName retain];
		self.userFirstName               = object.userFirstName;
		self.userLastName               = object.userLastName;
		self.userEmail               = object.userEmail;
		self.userPhone               = object.userPhone;
		userPassword               = [object.userPassword retain];
		userLastLogin               = [object.userLastLogin retain];
		userRegisterDate               = [object.userRegisterDate retain];
		self.userLocation               = object.userLocation;
		userIsRegistered               = object.userIsRegistered;
		userIsRegisteredFacebook               = object.userIsRegisteredFacebook;
		userLastUpdate               = [object.userLastUpdate retain];
		self.userImage               = object.userImage;
		self.userMainCurrencyBalance               = object.userMainCurrencyBalance;
		self.userSecondaryCurrencyBalance               = object.userSecondaryCurrencyBalance;
		userFacebookID               = [object.userFacebookID retain];
		self.userTempDate               = object.userTempDate;

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:userID forKey:KEY_userID];
	[dictionary addValue:userName forKey:KEY_userName];
	[dictionary addValue:userFirstName forKey:KEY_userFirstName];
	[dictionary addValue:userLastName forKey:KEY_userLastName];
	[dictionary addValue:userEmail forKey:KEY_userEmail];
	[dictionary addValue:userPhone forKey:KEY_userPhone];
	[dictionary addValue:userPassword forKey:KEY_userPassword];
	[dictionary addDateValue:userLastLogin forKey:KEY_userLastLogin];
	[dictionary addDateValue:userRegisterDate forKey:KEY_userRegisterDate];
	[dictionary addGeoValue:userLocation forKey:KEY_userLocation];
	[dictionary addBoolValue:userIsRegistered forKey:KEY_userIsRegistered];
	[dictionary addBoolValue:userIsRegisteredFacebook forKey:KEY_userIsRegisteredFacebook];
	[dictionary addDateValue:userLastUpdate forKey:KEY_userLastUpdate];
	[dictionary addValue:userImage.absoluteString forKey:KEY_userImage];	[dictionary addIntValue:userMainCurrencyBalance forKey:KEY_userMainCurrencyBalance];
	[dictionary addIntValue:userSecondaryCurrencyBalance forKey:KEY_userSecondaryCurrencyBalance];
	[dictionary addValue:userFacebookID forKey:KEY_userFacebookID];
	[dictionary addDateValue:userTempDate forKey:KEY_userTempDate];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_userID];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userName];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userFirstName];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userLastName];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userEmail];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userPhone];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userPassword];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_userLastLogin];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_userRegisterDate];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_userLocationLong];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_userLocationLat];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_userIsRegistered];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_userIsRegisteredFacebook];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_userLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userImage];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_userMainCurrencyBalance];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_userSecondaryCurrencyBalance];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_userFacebookID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_userTempDate];
	
	return [fieldsDic autorelease];
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	
	return [foreignKeysDic autorelease];
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case User_None:
			fieldName = @"pos";
			break;
	
		case UserID:
			fieldName = KEY_userID;
			break;

		case UserName:
			fieldName = KEY_userName;
			break;

		case UserFirstName:
			fieldName = KEY_userFirstName;
			break;

		case UserLastName:
			fieldName = KEY_userLastName;
			break;

		case UserEmail:
			fieldName = KEY_userEmail;
			break;

		case UserPhone:
			fieldName = KEY_userPhone;
			break;

		case UserLastLogin:
			fieldName = KEY_userLastLogin;
			break;

		case UserRegisterDate:
			fieldName = KEY_userRegisterDate;
			break;

		case UserIsRegistered:
			fieldName = KEY_userIsRegistered;
			break;

		case UserIsRegisteredFacebook:
			fieldName = KEY_userIsRegisteredFacebook;
			break;

		case UserLastUpdate:
			fieldName = KEY_userLastUpdate;
			break;

		case UserImage:
			fieldName = KEY_userImage;
			break;

		case UserMainCurrencyBalance:
			fieldName = KEY_userMainCurrencyBalance;
			break;

		case UserSecondaryCurrencyBalance:
			fieldName = KEY_userSecondaryCurrencyBalance;
			break;

		case UserFacebookID:
			fieldName = KEY_userFacebookID;
			break;

		case UserTempDate:
			fieldName = KEY_userTempDate;
			break;

		default:
			NSLog(@"Wrong LiFields numerator for %@ Class",kClassName);
			fieldName = nil;
			break;
	}
	
	return fieldName;
}

+ (NSString *) getGeoFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case User_None:
			fieldName = @"pos";
			break;
	
		case UserLocation:
			fieldName = KEY_userLocation;
			break;

		default:
			NSLog(@"Wrong Geo LiFields numerator for %@ Class",kClassName);
			fieldName = nil;
			break;
	}
	
	return fieldName;
}


- (void) addValuesToRequest:(LiObjRequest **)request{
	[*request addValue:userFirstName forKey:KEY_userFirstName];
	[*request addValue:userLastName forKey:KEY_userLastName];
	[*request addValue:userEmail forKey:KEY_userEmail];
	[*request addValue:userPhone forKey:KEY_userPhone];
	[*request addLocationValue:userLocation forKey:KEY_userLocation];
	[*request addValue:userImage.absoluteString forKey:KEY_userImage];
	[*request addIntValue:userMainCurrencyBalance forKey:KEY_userMainCurrencyBalance];
	[*request addIntValue:userSecondaryCurrencyBalance forKey:KEY_userSecondaryCurrencyBalance];
	[*request addDateValue:userTempDate forKey:KEY_userTempDate];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.userID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserIDIndex])];
			userName = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserNameIndex])] retain];
			self.userFirstName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserFirstNameIndex])];
			self.userLastName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserLastNameIndex])];
			self.userEmail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserEmailIndex])];
			self.userPhone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserPhoneIndex])];
			userPassword = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserPasswordIndex])] retain];
			userLastLogin = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserLastLoginIndex])]] retain];
			userRegisterDate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserRegisterDateIndex])]] retain];
			self.userLocation =  [[[CLLocation alloc] initWithLatitude:sqlite3_column_double(stmt, array[0][UserLocationLatIndex]) longitude:sqlite3_column_double(stmt, array[0][UserLocationLongIndex])] autorelease];
			userIsRegistered = sqlite3_column_int(stmt, array[0][UserIsRegisteredIndex]);
			userIsRegisteredFacebook = sqlite3_column_int(stmt, array[0][UserIsRegisteredFacebookIndex]);
			userLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserLastUpdateIndex])]] retain];
			self.userImage = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserImageIndex])]];
			self.userMainCurrencyBalance = sqlite3_column_int(stmt, array[0][UserMainCurrencyBalanceIndex]);
			self.userSecondaryCurrencyBalance = sqlite3_column_int(stmt, array[0][UserSecondaryCurrencyBalanceIndex]);
			userFacebookID = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserFacebookIDIndex])] retain];
			self.userTempDate = [[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][UserTempDateIndex])]];
		
		}
	return self;
}

+ (NSArray *) getArrayFromStatement:(sqlite3_stmt *)stmt IDsList:(NSArray *)idsList resultFromServer:(BOOL)resultFromServer{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	
	NSMutableArray *columnsArray = [[NSMutableArray alloc] init];
	int columns = sqlite3_column_count(stmt);
	for (int i=0; i<columns; i++) {
		char *columnName = (char *)sqlite3_column_name(stmt, i);
		[columnsArray addObject:[NSString stringWithUTF8String:columnName]];
	}
	
	int **indexes = (int **)malloc(1*sizeof(int *));
	indexes[0] = (int *)malloc(NUM_OF_USER_FIELDS*sizeof(int));

	indexes[0][UserIDIndex] = [columnsArray indexOfObject:KEY_userID];
	indexes[0][UserNameIndex] = [columnsArray indexOfObject:KEY_userName];
	indexes[0][UserFirstNameIndex] = [columnsArray indexOfObject:KEY_userFirstName];
	indexes[0][UserLastNameIndex] = [columnsArray indexOfObject:KEY_userLastName];
	indexes[0][UserEmailIndex] = [columnsArray indexOfObject:KEY_userEmail];
	indexes[0][UserPhoneIndex] = [columnsArray indexOfObject:KEY_userPhone];
	indexes[0][UserPasswordIndex] = [columnsArray indexOfObject:KEY_userPassword];
	indexes[0][UserLastLoginIndex] = [columnsArray indexOfObject:KEY_userLastLogin];
	indexes[0][UserRegisterDateIndex] = [columnsArray indexOfObject:KEY_userRegisterDate];
	indexes[0][UserLocationLatIndex] = [columnsArray indexOfObject:KEY_userLocationLat];
	indexes[0][UserLocationLongIndex] = [columnsArray indexOfObject:KEY_userLocationLong];
	indexes[0][UserIsRegisteredIndex] = [columnsArray indexOfObject:KEY_userIsRegistered];
	indexes[0][UserIsRegisteredFacebookIndex] = [columnsArray indexOfObject:KEY_userIsRegisteredFacebook];
	indexes[0][UserLastUpdateIndex] = [columnsArray indexOfObject:KEY_userLastUpdate];
	indexes[0][UserImageIndex] = [columnsArray indexOfObject:KEY_userImage];
	indexes[0][UserMainCurrencyBalanceIndex] = [columnsArray indexOfObject:KEY_userMainCurrencyBalance];
	indexes[0][UserSecondaryCurrencyBalanceIndex] = [columnsArray indexOfObject:KEY_userSecondaryCurrencyBalance];
	indexes[0][UserFacebookIDIndex] = [columnsArray indexOfObject:KEY_userFacebookID];
	indexes[0][UserTempDateIndex] = [columnsArray indexOfObject:KEY_userTempDate];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][UserIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			User *item  = [[User alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
			[result addObject:item];
[item release];
		}
	}

	[LiObjRequest removeIDsList:blackList FromObject:kClassName];
	[blackList release];
	
	for (int i=0; i<1; i++) {
		free(indexes[i]);
	}
	free(indexes);
	
	return [result autorelease];
}


#pragma mark - End of Basic SDK

- (void) registerUsername:(NSString *)username andPassword:(NSString *)password withBlock:(LiBlockAction)block{

    if (!username || [username isEqualToString:@""] || !password){
        [self respondToLiActionCallBack:1011 ResponseMessage:@"You have to register with username and password" ItemID:self.userID Action:Register Block:block];		
        return;
    }
    
    LiObjRequest *request = [LiObjRequest requestWithAction:Register ClassName:kClassName];
	[request setBlock:block];
    [request addValue:username forKey:KEY_userName];
    [request addValue:password forKey:KEY_userPassword];

    [self addValuesToRequest:&request];
    
    NSString *liUserID = [[LiCore getCurrentUser] userID];
    [request addValue:liUserID forKey:@"_id"];
    [request startSync:YES];
        
    if (request.response.responseType == 1){
        userIsRegistered = YES;
    }

    [self respondToLiActionCallBack:request.response.responseType ResponseMessage:request.response.responseMessage ItemID:[[LiCore getCurrentUser] userID] Action:Register Block:block];
}

+ (void) loginWithUsername:(NSString *)username andPassword:(NSString *)password withBlock:(LiBlockAction)block{
    User *item = [User instance];
    
    if (!username || [username isEqualToString:@""]){
        [item respondToLiActionCallBack:1020 ResponseMessage:@"You have to login with username and password" ItemID:[[LiCore getCurrentUser] userID] Action:Login Block:block];
        return;
    }
    
    LiObjRequest *request = [LiObjRequest requestWithAction:Login ClassName:kClassName];
    [request addValue:username forKey:@"UserName"];
    [request addValue:password forKey:@"UserPassword"];
    [request startSync:YES];
        
    [item respondToLiActionCallBack:request.response.responseType ResponseMessage:request.response.responseMessage ItemID:[[LiCore getCurrentUser] userID] Action:Login Block:block];
}

+ (void) updateUsername:(NSString *)newUsername usingPassword:(NSString *)password withBlock:(LiBlockAction)block{
    User *item = [User instance];
   
    
    if (!newUsername || [newUsername isEqualToString:@""] || !password){
        [item respondToLiActionCallBack:1021 ResponseMessage:@"You can't update the username without new username and password" ItemID:[[LiCore getCurrentUser] userID] Action:UpdateUserName Block:block];
        return;
    }
    
    LiObjRequest *request = [LiObjRequest requestWithAction:UpdateUserName ClassName:kClassName];
    [request addValue:[[LiCore getCurrentUser] userID] forKey:@"_id"];
    [request addValue:[[LiCore getCurrentUser] userName] forKey:@"UserName"];
    [request addValue:newUsername forKey:@"NewUserName"];
    [request addValue:password forKey:@"UserPassword"];
    [request startSync:YES];
    
    [item respondToLiActionCallBack:request.response.responseType ResponseMessage:request.response.responseMessage ItemID:[[LiCore getCurrentUser] userID] Action:UpdateUserName Block:block];
}

+ (void) updatePassword:(NSString *)newPassword forOldPassword:(NSString *)oldPassword withBlock:(LiBlockAction)block{
    User *item = [User instance];
   
    
    if (!newPassword || !oldPassword){
        [item respondToLiActionCallBack:1022 ResponseMessage:@"You can't update password without new and old passwords" ItemID:[[LiCore getCurrentUser] userID] Action:UpdatePassword Block:block];
        return;
    }
    
    LiObjRequest *request = [LiObjRequest requestWithAction:UpdatePassword ClassName:kClassName];
    [request addValue:[[LiCore getCurrentUser] userID] forKey:@"_id"];
    [request addValue:[[LiCore getCurrentUser] userName] forKey:@"UserName"];
    [request addValue:oldPassword forKey:@"UserPassword"];
    [request addValue:newPassword forKey:@"NewUserPassword"];
    [request startSync:YES];
    
    [item respondToLiActionCallBack:request.response.responseType ResponseMessage:request.response.responseMessage ItemID:[[LiCore getCurrentUser] userID] Action:UpdatePassword Block:block];
}

+ (void) logoutWithBlock:(LiBlockAction)block{
    User *item = [User instance];
   
    
    LiObjRequest *request = [LiObjRequest requestWithAction:Logout ClassName:kClassName];
    [request startSync:YES];
    
    [item respondToLiActionCallBack:request.response.responseType ResponseMessage:request.response.responseMessage ItemID:[[LiCore getCurrentUser] userID] Action:Logout Block:block];
}

+ (void) forgotPasswordForUsername:(NSString *)username withBlock:(LiBlockAction)block;{
    User *item = [User instance];   
    
    LiObjRequest *request = [LiObjRequest requestWithAction:ForgotPassword ClassName:kClassName];
    [request addValue:username forKey:KEY_userName];
    
    [request startSync:YES];
        
    [item respondToLiActionCallBack:request.response.responseType ResponseMessage:request.response.responseMessage ItemID:[[LiCore getCurrentUser] userID] Action:ForgotPassword Block:block];
}

#pragma mark - Deprecated Methods
/*********************************************************************************
 DEPRECATED METHODS:
 
 These methods are deprecated. They are included for backward-compatibility only.
 They will be removed in the next release. You should update your code immediately.
 **********************************************************************************/

- (void) increaseField:(LiFields)field ByValue:(NSNumber *)value {
    [self increaseField:field byValue:value];
}

- (void) updateField:(LiFields)field Value:(NSNumber *)value {
    [self updateField:field withValue:value];
}

- (void) setField:(LiFields)field WithValue:(NSNumber *)value {
    [self setField:field toValue:value];
}

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetUserFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetUserArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetUserArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

- (void)registerUserWithUsername:(NSString *)username Password:(NSString *)password WithBlock:(LiBlockAction)block {
    [self registerUsername:username andPassword:password withBlock:block];
}

+ (void)loginUserWithUsername:(NSString *)username Password:(NSString *)password WithBlock:(LiBlockAction)block {
    [self loginWithUsername:username andPassword:password withBlock:block];
}

+ (void)updatePassword:(NSString *)newPassword OldPassword:(NSString *)oldPassword WithBlock:(LiBlockAction)block {
    [self updatePassword:newPassword forOldPassword:oldPassword withBlock:block];
}

+ (void)updateUsername:(NSString *)newUsername WithPassword:(NSString *)password WithBlock:(LiBlockAction)block {
    [self updateUsername:newUsername usingPassword:password withBlock:block];
}

+ (void)logOutWithBlock:(LiBlockAction)block {
    [self logoutWithBlock:block];
}

#pragma mark - Profile Data Methods

+ (LiSpendingProfile) getCurrentSpendingProfile{
    return [LiKitPromotions getCurrentUserSpendingProfile];
}

+ (LiUsageProfile) getCurrentUsageProfile{
    return [LiKitPromotions getCurrentUserUsageProfile];
}

@end
