//
//  ApplicasaCore.m
//  Unity-iPhone
//
#include "ApplicasaCore.h"
#import <LiCore/LiKitIAP.h>
#import <LiCore/LiCore.h>

void UnityPause(bool pause);

NSMutableDictionary *holdinPointers = [[NSMutableDictionary alloc]init];
extern "C" {

IAP_STATUS ApplicasaIAPStatus() {
        return [LiKitIAP liKitIAPStatus];
}

IAP_STATUS ApplicasaReValidateStatus() {
    return [LiKitIAP validateStatus];
}
    
static int promotionCounter = 0;
void IncreasePromoCounter(){
    promotionCounter++;
    UnityPause(true);
}
bool DecreasePromoCounter(){
    promotionCounter--;
    if (promotionCounter == 0)
    {
        UnityPause(false);
        return true;
    }
        return false;
}

LiBlockAction ApplicasaActionToBlock(ApplicasaAction function) {
    return [[^(NSError* error, NSString* itemID, Actions action) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        function(success, errorStruct, NSStringToCharPointer(itemID), action);
    } copy] autorelease];
}

GetUserFinished ApplicasaGetUserFinishedToBlock(ApplicasaGetUserFinished function) {
    return [[^(NSError *error, User *object) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
         [holdinPointers setObject:object forKey:[NSValue valueWithPointer:object]];
        function(success, errorStruct, object);
    } copy] autorelease];
}

GetUserArrayFinished ApplicasaGetUserArrayFinishedToBlock(ApplicasaGetUserArrayFinished function) {
    return [[^(NSError *error, NSArray *array) {
        
        struct ApplicasaError errorStruct;
        bool success;

        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        
        int arraySize = [array count];
        
        User* userArray[arraySize];
        for (int i = 0 ; i < arraySize; i++)
        {
            [holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
            userArray[i] = [array objectAtIndex:i];
        }
        
        struct ApplicasaUserArray finalArray;
        finalArray.ArraySize = arraySize;
        finalArray.Array = userArray;
        
        function(success, errorStruct, finalArray);
    } copy] autorelease];
}

LiBlockFBFriendsAction ApplicasaFBFriendsActionToBlock(ApplicasaFBFriendsAction function) {
    return [[^(NSError *error, NSArray *friends,Actions action) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        
        int arraySize = [friends count];
        
        LiObjFBFriend* friendArray[arraySize];
        for (int i = 0; i < arraySize; i++) {
            [holdinPointers setObject:[friends objectAtIndex:i] forKey:[NSValue valueWithPointer:[friends objectAtIndex:i]]];
            
            friendArray[i] = [friends objectAtIndex:i];
        }
        
        struct ApplicasaFBFriendArray fbFriendArray;
        fbFriendArray.Array = friendArray;
        fbFriendArray.ArraySize = arraySize;
        
        function(success, errorStruct, fbFriendArray , action);
    } copy] autorelease];
}


GetVirtualCurrencyArrayFinished ApplicasaGetVirtualCurrencyArrayFinishedToBlock(ApplicasaGetVirtualCurrencyArrayFinished function) {
    return [[^(NSError *error, NSArray *array) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        
        int arraySize = [array count];
        
        VirtualCurrency* virtualCurrencyArray[arraySize];
        for (int i = 0; i < arraySize; i++) {
             [holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
            virtualCurrencyArray[i] = [array objectAtIndex:i];
        }
        
        struct ApplicasaVirtualCurrencyArray virtualCurrencies;
        virtualCurrencies.Array = virtualCurrencyArray;
        virtualCurrencies.ArraySize = arraySize;
        
        function(success, errorStruct, virtualCurrencies);
    } copy] autorelease];
}

GetVirtualGoodArrayFinished ApplicasaGetVirtualGoodArrayFinishedToBlock(ApplicasaGetVirtualGoodArrayFinished function) {
    return [[^(NSError *error, NSArray *array) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        
        int arraySize = [array count];
        
        VirtualGood* virtualGoodArray[arraySize];
        for (int i = 0; i < arraySize; i++) {
             [holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
            virtualGoodArray[i] = [array objectAtIndex:i];
        }
        
        struct ApplicasaVirtualGoodArray virtualGoods;
        virtualGoods.Array = virtualGoodArray;
        virtualGoods.ArraySize = arraySize;
        
        function(success, errorStruct, virtualGoods);
    } copy] autorelease];
}

GetVirtualGoodCategoryFinished ApplicasaGetVirtualGoodCategoryFinishedToBlock(ApplicasaGetVirtualGoodCategoryFinished function) {
    return [[^(NSError *error, VirtualGoodCategory *object) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
         [holdinPointers setObject:object forKey:[NSValue valueWithPointer:object]];
        function(success, errorStruct, object);
    } copy] autorelease];
}

GetVirtualGoodCategoryArrayFinished ApplicasaGetVirtualGoodCategoryArrayFinishedToBlock(ApplicasaGetVirtualGoodCategoryArrayFinished function) {
    return [[^(NSError *error, NSArray *array) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        
        int arraySize = [array count];
        
        VirtualGoodCategory* virtualGoodCategoryArray[arraySize];
        for (int i = 0; i < arraySize; i++) {
             [holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
            virtualGoodCategoryArray[i] = [array objectAtIndex:i];
        }
        
        struct ApplicasaVirtualGoodCategoryArray virtualGoodCategories;
        virtualGoodCategories.Array = virtualGoodCategoryArray;
        virtualGoodCategories.ArraySize = arraySize;
        
        function(success, errorStruct, virtualGoodCategories);
    } copy] autorelease];
}

