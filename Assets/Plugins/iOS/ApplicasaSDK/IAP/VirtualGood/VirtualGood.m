//
// VirtualGood.m
// Created by Applicasa 
// 10/30/2013
//

#import "VirtualGood.h"
#import "VirtualGoodCategory.h"

#define kClassName                  @"VirtualGood"

#define KEY_virtualGoodID				@"VirtualGoodID"
#define KEY_virtualGoodTitle				@"VirtualGoodTitle"
#define KEY_virtualGoodDescription				@"VirtualGoodDescription"
#define KEY_virtualGoodAppleIdentifier				@"VirtualGoodAppleIdentifier"
#define KEY_virtualGoodGoogleIdentifier				@"VirtualGoodGoogleIdentifier"
#define KEY_virtualGoodMainCurrency				@"VirtualGoodMainCurrency"
#define KEY_virtualGoodSecondaryCurrency				@"VirtualGoodSecondaryCurrency"
#define KEY_virtualGoodRelatedVirtualGood				@"VirtualGoodRelatedVirtualGood"
#define KEY_virtualGoodIOSBundleMin				@"VirtualGoodIOSBundleMin"
#define KEY_virtualGoodIOSBundleMax				@"VirtualGoodIOSBundleMax"
#define KEY_virtualGoodAndroidBundleMin				@"VirtualGoodAndroidBundleMin"
#define KEY_virtualGoodAndroidBundleMax				@"VirtualGoodAndroidBundleMax"
#define KEY_virtualGoodStoreItemPrice				@"VirtualGoodStoreItemPrice"
#define KEY_virtualGoodPos				@"VirtualGoodPos"
#define KEY_virtualGoodQuantity				@"VirtualGoodQuantity"
#define KEY_virtualGoodMaxForUser				@"VirtualGoodMaxForUser"
#define KEY_virtualGoodUserInventory				@"VirtualGoodUserInventory"
#define KEY_virtualGoodImageA				@"VirtualGoodImageA"
#define KEY_virtualGoodImageB				@"VirtualGoodImageB"
#define KEY_virtualGoodImageC				@"VirtualGoodImageC"
#define KEY_virtualGoodInAppleStore				@"VirtualGoodInAppleStore"
#define KEY_virtualGoodInGoogleStore				@"VirtualGoodInGoogleStore"
#define KEY_virtualGoodIsStoreItem				@"VirtualGoodIsStoreItem"
#define KEY_virtualGoodIsDeal				@"VirtualGoodIsDeal"
#define KEY_virtualGoodConsumable				@"VirtualGoodConsumable"
#define KEY_virtualGoodLastUpdate				@"VirtualGoodLastUpdate"
#define KEY_virtualGoodMainCategory				@"VirtualGoodMainCategory"

@interface VirtualGood (privateMethods)

- (void) updateField:(LiFields)field withValue:(NSNumber *)value;
- (void) setField:(LiFields)field toValue:(id)value;

@end

@implementation VirtualGood

@synthesize virtualGoodID;
@synthesize virtualGoodTitle;
@synthesize virtualGoodDescription;
@synthesize virtualGoodAppleIdentifier;
@synthesize virtualGoodGoogleIdentifier;
@synthesize virtualGoodMainCurrency;
@synthesize virtualGoodSecondaryCurrency;
@synthesize virtualGoodRelatedVirtualGood;
@synthesize virtualGoodIOSBundleMin;
@synthesize virtualGoodIOSBundleMax;
@synthesize virtualGoodAndroidBundleMin;
@synthesize virtualGoodAndroidBundleMax;
@synthesize virtualGoodStoreItemPrice;
@synthesize virtualGoodPos;
@synthesize virtualGoodQuantity;
@synthesize virtualGoodMaxForUser;
@synthesize virtualGoodUserInventory;
@synthesize virtualGoodImageA;
@synthesize virtualGoodImageB;
@synthesize virtualGoodImageC;
@synthesize virtualGoodInAppleStore;
@synthesize virtualGoodInGoogleStore;
@synthesize virtualGoodIsStoreItem;
@synthesize virtualGoodIsDeal;
@synthesize virtualGoodConsumable;
@synthesize virtualGoodLastUpdate;
@synthesize virtualGoodMainCategory;

enum VirtualGoodIndexes {
	VirtualGoodIDIndex = 0,
	VirtualGoodTitleIndex,
	VirtualGoodDescriptionIndex,
	VirtualGoodAppleIdentifierIndex,
	VirtualGoodGoogleIdentifierIndex,
	VirtualGoodMainCurrencyIndex,
	VirtualGoodSecondaryCurrencyIndex,
	VirtualGoodRelatedVirtualGoodIndex,
	VirtualGoodIOSBundleMinIndex,
	VirtualGoodIOSBundleMaxIndex,
	VirtualGoodAndroidBundleMinIndex,
	VirtualGoodAndroidBundleMaxIndex,
	VirtualGoodStoreItemPriceIndex,
	VirtualGoodPosIndex,
	VirtualGoodQuantityIndex,
	VirtualGoodMaxForUserIndex,
	VirtualGoodUserInventoryIndex,
	VirtualGoodImageAIndex,
	VirtualGoodImageBIndex,
	VirtualGoodImageCIndex,
	VirtualGoodInAppleStoreIndex,
	VirtualGoodInGoogleStoreIndex,
	VirtualGoodIsStoreItemIndex,
	VirtualGoodMainCategoryIndex,
	VirtualGoodIsDealIndex,
	VirtualGoodConsumableIndex,
	VirtualGoodLastUpdateIndex,};
