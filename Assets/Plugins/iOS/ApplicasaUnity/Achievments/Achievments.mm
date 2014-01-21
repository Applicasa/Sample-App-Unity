//
// Achievments.mm
// Created by Applicasa 
// 1/21/2014
//

#import "ApplicasaCore.h"
#import "Achievments.h"

extern "C" {



const char* ApplicasaAchievmentsGetAchievmentsID(Achievments* achievments) {
	return NSStringToCharPointer(achievments.achievmentsID);
}
void ApplicasaAchievmentsSetAchievmentsID(Achievments* achievments, const char * achievmentsID) {
	achievments.achievmentsID = CharPointerToNSString(achievmentsID);
}
const double ApplicasaAchievmentsGetAchievmentsLastUpdate(Achievments* achievments) {
	return ((double)achievments.achievmentsLastUpdate.timeIntervalSince1970);
}
const int ApplicasaAchievmentsGetAchievmentsPoints(Achievments* achievments) {
	return achievments.achievmentsPoints;
}
void ApplicasaAchievmentsSetAchievmentsPoints(Achievments* achievments,int achievmentsPoints) {
	achievments.achievmentsPoints = achievmentsPoints;
}
const char* ApplicasaAchievmentsGetAchievmentsDes(Achievments* achievments) {
	return NSStringToCharPointer(achievments.achievmentsDes);
}
void ApplicasaAchievmentsSetAchievmentsDes(Achievments* achievments, const char * achievmentsDes) {
	achievments.achievmentsDes = CharPointerToNSString(achievmentsDes);
}




Achievments * ApplicasaAchievments() {
    return [[Achievments alloc] init];
}

void ApplicasaAchievmentsSaveWithBlock(Achievments* achievments, ApplicasaAction callback) {
    [achievments saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaAchievmentsIncreaseFieldInt(Achievments* achievments, LiFields field, int val) {
    [achievments increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaAchievmentsIncreaseFieldFloat(Achievments* achievments, LiFields field, float val) {
    [achievments increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaAchievmentsDeleteWithBlock(Achievments* achievments, ApplicasaAction callback) {
    [achievments deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaAchievmentsUploadFile(Achievments* achievments, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [achievments uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaAchievmentsGetById(const char * id, QueryKind queryKind, ApplicasaGetAchievmentsFinished callback) {
    [Achievments getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetAchievmentsFinishedToBlock(callback)];
}

void ApplicasaAchievmentsGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetAchievmentsArrayFinished callback) {
    [Achievments getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetAchievmentsArrayFinishedToBlock(callback)];
}

void ApplicasaAchievmentsGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetAchievmentsArrayFinished callback) {
    [Achievments getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetAchievmentsArrayFinishedToBlock(callback)];
}
    
int ApplicasaAchievmentsUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Achievments updateLocalStorage:query queryKind:queryKind];
}

ApplicasaAchievmentsArray ApplicasaAchievmentsGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Achievments getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Achievments** achievmentsArray = (Achievments**)malloc(sizeof(Achievments*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            achievmentsArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaAchievmentsArray achievmentsStruct;
    achievmentsStruct.Array = achievmentsArray;
    achievmentsStruct.ArraySize = arraySize;
   
    return achievmentsStruct;
}



}