GetPromotionArrayFinished ApplicasaGetPromotionArrayFinishedToBlock(ApplicasaGetPromotionArrayFinished function) {
    return [[^(NSError *error, NSArray *array) {
        struct ApplicasaError errorStruct;
        bool success;
        if (error) {
            success = false;
            errorStruct.Id = error.code;
            errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
        } else {
            success = true;
            errorStruct.Id = 1;
            errorStruct.Message = NSStringToCharPointer(@"");
        }
        
        int arraySize = [array count];
        
        Promotion* promotionArray[arraySize];
        for (int i = 0; i < arraySize; i++) {
             [holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
            promotionArray[i] = [array objectAtIndex:i];
        }
        
        struct ApplicasaPromotionArray promotions;
        promotions.Array = promotionArray;
        promotions.ArraySize = arraySize;
        
        function(success, errorStruct, promotions);
    } copy] autorelease];
}
    



	
    SendPushFinished ApplicasaSendPushFinishedToBlock(ApplicasaSendPushFinished function) {
        return [[^(NSError *error, NSString *message,LiObjPushNotification *pushObject) {
            struct ApplicasaError errorStruct;
            bool success;
            if (error) {
                success = false;
                errorStruct.Id = error.code;
                errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
            } else {
                success = true;
                errorStruct.Id = 1;
                errorStruct.Message = NSStringToCharPointer(@"");
            }
            
            function(success, errorStruct, NSStringToCharPointer(message), pushObject);
        } copy] autorelease];
    }

PromotionResultBlock ApplicasaPromotionResultToBlock(ApplicasaPromotionResult function) {
    return [[^(LiPromotionAction promoAction,LiPromotionResult result,id info) {
        
    if (DecreasePromoCounter())
        UnityPause(false);
        

     struct PromotionResultInfo promoResult;
     promoResult.stringResult = NSStringToCharPointer(@"");
     promoResult.intResult = -1;
     
     switch (result) {
        case LiPromotionResultLinkOpened:{
            promoResult.type = PromotionResultDataTypeString;
            promoResult.stringResult = NSStringToCharPointer([(NSURL *)info absoluteString]);
        }
            break;
        case LiPromotionResultStringInfo:{
            promoResult.type = PromotionResultDataTypeString;
            promoResult.stringResult = NSStringToCharPointer((NSString *)info);
        }
            break;
        case LiPromotionResultGiveSecondaryCurrencyVirtualCurrency:
        case LiPromotionResultGiveMainCurrencyVirtualCurrency:{
         promoResult.type = PromotionResultDataTypeInt;
             promoResult.intResult = [info integerValue];
        }
            break;
        case LiPromotionResultGiveVirtualGood:{
            promoResult.type = PromotionResultDataTypeVirtualGood;
            promoResult.virtualGoodResult = (VirtualGood *) info;
        }
            break;
        case LiPromotionResultDealVirtualCurrency:{
            promoResult.type = PromotionResultDataTypeVirtualCurrency;
            promoResult.virtualCurrencyResult = (VirtualCurrency *) info;
        }
            break;
        case LiPromotionResultDealVirtualGood:{
            promoResult.type = PromotionResultDataTypeVirtualGood;
            promoResult.virtualGoodResult = (VirtualGood *) info;
        }
            break;
        default:
            //nothing...
            break;
    }
     
    
    function(promoAction, result, promoResult);
    } copy] autorelease];
}

    bool ApplicasaIsDoneLoading() {
        return [LiCore isDoneLoading];
    }
    
    GetCachedImageFinished ApplicasaGetFileDataToImageBlock(ApplicasaGetFileData function) {
        return [[^(NSError *error, UIImage *image) {
            struct ApplicasaError errorStruct;
            bool success;
            if (error) {
                success = false;
                errorStruct.Id = error.code;
                errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
            } else {
                success = true;
                errorStruct.Id = 1;
                errorStruct.Message = NSStringToCharPointer(@"");
            }
            
            NSData *data = UIImagePNGRepresentation(image);
            
            struct ApplicasaByteArray bytes;
            bytes.Array = (Byte*)data.bytes;
            bytes.ArraySize = data.length;
            
            function(success, errorStruct, bytes);
        } copy] autorelease];
    }
    
    GetCachedDataFinished ApplicasaGetFileDataToDataBlock(ApplicasaGetFileData function) {
        return [[^(NSError *error, NSData *data) {
            struct ApplicasaError errorStruct;
            bool success;
            if (error) {
                success = false;
                errorStruct.Id = error.code;
                errorStruct.Message = NSStringToCharPointer(error.localizedDescription);
            } else {
                success = true;
                errorStruct.Id = 1;
                errorStruct.Message = NSStringToCharPointer(@"");
            }
            
            struct ApplicasaByteArray bytes;
            bytes.Array = (Byte*)data.bytes;
            bytes.ArraySize = data.length;
            
            function(success, errorStruct, bytes);
        } copy] autorelease];
    }
    
    long ApplicasaGetServerTime()
    {
        return [LiCore getServerTime];
    }
    
    void ApplicasaDeallocPointer(id item)
    {
        [holdinPointers removeObjectForKey:[NSValue valueWithPointer:item]];
    }

}