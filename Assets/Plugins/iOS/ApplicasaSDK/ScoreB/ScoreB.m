//
// ScoreB.m
// Created by Applicasa 
// 10/24/2013
//

#import "ScoreB.h"
#import "User.h"

#define kClassName                  @"ScoreB"

#define KEY_scoreBID				@"ScoreBID"
#define KEY_scoreBLastUpdate				@"ScoreBLastUpdate"
#define KEY_scoreBScore				@"ScoreBScore"
#define KEY_scoreBUser				@"ScoreBUser"

@interface ScoreB (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation ScoreB

@synthesize scoreBID;
@synthesize scoreBLastUpdate;
@synthesize scoreBScore;
@synthesize scoreBUser;

enum ScoreBIndexes {
	ScoreBIDIndex = 0,
	ScoreBLastUpdateIndex,
	ScoreBScoreIndex,
	ScoreBUserIndex,};
#define NUM_OF_SCOREB_FIELDS 4

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
	request.shouldWorkOffline = kShouldScoreBWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.scoreBID]){
		request.action = Update;
		[request addValue:scoreBID forKey:KEY_scoreBID];
		if (self.increaseDictionary.count){
			[request.requestParameters setValue:self.increaseDictionary forKey:@"$inc"];
			self.increaseDictionary = nil;
		}
	} 	
	request.delegate = self;
	[request startSync:NO];
}

- (void) updateField:(LiFields)field withValue:(NSNumber *)value{
	switch (field) {
		case ScoreBScore:
			scoreBScore += [value intValue];
			break;
		default:
			break;
	}
}

#pragma mark - Increase

- (void) increaseField:(LiFields)field byValue:(NSNumber *)value{
    if (!self.increaseDictionary)
        self.increaseDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    [self.increaseDictionary setValue:value forKey:[[self class] getFieldName:field]];
    [self updateField:field withValue:value];
}

#pragma mark - Delete

- (void) deleteWithBlock:(LiBlockAction)block{        
	LiObjRequest *request = [LiObjRequest requestWithAction:Delete ClassName:kClassName];
	request.shouldWorkOffline = kShouldScoreBWorkOffline;
	[request setBlock:block];
	request.delegate = self;
	[request addValue:scoreBID forKey:KEY_scoreBID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetScoreBFinished)block{
    __block ScoreB *item = [ScoreB instance];

    LiFilters *filters = [LiBasicFilters filterByField:ScoreBID Operator:Equal Value:idString];
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

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetScoreBArrayFinished)block{
    ScoreB *item = [ScoreB instance];
    
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

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetScoreBArrayFinished)block{
    ScoreB *item = [ScoreB instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    ScoreB *item = [ScoreB instance];
    
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
    
        return [ScoreB getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
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

	[request addValue:scoreBID forKey:KEY_scoreBID];
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
        case Add:
        case Update:
        case Delete:{
            NSString *itemID = [responseData objectForKey:KEY_scoreBID];
            if (itemID)
                self.scoreBID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.scoreBID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[ScoreB getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    ScoreB *instace = [[ScoreB alloc] init];
    instace.scoreBID = ID;
    return [instace autorelease];
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetScoreBArrayFinished _block = (GetScoreBArrayFinished)block;
    if(_block)
        _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case ScoreBID:
		self.scoreBID = value;
		break;
	case ScoreBScore:
		self.scoreBScore = [value intValue];
		break;
	case ScoreBUser:
		self.scoreBUser = value;
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[scoreBID release];
	[scoreBLastUpdate release];
	[scoreBUser release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.scoreBID				= @"0";
		scoreBLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.scoreBScore				= 0;
self.scoreBUser    = [User instanceWithID:@"0"];
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.scoreBID               = [item objectForKey:KeyWithHeader(KEY_scoreBID, header)];
		scoreBLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_scoreBLastUpdate, header)] retain];
		self.scoreBScore               = [[item objectForKey:KeyWithHeader(KEY_scoreBScore, header)] integerValue];
		scoreBUser               = [[User alloc] initWithDictionary:item Header:KeyWithHeader
	(@"_",KEY_scoreBUser)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(ScoreB *)object {
	if (self = [super init]) {

		self.scoreBID               = object.scoreBID;
		scoreBLastUpdate               = [object.scoreBLastUpdate retain];
		self.scoreBScore               = object.scoreBScore;
		scoreBUser               = [[User alloc] initWithObject:object.scoreBUser];

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:scoreBID forKey:KEY_scoreBID];
	[dictionary addDateValue:scoreBLastUpdate forKey:KEY_scoreBLastUpdate];
	[dictionary addIntValue:scoreBScore forKey:KEY_scoreBScore];
	[dictionary addForeignKeyValue:scoreBUser.dictionaryRepresentation forKey:KEY_scoreBUser];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_scoreBID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_scoreBLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_scoreBScore];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"'0'") forKey:KEY_scoreBUser];
	
	return [fieldsDic autorelease];
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	[foreignKeysDic setValue:[User getClassName] forKey:KEY_scoreBUser];
	
	return [foreignKeysDic autorelease];
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case ScoreB_None:
			fieldName = @"pos";
			break;
	
		case ScoreBID:
			fieldName = KEY_scoreBID;
			break;

		case ScoreBLastUpdate:
			fieldName = KEY_scoreBLastUpdate;
			break;

		case ScoreBScore:
			fieldName = KEY_scoreBScore;
			break;

		case ScoreBUser:
			fieldName = KEY_scoreBUser;
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
		case ScoreB_None:
			fieldName = @"pos";
			break;
	
		default:
			NSLog(@"Wrong Geo LiFields numerator for %@ Class",kClassName);
			fieldName = nil;
			break;
	}
	
	return fieldName;
}


- (void) addValuesToRequest:(LiObjRequest **)request{
	[*request addIntValue:scoreBScore forKey:KEY_scoreBScore];
	[*request addValue:scoreBUser.userID forKey:KEY_scoreBUser];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.scoreBID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ScoreBIDIndex])];
			scoreBLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ScoreBLastUpdateIndex])]] retain];
			self.scoreBScore = sqlite3_column_int(stmt, array[0][ScoreBScoreIndex]);

	if (isFK){
		self.scoreBUser = [User instanceWithID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ScoreBUserIndex])]];
	} else {
		int **scoreBUserArray = (int **)malloc(sizeof(int *));
		scoreBUserArray[0] = array[1];
		self.scoreBUser = [[User alloc] initWithStatement:stmt Array:scoreBUserArray IsFK:YES];
		free(scoreBUserArray);
	}

