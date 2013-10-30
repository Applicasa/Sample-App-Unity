//
// Levels.mm
// Created by Applicasa 
// 10/30/2013
//

#import "ApplicasaCore.h"
#import "Levels.h"

extern "C" {



const char* ApplicasaLevelsGetLevelsID(Levels* levels) {
	return NSStringToCharPointer(levels.levelsID);
}
void ApplicasaLevelsSetLevelsID(Levels* levels, const char * levelsID) {
	levels.levelsID = CharPointerToNSString(levelsID);
}
const double ApplicasaLevelsGetLevelsLastUpdate(Levels* levels) {
	return ((double)levels.levelsLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaLevelsGetLevelsGtgtg(Levels* levels) {
	return NSStringToCharPointer(levels.levelsGtgtg);
}
void ApplicasaLevelsSetLevelsGtgtg(Levels* levels, const char * levelsGtgtg) {
	levels.levelsGtgtg = CharPointerToNSString(levelsGtgtg);
}
const char* ApplicasaLevelsGetLevelsHTML(Levels* levels) {
	return NSStringToCharPointer(levels.levelsHTML);
}
void ApplicasaLevelsSetLevelsHTML(Levels* levels, const char * levelsHTML) {
	levels.levelsHTML = CharPointerToNSString(levelsHTML);
}
const int ApplicasaLevelsGetLevelsTgtggtg(Levels* levels) {
	return levels.levelsTgtggtg;
}
void ApplicasaLevelsSetLevelsTgtggtg(Levels* levels,int levelsTgtggtg) {
	levels.levelsTgtggtg = levelsTgtggtg;
}




Levels * ApplicasaLevels() {
    return [[Levels alloc] init];
}

void ApplicasaLevelsSaveWithBlock(Levels* levels, ApplicasaAction callback) {
    [levels saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaLevelsIncreaseFieldInt(Levels* levels, LiFields field, int val) {
    [levels increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaLevelsIncreaseFieldFloat(Levels* levels, LiFields field, float val) {
    [levels increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaLevelsDeleteWithBlock(Levels* levels, ApplicasaAction callback) {
    [levels deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaLevelsUploadFile(Levels* levels, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [levels uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaLevelsGetById(const char * id, QueryKind queryKind, ApplicasaGetLevelsFinished callback) {
    [Levels getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetLevelsFinishedToBlock(callback)];
}

void ApplicasaLevelsGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetLevelsArrayFinished callback) {
    [Levels getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetLevelsArrayFinishedToBlock(callback)];
}

void ApplicasaLevelsGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetLevelsArrayFinished callback) {
    [Levels getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetLevelsArrayFinishedToBlock(callback)];
}
    
int ApplicasaLevelsUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Levels updateLocalStorage:query queryKind:queryKind];
}

ApplicasaLevelsArray ApplicasaLevelsGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Levels getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Levels** levelsArray = (Levels**)malloc(sizeof(Levels*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            levelsArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaLevelsArray levelsStruct;
    levelsStruct.Array = levelsArray;
    levelsStruct.ArraySize = arraySize;
   
    return levelsStruct;
}



}
