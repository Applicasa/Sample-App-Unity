//
// Foo.mm
// Created by Applicasa 
// 10/24/2013
//

#import "ApplicasaCore.h"
#import "Foo.h"

extern "C" {



const char* ApplicasaFooGetFooID(Foo* foo) {
	return NSStringToCharPointer(foo.fooID);
}
void ApplicasaFooSetFooID(Foo* foo, const char * fooID) {
	foo.fooID = CharPointerToNSString(fooID);
}
const double ApplicasaFooGetFooLastUpdate(Foo* foo) {
	return ((double)foo.fooLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaFooGetFooName(Foo* foo) {
	return NSStringToCharPointer(foo.fooName);
}
void ApplicasaFooSetFooName(Foo* foo, const char * fooName) {
	foo.fooName = CharPointerToNSString(fooName);
}
const char* ApplicasaFooGetFooDescription(Foo* foo) {
	return NSStringToCharPointer(foo.fooDescription);
}
void ApplicasaFooSetFooDescription(Foo* foo, const char * fooDescription) {
	foo.fooDescription = CharPointerToNSString(fooDescription);
}
const bool ApplicasaFooGetFooBoolean(Foo* foo) {
	return foo.fooBoolean;
}
void ApplicasaFooSetFooBoolean(Foo* foo,bool fooBoolean) {
	 foo.fooBoolean=fooBoolean;
}
const double ApplicasaFooGetFooDate(Foo* foo) {
	return ((double)foo.fooDate.timeIntervalSince1970);
}
void ApplicasaFooSetFooDate(Foo* foo, double fooDate) {
	foo.fooDate =  [NSDate dateWithTimeIntervalSince1970:fooDate];
}
const char* ApplicasaFooGetFooImage(Foo* foo) {
	return NSStringToCharPointer([foo.fooImage absoluteString]);
}
void ApplicasaFooSetFooImage(Foo* foo,const char* url) {
	foo.fooImage = [NSURL URLWithString:CharPointerToNSString(url)];
}
const char* ApplicasaFooGetFooFile(Foo* foo) {
	return NSStringToCharPointer([foo.fooFile absoluteString]);
}
void ApplicasaFooSetFooFile(Foo* foo,const char* url) {
	foo.fooFile = [NSURL URLWithString:CharPointerToNSString(url)];
}
User* ApplicasaFooGetFooOwner(Foo* foo) {
	return foo.fooOwner;
}

void ApplicasaFooSetFooOwner(Foo* foo, User* fooOwner){
	foo.fooOwner = fooOwner;
}
const struct ApplicasaLocation ApplicasaFooGetFooLocation(Foo* foo) {
	CLLocation* loc = foo.fooLocation;
	struct ApplicasaLocation location;
	location.Latitude = loc.coordinate.latitude;
	location.Longitude = loc.coordinate.longitude;
	return location;
}
void ApplicasaFooSetFooLocation(Foo* foo, struct ApplicasaLocation loc) {
	foo.fooLocation = [[[CLLocation alloc] initWithLatitude:loc.Latitude longitude:loc.Longitude] autorelease];
}
const int ApplicasaFooGetFooNumber(Foo* foo) {
	return foo.fooNumber;
}
void ApplicasaFooSetFooNumber(Foo* foo,int fooNumber) {
	foo.fooNumber = fooNumber;
}
const int ApplicasaFooGetFooAge(Foo* foo) {
	return foo.fooAge;
}
void ApplicasaFooSetFooAge(Foo* foo,int fooAge) {
	foo.fooAge = fooAge;
}




Foo * ApplicasaFoo() {
    return [[Foo alloc] init];
}

void ApplicasaFooSaveWithBlock(Foo* foo, ApplicasaAction callback) {
    [foo saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaFooIncreaseFieldInt(Foo* foo, LiFields field, int val) {
    [foo increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaFooIncreaseFieldFloat(Foo* foo, LiFields field, float val) {
    [foo increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaFooDeleteWithBlock(Foo* foo, ApplicasaAction callback) {
    [foo deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaFooUploadFile(Foo* foo, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [foo uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaFooGetById(const char * id, QueryKind queryKind, ApplicasaGetFooFinished callback) {
    [Foo getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetFooFinishedToBlock(callback)];
}

void ApplicasaFooGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetFooArrayFinished callback) {
    [Foo getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetFooArrayFinishedToBlock(callback)];
}

void ApplicasaFooGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetFooArrayFinished callback) {
    [Foo getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetFooArrayFinishedToBlock(callback)];
}
    
int ApplicasaFooUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Foo updateLocalStorage:query queryKind:queryKind];
}

ApplicasaFooArray ApplicasaFooGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Foo getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Foo** fooArray = (Foo**)malloc(sizeof(Foo*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            fooArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaFooArray fooStruct;
    fooStruct.Array = fooArray;
    fooStruct.ArraySize = arraySize;
   
    return fooStruct;
}



}
