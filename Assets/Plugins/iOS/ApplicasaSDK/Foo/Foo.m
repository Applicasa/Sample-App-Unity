//
// Foo.m
// Created by Applicasa 
// 1/21/2014
//

#import "Foo.h"
#import "User.h"

#define kClassName                  @"Foo"

#define KEY_fooID				@"FooID"
#define KEY_fooLastUpdate				@"FooLastUpdate"
#define KEY_fooName				@"FooName"
#define KEY_fooDescription				@"FooDescription"
#define KEY_fooBoolean				@"FooBoolean"
#define KEY_fooDate				@"FooDate"
#define KEY_fooImage				@"FooImage"
#define KEY_fooFile				@"FooFile"
#define KEY_fooLocation				@"FooLocation"
#define KEY_fooLocationLong				@"FooLocationLong"
#define KEY_fooLocationLat				@"FooLocationLat"
#define KEY_fooNumber				@"FooNumber"
#define KEY_fooAge				@"FooAge"
#define KEY_fooOwner				@"FooOwner"

@interface Foo (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation Foo

@synthesize fooID;
@synthesize fooLastUpdate;
@synthesize fooName;
@synthesize fooDescription;
@synthesize fooBoolean;
@synthesize fooDate;
@synthesize fooImage;
@synthesize fooFile;
@synthesize fooLocation;
@synthesize fooNumber;
@synthesize fooAge;
@synthesize fooOwner;

enum FooIndexes {
	FooIDIndex = 0,
	FooLastUpdateIndex,
	FooNameIndex,
	FooDescriptionIndex,
	FooBooleanIndex,
	FooDateIndex,
	FooImageIndex,
	FooFileIndex,
	FooOwnerIndex,
	FooLocationLatIndex,
	FooLocationLongIndex,
	FooNumberIndex,
	FooAgeIndex,};
#define NUM_OF_FOO_FIELDS 13

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
	request.shouldWorkOffline = kShouldFooWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.fooID]){
		request.action = Update;
		[request addValue:fooID forKey:KEY_fooID];
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
		case FooNumber:
			fooNumber += [value intValue];
			break;
		case FooAge:
			fooAge += [value intValue];
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
	request.shouldWorkOffline = kShouldFooWorkOffline;
	[request setBlock:block];
	request.delegate = self;
	[request addValue:fooID forKey:KEY_fooID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetFooFinished)block{
    __block Foo *item = [Foo instance];

    LiFilters *filters = [LiBasicFilters filterByField:FooID Operator:Equal Value:idString];
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

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetFooArrayFinished)block{
    Foo *item = [Foo instance];
    
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

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetFooArrayFinished)block{
    Foo *item = [Foo instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    Foo *item = [Foo instance];
    
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
    
        return [Foo getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
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

	[request addValue:fooID forKey:KEY_fooID];
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
            NSString *itemID = [responseData objectForKey:KEY_fooID];
            if (itemID)
                self.fooID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.fooID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[Foo getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    Foo *instace = [[Foo alloc] init];
    instace.fooID = ID;
    return [instace autorelease];
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetFooArrayFinished _block = (GetFooArrayFinished)block;
    if(_block)
        _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case FooID:
		self.fooID = value;
		break;
	case FooName:
		self.fooName = value;
		break;
	case FooDescription:
		self.fooDescription = value;
		break;
	case FooBoolean:
		self.fooBoolean = [value boolValue];
		break;
	case FooDate:
		self.fooDate = value;
		break;
	case FooImage:
		self.fooImage = value;
		break;
	case FooFile:
		self.fooFile = value;
		break;
	case FooOwner:
		self.fooOwner = value;
		break;
	case FooLocation:
		self.fooLocation = value;
		break;
	case FooNumber:
		self.fooNumber = [value intValue];
		break;
	case FooAge:
		self.fooAge = [value intValue];
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[fooID release];
	[fooLastUpdate release];
	[fooName release];
	[fooDescription release];
	[fooDate release];
	[fooImage release];
	[fooFile release];
	[fooLocation release];
	[fooOwner release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.fooID				= @"0";
		fooLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.fooName				= @"";
		self.fooDescription				= @"";
		self.fooBoolean				= YES;
		self.fooDate				= [[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease];
		self.fooImage				= [NSURL URLWithString:@""];
		self.fooFile				= [NSURL URLWithString:@""];
		self.fooLocation				=  [[[CLLocation alloc] initWithLatitude:0 longitude:0] autorelease];
		self.fooNumber				= 0;
		self.fooAge				= 0;
self.fooOwner    = [User instanceWithID:@"0"];
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.fooID               = [item objectForKey:KeyWithHeader(KEY_fooID, header)];
		fooLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_fooLastUpdate, header)] retain];
		self.fooName               = [item objectForKey:KeyWithHeader(KEY_fooName, header)];
		self.fooDescription               = [item objectForKey:KeyWithHeader(KEY_fooDescription, header)];
		self.fooBoolean               = [[item objectForKey:KeyWithHeader(KEY_fooBoolean, header)] boolValue];
		self.fooDate               = [item objectForKey:KeyWithHeader(KEY_fooDate, header)];
		self.fooImage               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_fooImage, header)]];
		self.fooFile               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_fooFile, header)]];
		self.fooLocation               = [[[CLLocation alloc] initWithLatitude:[[item objectForKey:KeyWithHeader(KEY_fooLocationLat, header)] floatValue] longitude:[[item objectForKey:KeyWithHeader(KEY_fooLocationLong, header)] floatValue]] autorelease];
		self.fooNumber               = [[item objectForKey:KeyWithHeader(KEY_fooNumber, header)] integerValue];
		self.fooAge               = [[item objectForKey:KeyWithHeader(KEY_fooAge, header)] integerValue];
		fooOwner               = [[User alloc] initWithDictionary:item Header:KeyWithHeader
	(@"_",KEY_fooOwner)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(Foo *)object {
	if (self = [super init]) {

		self.fooID               = object.fooID;
		fooLastUpdate               = [object.fooLastUpdate retain];
		self.fooName               = object.fooName;
		self.fooDescription               = object.fooDescription;
		self.fooBoolean               = object.fooBoolean;
		self.fooDate               = object.fooDate;
		self.fooImage               = object.fooImage;
		self.fooFile               = object.fooFile;
		self.fooLocation               = object.fooLocation;
		self.fooNumber               = object.fooNumber;
		self.fooAge               = object.fooAge;
		fooOwner               = [[User alloc] initWithObject:object.fooOwner];

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:fooID forKey:KEY_fooID];
	[dictionary addDateValue:fooLastUpdate forKey:KEY_fooLastUpdate];
	[dictionary addValue:fooName forKey:KEY_fooName];
	[dictionary addValue:fooDescription forKey:KEY_fooDescription];
	[dictionary addBoolValue:fooBoolean forKey:KEY_fooBoolean];
	[dictionary addDateValue:fooDate forKey:KEY_fooDate];
	[dictionary addValue:fooImage.absoluteString forKey:KEY_fooImage];	[dictionary addValue:fooFile.absoluteString forKey:KEY_fooFile];	[dictionary addGeoValue:fooLocation forKey:KEY_fooLocation];
	[dictionary addIntValue:fooNumber forKey:KEY_fooNumber];
	[dictionary addIntValue:fooAge forKey:KEY_fooAge];
	[dictionary addForeignKeyValue:fooOwner.dictionaryRepresentation forKey:KEY_fooOwner];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_fooID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_fooLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_fooName];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_fooDescription];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"1") forKey:KEY_fooBoolean];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_fooDate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_fooImage];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_fooFile];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"'0'") forKey:KEY_fooOwner];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_fooLocationLong];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_fooLocationLat];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_fooNumber];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_fooAge];
	
	return [fieldsDic autorelease];
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	[foreignKeysDic setValue:[User getClassName] forKey:KEY_fooOwner];
	
	return [foreignKeysDic autorelease];
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case Foo_None:
			fieldName = @"pos";
			break;
	
		case FooID:
			fieldName = KEY_fooID;
			break;

		case FooLastUpdate:
			fieldName = KEY_fooLastUpdate;
			break;

		case FooName:
			fieldName = KEY_fooName;
			break;

		case FooDescription:
			fieldName = KEY_fooDescription;
			break;

		case FooBoolean:
			fieldName = KEY_fooBoolean;
			break;

		case FooDate:
			fieldName = KEY_fooDate;
			break;

		case FooImage:
			fieldName = KEY_fooImage;
			break;

		case FooFile:
			fieldName = KEY_fooFile;
			break;

		case FooNumber:
			fieldName = KEY_fooNumber;
			break;

		case FooAge:
			fieldName = KEY_fooAge;
			break;

		case FooOwner:
			fieldName = KEY_fooOwner;
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
		case Foo_None:
			fieldName = @"pos";
			break;
	
		case FooLocation:
			fieldName = KEY_fooLocation;
			break;

		default:
			NSLog(@"Wrong Geo LiFields numerator for %@ Class",kClassName);
			fieldName = nil;
			break;
	}
	
	return fieldName;
}


