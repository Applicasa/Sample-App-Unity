//
//  ApplicasaCore.m
//  Unity-iPhone
//
#include "ApplicasaCore.h"
#import <LiCore/LiKitIAP.h>
#import <LiCore/LiCore.h>
#import <LiCore/TPAction.h>

void UnityPause(bool pause);

NSMutableDictionary *holdinPointers = [[NSMutableDictionary alloc]init];

extern "C" {
    
    IAP_STATUS ApplicasaIAPStatus() {
        return [LiKitIAP liKitIAPStatus];
    }
    
    IAP_STATUS ApplicasaReValidateStatus() {
        return [LiKitIAP validateStatus];
    }
    
    bool ApplicasaIsDoneLoading() {
        return [LiCore isDoneLoading];
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

extern "C++" {
    
static int promotionCounter = 0;
void IncreasePromoCounter(){
    promotionCounter++;
    UnityPause(true);
}
bool DecreasePromoCounter(){
    promotionCounter--;
    if (promotionCounter == 0)
    {
        //UnityPause(false);
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
    
    LiThirdPartyResponse ApplicasaGetThirdPartyActionArrayFinishedToBlock(ApplicasaGetThirdPartyActionArrayFinished function) {
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
            
            TPAction* thirdPartyActionArray[arraySize];
            for (int i = 0; i < arraySize; i++) {
                [holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
                thirdPartyActionArray[i] = [array objectAtIndex:i];
            }
            
            struct ApplicasaThirdPartyActionArray thirdPartyActionStruct;
            thirdPartyActionStruct.Array = thirdPartyActionArray;
            thirdPartyActionStruct.ArraySize = arraySize;
            
            function(success, errorStruct, thirdPartyActionStruct);
        } copy] autorelease];
    }

    

GetDynamicFinished ApplicasaGetDynamicFinishedToBlock(ApplicasaGetDynamicFinished function) {
	return [[^(NSError *error, Dynamic *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetDynamicArrayFinished ApplicasaGetDynamicArrayFinishedToBlock(ApplicasaGetDynamicArrayFinished function) {
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

		Dynamic* dynamicArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			dynamicArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaDynamicArray dynamicStruct;
		dynamicStruct.Array = dynamicArray;
		dynamicStruct.ArraySize = arraySize;

		function(success, errorStruct, dynamicStruct);
	} copy] autorelease];
}


GetChatFinished ApplicasaGetChatFinishedToBlock(ApplicasaGetChatFinished function) {
	return [[^(NSError *error, Chat *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetChatArrayFinished ApplicasaGetChatArrayFinishedToBlock(ApplicasaGetChatArrayFinished function) {
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

		Chat* chatArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			chatArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaChatArray chatStruct;
		chatStruct.Array = chatArray;
		chatStruct.ArraySize = arraySize;

		function(success, errorStruct, chatStruct);
	} copy] autorelease];
}


GetAchievmentsFinished ApplicasaGetAchievmentsFinishedToBlock(ApplicasaGetAchievmentsFinished function) {
	return [[^(NSError *error, Achievments *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetAchievmentsArrayFinished ApplicasaGetAchievmentsArrayFinishedToBlock(ApplicasaGetAchievmentsArrayFinished function) {
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

		Achievments* achievmentsArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			achievmentsArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaAchievmentsArray achievmentsStruct;
		achievmentsStruct.Array = achievmentsArray;
		achievmentsStruct.ArraySize = arraySize;

		function(success, errorStruct, achievmentsStruct);
	} copy] autorelease];
}


GetFooFinished ApplicasaGetFooFinishedToBlock(ApplicasaGetFooFinished function) {
	return [[^(NSError *error, Foo *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetFooArrayFinished ApplicasaGetFooArrayFinishedToBlock(ApplicasaGetFooArrayFinished function) {
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

		Foo* fooArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			fooArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaFooArray fooStruct;
		fooStruct.Array = fooArray;
		fooStruct.ArraySize = arraySize;

		function(success, errorStruct, fooStruct);
	} copy] autorelease];
}


GetGameVFinished ApplicasaGetGameVFinishedToBlock(ApplicasaGetGameVFinished function) {
	return [[^(NSError *error, GameV *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetGameVArrayFinished ApplicasaGetGameVArrayFinishedToBlock(ApplicasaGetGameVArrayFinished function) {
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

		GameV* gameVArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			gameVArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaGameVArray gameVStruct;
		gameVStruct.Array = gameVArray;
		gameVStruct.ArraySize = arraySize;

		function(success, errorStruct, gameVStruct);
	} copy] autorelease];
}


GetDataManagerFinished ApplicasaGetDataManagerFinishedToBlock(ApplicasaGetDataManagerFinished function) {
	return [[^(NSError *error, DataManager *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetDataManagerArrayFinished ApplicasaGetDataManagerArrayFinishedToBlock(ApplicasaGetDataManagerArrayFinished function) {
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

		DataManager* dataManagerArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			dataManagerArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaDataManagerArray dataManagerStruct;
		dataManagerStruct.Array = dataManagerArray;
		dataManagerStruct.ArraySize = arraySize;

		function(success, errorStruct, dataManagerStruct);
	} copy] autorelease];
}


GetDataManStringFinished ApplicasaGetDataManStringFinishedToBlock(ApplicasaGetDataManStringFinished function) {
	return [[^(NSError *error, DataManString *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetDataManStringArrayFinished ApplicasaGetDataManStringArrayFinishedToBlock(ApplicasaGetDataManStringArrayFinished function) {
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

		DataManString* dataManStringArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			dataManStringArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaDataManStringArray dataManStringStruct;
		dataManStringStruct.Array = dataManStringArray;
		dataManStringStruct.ArraySize = arraySize;

		function(success, errorStruct, dataManStringStruct);
	} copy] autorelease];
}


GetScoreBFinished ApplicasaGetScoreBFinishedToBlock(ApplicasaGetScoreBFinished function) {
	return [[^(NSError *error, ScoreB *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetScoreBArrayFinished ApplicasaGetScoreBArrayFinishedToBlock(ApplicasaGetScoreBArrayFinished function) {
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

		ScoreB* scoreBArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			scoreBArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaScoreBArray scoreBStruct;
		scoreBStruct.Array = scoreBArray;
		scoreBStruct.ArraySize = arraySize;

		function(success, errorStruct, scoreBStruct);
	} copy] autorelease];
}


GetLevelsFinished ApplicasaGetLevelsFinishedToBlock(ApplicasaGetLevelsFinished function) {
	return [[^(NSError *error, Levels *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetLevelsArrayFinished ApplicasaGetLevelsArrayFinishedToBlock(ApplicasaGetLevelsArrayFinished function) {
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

		Levels* levelsArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			levelsArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaLevelsArray levelsStruct;
		levelsStruct.Array = levelsArray;
		levelsStruct.ArraySize = arraySize;

		function(success, errorStruct, levelsStruct);
	} copy] autorelease];
}


GetColorsFinished ApplicasaGetColorsFinishedToBlock(ApplicasaGetColorsFinished function) {
	return [[^(NSError *error, Colors *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetColorsArrayFinished ApplicasaGetColorsArrayFinishedToBlock(ApplicasaGetColorsArrayFinished function) {
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

		Colors* colorsArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			colorsArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaColorsArray colorsStruct;
		colorsStruct.Array = colorsArray;
		colorsStruct.ArraySize = arraySize;

		function(success, errorStruct, colorsStruct);
	} copy] autorelease];
}


GetLanguagesFinished ApplicasaGetLanguagesFinishedToBlock(ApplicasaGetLanguagesFinished function) {
	return [[^(NSError *error, Languages *object) {
		struct ApplicasaError errorStruct;
		bool success;		if (error) {
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

GetLanguagesArrayFinished ApplicasaGetLanguagesArrayFinishedToBlock(ApplicasaGetLanguagesArrayFinished function) {
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

		Languages* languagesArray[arraySize];
		for (int i = 0; i < arraySize; i++) {
			[holdinPointers setObject:[array objectAtIndex:i] forKey:[NSValue valueWithPointer:[array objectAtIndex:i]]];
			languagesArray[i] = [array objectAtIndex:i];
		}

		struct ApplicasaLanguagesArray languagesStruct;
		languagesStruct.Array = languagesArray;
		languagesStruct.ArraySize = arraySize;

		function(success, errorStruct, languagesStruct);
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
	
	switch (result) {
            case LiPromotionResultChartboost:
            case LiPromotionResultAppnext:
            case LiPromotionResultMMedia:
            case LiPromotionResultSponsorPay:
            case LiPromotionResultSupersonicAds:
                break;
                
            default:
                if (DecreasePromoCounter() )
                    UnityPause(false);

                break;
        }

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
}