//
// DataManString.m
// Created by Applicasa 
// 10/24/2013
//

#import "DataManString.h"

#define kClassName                  @"DataManString"

#define KEY_dataManStringID				@"DataManStringID"
#define KEY_dataManStringLastUpdate				@"DataManStringLastUpdate"
#define KEY_dataManStringKey				@"DataManStringKey"
#define KEY_dataManStringValue				@"DataManStringValue"

@interface DataManString (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation DataManString

@synthesize dataManStringID;
@synthesize dataManStringLastUpdate;
@synthesize dataManStringKey;
@synthesize dataManStringValue;

enum DataManStringIndexes {
	DataManStringIDIndex = 0,
	DataManStringLastUpdateIndex,
	DataManStringKeyIndex,
	DataManStringValueIndex,};
#define NUM_OF_DATAMANSTRING_FIELDS 4



#pragma mark - Save

- (void) saveWithBlock:(LiBlockAction)block{
	LiObjRequest *request = [LiObjRequest requestWithAction:Add ClassName:kClassName];
	request.shouldWorkOffline = kShouldDataManStringWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.dataManStringID]){
		request.action = Update;
		[request addValue:dataManStringID forKey:KEY_dataManStringID];
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
	request.shouldWorkOffline = kShouldDataManStringWorkOffline;
	[request setBlock:block];
	request.delegate = self;
	[request addValue:dataManStringID forKey:KEY_dataManStringID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetDataManStringFinished)block{
    __block DataManString *item = [DataManString instance];

    LiFilters *filters = [LiBasicFilters filterByField:DataManStringID Operator:Equal Value:idString];
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

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetDataManStringArrayFinished)block{
    DataManString *item = [DataManString instance];
    
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

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetDataManStringArrayFinished)block{
    DataManString *item = [DataManString instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    DataManString *item = [DataManString instance];
    
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
    
        return [DataManString getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
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

	[request addValue:dataManStringID forKey:KEY_dataManStringID];
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
            NSString *itemID = [responseData objectForKey:KEY_dataManStringID];
            if (itemID)
                self.dataManStringID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.dataManStringID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[DataManString getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    DataManString *instace = [[DataManString alloc] init];
    instace.dataManStringID = ID;
    return [instace autorelease];
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetDataManStringArrayFinished _block = (GetDataManStringArrayFinished)block;
    if(_block)
        _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case DataManStringID:
		self.dataManStringID = value;
		break;
	case DataManStringKey:
		self.dataManStringKey = value;
		break;
	case DataManStringValue:
		self.dataManStringValue = value;
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[dataManStringID release];
	[dataManStringLastUpdate release];
	[dataManStringKey release];
	[dataManStringValue release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.dataManStringID				= @"0";
		dataManStringLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.dataManStringKey				= @"";
		self.dataManStringValue				= @"";
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.dataManStringID               = [item objectForKey:KeyWithHeader(KEY_dataManStringID, header)];
		dataManStringLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_dataManStringLastUpdate, header)] retain];
		self.dataManStringKey               = [item objectForKey:KeyWithHeader(KEY_dataManStringKey, header)];
		self.dataManStringValue               = [item objectForKey:KeyWithHeader(KEY_dataManStringValue, header)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(DataManString *)object {
	if (self = [super init]) {

		self.dataManStringID               = object.dataManStringID;
		dataManStringLastUpdate               = [object.dataManStringLastUpdate retain];
		self.dataManStringKey               = object.dataManStringKey;
		self.dataManStringValue               = object.dataManStringValue;

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:dataManStringID forKey:KEY_dataManStringID];
	[dictionary addDateValue:dataManStringLastUpdate forKey:KEY_dataManStringLastUpdate];
	[dictionary addValue:dataManStringKey forKey:KEY_dataManStringKey];
	[dictionary addValue:dataManStringValue forKey:KEY_dataManStringValue];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_dataManStringID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_dataManStringLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_dataManStringKey];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_dataManStringValue];
	
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
		case DataManString_None:
			fieldName = @"pos";
			break;
	
		case DataManStringID:
			fieldName = KEY_dataManStringID;
			break;

		case DataManStringLastUpdate:
			fieldName = KEY_dataManStringLastUpdate;
			break;

		case DataManStringKey:
			fieldName = KEY_dataManStringKey;
			break;

		case DataManStringValue:
			fieldName = KEY_dataManStringValue;
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
		case DataManString_None:
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
	[*request addValue:dataManStringKey forKey:KEY_dataManStringKey];
	[*request addValue:dataManStringValue forKey:KEY_dataManStringValue];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.dataManStringID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DataManStringIDIndex])];
			dataManStringLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DataManStringLastUpdateIndex])]] retain];
			self.dataManStringKey = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DataManStringKeyIndex])];
			self.dataManStringValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DataManStringValueIndex])];
		
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
	indexes[0] = (int *)malloc(NUM_OF_DATAMANSTRING_FIELDS*sizeof(int));

	indexes[0][DataManStringIDIndex] = [columnsArray indexOfObject:KEY_dataManStringID];
	indexes[0][DataManStringLastUpdateIndex] = [columnsArray indexOfObject:KEY_dataManStringLastUpdate];
	indexes[0][DataManStringKeyIndex] = [columnsArray indexOfObject:KEY_dataManStringKey];
	indexes[0][DataManStringValueIndex] = [columnsArray indexOfObject:KEY_dataManStringValue];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][DataManStringIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			DataManString *item  = [[DataManString alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
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

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetDataManStringFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetDataManStringArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetDataManStringArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

#pragma mark - End of Basic SDK

@end
