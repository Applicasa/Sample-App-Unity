//
// Cards.m
// Created by Applicasa 
// 1/21/2014
//

#import "Cards.h"
#import "Languages.h"

#define kClassName                  @"Cards"

#define KEY_cardsID				@"CardsID"
#define KEY_cardsLastUpdate				@"CardsLastUpdate"
#define KEY_cardsName				@"CardsName"
#define KEY_cardsPres				@"CardsPres"
#define KEY_cardsImg				@"CardsImg"
#define KEY_cardsAaaaa				@"CardsAaaaa"

@interface Cards (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation Cards

@synthesize cardsID;
@synthesize cardsLastUpdate;
@synthesize cardsName;
@synthesize cardsPres;
@synthesize cardsImg;
@synthesize cardsAaaaa;

enum CardsIndexes {
	CardsIDIndex = 0,
	CardsLastUpdateIndex,
	CardsNameIndex,
	CardsPresIndex,
	CardsImgIndex,
	CardsAaaaaIndex,};
#define NUM_OF_CARDS_FIELDS 6

enum LanguagesIndexes {
	LanguagesIDIndex = 0,
	LanguagesLastUpdateIndex,
	LanguagesTextIndex,
	LanguagesLanguageNameIndex,};
#define NUM_OF_LANGUAGES_FIELDS 4


#pragma mark - Save

- (void) saveWithBlock:(LiBlockAction)block{
	LiObjRequest *request = [LiObjRequest requestWithAction:Add ClassName:kClassName];
	request.shouldWorkOffline = kShouldCardsWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.cardsID]){
		request.action = Update;
		[request addValue:cardsID forKey:KEY_cardsID];
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
		case CardsPres:
			cardsPres += [value floatValue];
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
	request.shouldWorkOffline = kShouldCardsWorkOffline;
	[request setBlock:block];
	request.delegate = self;
	[request addValue:cardsID forKey:KEY_cardsID];
	[request startSync:NO];    
}

#pragma mark - Get By ID

+ (void) getById:(NSString *)idString queryKind:(QueryKind)queryKind withBlock:(GetCardsFinished)block{
    __block Cards *item = [Cards instance];

    LiFilters *filters = [LiBasicFilters filterByField:CardsID Operator:Equal Value:idString];
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

+ (void) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind withBlock:(GetCardsArrayFinished)block{
    Cards *item = [Cards instance];
    
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

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetCardsArrayFinished)block{
    Cards *item = [Cards instance];

    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
    [request addValue:rawQuery forKey:@"filters"];
    [request setShouldWorkOffline:YES];
    [request startSync:YES];
    
    [item requestDidFinished:request];
}

+ (NSArray *) getArrayWithQuery:(LiQuery *)query queryKind:(QueryKind)queryKind {
    Cards *item = [Cards instance];
    
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
    
        return [Cards getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer];
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

	[request addValue:cardsID forKey:KEY_cardsID];
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
            NSString *itemID = [responseData objectForKey:KEY_cardsID];
            if (itemID)
                self.cardsID = itemID;
            
            [self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self.cardsID Action:action Block:[request getBlock]];
			[request releaseBlock];
        }
            break;

        case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
            NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[Cards getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];

			[request releaseBlock];
			
        }
            break;
        default:
            break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    Cards *instace = [[Cards alloc] init];
    instace.cardsID = ID;
    return [instace autorelease];
}


#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
	
    GetCardsArrayFinished _block = (GetCardsArrayFinished)block;
    if(_block)
        _block(error,array);
}



- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case CardsID:
		self.cardsID = value;
		break;
	case CardsName:
		self.cardsName = value;
		break;
	case CardsPres:
		self.cardsPres = [value floatValue];
		break;
	case CardsImg:
		self.cardsImg = value;
		break;
	case CardsAaaaa:
		self.cardsAaaaa = value;
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[cardsID release];
	[cardsLastUpdate release];
	[cardsName release];
	[cardsImg release];
	[cardsAaaaa release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.cardsID				= @"0";
		cardsLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
		self.cardsName				= @"";
		self.cardsPres				= 0;
		self.cardsImg				= [NSURL URLWithString:@""];
self.cardsAaaaa    = [Languages instanceWithID:@"0"];
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

		self.cardsID               = [item objectForKey:KeyWithHeader(KEY_cardsID, header)];
		cardsLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_cardsLastUpdate, header)] retain];
		self.cardsName               = [item objectForKey:KeyWithHeader(KEY_cardsName, header)];
		self.cardsPres               = [[item objectForKey:KeyWithHeader(KEY_cardsPres, header)] floatValue];
		self.cardsImg               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_cardsImg, header)]];
		cardsAaaaa               = [[Languages alloc] initWithDictionary:item Header:KeyWithHeader
	(@"_",KEY_cardsAaaaa)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(Cards *)object {
	if (self = [super init]) {

		self.cardsID               = object.cardsID;
		cardsLastUpdate               = [object.cardsLastUpdate retain];
		self.cardsName               = object.cardsName;
		self.cardsPres               = object.cardsPres;
		self.cardsImg               = object.cardsImg;
		cardsAaaaa               = [[Languages alloc] initWithObject:object.cardsAaaaa];

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:cardsID forKey:KEY_cardsID];
	[dictionary addDateValue:cardsLastUpdate forKey:KEY_cardsLastUpdate];
	[dictionary addValue:cardsName forKey:KEY_cardsName];
	[dictionary addFloatValue:cardsPres forKey:KEY_cardsPres];
	[dictionary addValue:cardsImg.absoluteString forKey:KEY_cardsImg];	[dictionary addForeignKeyValue:cardsAaaaa.dictionaryRepresentation forKey:KEY_cardsAaaaa];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_cardsID];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_cardsLastUpdate];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_cardsName];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_cardsPres];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_cardsImg];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"'0'") forKey:KEY_cardsAaaaa];
	
	return [fieldsDic autorelease];
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	[foreignKeysDic setValue:[Languages getClassName] forKey:KEY_cardsAaaaa];
	
	return [foreignKeysDic autorelease];
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case Cards_None:
			fieldName = @"pos";
			break;
	
		case CardsID:
			fieldName = KEY_cardsID;
			break;

		case CardsLastUpdate:
			fieldName = KEY_cardsLastUpdate;
			break;

		case CardsName:
			fieldName = KEY_cardsName;
			break;

		case CardsPres:
			fieldName = KEY_cardsPres;
			break;

		case CardsImg:
			fieldName = KEY_cardsImg;
			break;

		case CardsAaaaa:
			fieldName = KEY_cardsAaaaa;
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
		case Cards_None:
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
	[*request addValue:cardsName forKey:KEY_cardsName];
	[*request addFloatValue:cardsPres forKey:KEY_cardsPres];
	[*request addValue:cardsImg.absoluteString forKey:KEY_cardsImg];
	[*request addValue:cardsAaaaa.languagesID forKey:KEY_cardsAaaaa];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.cardsID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CardsIDIndex])];
			cardsLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CardsLastUpdateIndex])]] retain];
			self.cardsName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CardsNameIndex])];
			self.cardsPres = sqlite3_column_double(stmt, array[0][CardsPresIndex]);
			self.cardsImg = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CardsImgIndex])]];

	if (isFK){
		self.cardsAaaaa = [Languages instanceWithID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][CardsAaaaaIndex])]];
	} else {
		int **cardsAaaaaArray = (int **)malloc(sizeof(int *));
		cardsAaaaaArray[0] = array[1];
		self.cardsAaaaa = [[Languages alloc] initWithStatement:stmt Array:cardsAaaaaArray IsFK:YES];
		free(cardsAaaaaArray);
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
	indexes[0] = (int *)malloc(NUM_OF_CARDS_FIELDS*sizeof(int));
	indexes[1] = (int *)malloc(NUM_OF_LANGUAGES_FIELDS*sizeof(int));

	indexes[0][CardsIDIndex] = [columnsArray indexOfObject:KEY_cardsID];
	indexes[0][CardsLastUpdateIndex] = [columnsArray indexOfObject:KEY_cardsLastUpdate];
	indexes[0][CardsNameIndex] = [columnsArray indexOfObject:KEY_cardsName];
	indexes[0][CardsPresIndex] = [columnsArray indexOfObject:KEY_cardsPres];
	indexes[0][CardsImgIndex] = [columnsArray indexOfObject:KEY_cardsImg];
	indexes[0][CardsAaaaaIndex] = [columnsArray indexOfObject:KEY_cardsAaaaa];

	indexes[1][LanguagesIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"LanguagesID",@"_CardsAaaaa")];
	indexes[1][LanguagesLastUpdateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"LanguagesLastUpdate",@"_CardsAaaaa")];
	indexes[1][LanguagesTextIndex] = [columnsArray indexOfObject:KeyWithHeader(@"LanguagesText",@"_CardsAaaaa")];
	indexes[1][LanguagesLanguageNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"LanguagesLanguageName",@"_CardsAaaaa")];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][CardsIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			Cards *item  = [[Cards alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
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

+ (void) getByID:(NSString *)idString QueryKind:(QueryKind)queryKind WithBlock:(GetCardsFinished)block {
    [self getById:idString queryKind:queryKind withBlock:block];
}

+ (void) getArrayWithQuery:(LiQuery *)query QueryKind:(QueryKind)queryKind WithBlock:(GetCardsArrayFinished)block {
    [self getArrayWithQuery:query queryKind:queryKind withBlock:block];
}

+ (void) getArrayLocalyWithRawSQLQuery:(NSString *)rawQuery WithBlock:(GetCardsArrayFinished)block {
    [self getLocalArrayWithRawSQLQuery:rawQuery andBlock:block];
}

- (void)uploadFile:(NSData *)data ToField:(LiFields)field FileType:(AMAZON_FILE_TYPES)fileType Extenstion:(NSString *)ext WithBlock:(LiBlockAction)block {
    [self uploadFile:data toField:field withFileType:fileType extension:ext andBlock:block];
}

#pragma mark - End of Basic SDK

@end
