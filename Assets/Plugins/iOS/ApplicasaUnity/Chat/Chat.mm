//
// Chat.mm
// Created by Applicasa 
// 1/21/2014
//

#import "ApplicasaCore.h"
#import "Chat.h"

extern "C" {



const char* ApplicasaChatGetChatID(Chat* chat) {
	return NSStringToCharPointer(chat.chatID);
}
void ApplicasaChatSetChatID(Chat* chat, const char * chatID) {
	chat.chatID = CharPointerToNSString(chatID);
}
const double ApplicasaChatGetChatLastUpdate(Chat* chat) {
	return ((double)chat.chatLastUpdate.timeIntervalSince1970);
}
const bool ApplicasaChatGetChatIsSender(Chat* chat) {
	return chat.chatIsSender;
}
void ApplicasaChatSetChatIsSender(Chat* chat,bool chatIsSender) {
	 chat.chatIsSender=chatIsSender;
}
User* ApplicasaChatGetChatSender(Chat* chat) {
	return chat.chatSender;
}

void ApplicasaChatSetChatSender(Chat* chat, User* chatSender){
	chat.chatSender = chatSender;
}
const char* ApplicasaChatGetChatText(Chat* chat) {
	return NSStringToCharPointer(chat.chatText);
}
void ApplicasaChatSetChatText(Chat* chat, const char * chatText) {
	chat.chatText = CharPointerToNSString(chatText);
}
User* ApplicasaChatGetChatReciepent(Chat* chat) {
	return chat.chatReciepent;
}

void ApplicasaChatSetChatReciepent(Chat* chat, User* chatReciepent){
	chat.chatReciepent = chatReciepent;
}
const char* ApplicasaChatGetChatGhjgjgj(Chat* chat) {
	return NSStringToCharPointer([chat.chatGhjgjgj absoluteString]);
}
void ApplicasaChatSetChatGhjgjgj(Chat* chat,const char* url) {
	chat.chatGhjgjgj = [NSURL URLWithString:CharPointerToNSString(url)];
}




Chat * ApplicasaChat() {
    return [[Chat alloc] init];
}

void ApplicasaChatSaveWithBlock(Chat* chat, ApplicasaAction callback) {
    [chat saveWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaChatIncreaseFieldInt(Chat* chat, LiFields field, int val) {
    [chat increaseField:field byValue:[NSNumber numberWithInt:val]];
}

void ApplicasaChatIncreaseFieldFloat(Chat* chat, LiFields field, float val) {
    [chat increaseField:field byValue:[NSNumber numberWithFloat:val]];
}

void ApplicasaChatDeleteWithBlock(Chat* chat, ApplicasaAction callback) {
    [chat deleteWithBlock:ApplicasaActionToBlock(callback)];
}


void ApplicasaChatUploadFile(Chat* chat, LiFields field, Byte* data, int dataLen, AMAZON_FILE_TYPES fileType, const char * extension,  ApplicasaAction callback) {
    NSData* imageData = [NSData dataWithBytes:data length:dataLen];
    [chat uploadFile:imageData toField:field withFileType:fileType extension:CharPointerToNSString(extension) andBlock:ApplicasaActionToBlock(callback)];
}

void ApplicasaChatGetById(const char * id, QueryKind queryKind, ApplicasaGetChatFinished callback) {
    [Chat getById:CharPointerToNSString(id) queryKind:queryKind withBlock:ApplicasaGetChatFinishedToBlock(callback)];
}

void ApplicasaChatGetArrayWithQuery(LiQuery* query, QueryKind queryKind, ApplicasaGetChatArrayFinished callback) {
    [Chat getArrayWithQuery:query queryKind:queryKind withBlock:ApplicasaGetChatArrayFinishedToBlock(callback)];
}

void ApplicasaChatGetLocalArrayWithRawSqlQuery(const char * rawQuery, ApplicasaGetChatArrayFinished callback) {
    [Chat getLocalArrayWithRawSQLQuery:CharPointerToNSString(rawQuery) andBlock:ApplicasaGetChatArrayFinishedToBlock(callback)];
}
    
int ApplicasaChatUpdateLocalStorage(LiQuery* query, QueryKind queryKind)
{
    return [Chat updateLocalStorage:query queryKind:queryKind];
}

ApplicasaChatArray ApplicasaChatGetArrayWithQuerySync(LiQuery* query, QueryKind queryKind) {    
    NSArray *array = [Chat getArrayWithQuery:query queryKind:queryKind ];
    int arraySize = [array count];
    Chat** chatArray = (Chat**)malloc(sizeof(Chat*) * arraySize);
    if (array != nil)
    {
        for (int i = 0; i < arraySize; i++) {
            chatArray[i] = [array objectAtIndex:i];
        }
    }
    struct ApplicasaChatArray chatStruct;
    chatStruct.Array = chatArray;
    chatStruct.ArraySize = arraySize;
   
    return chatStruct;
}



}
