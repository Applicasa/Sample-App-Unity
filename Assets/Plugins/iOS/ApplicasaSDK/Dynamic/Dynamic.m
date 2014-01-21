//
// Dynamic.m
// Created by Applicasa 
// 1/21/2014
//

#import "Dynamic.h"

#define kClassName                  @"Dynamic"

#define KEY_dynamicID				@"DynamicID"
#define KEY_dynamicLastUpdate				@"DynamicLastUpdate"
#define KEY_dynamicText				@"DynamicText"
#define KEY_dynamicNumber				@"DynamicNumber"
#define KEY_dynamicReal				@"DynamicReal"
#define KEY_dynamicDate				@"DynamicDate"
#define KEY_dynamicBool				@"DynamicBool"
#define KEY_dynamicHtml				@"DynamicHtml"
#define KEY_dynamicImage				@"DynamicImage"

@interface Dynamic (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation Dynamic

@synthesize dynamicID;
@synthesize dynamicLastUpdate;
@synthesize dynamicText;
@synthesize dynamicNumber;
@synthesize dynamicReal;
@synthesize dynamicDate;
@synthesize dynamicBool;
@synthesize dynamicHtml;
@synthesize dynamicImage;

enum DynamicIndexes {
	DynamicIDIndex = 0,
	DynamicLastUpdateIndex,
	DynamicTextIndex,
	DynamicNumberIndex,
	DynamicRealIndex,
	DynamicDateIndex,
	DynamicBoolIndex,
	DynamicHtmlIndex,
	DynamicImageIndex,};
#define NUM_OF_DYNAMIC_FIELDS 9



#pragma mark - Save

- (void) saveWithBlock:(LiBlockAction)block{
	LiObjRequest *request = [LiObjRequest requestWithAction:Add ClassName:kClassName];
	request.shouldWorkOffline = kShouldDynamicWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.dynamicID]){
		request.action = Update;
		[request addValue:dynamicID forKey:KEY_dynamicID];
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
		case DynamicNumber:
			dynamicNumber += [value intValue];
			break;
		case DynamicReal:
			dynamicReal += [value floatValue];
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
	request.shouldWorkOffline = kShouldDynamicWorkOffline;
	[request setBlock:block];
	request.delegate = self;
	[request addValue:dynamicID forKey:KEY_dynamicID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetDynamicFinished)block{
    __block Dynamic *item = [Dynamic instance];

    LiFilters *filters = [LiBasicFilters filterByField:DynamicID Operator:Equal Value:idString];
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

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetDynamicArrayFinished)block{
    Dynamic *item = [Dynamic instance];
    
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

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetDynamicArrayFinished)block{
    Dynamic *item = [Dynamic instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    Dynamic *item = [Dynamic instance];
    
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
    
        return [Dynamic getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
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

	[request addValue:dynamicID forKey:KEY_dynamicID];
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
            NSString *itemID = [responseData objectForKey:KEY_dynamicID];
            if (itemID)
                self.dynamicID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.dynamicID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[Dynamic getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    Dynamic *instace = [[Dynamic alloc] init];
    instace.dynamicID = ID;
    return [instace autorelease];
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetDynamicArrayFinished _block = (GetDynamicArrayFinished)block;
    if(_block)
        _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case DynamicID:
		self.dynamicID = value;
		break;
	case DynamicText:
		self.dynamicText = value;
		break;
	case DynamicNumber:
		self.dynamicNumber = [value intValue];
		break;
	case DynamicReal:
		self.dynamicReal = [value floatValue];
		break;
	case DynamicDate:
		self.dynamicDate = value;
		break;
	case DynamicBool:
		self.dynamicBool = [value boolValue];
		break;
	case DynamicHtml:
		self.dynamicHtml = value;
		break;
	case DynamicImage:
		self.dynamicImage = value;
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[dynamicID release];
	[dynamicLastUpdate release];
	[dynamicText release];
	[dynamicDate release];
	[dynamicHtml release];
	[dynamicImage release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.dynamicID				= @"0";
		dynamicLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.dynamicText				= @"";
		self.dynamicNumber				= 0;
		self.dynamicReal				= 0;
		self.dynamicDate				= [[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease];
		self.dynamicBool				= YES;
		self.dynamicHtml				= @"";
		self.dynamicImage				= [NSURL URLWithString:@""];
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.dynamicID               = [item objectForKey:KeyWithHeader(KEY_dynamicID, header)];
		dynamicLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_dynamicLastUpdate, header)] retain];
		self.dynamicText               = [item objectForKey:KeyWithHeader(KEY_dynamicText, header)];
		self.dynamicNumber               = [[item objectForKey:KeyWithHeader(KEY_dynamicNumber, header)] integerValue];
		self.dynamicReal               = [[item objectForKey:KeyWithHeader(KEY_dynamicReal, header)] floatValue];
		self.dynamicDate               = [item objectForKey:KeyWithHeader(KEY_dynamicDate, header)];
		self.dynamicBool               = [[item objectForKey:KeyWithHeader(KEY_dynamicBool, header)] boolValue];
		self.dynamicHtml               = [item objectForKey:KeyWithHeader(KEY_dynamicHtml, header)];
		self.dynamicImage               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_dynamicImage, header)]];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(Dynamic *)object {
	if (self = [super init]) {

		self.dynamicID               = object.dynamicID;
		dynamicLastUpdate               = [object.dynamicLastUpdate retain];
		self.dynamicText               = object.dynamicText;
		self.dynamicNumber               = object.dynamicNumber;
		self.dynamicReal               = object.dynamicReal;
		self.dynamicDate               = object.dynamicDate;
		self.dynamicBool               = object.dynamicBool;
		self.dynamicHtml               = object.dynamicHtml;
		self.dynamicImage               = object.dynamicImage;

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:dynamicID forKey:KEY_dynamicID];
	[dictionary addDateValue:dynamicLastUpdate forKey:KEY_dynamicLastUpdate];
	[dictionary addValue:dynamicText forKey:KEY_dynamicText];
	[dictionary addIntValue:dynamicNumber forKey:KEY_dynamicNumber];
	[dictionary addFloatValue:dynamicReal forKey:KEY_dynamicReal];
	[dictionary addDateValue:dynamicDate forKey:KEY_dynamicDate];
	[dictionary addBoolValue:dynamicBool forKey:KEY_dynamicBool];
	[dictionary addValue:dynamicHtml forKey:KEY_dynamicHtml];
	[dictionary addValue:dynamicImage.absoluteString forKey:KEY_dynamicImage];
	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_dynamicID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_dynamicLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_dynamicText];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_dynamicNumber];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_dynamicReal];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_dynamicDate];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"1") forKey:KEY_dynamicBool];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_dynamicHtml];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_dynamicImage];
	
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
		case Dynamic_None:
			fieldName = @"pos";
			break;
	
		case DynamicID:
			fieldName = KEY_dynamicID;
			break;

		case DynamicLastUpdate:
			fieldName = KEY_dynamicLastUpdate;
			break;

		case DynamicText:
			fieldName = KEY_dynamicText;
			break;

		case DynamicNumber:
			fieldName = KEY_dynamicNumber;
			break;

		case DynamicReal:
			fieldName = KEY_dynamicReal;
			break;

		case DynamicDate:
			fieldName = KEY_dynamicDate;
			break;

		case DynamicBool:
			fieldName = KEY_dynamicBool;
			break;

		case DynamicHtml:
			fieldName = KEY_dynamicHtml;
			break;

		case DynamicImage:
			fieldName = KEY_dynamicImage;
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
		case Dynamic_None:
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
	[*request addValue:dynamicText forKey:KEY_dynamicText];
	[*request addIntValue:dynamicNumber forKey:KEY_dynamicNumber];
	[*request addFloatValue:dynamicReal forKey:KEY_dynamicReal];
	[*request addDateValue:dynamicDate forKey:KEY_dynamicDate];
	[*request addBoolValue:dynamicBool forKey:KEY_dynamicBool];
	[*request addValue:dynamicHtml forKey:KEY_dynamicHtml];
	[*request addValue:dynamicImage.absoluteString forKey:KEY_dynamicImage];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.dynamicID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DynamicIDIndex])];
			dynamicLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DynamicLastUpdateIndex])]] retain];
			self.dynamicText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DynamicTextIndex])];
			self.dynamicNumber = sqlite3_column_int(stmt, array[0][DynamicNumberIndex]);
			self.dynamicReal = sqlite3_column_double(stmt, array[0][DynamicRealIndex]);
			self.dynamicDate = [[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DynamicDateIndex])]];
			self.dynamicBool = sqlite3_column_int(stmt, array[0][DynamicBoolIndex]);
			self.dynamicHtml = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DynamicHtmlIndex])];
			self.dynamicImage = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][DynamicImageIndex])]];
		
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
	indexes[0] = (int *)malloc(NUM_OF_DYNAMIC_FIELDS*sizeof(int));

	indexes[0][DynamicIDIndex] = [columnsArray indexOfObject:KEY_dynamicID];
	indexes[0][DynamicLastUpdateIndex] = [columnsArray indexOfObject:KEY_dynamicLastUpdate];
	indexes[0][DynamicTextIndex] = [columnsArray indexOfObject:KEY_dynamicText];
	indexes[0][DynamicNumberIndex] = [columnsArray indexOfObject:KEY_dynamicNumber];
	indexes[0][DynamicRealIndex] = [columnsArray indexOfObject:KEY_dynamicReal];
	indexes[0][DynamicDateIndex] = [columnsArray indexOfObject:KEY_dynamicDate];
	indexes[0][DynamicBoolIndex] = [columnsArray indexOfObject:KEY_dynamicBool];
	indexes[0][DynamicHtmlIndex] = [columnsArray indexOfObject:KEY_dynamicHtml];
	indexes[0][DynamicImageIndex] = [columnsArray indexOfObject:KEY_dynamicImage];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][DynamicIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			Dynamic *item  = [[Dynamic alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
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

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetDynamicFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetDynamicArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetDynamicArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

#pragma mark - End of Basic SDK

@end