- (void) addValuesToRequest:(LiObjRequest **)request{
	[*request addValue:fooName forKey:KEY_fooName];
	[*request addValue:fooDescription forKey:KEY_fooDescription];
	[*request addBoolValue:fooBoolean forKey:KEY_fooBoolean];
	[*request addDateValue:fooDate forKey:KEY_fooDate];
	[*request addValue:fooImage.absoluteString forKey:KEY_fooImage];
	[*request addValue:fooFile.absoluteString forKey:KEY_fooFile];
	[*request addLocationValue:fooLocation forKey:KEY_fooLocation];
	[*request addIntValue:fooNumber forKey:KEY_fooNumber];
	[*request addIntValue:fooAge forKey:KEY_fooAge];
	[*request addValue:fooOwner.userID forKey:KEY_fooOwner];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.fooID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooIDIndex])];
			fooLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooLastUpdateIndex])]] retain];
			self.fooName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooNameIndex])];
			self.fooDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooDescriptionIndex])];
			self.fooBoolean = sqlite3_column_int(stmt, array[0][FooBooleanIndex]);
			self.fooDate = [[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooDateIndex])]];
			self.fooImage = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooImageIndex])]];
			self.fooFile = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooFileIndex])]];

	if (isFK){
		self.fooOwner = [User instanceWithID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][FooOwnerIndex])]];
	} else {
		int **fooOwnerArray = (int **)malloc(sizeof(int *));
		fooOwnerArray[0] = array[1];
		self.fooOwner = [[User alloc] initWithStatement:stmt Array:fooOwnerArray IsFK:YES];
		free(fooOwnerArray);
	}