#define NUM_OF_VIRTUALGOOD_FIELDS 27

enum VirtualGoodCategoryIndexes {
	VirtualGoodCategoryIDIndex = 0,
	VirtualGoodCategoryNameIndex,
	VirtualGoodCategoryLastUpdateIndex,
	VirtualGoodCategoryPosIndex,};
#define NUM_OF_VIRTUALGOODCATEGORY_FIELDS 4


#pragma mark - Save

- (void) saveWithBlock:(LiBlockAction)block{
	LiObjRequest *request = [LiObjRequest requestWithAction:Add ClassName:kClassName];
	request.shouldWorkOffline = kShouldVirtualGoodWorkOffline;

	[request setBlock:block];
	[self addValuesToRequest:&request];

	if ([self isServerId:self.virtualGoodID]){
		request.action = Update;
		[request addValue:virtualGoodID forKey:KEY_virtualGoodID];
		if (self.increaseDictionary.count){
			[request.requestParameters setValue:self.increaseDictionary forKey:@"$inc"];
			self.increaseDictionary = nil;
		}
	} 	else {
		[self respondToLiActionCallBack:1023 ResponseMessage:@"Attempt to add VirtualGood instance" ItemID:@"0" Action:Add Block:block];
		return;
	}	
	request.delegate = self;
	[request startSync:NO];
}

- (void) updateField:(LiFields)field withValue:(NSNumber *)value{
	switch (field) {
		case VirtualGoodMainCurrency:
			virtualGoodMainCurrency += [value intValue];
			break;
		case VirtualGoodSecondaryCurrency:
			virtualGoodSecondaryCurrency += [value intValue];
			break;
		case VirtualGoodIOSBundleMin:
			virtualGoodIOSBundleMin += [value floatValue];
			break;
		case VirtualGoodIOSBundleMax:
			virtualGoodIOSBundleMax += [value floatValue];
			break;
		case VirtualGoodAndroidBundleMin:
			virtualGoodAndroidBundleMin += [value floatValue];
			break;
		case VirtualGoodAndroidBundleMax:
			virtualGoodAndroidBundleMax += [value floatValue];
			break;
		case VirtualGoodStoreItemPrice:
			virtualGoodStoreItemPrice += [value floatValue];
			break;
		case VirtualGoodQuantity:
			virtualGoodQuantity += [value intValue];
			break;
		case VirtualGoodMaxForUser:
			virtualGoodMaxForUser += [value intValue];
			break;
		case VirtualGoodUserInventory:
			virtualGoodUserInventory += [value intValue];
			break;
		default:
			break;
	}
}


- (void) setField:(LiFields)field toValue:(id)value{
	switch (field) {
	case VirtualGoodID:
		self.virtualGoodID = value;
		break;
	case VirtualGoodTitle:
		self.virtualGoodTitle = value;
		break;
	case VirtualGoodDescription:
		self.virtualGoodDescription = value;
		break;
	case VirtualGoodAppleIdentifier:
		self.virtualGoodAppleIdentifier = value;
		break;
	case VirtualGoodGoogleIdentifier:
		self.virtualGoodGoogleIdentifier = value;
		break;
	case VirtualGoodMainCurrency:
		self.virtualGoodMainCurrency = [value intValue];
		break;
	case VirtualGoodSecondaryCurrency:
		self.virtualGoodSecondaryCurrency = [value intValue];
		break;
	case VirtualGoodRelatedVirtualGood:
		self.virtualGoodRelatedVirtualGood = value;
		break;
	case VirtualGoodIOSBundleMin:
		self.virtualGoodIOSBundleMin = [value floatValue];
		break;
	case VirtualGoodIOSBundleMax:
		self.virtualGoodIOSBundleMax = [value floatValue];
		break;
	case VirtualGoodAndroidBundleMin:
		self.virtualGoodAndroidBundleMin = [value floatValue];
		break;
	case VirtualGoodAndroidBundleMax:
		self.virtualGoodAndroidBundleMax = [value floatValue];
		break;
	case VirtualGoodStoreItemPrice:
		self.virtualGoodStoreItemPrice = [value floatValue];
		break;
	case VirtualGoodQuantity:
		self.virtualGoodQuantity = [value intValue];
		break;
	case VirtualGoodMaxForUser:
		self.virtualGoodMaxForUser = [value intValue];
		break;
	case VirtualGoodUserInventory:
		self.virtualGoodUserInventory = [value intValue];
		break;
	case VirtualGoodImageA:
		self.virtualGoodImageA = value;
		break;
	case VirtualGoodImageB:
		self.virtualGoodImageB = value;
		break;
	case VirtualGoodImageC:
		self.virtualGoodImageC = value;
		break;
	case VirtualGoodInAppleStore:
		self.virtualGoodInAppleStore = [value boolValue];
		break;
	case VirtualGoodInGoogleStore:
		self.virtualGoodInGoogleStore = [value boolValue];
		break;
	case VirtualGoodIsStoreItem:
		self.virtualGoodIsStoreItem = [value boolValue];
		break;
	case VirtualGoodMainCategory:
		self.virtualGoodMainCategory = value;
		break;
	case VirtualGoodIsDeal:
		self.virtualGoodIsDeal = [value boolValue];
		break;
	case VirtualGoodConsumable:
		self.virtualGoodConsumable = [value boolValue];
		break;
	default:
	break;
	}
}


# pragma mark - Memory Management

