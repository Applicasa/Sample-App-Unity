#import "ApplicasaCore.h"
#import "LiCore/Promotion.h"
#import "ApplicasaPromotionDelegator.h"
#import "User.h"

@implementation ApplicasaPromotionDelegator

-(id)initWithFunction:(ApplicasaPromotionsAvailable) func {
    if (self = [super init]) {
        callback = func;
    }
    return self;
}

-(void)liKitPromotionsAvailable:(NSArray *)promotions{
    int arraySize = [promotions count];
    
    Promotion* promotionArray[arraySize];
    for (int i = 0; i < arraySize; i++) {
        promotionArray[i] = [promotions objectAtIndex:i];
    }
    
    struct ApplicasaPromotionArray array;
    array.Array = promotionArray;
    array.ArraySize = arraySize;
    callback(array);
}

@end