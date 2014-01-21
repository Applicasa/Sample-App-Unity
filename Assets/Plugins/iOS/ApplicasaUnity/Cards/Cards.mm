//
// Cards.mm
// Created by Applicasa 
// 1/21/2014
//

#import "ApplicasaCore.h"
#import "Cards.h"

extern "C" {



const char* ApplicasaCardsGetCardsID(Cards* cards) {
	return NSStringToCharPointer(cards.cardsID);
}
void ApplicasaCardsSetCardsID(Cards* cards, const char * cardsID) {
	cards.cardsID = CharPointerToNSString(cardsID);
}
const double ApplicasaCardsGetCardsLastUpdate(Cards* cards) {
	return ((double)cards.cardsLastUpdate.timeIntervalSince1970);
}
const char* ApplicasaCardsGetCardsName(Cards* cards) {
	return NSStringToCharPointer(cards.cardsName);
}
void ApplicasaCardsSetCardsName(Cards* cards, const char * cardsName) {
	cards.cardsName = CharPointerToNSString(cardsName);
}
const float ApplicasaCardsGetCardsPres(Cards* cards) {
	return cards.cardsPres;
}
void ApplicasaCardsSetCardsPres(Cards* cards, float cardsPres) {
	cards.cardsPres = cardsPres;
}
const char* ApplicasaCardsGetCardsImg(Cards* cards) {
	return NSStringToCharPointer([cards.cardsImg absoluteString]);
}
void ApplicasaCardsSetCardsImg(Cards* cards,const char* url) {
	cards.cardsImg = [NSURL URLWithString:CharPointerToNSString(url)];
}
Languages* ApplicasaCardsGetCardsAaaaa(Cards* cards) {
	return cards.cardsAaaaa;
}

void ApplicasaCardsSetCardsAaaaa(Cards* cards, Languages* cardsAaaaa){
	cards.cardsAaaaa = cardsAaaaa;
}




Cards * ApplicasaCards() {
    return [[Cards alloc] init];
}

void ApplicasaCardsSaveWithBlock(Cards* cards, ApplicasaAction callback) {
    [cards saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaCardsIncreaseFieldInt(Cards* cards, LiFields field, int val) {
    [cards increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaCardsIncreaseFieldFloat(Cards* cards, LiFields field, float val) {
    [cards increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaCardsDeleteWithBlock(Cards* cards, ApplicasaAction callback) {
    [cards deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaCardsUploadFile(Cards* cards, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [cards uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaCardsGetById(const char * id, QueryKind queryKind, ApplicasaGetCardsFinished callback) {
    [Cards getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetCardsFinishedToBlock(callback)];
}

void ApplicasaCardsGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetCardsArrayFinished callback) {
    [Cards getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetCardsArrayFinishedToBlock(callback)];
}

void ApplicasaCardsGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetCardsArrayFinished callback) {
    [Cards getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetCardsArrayFinishedToBlock(callback)];
}
    
int ApplicasaCardsUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Cards updateLocalStorage:query queryKind:queryKind];
}

ApplicasaCardsArray ApplicasaCardsGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Cards getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Cards** cardsArray = (Cards**)malloc(sizeof(Cards*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            cardsArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaCardsArray cardsStruct;
    cardsStruct.Array = cardsArray;
    cardsStruct.ArraySize = arraySize;
   
    return cardsStruct;
}



}