- (void) dealloc
{
	[virtualGoodID release];
	[virtualGoodTitle release];
	[virtualGoodDescription release];
	[virtualGoodAppleIdentifier release];
	[virtualGoodGoogleIdentifier release];
	[virtualGoodRelatedVirtualGood release];
	[virtualGoodImageA release];
	[virtualGoodImageB release];
	[virtualGoodImageC release];
	[virtualGoodLastUpdate release];
	[virtualGoodMainCategory release];


	[super dealloc];
}


# pragma mark - Initialization

/*
*  init with defaults values
*/
- (id) init {
	if (self = [super init]) {

		self.virtualGoodID				= @"0";
		self.virtualGoodTitle				= @"";
		self.virtualGoodDescription				= @"";
		self.virtualGoodAppleIdentifier				= @"";
		self.virtualGoodGoogleIdentifier				= @"";
		self.virtualGoodMainCurrency				= 0;
		self.virtualGoodSecondaryCurrency				= 0;
		self.virtualGoodRelatedVirtualGood				= @"";
		self.virtualGoodIOSBundleMin				= 0;
		self.virtualGoodIOSBundleMax				= 0;
		self.virtualGoodAndroidBundleMin				= 0;
		self.virtualGoodAndroidBundleMax				= 0;
		self.virtualGoodStoreItemPrice				= 0;
		virtualGoodPos				= 1;
		self.virtualGoodQuantity				= 0;
		self.virtualGoodMaxForUser				= 0;
		self.virtualGoodUserInventory				= 0;
		self.virtualGoodImageA				= [NSURL URLWithString:@""];
		self.virtualGoodImageB				= [NSURL URLWithString:@""];
		self.virtualGoodImageC				= [NSURL URLWithString:@""];
		self.virtualGoodInAppleStore				= NO;
		self.virtualGoodInGoogleStore				= NO;
		self.virtualGoodIsStoreItem				= NO;
		self.virtualGoodIsDeal				= NO;
		self.virtualGoodConsumable				= YES;
		virtualGoodLastUpdate				= [[[[NSDate alloc] initWithTimeIntervalSince1970:0] autorelease] retain];
self.virtualGoodMainCategory    = [VirtualGoodCategory instanceWithID:@"0"];
	}
	return self;
}

- (BOOL) validateSecurityForDictionary:(NSDictionary *)dictionary Header:(NSString *)header{
	return [LiKitIAP validateObjectDictionary:dictionary FromTable:kClassName Header:header];
}

- (id) initWithDictionary:(NSDictionary *)item Header:(NSString *)header{
	if (self = [self init]) {

	if (![self validateSecurityForDictionary:item Header:header])
		return self;
		self.virtualGoodID               = [item objectForKey:KeyWithHeader(KEY_virtualGoodID, header)];
		self.virtualGoodTitle               = [item objectForKey:KeyWithHeader(KEY_virtualGoodTitle, header)];
		self.virtualGoodDescription               = [item objectForKey:KeyWithHeader(KEY_virtualGoodDescription, header)];
		self.virtualGoodAppleIdentifier               = [item objectForKey:KeyWithHeader(KEY_virtualGoodAppleIdentifier, header)];
		self.virtualGoodGoogleIdentifier               = [item objectForKey:KeyWithHeader(KEY_virtualGoodGoogleIdentifier, header)];
		self.virtualGoodMainCurrency               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodMainCurrency, header)] integerValue];
		self.virtualGoodSecondaryCurrency               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodSecondaryCurrency, header)] integerValue];
		self.virtualGoodRelatedVirtualGood               = [item objectForKey:KeyWithHeader(KEY_virtualGoodRelatedVirtualGood, header)];
		self.virtualGoodIOSBundleMin               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodIOSBundleMin, header)] floatValue];
		self.virtualGoodIOSBundleMax               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodIOSBundleMax, header)] floatValue];
		self.virtualGoodAndroidBundleMin               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodAndroidBundleMin, header)] floatValue];
		self.virtualGoodAndroidBundleMax               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodAndroidBundleMax, header)] floatValue];
		self.virtualGoodStoreItemPrice               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodStoreItemPrice, header)] floatValue];
		virtualGoodPos               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodPos, header)] integerValue];
		self.virtualGoodQuantity               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodQuantity, header)] integerValue];
		self.virtualGoodMaxForUser               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodMaxForUser, header)] integerValue];
		self.virtualGoodUserInventory               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodUserInventory, header)] integerValue];
		self.virtualGoodImageA               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_virtualGoodImageA, header)]];
		self.virtualGoodImageB               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_virtualGoodImageB, header)]];
		self.virtualGoodImageC               = [NSURL URLWithString:[item objectForKey:KeyWithHeader(KEY_virtualGoodImageC, header)]];
		self.virtualGoodInAppleStore               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodInAppleStore, header)] boolValue];
		self.virtualGoodInGoogleStore               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodInGoogleStore, header)] boolValue];
		self.virtualGoodIsStoreItem               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodIsStoreItem, header)] boolValue];
		self.virtualGoodIsDeal               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodIsDeal, header)] boolValue];
		self.virtualGoodConsumable               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodConsumable, header)] boolValue];
		virtualGoodLastUpdate               = [[item objectForKey:KeyWithHeader(KEY_virtualGoodLastUpdate, header)] retain];
		virtualGoodMainCategory               = [[VirtualGoodCategory alloc] initWithDictionary:item Header:KeyWithHeader
	(@"_",KEY_virtualGoodMainCategory)];

	}
	return self;
}

