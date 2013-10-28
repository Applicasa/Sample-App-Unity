//
// Dynamic.mm
// Created by Applicasa 
// 10/24/2013
//

#import "ApplicasaCore.h"
#import "Dynamic.h"

extern "C" {



const char* ApplicasaDynamicGetDynamicID(Dynamic* dynamic) {
	return NSStringToCharPointer(dynamic.dynamicID);
}
void ApplicasaDynamicSetDynamicID(Dynamic* dynamic, const char * dynamicID) {
	dynamic.dynamicID = CharPointerToNSString(dynamicID);
}
const double ApplicasaDynamicGetDynamicLastUpdate(Dynamic* dynamic) {
	return ((double)dynamic.dynamicLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaDynamicGetDynamicText(Dynamic* dynamic) {
	return NSStringToCharPointer(dynamic.dynamicText);
}
void ApplicasaDynamicSetDynamicText(Dynamic* dynamic, const char * dynamicText) {
	dynamic.dynamicText = CharPointerToNSString(dynamicText);
}
const int ApplicasaDynamicGetDynamicNumber(Dynamic* dynamic) {
	return dynamic.dynamicNumber;
}
void ApplicasaDynamicSetDynamicNumber(Dynamic* dynamic,int dynamicNumber) {
	dynamic.dynamicNumber = dynamicNumber;
}
const float ApplicasaDynamicGetDynamicReal(Dynamic* dynamic) {
	return dynamic.dynamicReal;
}
void ApplicasaDynamicSetDynamicReal(Dynamic* dynamic, float dynamicReal) {
	dynamic.dynamicReal = dynamicReal;
}
const double ApplicasaDynamicGetDynamicDate(Dynamic* dynamic) {
	return ((double)dynamic.dynamicDate.timeIntervalSince1970);
}
void ApplicasaDynamicSetDynamicDate(Dynamic* dynamic, double dynamicDate) {
	dynamic.dynamicDate =  [NSDate dateWithTimeIntervalSince1970:dynamicDate];
}
const bool ApplicasaDynamicGetDynamicBool(Dynamic* dynamic) {
	return dynamic.dynamicBool;
}
void ApplicasaDynamicSetDynamicBool(Dynamic* dynamic,bool dynamicBool) {
	 dynamic.dynamicBool=dynamicBool;
}
const char* ApplicasaDynamicGetDynamicHtml(Dynamic* dynamic) {
	return NSStringToCharPointer(dynamic.dynamicHtml);
}
void ApplicasaDynamicSetDynamicHtml(Dynamic* dynamic, const char * dynamicHtml) {
	dynamic.dynamicHtml = CharPointerToNSString(dynamicHtml);
}
const char* ApplicasaDynamicGetDynamicImage(Dynamic* dynamic) {
	return NSStringToCharPointer([dynamic.dynamicImage absoluteString]);
}
void ApplicasaDynamicSetDynamicImage(Dynamic* dynamic,const char* url) {
	dynamic.dynamicImage = [NSURL URLWithString:CharPointerToNSString(url)];
}




Dynamic * ApplicasaDynamic() {
    return [[Dynamic alloc] init];
}

void ApplicasaDynamicSaveWithBlock(Dynamic* dynamic, ApplicasaAction callback) {
    [dynamic saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaDynamicIncreaseFieldInt(Dynamic* dynamic, LiFields field, int val) {
    [dynamic increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaDynamicIncreaseFieldFloat(Dynamic* dynamic, LiFields field, float val) {
    [dynamic increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaDynamicDeleteWithBlock(Dynamic* dynamic, ApplicasaAction callback) {
    [dynamic deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaDynamicUploadFile(Dynamic* dynamic, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [dynamic uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaDynamicGetById(const char * id, QueryKind queryKind, ApplicasaGetDynamicFinished callback) {
    [Dynamic getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetDynamicFinishedToBlock(callback)];
}

void ApplicasaDynamicGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetDynamicArrayFinished callback) {
    [Dynamic getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetDynamicArrayFinishedToBlock(callback)];
}

void ApplicasaDynamicGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetDynamicArrayFinished callback) {
    [Dynamic getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetDynamicArrayFinishedToBlock(callback)];
}
    
int ApplicasaDynamicUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Dynamic updateLocalStorage:query queryKind:queryKind];
}

ApplicasaDynamicArray ApplicasaDynamicGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Dynamic getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Dynamic** dynamicArray = (Dynamic**)malloc(sizeof(Dynamic*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            dynamicArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaDynamicArray dynamicStruct;
    dynamicStruct.Array = dynamicArray;
    dynamicStruct.ArraySize = arraySize;
   
    return dynamicStruct;
}



}
