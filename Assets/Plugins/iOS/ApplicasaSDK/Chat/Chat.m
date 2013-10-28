//
// Chat.m
// Created by Applicasa 
// 10/24/2013
//

#import "Chat.h"
#import "User.h"
#import "User.h"

#define kClassName                  @"Chat"

#define KEY_chatID				@"ChatID"
#define KEY_chatLastUpdate				@"ChatLastUpdate"
#define KEY_chatIsSender				@"ChatIsSender"
#define KEY_chatText				@"ChatText"
#define KEY_chatGhjgjgj				@"ChatGhjgjgj"
#define KEY_chatSender				@"ChatSender"
#define KEY_chatReciepent				@"ChatReciepent"

@interface Chat (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation Chat

@synthesize chatID;
@synthesize chatLastUpdate;
@synthesize chatIsSender;
@synthesize chatText;
@synthesize chatGhjgjgj;
@synthesize chatSender;
@synthesize chatReciepent;

enum ChatIndexes {
	ChatIDIndex = 0,
	ChatLastUpdateIndex,
	ChatIsSenderIndex,
	ChatSenderIndex,
	ChatTextIndex,
	ChatReciepentIndex,
	ChatGhjgjgjIndex,};
#define NUM_OF_CHAT_FIELDS 7

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
	request.shouldWorkOffline = kShouldChatWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.chatID]){
		request.action = Update;
		[request addValue:chatID forKey:KEY_chatID];
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
	request.shouldWorkOffline = kShouldChatWorkOffline;
	[request setBlock:block];
	request.delegate = self;
	[request addValue:chatID forKey:KEY_chatID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetChatFinished)block{
    __block Chat *item = [Chat instance];

    LiFilters *filters = [LiBasicFilters filterByField:ChatID Operator:Equal Value:idString];
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

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetChatArrayFinished)block{
    Chat *item = [Chat instance];
    
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

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetChatArrayFinished)block{
    Chat *item = [Chat instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    Chat *item = [Chat instance];
    
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
    
        return [Chat getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
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

	[request addValue:chatID forKey:KEY_chatID];
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
            NSString *itemID = [responseData objectForKey:KEY_chatID];
            if (itemID)
                self.chatID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.chatID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[Chat getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    Chat *instace = [[Chat alloc] init];
    instace.chatID = ID;
    return [instace autorelease];
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetChatArrayFinished _block = (GetChatArrayFinished)block;
    if(_block)
        _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case ChatID:
		self.chatID = value;
		break;
	case ChatIsSender:
		self.chatIsSender = [value boolValue];
		break;
	case ChatSender:
		self.chatSender = value;
		break;
	case ChatText:
		self.chatText = value;
		break;
	case ChatReciepent:
		self.chatReciepent = value;
		break;
	case ChatGhjgjgj:
		self.chatGhjgjgj = value;
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[chatID release];
	[chatLastUpdate release];
	[chatText release];
	[chatGhjgjgj release];
	[chatSender release];
	[chatReciepent release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.chatID				= @"0";
		chatLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.chatIsSender				= YES;
		self.chatText				= @"";
		self.chatGhjgjgj				= [NSURL URLWithString:@""];
self.chatSender    = [User instanceWithID:@"0"];
self.chatReciepent    = [User instanceWithID:@"0"];
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.chatID               = [item objectForKey:KeyWithHeader(KEY_chatID, header)];
		chatLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_chatLastUpdate, header)] retain];
		self.chatIsSender               = [[item objectForKey:KeyWithHeader(KEY_chatIsSender, header)] boolValue];
		self.chatText               = [item objectForKey:KeyWithHeader(KEY_chatText, header)];
		self.chatGhjgjgj               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_chatGhjgjgj, header)]];
		chatSender               = [[User alloc] initWithDictionary:item Header:KeyWithHeader
	(@"_",KEY_chatSender)];
		chatReciepent               = [[User alloc] initWithDictionary:item Header:KeyWithHeader
	(@"_",KEY_chatReciepent)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(Chat *)object {
	if (self = [super init]) {

		self.chatID               = object.chatID;
		chatLastUpdate               = [object.chatLastUpdate retain];
		self.chatIsSender               = object.chatIsSender;
		self.chatText               = object.chatText;
		self.chatGhjgjgj               = object.chatGhjgjgj;
		chatSender               = [[User alloc] initWithObject:object.chatSender];
		chatReciepent               = [[User alloc] initWithObject:object.chatReciepent];

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:chatID forKey:KEY_chatID];
	[dictionary addDateValue:chatLastUpdate forKey:KEY_chatLastUpdate];
	[dictionary addBoolValue:chatIsSender forKey:KEY_chatIsSender];
	[dictionary addValue:chatText forKey:KEY_chatText];
	[dictionary addValue:chatGhjgjgj.absoluteString forKey:KEY_chatGhjgjgj];	[dictionary addForeignKeyValue:chatSender.dictionaryRepresentation forKey:KEY_chatSender];
	[dictionary addForeignKeyValue:chatReciepent.dictionaryRepresentation forKey:KEY_chatReciepent];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_chatID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_chatLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"1") forKey:KEY_chatIsSender];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"'0'") forKey:KEY_chatSender];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_chatText];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"'0'") forKey:KEY_chatReciepent];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_chatGhjgjgj];
	
	return [fieldsDic autorelease];
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	[foreignKeysDic setValue:[User getClassName] forKey:KEY_chatSender];
	[foreignKeysDic setValue:[User getClassName] forKey:KEY_chatReciepent];
	
	return [foreignKeysDic autorelease];
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case Chat_None:
			fieldName = @"pos";
			break;
	
		case ChatID:
			fieldName = KEY_chatID;
			break;

		case ChatLastUpdate:
			fieldName = KEY_chatLastUpdate;
			break;

		case ChatIsSender:
			fieldName = KEY_chatIsSender;
			break;

		case ChatText:
			fieldName = KEY_chatText;
			break;

		case ChatGhjgjgj:
			fieldName = KEY_chatGhjgjgj;
			break;

		case ChatSender:
			fieldName = KEY_chatSender;
			break;

		case ChatReciepent:
			fieldName = KEY_chatReciepent;
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
		case Chat_None:
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
	[*request addBoolValue:chatIsSender forKey:KEY_chatIsSender];
	[*request addValue:chatText forKey:KEY_chatText];
	[*request addValue:chatGhjgjgj.absoluteString forKey:KEY_chatGhjgjgj];
	[*request addValue:chatSender.userID forKey:KEY_chatSender];
	[*request addValue:chatReciepent.userID forKey:KEY_chatReciepent];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.chatID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ChatIDIndex])];
			chatLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ChatLastUpdateIndex])]] retain];
			self.chatIsSender = sqlite3_column_int(stmt, array[0][ChatIsSenderIndex]);

	if (isFK){
		self.chatSender = [User instanceWithID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ChatSenderIndex])]];
	} else {
		int **chatSenderArray = (int **)malloc(sizeof(int *));
		chatSenderArray[0] = array[1];
		self.chatSender = [[User alloc] initWithStatement:stmt Array:chatSenderArray IsFK:YES];
		free(chatSenderArray);
	}