/*
*  init values from Object
*/
- (id) initWithObject:(VirtualGood *)object {
	if (self = [super init]) {

		self.virtualGoodID               = object.virtualGoodID;
		self.virtualGoodTitle               = object.virtualGoodTitle;
		self.virtualGoodDescription               = object.virtualGoodDescription;
		self.virtualGoodAppleIdentifier               = object.virtualGoodAppleIdentifier;
		self.virtualGoodGoogleIdentifier               = object.virtualGoodGoogleIdentifier;
		self.virtualGoodMainCurrency               = object.virtualGoodMainCurrency;
		self.virtualGoodSecondaryCurrency               = object.virtualGoodSecondaryCurrency;
		self.virtualGoodRelatedVirtualGood               = object.virtualGoodRelatedVirtualGood;
		self.virtualGoodIOSBundleMin               = object.virtualGoodIOSBundleMin;
		self.virtualGoodIOSBundleMax               = object.virtualGoodIOSBundleMax;
		self.virtualGoodAndroidBundleMin               = object.virtualGoodAndroidBundleMin;
		self.virtualGoodAndroidBundleMax               = object.virtualGoodAndroidBundleMax;
		self.virtualGoodStoreItemPrice               = object.virtualGoodStoreItemPrice;
		virtualGoodPos               = object.virtualGoodPos;
		self.virtualGoodQuantity               = object.virtualGoodQuantity;
		self.virtualGoodMaxForUser               = object.virtualGoodMaxForUser;
		self.virtualGoodUserInventory               = object.virtualGoodUserInventory;
		self.virtualGoodImageA               = object.virtualGoodImageA;
		self.virtualGoodImageB               = object.virtualGoodImageB;
		self.virtualGoodImageC               = object.virtualGoodImageC;
		self.virtualGoodInAppleStore               = object.virtualGoodInAppleStore;
		self.virtualGoodInGoogleStore               = object.virtualGoodInGoogleStore;
		self.virtualGoodIsStoreItem               = object.virtualGoodIsStoreItem;
		self.virtualGoodIsDeal               = object.virtualGoodIsDeal;
		self.virtualGoodConsumable               = object.virtualGoodConsumable;
		virtualGoodLastUpdate               = [object.virtualGoodLastUpdate retain];
		virtualGoodMainCategory               = [[VirtualGoodCategory alloc] initWithObject:object.virtualGoodMainCategory];

	}
	return self;
}

- (NSDictionary *) dictionaryRepresentation{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];

	[dictionary addValue:virtualGoodID forKey:KEY_virtualGoodID];
	[dictionary addValue:virtualGoodTitle forKey:KEY_virtualGoodTitle];
	[dictionary addValue:virtualGoodDescription forKey:KEY_virtualGoodDescription];
	[dictionary addValue:virtualGoodAppleIdentifier forKey:KEY_virtualGoodAppleIdentifier];
	[dictionary addValue:virtualGoodGoogleIdentifier forKey:KEY_virtualGoodGoogleIdentifier];
	[dictionary addIntValue:virtualGoodMainCurrency forKey:KEY_virtualGoodMainCurrency];
	[dictionary addIntValue:virtualGoodSecondaryCurrency forKey:KEY_virtualGoodSecondaryCurrency];
	[dictionary addValue:virtualGoodRelatedVirtualGood forKey:KEY_virtualGoodRelatedVirtualGood];
	[dictionary addFloatValue:virtualGoodIOSBundleMin forKey:KEY_virtualGoodIOSBundleMin];
	[dictionary addFloatValue:virtualGoodIOSBundleMax forKey:KEY_virtualGoodIOSBundleMax];
	[dictionary addFloatValue:virtualGoodAndroidBundleMin forKey:KEY_virtualGoodAndroidBundleMin];
	[dictionary addFloatValue:virtualGoodAndroidBundleMax forKey:KEY_virtualGoodAndroidBundleMax];
	[dictionary addFloatValue:virtualGoodStoreItemPrice forKey:KEY_virtualGoodStoreItemPrice];
	[dictionary addIntValue:virtualGoodPos forKey:KEY_virtualGoodPos];
	[dictionary addIntValue:virtualGoodQuantity forKey:KEY_virtualGoodQuantity];
	[dictionary addIntValue:virtualGoodMaxForUser forKey:KEY_virtualGoodMaxForUser];
	[dictionary addIntValue:virtualGoodUserInventory forKey:KEY_virtualGoodUserInventory];
	[dictionary addValue:virtualGoodImageA.absoluteString forKey:KEY_virtualGoodImageA];	[dictionary addValue:virtualGoodImageB.absoluteString forKey:KEY_virtualGoodImageB];	[dictionary addValue:virtualGoodImageC.absoluteString forKey:KEY_virtualGoodImageC];	[dictionary addBoolValue:virtualGoodInAppleStore forKey:KEY_virtualGoodInAppleStore];
	[dictionary addBoolValue:virtualGoodInGoogleStore forKey:KEY_virtualGoodInGoogleStore];
	[dictionary addBoolValue:virtualGoodIsStoreItem forKey:KEY_virtualGoodIsStoreItem];
	[dictionary addBoolValue:virtualGoodIsDeal forKey:KEY_virtualGoodIsDeal];
	[dictionary addBoolValue:virtualGoodConsumable forKey:KEY_virtualGoodConsumable];
	[dictionary addDateValue:virtualGoodLastUpdate forKey:KEY_virtualGoodLastUpdate];
	[dictionary addForeignKeyValue:virtualGoodMainCategory.dictionaryRepresentation forKey:KEY_virtualGoodMainCategory];

	return [dictionary autorelease];
}

