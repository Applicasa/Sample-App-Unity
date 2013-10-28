//
// Colors.mm
// Created by Applicasa 
// 10/24/2013
//

#import "ApplicasaCore.h"
#import "Colors.h"

extern "C" {



const char* ApplicasaColorsGetColorsID(Colors* colors) {
	return NSStringToCharPointer(colors.colorsID);
}
void ApplicasaColorsSetColorsID(Colors* colors, const char * colorsID) {
	colors.colorsID = CharPointerToNSString(colorsID);
}
const double ApplicasaColorsGetColorsLastUpdate(Colors* colors) {
	return ((double)colors.colorsLastUpdate.timeIntervalSince1970);
}
const int ApplicasaColorsGetColorsNumber(Colors* colors) {
	return colors.colorsNumber;
}
void ApplicasaColorsSetColorsNumber(Colors* colors,int colorsNumber) {
	colors.colorsNumber = colorsNumber;
}
const char* ApplicasaColorsGetColorsColor(Colors* colors) {
	return NSStringToCharPointer(colors.colorsColor);
}
void ApplicasaColorsSetColorsColor(Colors* colors, const char * colorsColor) {
	colors.colorsColor = CharPointerToNSString(colorsColor);
}




Colors * ApplicasaColors() {
    return [[Colors alloc] init];
}

void ApplicasaColorsSaveWithBlock(Colors* colors, ApplicasaAction callback) {
    [colors saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaColorsIncreaseFieldInt(Colors* colors, LiFields field, int val) {
    [colors increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaColorsIncreaseFieldFloat(Colors* colors, LiFields field, float val) {
    [colors increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaColorsDeleteWithBlock(Colors* colors, ApplicasaAction callback) {
    [colors deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaColorsUploadFile(Colors* colors, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [colors uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaColorsGetById(const char * id, QueryKind queryKind, ApplicasaGetColorsFinished callback) {
    [Colors getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetColorsFinishedToBlock(callback)];
}

void ApplicasaColorsGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetColorsArrayFinished callback) {
    [Colors getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetColorsArrayFinishedToBlock(callback)];
}

void ApplicasaColorsGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetColorsArrayFinished callback) {
    [Colors getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetColorsArrayFinishedToBlock(callback)];
}
    
int ApplicasaColorsUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Colors updateLocalStorage:query queryKind:queryKind];
}

ApplicasaColorsArray ApplicasaColorsGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Colors getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Colors** colorsArray = (Colors**)malloc(sizeof(Colors*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            colorsArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaColorsArray colorsStruct;
    colorsStruct.Array = colorsArray;
    colorsStruct.ArraySize = arraySize;
   
    return colorsStruct;
}



}
