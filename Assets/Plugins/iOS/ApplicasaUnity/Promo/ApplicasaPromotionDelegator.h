#import "ApplicasaCore.h"
#import "LiCore/Promotion.h"

//extern "C" {

#import <UIKit/UIKit.h>
#import "LiPromo.h"

@interface ApplicasaPromotionDelegator : NSObject <LiKitPromotionsDelegate> {
    ApplicasaPromotionsAvailable callback;
}

-(id)initWithFunction:(ApplicasaPromotionsAvailable) func;

@end


//}