+ (NSDictionary *) getFields{
	NSMutableDictionary *fieldsDic = [[NSMutableDictionary alloc] init];
	
	[fieldsDic setValue:[NSString stringWithFormat:@"%@ %@",kTEXT_TYPE,kPRIMARY_KEY] forKey:KEY_virtualGoodID];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodTitle];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodDescription];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodAppleIdentifier];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodGoogleIdentifier];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodMainCurrency];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodSecondaryCurrency];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodRelatedVirtualGood];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_virtualGoodIOSBundleMin];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_virtualGoodIOSBundleMax];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_virtualGoodAndroidBundleMin];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_virtualGoodAndroidBundleMax];
	[fieldsDic setValue:TypeAndDefaultValue(kREAL_TYPE,@"0") forKey:KEY_virtualGoodStoreItemPrice];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"1") forKey:KEY_virtualGoodPos];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodQuantity];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodMaxForUser];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodUserInventory];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodImageA];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodImageB];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"''") forKey:KEY_virtualGoodImageC];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodInAppleStore];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodInGoogleStore];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodIsStoreItem];
	[fieldsDic setValue:TypeAndDefaultValue(kTEXT_TYPE,@"'0'") forKey:KEY_virtualGoodMainCategory];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"0") forKey:KEY_virtualGoodIsDeal];
	[fieldsDic setValue:TypeAndDefaultValue(kINTEGER_TYPE,@"1") forKey:KEY_virtualGoodConsumable];
	[fieldsDic setValue:TypeAndDefaultValue(kDATETIME_TYPE,@"'1970-01-01 00:00:00'") forKey:KEY_virtualGoodLastUpdate];
	[fieldsDic setValue:kTEXT_TYPE forKey:@"Security"];
	
	return [fieldsDic autorelease];
}

+ (NSDictionary *) getForeignKeys{
	NSMutableDictionary *foreignKeysDic = [[NSMutableDictionary alloc] init];

	[foreignKeysDic setValue:[VirtualGoodCategory getClassName] forKey:KEY_virtualGoodMainCategory];
	
	return [foreignKeysDic autorelease];
}

+ (NSString *) getClassName{
	return kClassName;
}

