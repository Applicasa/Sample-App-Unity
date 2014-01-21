#import <UIKit/UIKit.h>

typedef enum {
    UserBalanceStatusConnectionFailure,
    UserBalanceStatusOtherFailure,
    UserBalanceStatusOK,
    UserBalanceStatusInsufficientFunds,
    UserBalanceStatusUserNotFound
} UserBalanceStatus;

typedef void(^AarkiUserBalanceBlock)(UserBalanceStatus, NSNumber *);

@interface AarkiUserBalance : NSObject

+ (void)check:(NSString *)placementId completion:(AarkiUserBalanceBlock)completion;
+ (void)add:(NSString *)placementId amount:(NSInteger)amount completion:(AarkiUserBalanceBlock)completion;

@end
