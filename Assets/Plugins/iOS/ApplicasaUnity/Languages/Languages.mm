//
// Languages.mm
// Created by Applicasa 
// 1/21/2014
//

#import "ApplicasaCore.h"
#import "Languages.h"

extern "C" {



const char* ApplicasaLanguagesGetLanguagesID(Languages* languages) {
	return NSStringToCharPointer(languages.languagesID);
}
void ApplicasaLanguagesSetLanguagesID(Languages* languages, const char * languagesID) {
	languages.languagesID = CharPointerToNSString(languagesID);
}
const double ApplicasaLanguagesGetLanguagesLastUpdate(Languages* languages) {
	return ((double)languages.languagesLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaLanguagesGetLanguagesText(Languages* languages) {
	return NSStringToCharPointer(languages.languagesText);
}
void ApplicasaLanguagesSetLanguagesText(Languages* languages, const char * languagesText) {
	languages.languagesText = CharPointerToNSString(languagesText);
}
const char* ApplicasaLanguagesGetLanguagesLanguageName(Languages* languages) {
	return NSStringToCharPointer(languages.languagesLanguageName);
}
void ApplicasaLanguagesSetLanguagesLanguageName(Languages* languages, const char * languagesLanguageName) {
	languages.languagesLanguageName = CharPointerToNSString(languagesLanguageName);
}




Languages * ApplicasaLanguages() {
    return [[Languages alloc] init];
}

void ApplicasaLanguagesSaveWithBlock(Languages* languages, ApplicasaAction callback) {
    [languages saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaLanguagesIncreaseFieldInt(Languages* languages, LiFields field, int val) {
    [languages increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaLanguagesIncreaseFieldFloat(Languages* languages, LiFields field, float val) {
    [languages increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaLanguagesDeleteWithBlock(Languages* languages, ApplicasaAction callback) {
    [languages deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaLanguagesUploadFile(Languages* languages, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [languages uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaLanguagesGetById(const char * id, QueryKind queryKind, ApplicasaGetLanguagesFinished callback) {
    [Languages getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetLanguagesFinishedToBlock(callback)];
}

void ApplicasaLanguagesGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetLanguagesArrayFinished callback) {
    [Languages getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetLanguagesArrayFinishedToBlock(callback)];
}

void ApplicasaLanguagesGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetLanguagesArrayFinished callback) {
    [Languages getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetLanguagesArrayFinishedToBlock(callback)];
}
    
int ApplicasaLanguagesUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Languages updateLocalStorage:query queryKind:queryKind];
}

ApplicasaLanguagesArray ApplicasaLanguagesGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Languages getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Languages** languagesArray = (Languages**)malloc(sizeof(Languages*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            languagesArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaLanguagesArray languagesStruct;
    languagesStruct.Array = languagesArray;
    languagesStruct.ArraySize = arraySize;
   
    return languagesStruct;
}



}