+ (NSString *) getFieldName:(LiFields)field{
	NSString *fieldName;
	
	switch (field) {
		case VirtualGood_None:
			fieldName = @"pos";
			break;
	
		case VirtualGoodID:
			fieldName = KEY_virtualGoodID;
			break;

		case VirtualGoodTitle:
			fieldName = KEY_virtualGoodTitle;
			break;

		case VirtualGoodDescription:
			fieldName = KEY_virtualGoodDescription;
			break;

		case VirtualGoodAppleIdentifier:
			fieldName = KEY_virtualGoodAppleIdentifier;
			break;

		case VirtualGoodGoogleIdentifier:
			fieldName = KEY_virtualGoodGoogleIdentifier;
			break;

		case VirtualGoodMainCurrency:
			fieldName = KEY_virtualGoodMainCurrency;
			break;

		case VirtualGoodSecondaryCurrency:
			fieldName = KEY_virtualGoodSecondaryCurrency;
			break;

		case VirtualGoodRelatedVirtualGood:
			fieldName = KEY_virtualGoodRelatedVirtualGood;
			break;

		case VirtualGoodIOSBundleMin:
			fieldName = KEY_virtualGoodIOSBundleMin;
			break;

		case VirtualGoodIOSBundleMax:
			fieldName = KEY_virtualGoodIOSBundleMax;
			break;

		case VirtualGoodAndroidBundleMin:
			fieldName = KEY_virtualGoodAndroidBundleMin;
			break;

		case VirtualGoodAndroidBundleMax:
			fieldName = KEY_virtualGoodAndroidBundleMax;
			break;

		case VirtualGoodStoreItemPrice:
			fieldName = KEY_virtualGoodStoreItemPrice;
			break;

		case VirtualGoodPos:
			fieldName = KEY_virtualGoodPos;
			break;

		case VirtualGoodQuantity:
			fieldName = KEY_virtualGoodQuantity;
			break;

		case VirtualGoodMaxForUser:
			fieldName = KEY_virtualGoodMaxForUser;
			break;

		case VirtualGoodUserInventory:
			fieldName = KEY_virtualGoodUserInventory;
			break;

		case VirtualGoodImageA:
			fieldName = KEY_virtualGoodImageA;
			break;

		case VirtualGoodImageB:
			fieldName = KEY_virtualGoodImageB;
			break;

		case VirtualGoodImageC:
			fieldName = KEY_virtualGoodImageC;
			break;

		case VirtualGoodInAppleStore:
			fieldName = KEY_virtualGoodInAppleStore;
			break;

		case VirtualGoodInGoogleStore:
			fieldName = KEY_virtualGoodInGoogleStore;
			break;

		case VirtualGoodIsStoreItem:
			fieldName = KEY_virtualGoodIsStoreItem;
			break;

		case VirtualGoodIsDeal:
			fieldName = KEY_virtualGoodIsDeal;
			break;

		case VirtualGoodConsumable:
			fieldName = KEY_virtualGoodConsumable;
			break;

		case VirtualGoodLastUpdate:
			fieldName = KEY_virtualGoodLastUpdate;
			break;

		case VirtualGoodMainCategory:
			fieldName = KEY_virtualGoodMainCategory;
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
		case VirtualGood_None:
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
	[*request addValue:virtualGoodTitle forKey:KEY_virtualGoodTitle];
	[*request addValue:virtualGoodDescription forKey:KEY_virtualGoodDescription];
	[*request addValue:virtualGoodAppleIdentifier forKey:KEY_virtualGoodAppleIdentifier];
	[*request addValue:virtualGoodGoogleIdentifier forKey:KEY_virtualGoodGoogleIdentifier];
	[*request addIntValue:virtualGoodMainCurrency forKey:KEY_virtualGoodMainCurrency];
	[*request addIntValue:virtualGoodSecondaryCurrency forKey:KEY_virtualGoodSecondaryCurrency];
	[*request addValue:virtualGoodRelatedVirtualGood forKey:KEY_virtualGoodRelatedVirtualGood];
	[*request addFloatValue:virtualGoodIOSBundleMin forKey:KEY_virtualGoodIOSBundleMin];
	[*request addFloatValue:virtualGoodIOSBundleMax forKey:KEY_virtualGoodIOSBundleMax];
	[*request addFloatValue:virtualGoodAndroidBundleMin forKey:KEY_virtualGoodAndroidBundleMin];
	[*request addFloatValue:virtualGoodAndroidBundleMax forKey:KEY_virtualGoodAndroidBundleMax];
	[*request addFloatValue:virtualGoodStoreItemPrice forKey:KEY_virtualGoodStoreItemPrice];
	[*request addIntValue:virtualGoodQuantity forKey:KEY_virtualGoodQuantity];
	[*request addIntValue:virtualGoodMaxForUser forKey:KEY_virtualGoodMaxForUser];
	[*request addIntValue:virtualGoodUserInventory forKey:KEY_virtualGoodUserInventory];
	[*request addValue:virtualGoodImageA.absoluteString forKey:KEY_virtualGoodImageA];
	[*request addValue:virtualGoodImageB.absoluteString forKey:KEY_virtualGoodImageB];
	[*request addValue:virtualGoodImageC.absoluteString forKey:KEY_virtualGoodImageC];
	[*request addBoolValue:virtualGoodInAppleStore forKey:KEY_virtualGoodInAppleStore];
	[*request addBoolValue:virtualGoodInGoogleStore forKey:KEY_virtualGoodInGoogleStore];
	[*request addBoolValue:virtualGoodIsStoreItem forKey:KEY_virtualGoodIsStoreItem];
	[*request addBoolValue:virtualGoodIsDeal forKey:KEY_virtualGoodIsDeal];
	[*request addBoolValue:virtualGoodConsumable forKey:KEY_virtualGoodConsumable];
	[*request addValue:virtualGoodMainCategory.virtualGoodCategoryID forKey:KEY_virtualGoodMainCategory];
}


- (id) initWithStatement:(sqlite3_stmt *)stmt Array:(int **)array IsFK:(BOOL)isFK{
	if (self = [super init]){
	
			self.virtualGoodID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodIDIndex])];
			self.virtualGoodTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodTitleIndex])];
			self.virtualGoodDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodDescriptionIndex])];
			self.virtualGoodAppleIdentifier = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodAppleIdentifierIndex])];
			self.virtualGoodGoogleIdentifier = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodGoogleIdentifierIndex])];
			self.virtualGoodMainCurrency = sqlite3_column_int(stmt, array[0][VirtualGoodMainCurrencyIndex]);
			self.virtualGoodSecondaryCurrency = sqlite3_column_int(stmt, array[0][VirtualGoodSecondaryCurrencyIndex]);
			self.virtualGoodRelatedVirtualGood = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodRelatedVirtualGoodIndex])];
			self.virtualGoodIOSBundleMin = sqlite3_column_double(stmt, array[0][VirtualGoodIOSBundleMinIndex]);
			self.virtualGoodIOSBundleMax = sqlite3_column_double(stmt, array[0][VirtualGoodIOSBundleMaxIndex]);
			self.virtualGoodAndroidBundleMin = sqlite3_column_double(stmt, array[0][VirtualGoodAndroidBundleMinIndex]);
			self.virtualGoodAndroidBundleMax = sqlite3_column_double(stmt, array[0][VirtualGoodAndroidBundleMaxIndex]);
			self.virtualGoodStoreItemPrice = sqlite3_column_double(stmt, array[0][VirtualGoodStoreItemPriceIndex]);
			virtualGoodPos = sqlite3_column_int(stmt, array[0][VirtualGoodPosIndex]);
			self.virtualGoodQuantity = sqlite3_column_int(stmt, array[0][VirtualGoodQuantityIndex]);
			self.virtualGoodMaxForUser = sqlite3_column_int(stmt, array[0][VirtualGoodMaxForUserIndex]);
			self.virtualGoodUserInventory = sqlite3_column_int(stmt, array[0][VirtualGoodUserInventoryIndex]);
			self.virtualGoodImageA = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodImageAIndex])]];
			self.virtualGoodImageB = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodImageBIndex])]];
			self.virtualGoodImageC = [NSURL URLWithString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodImageCIndex])]];
			self.virtualGoodInAppleStore = sqlite3_column_int(stmt, array[0][VirtualGoodInAppleStoreIndex]);
			self.virtualGoodInGoogleStore = sqlite3_column_int(stmt, array[0][VirtualGoodInGoogleStoreIndex]);
			self.virtualGoodIsStoreItem = sqlite3_column_int(stmt, array[0][VirtualGoodIsStoreItemIndex]);

	if (isFK){
		self.virtualGoodMainCategory = [VirtualGoodCategory instanceWithID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodMainCategoryIndex])]];
	} else {
		int **virtualGoodMainCategoryArray = (int **)malloc(sizeof(int *));
		virtualGoodMainCategoryArray[0] = array[1];
		self.virtualGoodMainCategory = [[VirtualGoodCategory alloc] initWithStatement:stmt Array:virtualGoodMainCategoryArray IsFK:YES];
		free(virtualGoodMainCategoryArray);
	}

