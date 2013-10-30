//
// DataManager.mm
// Created by Applicasa 
// 10/30/2013
//

#import "ApplicasaCore.h"
#import "DataManager.h"

extern "C" {



const char* ApplicasaDataManagerGetDataManagerID(DataManager* dataManager) {
	return NSStringToCharPointer(dataManager.dataManagerID);
}
void ApplicasaDataManagerSetDataManagerID(DataManager* dataManager, const char * dataManagerID) {
	dataManager.dataManagerID = CharPointerToNSString(dataManagerID);
}
const double ApplicasaDataManagerGetDataManagerLastUpdate(DataManager* dataManager) {
	return ((double)dataManager.dataManagerLastUpdate.timeIntervalSince1970);
}
const int ApplicasaDataManagerGetDataManagerAaa(DataManager* dataManager) {
	return dataManager.dataManagerAaa;
}
void ApplicasaDataManagerSetDataManagerAaa(DataManager* dataManager,int dataManagerAaa) {
	dataManager.dataManagerAaa = dataManagerAaa;
}
const char* ApplicasaDataManagerGetDataManagerName(DataManager* dataManager) {
	return NSStringToCharPointer(dataManager.dataManagerName);
}
void ApplicasaDataManagerSetDataManagerName(DataManager* dataManager, const char * dataManagerName) {
	dataManager.dataManagerName = CharPointerToNSString(dataManagerName);
}




DataManager * ApplicasaDataManager() {
    return [[DataManager alloc] init];
}

void ApplicasaDataManagerSaveWithBlock(DataManager* dataManager, ApplicasaAction callback) {
    [dataManager saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaDataManagerIncreaseFieldInt(DataManager* dataManager, LiFields field, int val) {
    [dataManager increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaDataManagerIncreaseFieldFloat(DataManager* dataManager, LiFields field, float val) {
    [dataManager increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaDataManagerDeleteWithBlock(DataManager* dataManager, ApplicasaAction callback) {
    [dataManager deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaDataManagerUploadFile(DataManager* dataManager, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [dataManager uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaDataManagerGetById(const char * id, QueryKind queryKind, ApplicasaGetDataManagerFinished callback) {
    [DataManager getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetDataManagerFinishedToBlock(callback)];
}

void ApplicasaDataManagerGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetDataManagerArrayFinished callback) {
    [DataManager getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetDataManagerArrayFinishedToBlock(callback)];
}

void ApplicasaDataManagerGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetDataManagerArrayFinished callback) {
    [DataManager getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetDataManagerArrayFinishedToBlock(callback)];
}
    
int ApplicasaDataManagerUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [DataManager updateLocalStorage:query queryKind:queryKind];
}

ApplicasaDataManagerArray ApplicasaDataManagerGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [DataManager getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    DataManager** dataManagerArray = (DataManager**)malloc(sizeof(DataManager*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            dataManagerArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaDataManagerArray dataManagerStruct;
    dataManagerStruct.Array = dataManagerArray;
    dataManagerStruct.ArraySize = arraySize;
   
    return dataManagerStruct;
}



}
