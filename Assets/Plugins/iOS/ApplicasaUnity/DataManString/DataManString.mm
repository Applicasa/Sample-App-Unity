//
// DataManString.mm
// Created by Applicasa 
// 10/24/2013
//

#import "ApplicasaCore.h"
#import "DataManString.h"

extern "C" {



const char* ApplicasaDataManStringGetDataManStringID(DataManString* dataManString) {
	return NSStringToCharPointer(dataManString.dataManStringID);
}
void ApplicasaDataManStringSetDataManStringID(DataManString* dataManString, const char * dataManStringID) {
	dataManString.dataManStringID = CharPointerToNSString(dataManStringID);
}
const double ApplicasaDataManStringGetDataManStringLastUpdate(DataManString* dataManString) {
	return ((double)dataManString.dataManStringLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaDataManStringGetDataManStringKey(DataManString* dataManString) {
	return NSStringToCharPointer(dataManString.dataManStringKey);
}
void ApplicasaDataManStringSetDataManStringKey(DataManString* dataManString, const char * dataManStringKey) {
	dataManString.dataManStringKey = CharPointerToNSString(dataManStringKey);
}
const char* ApplicasaDataManStringGetDataManStringValue(DataManString* dataManString) {
	return NSStringToCharPointer(dataManString.dataManStringValue);
}
void ApplicasaDataManStringSetDataManStringValue(DataManString* dataManString, const char * dataManStringValue) {
	dataManString.dataManStringValue = CharPointerToNSString(dataManStringValue);
}




DataManString * ApplicasaDataManString() {
    return [[DataManString alloc] init];
}

void ApplicasaDataManStringSaveWithBlock(DataManString* dataManString, ApplicasaAction callback) {
    [dataManString saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaDataManStringIncreaseFieldInt(DataManString* dataManString, LiFields field, int val) {
    [dataManString increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaDataManStringIncreaseFieldFloat(DataManString* dataManString, LiFields field, float val) {
    [dataManString increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaDataManStringDeleteWithBlock(DataManString* dataManString, ApplicasaAction callback) {
    [dataManString deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaDataManStringUploadFile(DataManString* dataManString, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [dataManString uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaDataManStringGetById(const char * id, QueryKind queryKind, ApplicasaGetDataManStringFinished callback) {
    [DataManString getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetDataManStringFinishedToBlock(callback)];
}

void ApplicasaDataManStringGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetDataManStringArrayFinished callback) {
    [DataManString getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetDataManStringArrayFinishedToBlock(callback)];
}

void ApplicasaDataManStringGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetDataManStringArrayFinished callback) {
    [DataManString getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetDataManStringArrayFinishedToBlock(callback)];
}
    
int ApplicasaDataManStringUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [DataManString updateLocalStorage:query queryKind:queryKind];
}

ApplicasaDataManStringArray ApplicasaDataManStringGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [DataManString getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    DataManString** dataManStringArray = (DataManString**)malloc(sizeof(DataManString*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            dataManStringArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaDataManStringArray dataManStringStruct;
    dataManStringStruct.Array = dataManStringArray;
    dataManStringStruct.ArraySize = arraySize;
   
    return dataManStringStruct;
}



}