;
			self.virtualGoodIsDeal = sqlite3_column_int(stmt, array[0][VirtualGoodIsDealIndex]);
			self.virtualGoodConsumable = sqlite3_column_int(stmt, array[0][VirtualGoodConsumableIndex]);
			virtualGoodLastUpdate = [[[LiCore liSqliteDateFormatter] dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, array[0][VirtualGoodLastUpdateIndex])]] retain];
		
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
	indexes[0] = (int *)malloc(NUM_OF_VIRTUALGOOD_FIELDS*sizeof(int));
	indexes[1] = (int *)malloc(NUM_OF_VIRTUALGOODCATEGORY_FIELDS*sizeof(int));

	indexes[0][VirtualGoodIDIndex] = [columnsArray indexOfObject:KEY_virtualGoodID];
	indexes[0][VirtualGoodTitleIndex] = [columnsArray indexOfObject:KEY_virtualGoodTitle];
	indexes[0][VirtualGoodDescriptionIndex] = [columnsArray indexOfObject:KEY_virtualGoodDescription];
	indexes[0][VirtualGoodAppleIdentifierIndex] = [columnsArray indexOfObject:KEY_virtualGoodAppleIdentifier];
	indexes[0][VirtualGoodGoogleIdentifierIndex] = [columnsArray indexOfObject:KEY_virtualGoodGoogleIdentifier];
	indexes[0][VirtualGoodMainCurrencyIndex] = [columnsArray indexOfObject:KEY_virtualGoodMainCurrency];
	indexes[0][VirtualGoodSecondaryCurrencyIndex] = [columnsArray indexOfObject:KEY_virtualGoodSecondaryCurrency];
	indexes[0][VirtualGoodRelatedVirtualGoodIndex] = [columnsArray indexOfObject:KEY_virtualGoodRelatedVirtualGood];
	indexes[0][VirtualGoodIOSBundleMinIndex] = [columnsArray indexOfObject:KEY_virtualGoodIOSBundleMin];
	indexes[0][VirtualGoodIOSBundleMaxIndex] = [columnsArray indexOfObject:KEY_virtualGoodIOSBundleMax];
	indexes[0][VirtualGoodAndroidBundleMinIndex] = [columnsArray indexOfObject:KEY_virtualGoodAndroidBundleMin];
	indexes[0][VirtualGoodAndroidBundleMaxIndex] = [columnsArray indexOfObject:KEY_virtualGoodAndroidBundleMax];
	indexes[0][VirtualGoodStoreItemPriceIndex] = [columnsArray indexOfObject:KEY_virtualGoodStoreItemPrice];
	indexes[0][VirtualGoodPosIndex] = [columnsArray indexOfObject:KEY_virtualGoodPos];
	indexes[0][VirtualGoodQuantityIndex] = [columnsArray indexOfObject:KEY_virtualGoodQuantity];
	indexes[0][VirtualGoodMaxForUserIndex] = [columnsArray indexOfObject:KEY_virtualGoodMaxForUser];
	indexes[0][VirtualGoodUserInventoryIndex] = [columnsArray indexOfObject:KEY_virtualGoodUserInventory];
	indexes[0][VirtualGoodImageAIndex] = [columnsArray indexOfObject:KEY_virtualGoodImageA];
	indexes[0][VirtualGoodImageBIndex] = [columnsArray indexOfObject:KEY_virtualGoodImageB];
	indexes[0][VirtualGoodImageCIndex] = [columnsArray indexOfObject:KEY_virtualGoodImageC];
	indexes[0][VirtualGoodInAppleStoreIndex] = [columnsArray indexOfObject:KEY_virtualGoodInAppleStore];
	indexes[0][VirtualGoodInGoogleStoreIndex] = [columnsArray indexOfObject:KEY_virtualGoodInGoogleStore];
	indexes[0][VirtualGoodIsStoreItemIndex] = [columnsArray indexOfObject:KEY_virtualGoodIsStoreItem];
	indexes[0][VirtualGoodMainCategoryIndex] = [columnsArray indexOfObject:KEY_virtualGoodMainCategory];
	indexes[0][VirtualGoodIsDealIndex] = [columnsArray indexOfObject:KEY_virtualGoodIsDeal];
	indexes[0][VirtualGoodConsumableIndex] = [columnsArray indexOfObject:KEY_virtualGoodConsumable];
	indexes[0][VirtualGoodLastUpdateIndex] = [columnsArray indexOfObject:KEY_virtualGoodLastUpdate];

	indexes[1][VirtualGoodCategoryIDIndex] = [columnsArray indexOfObject:KeyWithHeader(@"VirtualGoodCategoryID",@"_VirtualGoodMainCategory")];
	indexes[1][VirtualGoodCategoryNameIndex] = [columnsArray indexOfObject:KeyWithHeader(@"VirtualGoodCategoryName",@"_VirtualGoodMainCategory")];
	indexes[1][VirtualGoodCategoryLastUpdateIndex] = [columnsArray indexOfObject:KeyWithHeader(@"VirtualGoodCategoryLastUpdate",@"_VirtualGoodMainCategory")];
	indexes[1][VirtualGoodCategoryPosIndex] = [columnsArray indexOfObject:KeyWithHeader(@"VirtualGoodCategoryPos",@"_VirtualGoodMainCategory")];

	[columnsArray release];
	NSMutableArray *blackList = [[NSMutableArray alloc] init];
	
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, indexes[0][VirtualGoodIDIndex])];
		if (resultFromServer && ([idsList indexOfObject:ID] == NSNotFound)){
			[blackList addObject:ID];
		} else {
			VirtualGood *item  = [[VirtualGood alloc] initWithStatement:stmt Array:(int **)indexes IsFK:NO];
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


#pragma mark - End of Basic SDK

+ (void) getLocalArrayWithQuery:(LiQuery *)query andBlock:(GetVirtualGoodArrayFinished)block{
    VirtualGood *item = [VirtualGood instance];
     
	query = [self setFieldsNameToQuery:query];
	LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
	[request addIntValue:LOCAL forKey:@"DbGetKind"];
	[request setDelegate:item];
	[request addValue:query forKey:@"query"];
	request.shouldWorkOffline = YES;
    
	[request startSync:YES];
    
	[item requestDidFinished:request];
}

+ (void) getLocalArrayWithRawSQLQuery:(NSString *)rawQuery andBlock:(GetVirtualGoodArrayFinished)block{
    VirtualGood *item = [VirtualGood instance];
    
    LiObjRequest *request = [LiObjRequest requestWithAction:GetArray ClassName:kClassName];
	[request setBlock:block];
	[request addValue:rawQuery forKey:@"filters"];
	[request setShouldWorkOffline:YES];
	[request startSync:YES];
    
	[item requestDidFinished:request];
}   

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type withBlock:(GetVirtualGoodArrayFinished)block{
    [self getVirtualGoodsOfType:type andCategory:nil withBlock:block];
}

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type andCategory:(VirtualGoodCategory *)category withBlock:(GetVirtualGoodArrayFinished)block{
    block (nil,[LiKitIAP getVirtualGoodsByType:type andCategory:category]);
}

+ (void) getVirtualGoodsOfType:(VirtualGoodType)type byCategoryPosition:(int)position withBlock:(GetVirtualGoodArrayFinished)block{
    NSError *error = nil;
    block (error,[LiKitIAP getVirtualGoodsByType:type andCategoryPosition:position WithError:&error]);
}

- (void) buyQuantity:(NSInteger)quantity withCurrencyKind:(LiCurrency)currencyKind andBlock:(LiBlockAction)block{
    NSError *error = nil;
    if (currencyKind != RealMoney)
    {
        [LiKitIAP purchaseVirtualGood:self Quantity:quantity CurrencyKind:currencyKind WithError:&error];
        block(error,virtualGoodID,DoIapAction);
    }
    else
        [self buyWithRealMoneyAndBlock:block];
}

static LiBlockAction actionBlock = NULL;
- (void) buyWithRealMoneyAndBlock:(LiBlockAction)block
{
      NSError *error = nil;
     actionBlock = Block_copy(block);
    [LiKitIAP purchaseVirtualGoodWithRealMoney:self  Delegate:self WithError:&error];
    if (error)
    {
        actionBlock(error,self.virtualGoodID,DoIapAction);
		Block_release(actionBlock);
    }
}

- (void) InAppPurchase_AppStorePurchaseVirtualGood:(VirtualGood *)item ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
    actionBlock(error,item.virtualGoodID,DoIapAction);
	//Block_release(actionBlock);
}