;
		
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
	
	int **indexes = (int **)malloc(2*sizeof(int *));
	indexes[0] = (int *)malloc(NUM_OF_SCOREB_FIELDS*sizeof(int));
	indexes[1] = (int *)malloc(NUM_OF_USER_FIELDS*sizeof(int));

	indexes[0][ScoreBIDIndex] = [columnsArray indexOfObject:KEY_scoreBID];
	indexes[0][ScoreBLastUpdateIndex] = [columnsArray indexOfObject:KEY_scoreBLastUpdate];
	indexes[0][ScoreBScoreIndex] = [columnsArray indexOfObject:KEY_scoreBScore];
	indexes[0][ScoreBUserIndex] = [columnsArray indexOfObject:KEY_scoreBUser];

	indexes[1][UserIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserID",@"_ScoreBUser")];
	indexes[1][UserNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserName",@"_ScoreBUser")];
	indexes[1][UserFirstNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFirstName",@"_ScoreBUser")];
	indexes[1][UserLastNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastName",@"_ScoreBUser")];
	indexes[1][UserEmailIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserEmail",@"_ScoreBUser")];
	indexes[1][UserPhoneIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPhone",@"_ScoreBUser")];
	indexes[1][UserPasswordIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPassword",@"_ScoreBUser")];
	indexes[1][UserLastLoginIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastLogin",@"_ScoreBUser")];
	indexes[1][UserRegisterDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserRegisterDate",@"_ScoreBUser")];
	indexes[1][UserLocationLatIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLat",@"_ScoreBUser")];
	indexes[1][UserLocationLongIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLong",@"_ScoreBUser")];
	indexes[1][UserIsRegisteredIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegistered",@"_ScoreBUser")];
	indexes[1][UserIsRegisteredFacebookIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegisteredFacebook",@"_ScoreBUser")];
	indexes[1][UserLastUpdateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastUpdate",@"_ScoreBUser")];
	indexes[1][UserImageIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserImage",@"_ScoreBUser")];
	indexes[1][UserMainCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserMainCurrencyBalance",@"_ScoreBUser")];
	indexes[1][UserSecondaryCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserSecondaryCurrencyBalance",@"_ScoreBUser")];
	indexes[1][UserFacebookIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFacebookID",@"_ScoreBUser")];
	indexes[1][UserTempDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserTempDate",@"_ScoreBUser")];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][ScoreBIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			ScoreB *item  = [[ScoreB alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
			[result addObject:item];
[item release];
		}
	}

	[LiObjRequest removeIDsList:blackList FromObject:kClassName];
	[blackList release];
	
	for (int i=0; i<2; i++) {
		free(indexes[i]);
	}
	free(indexes);
	
	return [result autorelease];
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

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetScoreBFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetScoreBArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetScoreBArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

#pragma mark - End of Basic SDK

@end
