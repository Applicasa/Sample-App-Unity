//
// GameV.mm
// Created by Applicasa 
// 10/30/2013
//

#import "ApplicasaCore.h"
#import "GameV.h"

extern "C" {



const char* ApplicasaGameVGetGameVID(GameV* gameV) {
	return NSStringToCharPointer(gameV.gameVID);
}
void ApplicasaGameVSetGameVID(GameV* gameV, const char * gameVID) {
	gameV.gameVID = CharPointerToNSString(gameVID);
}
const double ApplicasaGameVGetGameVLastUpdate(GameV* gameV) {
	return ((double)gameV.gameVLastUpdate.timeIntervalSince1970);
}
const int ApplicasaGameVGetGameVValue(GameV* gameV) {
	return gameV.gameVValue;
}
void ApplicasaGameVSetGameVValue(GameV* gameV,int gameVValue) {
	gameV.gameVValue = gameVValue;
}
const char* ApplicasaGameVGetGameVFunction(GameV* gameV) {
	return NSStringToCharPointer(gameV.gameVFunction);
}
void ApplicasaGameVSetGameVFunction(GameV* gameV, const char * gameVFunction) {
	gameV.gameVFunction = CharPointerToNSString(gameVFunction);
}




GameV * ApplicasaGameV() {
    return [[GameV alloc] init];
}

void ApplicasaGameVSaveWithBlock(GameV* gameV, ApplicasaAction callback) {
    [gameV saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaGameVIncreaseFieldInt(GameV* gameV, LiFields field, int val) {
    [gameV increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaGameVIncreaseFieldFloat(GameV* gameV, LiFields field, float val) {
    [gameV increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaGameVDeleteWithBlock(GameV* gameV, ApplicasaAction callback) {
    [gameV deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaGameVUploadFile(GameV* gameV, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [gameV uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaGameVGetById(const char * id, QueryKind queryKind, ApplicasaGetGameVFinished callback) {
    [GameV getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetGameVFinishedToBlock(callback)];
}

void ApplicasaGameVGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetGameVArrayFinished callback) {
    [GameV getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetGameVArrayFinishedToBlock(callback)];
}

void ApplicasaGameVGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetGameVArrayFinished callback) {
    [GameV getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetGameVArrayFinishedToBlock(callback)];
}
    
int ApplicasaGameVUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [GameV updateLocalStorage:query queryKind:queryKind];
}

ApplicasaGameVArray ApplicasaGameVGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [GameV getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    GameV** gameVArray = (GameV**)malloc(sizeof(GameV*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            gameVArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaGameVArray gameVStruct;
    gameVStruct.Array = gameVArray;
    gameVStruct.ArraySize = arraySize;
   
    return gameVStruct;
}



}