- (void) giveQuantity:(NSInteger)quantity withBlock:(LiBlockAction)block{
    NSError *error = nil;
    [LiKitIAP giveVirtualGood:self Quantity:quantity WithError:&error];
    block(error,virtualGoodID,DoIapAction);
    
}

- (void) useQuantity:(NSInteger)quantity withBlock:(LiBlockAction)block{
    NSError *error = nil;
    [LiKitIAP useVirtualGood:self Quantity:quantity WithError:&error];
    block(error,virtualGoodID,DoIapAction);
}



#pragma mark - Applicasa Delegate Methods

- (void) requestDidFinished:(LiObjRequest *)request{
    Actions action = request.action;
    NSInteger responseType = request.response.responseType;
    NSString *responseMessage = request.response.responseMessage;
    NSDictionary *responseData = request.response.responseData;
    
    switch (action) {        
        case Add:
        case Update:
        case Delete:{
			NSString *itemID = [responseData objectForKey:KEY_virtualGoodID];
			if (itemID)
				self.virtualGoodID = itemID;
				
			[self respondToLiActionCallBack:responseType ResponseMessage:responseMessage ItemID:self. virtualGoodID Action:action Block:[request getBlock]];
			[request releaseBlock];
			}
			break;
			
		case GetArray:{            
			sqlite3_stmt *stmt = (sqlite3_stmt *)[request.response getStatement];
			NSArray *idsList = [request.response.responseData objectForKey:@"ids"];
			[self respondToGetArray_ResponseType:responseType ResponseMessage:responseMessage Array:[VirtualGood getArrayFromStatement:stmt IDsList:idsList resultFromServer:request.resultFromServer] Block:[request getBlock]];
			[request releaseBlock];
			}
			break;
		default:
			break;
    }
}

+ (id) instanceWithID:(NSString *)ID{
    VirtualGood *instace = [[VirtualGood alloc] init];
    instace.virtualGoodID = ID;
    return [instace autorelease];
}

#pragma mark - Responders

- (void) respondToGetArray_ResponseType:(NSInteger)responseType ResponseMessage:(NSString *)responseMessage Array:(NSArray *)array Block:(void *)block{
    NSError *error = nil;
    [LiObjRequest handleError:&error ResponseType:responseType ResponseMessage:responseMessage];
 
    GetVirtualGoodArrayFinished _block = (GetVirtualGoodArrayFinished)block;
    _block(error,array);
}




@end