;
			self.chatText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ChatTextIndex])];

	if (isFK){
		self.chatReciepent = [User instanceWithID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ChatReciepentIndex])]];
	} else {
		int **chatReciepentArray = (int **)malloc(sizeof(int *));
		chatReciepentArray[0] = array[2];
		self.chatReciepent = [[User alloc] initWithStatement:stmt Array:chatReciepentArray IsFK:YES];
		free(chatReciepentArray);
	}

;
			self.chatGhjgjgj = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][ChatGhjgjgjIndex])]];
		
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
	
	int **indexes = (int **)malloc(3*sizeof(int *));
	indexes[0] = (int *)malloc(NUM_OF_CHAT_FIELDS*sizeof(int));
	indexes[1] = (int *)malloc(NUM_OF_USER_FIELDS*sizeof(int));
	indexes[2] = (int *)malloc(NUM_OF_USER_FIELDS*sizeof(int));

	indexes[0][ChatIDIndex] = [columnsArray indexOfObject:KEY_chatID];
	indexes[0][ChatLastUpdateIndex] = [columnsArray indexOfObject:KEY_chatLastUpdate];
	indexes[0][ChatIsSenderIndex] = [columnsArray indexOfObject:KEY_chatIsSender];
	indexes[0][ChatSenderIndex] = [columnsArray indexOfObject:KEY_chatSender];
	indexes[0][ChatTextIndex] = [columnsArray indexOfObject:KEY_chatText];
	indexes[0][ChatReciepentIndex] = [columnsArray indexOfObject:KEY_chatReciepent];
	indexes[0][ChatGhjgjgjIndex] = [columnsArray indexOfObject:KEY_chatGhjgjgj];

	indexes[1][UserIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserID",@"_ChatSender")];
	indexes[1][UserNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserName",@"_ChatSender")];
	indexes[1][UserFirstNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFirstName",@"_ChatSender")];
	indexes[1][UserLastNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastName",@"_ChatSender")];
	indexes[1][UserEmailIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserEmail",@"_ChatSender")];
	indexes[1][UserPhoneIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPhone",@"_ChatSender")];
	indexes[1][UserPasswordIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPassword",@"_ChatSender")];
	indexes[1][UserLastLoginIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastLogin",@"_ChatSender")];
	indexes[1][UserRegisterDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserRegisterDate",@"_ChatSender")];
	indexes[1][UserLocationLatIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLat",@"_ChatSender")];
	indexes[1][UserLocationLongIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLong",@"_ChatSender")];
	indexes[1][UserIsRegisteredIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegistered",@"_ChatSender")];
	indexes[1][UserIsRegisteredFacebookIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegisteredFacebook",@"_ChatSender")];
	indexes[1][UserLastUpdateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastUpdate",@"_ChatSender")];
	indexes[1][UserImageIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserImage",@"_ChatSender")];
	indexes[1][UserMainCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserMainCurrencyBalance",@"_ChatSender")];
	indexes[1][UserSecondaryCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserSecondaryCurrencyBalance",@"_ChatSender")];
	indexes[1][UserFacebookIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFacebookID",@"_ChatSender")];
	indexes[1][UserTempDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserTempDate",@"_ChatSender")];

	indexes[2][UserIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserID",@"_ChatReciepent")];
	indexes[2][UserNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserName",@"_ChatReciepent")];
	indexes[2][UserFirstNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFirstName",@"_ChatReciepent")];
	indexes[2][UserLastNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastName",@"_ChatReciepent")];
	indexes[2][UserEmailIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserEmail",@"_ChatReciepent")];
	indexes[2][UserPhoneIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPhone",@"_ChatReciepent")];
	indexes[2][UserPasswordIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPassword",@"_ChatReciepent")];
	indexes[2][UserLastLoginIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastLogin",@"_ChatReciepent")];
	indexes[2][UserRegisterDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserRegisterDate",@"_ChatReciepent")];
	indexes[2][UserLocationLatIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLat",@"_ChatReciepent")];
	indexes[2][UserLocationLongIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLong",@"_ChatReciepent")];
	indexes[2][UserIsRegisteredIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegistered",@"_ChatReciepent")];
	indexes[2][UserIsRegisteredFacebookIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegisteredFacebook",@"_ChatReciepent")];
	indexes[2][UserLastUpdateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastUpdate",@"_ChatReciepent")];
	indexes[2][UserImageIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserImage",@"_ChatReciepent")];
	indexes[2][UserMainCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserMainCurrencyBalance",@"_ChatReciepent")];
	indexes[2][UserSecondaryCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserSecondaryCurrencyBalance",@"_ChatReciepent")];
	indexes[2][UserFacebookIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFacebookID",@"_ChatReciepent")];
	indexes[2][UserTempDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserTempDate",@"_ChatReciepent")];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][ChatIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			Chat *item  = [[Chat alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
			[result addObject:item];
[item release];
		}
	}

	[LiObjRequest removeIDsList:blackList FromObject:kClassName];
	[blackList release];
	
	for (int i=0; i<3; i++) {
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

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetChatFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetChatArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetChatArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

#pragma mark - End of Basic SDK

@end
