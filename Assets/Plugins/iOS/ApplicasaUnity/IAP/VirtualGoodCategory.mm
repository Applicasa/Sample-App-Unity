//
// VirtualGoodCategory.mm
// Created by Applicasa 
// 5/13/2013
//

#import "ApplicasaCore.h"
#import "VirtualGoodCategory.h"

extern "C" {



const char* ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryID(VirtualGoodCategory* virtualGoodCategory) {
	return NSStringToCharPointer(virtualGoodCategory.virtualGoodCategoryID);
}
void ApplicasaVirtualGoodCategorySetVirtualGoodCategoryID(VirtualGoodCategory* virtualGoodCategory, const char * virtualGoodCategoryID) {
	virtualGoodCategory.virtualGoodCategoryID = CharPointerToNSString(virtualGoodCategoryID);
}
const char* ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryName(VirtualGoodCategory* virtualGoodCategory) {
	return NSStringToCharPointer(virtualGoodCategory.virtualGoodCategoryName);
}
void ApplicasaVirtualGoodCategorySetVirtualGoodCategoryName(VirtualGoodCategory* virtualGoodCategory, const char * virtualGoodCategoryName) {
	virtualGoodCategory.virtualGoodCategoryName = CharPointerToNSString(virtualGoodCategoryName);
}
const double ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryLastUpdate(VirtualGoodCategory* virtualGoodCategory) {
	return ((double)virtualGoodCategory.virtualGoodCategoryLastUpdate.timeIntervalSince1970);
}
const int ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryPos(VirtualGoodCategory* virtualGoodCategory) {
	return virtualGoodCategory.virtualGoodCategoryPos;
}




void ApplicasaVirtualGoodCategorySaveWithBlock(VirtualGoodCategory* virtualGoodCategory, ApplicasaAction callback) {
    [virtualGoodCategory saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaVirtualGoodCategoryIncreaseFieldInt(VirtualGoodCategory* virtualGoodCategory, LiFields field, int val) {
    [virtualGoodCategory increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaVirtualGoodCategoryIncreaseFieldFloat(VirtualGoodCategory* virtualGoodCategory, LiFields field, float val) {
    [virtualGoodCategory increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaVirtualGoodCategoryDeleteWithBlock(VirtualGoodCategory* virtualGoodCategory, ApplicasaAction callback) {
    [virtualGoodCategory deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaVirtualGoodCategoryUploadFile(VirtualGoodCategory* virtualGoodCategory, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [virtualGoodCategory uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaVirtualGoodCategoryGetById(const char * id, QueryKind queryKind, ApplicasaGetVirtualGoodCategoryFinished callback) {
    [VirtualGoodCategory getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetVirtualGoodCategoryFinishedToBlock(callback)];
}

void ApplicasaVirtualGoodCategoryGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetVirtualGoodCategoryArrayFinished callback) {
    [VirtualGoodCategory getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetVirtualGoodCategoryArrayFinishedToBlock(callback)];
}

void ApplicasaVirtualGoodCategoryGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetVirtualGoodCategoryArrayFinished callback) {
    [VirtualGoodCategory getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetVirtualGoodCategoryArrayFinishedToBlock(callback)];
}

ApplicasaVirtualGoodCategoryArray ApplicasaVirtualGoodCategoryGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [VirtualGoodCategory getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    VirtualGoodCategory** virtualGoodCategoryArray = (VirtualGoodCategory**)malloc(sizeof(VirtualGoodCategory*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            virtualGoodCategoryArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaVirtualGoodCategoryArray virtualGoodCategoryStruct;
    virtualGoodCategoryStruct.Array = virtualGoodCategoryArray;
    virtualGoodCategoryStruct.ArraySize = arraySize;
   
    return virtualGoodCategoryStruct;
}



}