;
			self.fooLocation =  [[[CLLocation alloc] initWithLatitude:sqlite3_column_double(stmt, array[0][FooLocationLatIndex]) longitude:sqlite3_column_double(stmt, array[0][FooLocationLongIndex])] autorelease];
			self.fooNumber = sqlite3_column_int(stmt, array[0][FooNumberIndex]);
			self.fooAge = sqlite3_column_int(stmt, array[0][FooAgeIndex]);
		
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
	indexes[0] = (int *)malloc(NUM_OF_FOO_FIELDS*sizeof(int));
	indexes[1] = (int *)malloc(NUM_OF_USER_FIELDS*sizeof(int));

	indexes[0][FooIDIndex] = [columnsArray indexOfObject:KEY_fooID];
	indexes[0][FooLastUpdateIndex] = [columnsArray indexOfObject:KEY_fooLastUpdate];
	indexes[0][FooNameIndex] = [columnsArray indexOfObject:KEY_fooName];
	indexes[0][FooDescriptionIndex] = [columnsArray indexOfObject:KEY_fooDescription];
	indexes[0][FooBooleanIndex] = [columnsArray indexOfObject:KEY_fooBoolean];
	indexes[0][FooDateIndex] = [columnsArray indexOfObject:KEY_fooDate];
	indexes[0][FooImageIndex] = [columnsArray indexOfObject:KEY_fooImage];
	indexes[0][FooFileIndex] = [columnsArray indexOfObject:KEY_fooFile];
	indexes[0][FooOwnerIndex] = [columnsArray indexOfObject:KEY_fooOwner];
	indexes[0][FooLocationLatIndex] = [columnsArray indexOfObject:KEY_fooLocationLat];
	indexes[0][FooLocationLongIndex] = [columnsArray indexOfObject:KEY_fooLocationLong];
	indexes[0][FooNumberIndex] = [columnsArray indexOfObject:KEY_fooNumber];
	indexes[0][FooAgeIndex] = [columnsArray indexOfObject:KEY_fooAge];

	indexes[1][UserIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserID",@"_FooOwner")];
	indexes[1][UserNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserName",@"_FooOwner")];
	indexes[1][UserFirstNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFirstName",@"_FooOwner")];
	indexes[1][UserLastNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastName",@"_FooOwner")];
	indexes[1][UserEmailIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserEmail",@"_FooOwner")];
	indexes[1][UserPhoneIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPhone",@"_FooOwner")];
	indexes[1][UserPasswordIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserPassword",@"_FooOwner")];
	indexes[1][UserLastLoginIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastLogin",@"_FooOwner")];
	indexes[1][UserRegisterDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserRegisterDate",@"_FooOwner")];
	indexes[1][UserLocationLatIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLat",@"_FooOwner")];
	indexes[1][UserLocationLongIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLocationLong",@"_FooOwner")];
	indexes[1][UserIsRegisteredIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegistered",@"_FooOwner")];
	indexes[1][UserIsRegisteredFacebookIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserIsRegisteredFacebook",@"_FooOwner")];
	indexes[1][UserLastUpdateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserLastUpdate",@"_FooOwner")];
	indexes[1][UserImageIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserImage",@"_FooOwner")];
	indexes[1][UserMainCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserMainCurrencyBalance",@"_FooOwner")];
	indexes[1][UserSecondaryCurrencyBalanceIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserSecondaryCurrencyBalance",@"_FooOwner")];
	indexes[1][UserFacebookIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserFacebookID",@"_FooOwner")];
	indexes[1][UserTempDateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"UserTempDate",@"_FooOwner")];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][FooIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			Foo *item  = [[Foo alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
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

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetFooFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetFooArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetFooArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

#pragma mark - End of Basic SDK

@end
