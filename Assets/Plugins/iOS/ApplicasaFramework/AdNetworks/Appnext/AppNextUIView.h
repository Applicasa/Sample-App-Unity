
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AdSupport/ASIdentifierManager.h>

@protocol AppnextDelegate <NSObject>

- (void)noAds;
- (void)AdLoaded;
- (void)PopupOpened;
- (void)PopupClosed;
- (void)PopupClicked;

@end


id appnextDelegate;

@interface AppNextUIView : UIView

- (AppNextUIView *)newAppNextUIView;
- (void)hidePopup;
- (void)showPopup;
- (void)refreshAds;
- (void)setID:(NSString *)appid;

- (void)setAppnextDelegate:(id)delegate;

@end
