//
// ScoreB.mm
// Created by Applicasa 
// 1/21/2014
//

#import "ApplicasaCore.h"
#import "ScoreB.h"

extern "C" {



const char* ApplicasaScoreBGetScoreBID(ScoreB* scoreB) {
	return NSStringToCharPointer(scoreB.scoreBID);
}
void ApplicasaScoreBSetScoreBID(ScoreB* scoreB, const char * scoreBID) {
	scoreB.scoreBID = CharPointerToNSString(scoreBID);
}
const double ApplicasaScoreBGetScoreBLastUpdate(ScoreB* scoreB) {
	return ((double)scoreB.scoreBLastUpdate.timeIntervalSince1970);
}
const int ApplicasaScoreBGetScoreBScore(ScoreB* scoreB) {
	return scoreB.scoreBScore;
}
void ApplicasaScoreBSetScoreBScore(ScoreB* scoreB,int scoreBScore) {
	scoreB.scoreBScore = scoreBScore;
}
User* ApplicasaScoreBGetScoreBUser(ScoreB* scoreB) {
	return scoreB.scoreBUser;
}

void ApplicasaScoreBSetScoreBUser(ScoreB* scoreB, User* scoreBUser){
	scoreB.scoreBUser = scoreBUser;
}




ScoreB * ApplicasaScoreB() {
    return [[ScoreB alloc] init];
}

void ApplicasaScoreBSaveWithBlock(ScoreB* scoreB, ApplicasaAction callback) {
    [scoreB saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaScoreBIncreaseFieldInt(ScoreB* scoreB, LiFields field, int val) {
    [scoreB increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaScoreBIncreaseFieldFloat(ScoreB* scoreB, LiFields field, float val) {
    [scoreB increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaScoreBDeleteWithBlock(ScoreB* scoreB, ApplicasaAction callback) {
    [scoreB deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaScoreBUploadFile(ScoreB* scoreB, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [scoreB uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaScoreBGetById(const char * id, QueryKind queryKind, ApplicasaGetScoreBFinished callback) {
    [ScoreB getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetScoreBFinishedToBlock(callback)];
}

void ApplicasaScoreBGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetScoreBArrayFinished callback) {
    [ScoreB getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetScoreBArrayFinishedToBlock(callback)];
}

void ApplicasaScoreBGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetScoreBArrayFinished callback) {
    [ScoreB getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetScoreBArrayFinishedToBlock(callback)];
}
    
int ApplicasaScoreBUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [ScoreB updateLocalStorage:query queryKind:queryKind];
}

ApplicasaScoreBArray ApplicasaScoreBGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [ScoreB getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    ScoreB** scoreBArray = (ScoreB**)malloc(sizeof(ScoreB*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            scoreBArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaScoreBArray scoreBStruct;
    scoreBStruct.Array = scoreBArray;
    scoreBStruct.ArraySize = arraySize;
   
    return scoreBStruct;
}



}
