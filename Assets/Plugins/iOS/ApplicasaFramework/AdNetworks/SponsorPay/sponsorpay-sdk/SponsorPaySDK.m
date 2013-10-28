//
//  SponsorPaySDK.m
//  SponsorPay iOS SDK
//
//  Created by David Davila on 11/13/12.
//  Copyright (c) 2012 SponsorPay. All rights reserved.
//

#import "SponsorPaySDK.h"
#import "SPAdvertiserManager.h"
#import "SPAdvertisementViewController_SDKPrivate.h"
#import "SPVirtualCurrencyServerConnector_SDKPrivate.h"
#import "SPBrandEngageClient_SDKPrivate.h"
#import "SPCredentials.h"
#import "SPActionIdValidator.h"
#import "SPToast.h"
#import "mediation/SPMediationCoordinator.h"

// Constants used in NSNotifications
NSString *const SPCurrencyNameChangeNotification = @"SPCurrencyNameChangeNotification";
NSString *const SPNewCurrencyNameKey = @"SPNewCurrencyNameKey";
NSString *const SPAppIdKey = @"SPAppIdKey";
NSString *const SPUserIdKey = @"SPUserIdKey";


static const NSUInteger SPExpectedNumberOfDifferentCredentials = 1;
static NSString *const SPPersistedUserIdKey = @"SponsorPayUserId";

// Keys for SDK configuration per credentials item
static NSString *const SPCurrencyNameConfigKey = @"SPCurrencyNameConfigKey";
static NSString *const SPShowPayoffNotificationConfigKey = @"SPShowPayoffNotificationConfigKey";
static const BOOL SPShowPayoffNotificationConfigDefaultValue = YES;

// User feedback message on payoff
static NSString *const SPCoinsNotificationDefaultCurrencyName = @"coins";
static NSString *const SPCoinsNotificationText = @"Congratulations! You've earned %d %@!";

@interface SponsorPaySDK()
@property (retain) NSMutableDictionary *activeCredentialsItems;
@property (retain) NSMutableDictionary *brandEngageClientsPool;
@property (retain) NSMutableDictionary *VCSConnectorsPool;
@property (retain) NSMutableSet *elementsWaitingForDisposal;
@property (retain) SPMediationCoordinator *mediationCoordinator;
@end

@implementation SponsorPaySDK

#pragma mark - Singleton accessor method and initializer

+ (SponsorPaySDK *)instance
{
    static SponsorPaySDK *instance = NULL;

    @synchronized(self)
    {
        if (instance == NULL)
            instance = [[self alloc] init];
    }
    
    return(instance);
}

- (id)init
{
    self = [super init];
    if (self) {
        NSUInteger capacity = SPExpectedNumberOfDifferentCredentials;
        self.activeCredentialsItems = [NSMutableDictionary dictionaryWithCapacity:capacity];
        self.brandEngageClientsPool = [NSMutableDictionary dictionaryWithCapacity:capacity];
        self.VCSConnectorsPool = [NSMutableDictionary dictionaryWithCapacity:capacity];
        self.elementsWaitingForDisposal = [NSMutableSet setWithCapacity:1];
        self.mediationCoordinator = [[SPMediationCoordinator alloc] init];
        [self registerForFeedbackToUserNotifications];
    }
    return self;
}

- (void)dealloc
{
    self.activeCredentialsItems = nil;
    self.brandEngageClientsPool = nil;
    self.VCSConnectorsPool = nil;
    self.elementsWaitingForDisposal = nil;
    self.mediationCoordinator = nil;
    [super dealloc];
}

#pragma mark - Class to unique instance message forwarding

+ (NSString *)startForAppId:(NSString *)appId
                     userId:(NSString *)userId
              securityToken:(NSString *)securityToken
{
    return [[self instance] startForAppId:appId userId:userId securityToken:securityToken];
}

+ (SPOfferWallViewController *)offerWallViewController
{
    return [[self instance] offerWallViewController];
}

+ (SPOfferWallViewController *)offerWallViewControllerForCredentials:(NSString *)credentialsToken
{
    return [[self instance] offerWallViewControllerForCredentials:credentialsToken];
}

+ (SPOfferWallViewController *)showOfferWallWithParentViewController:(UIViewController<SPOfferWallViewControllerDelegate> *)parent
{
    return [[self instance] showOfferWallWithParentViewController:parent];
}

+ (SPBrandEngageClient *)brandEngageClient
{
    return [[self instance] brandEngageClient];
}

+ (SPBrandEngageClient *)brandEngageClientForCredentials:(NSString *)credentialsToken
{
    return [[self instance] brandEngageClientForCredentials:credentialsToken];
}

+ (SPBrandEngageClient *)requestBrandEngageOffersNotifyingDelegate:(id<SPBrandEngageClientDelegate>)delegate
{
    return [[self instance] requestBrandEngageOffersNotifyingDelegate:delegate];
}

+ (void)setCurrencyName:(NSString *)name
{
    [[self instance] setCurrencyName:name];
}

+ (void)setCurrencyName:(NSString *)name forCredentials:(NSString *)credentialsToken
{
    [[self instance] setCurrencyName:name forCredentials:credentialsToken];
}

+ (NSString *)currencyNameForCredentials:(NSString *)credentialsToken {
    return [[self instance] currencyNameForCredentials:credentialsToken];
}

+ (void)setShowPayoffNotificationOnVirtualCoinsReceived:(BOOL)shouldShowNotification
{
    [[self instance] setShowPayoffNotificationOnVirtualCoinsReceived:shouldShowNotification];
}

+ (void)setShowPayoffNotificationOnVirtualCoinsReceived:(BOOL)shouldShowNotification
                                         forCredentials:(NSString *)credentialsToken
{
    [[self instance] setShowPayoffNotificationOnVirtualCoinsReceived:shouldShowNotification forCredentials:credentialsToken];
}

+ (BOOL)shouldShowPayoffNotificationOnVirtualCoinsReceivedForCredentials:(NSString *)credentialsToken
{
    return [[self instance] shouldShowPayoffNotificationOnVirtualCoinsReceivedForCredentials:credentialsToken];
}

+ (SPVirtualCurrencyServerConnector *)VCSConnector
{
    return [[self instance] VCSConnector];
}

+ (SPVirtualCurrencyServerConnector *)VCSConnectorForCredentials:(NSString *)credentialsToken
{
    return [[self instance] VCSConnectorForCredentials:credentialsToken];
}

+ (SPVirtualCurrencyServerConnector *)requestDeltaOfCoinsNotifyingDelegate:(id<SPVirtualCurrencyConnectionDelegate>)delegate
{
    return [[self instance] requestDeltaOfCoinsNotifyingDelegate:delegate];
}

+ (void)reportActionCompleted:(NSString *)actionID
{
    [[self instance] reportActionCompleted:actionID];
}

+ (void)reportActionCompleted:(NSString *)actionID forCredentials:(NSString *)credentialsToken
{
    [[self instance] reportActionCompleted:actionID forCredentials:credentialsToken];
}

#pragma mark - Credentials and callback management

- (NSString *)startForAppId:(NSString *)appId
                     userId:(NSString *)userId
              securityToken:(NSString *)securityToken
{
    if (!userId || [userId isEqualToString:@""]) {
        userId = [self anonymousUserId];
    }
    
    NSString *credentialsToken = [SPCredentials credentialsTokenForAppId:appId
                                                                  userId:userId];
    SPCredentials *credentials;
    
   @try {
        credentials = [self credentialsForToken:credentialsToken];
        credentials.securityToken = securityToken;
    }
    
    @catch (NSException *noSuchCredentialsException) {
        credentials = [SPCredentials credentialsWithAppId:appId
                                                   userId:userId
                                            securityToken:securityToken];

        [self.activeCredentialsItems setObject:credentials forKey:credentialsToken];
        [self sendAdvertiserCallbackForCredentials:credentials];
    }

    [self.mediationCoordinator startThirdPartySDKs];

    return credentialsToken;
}

- (void)clearCredentials
{
    [self.activeCredentialsItems removeAllObjects];
    [SPLogger log:@"Removed all credential items from SponsorPaySDK"];
}

- (NSString *)anonymousUserId
{
    NSString *userId = [self persistedUserId];
    if (!userId) {
        userId = [self generatedRandomUserId];
        [self persistUserId:userId];
    }

    return userId;
}

- (NSString *)persistedUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:SPPersistedUserIdKey];
}

- (void)persistUserId:(NSString *)generatedUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:generatedUserId forKey:SPPersistedUserIdKey];
    [defaults synchronize];
}

- (NSString *)generatedRandomUserId
{
    NSString *generatedUserId = nil;
    
    Class uuidClass = NSClassFromString(@"NSUUID");
    if (uuidClass) {
        id uuidInstance = [[uuidClass alloc] init];
        generatedUserId = [uuidInstance performSelector:@selector(UUIDString)];
        [uuidInstance release];
    } else {
        static NSString *const alphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        static const NSUInteger randomStringLength = 64;
        
        NSMutableString *randomString = [NSMutableString stringWithCapacity:randomStringLength];
        
        for (int i=0; i<randomStringLength; i++) {
            [randomString appendFormat: @"%C", [alphabet characterAtIndex: arc4random() % [alphabet length]]];
        }
        
        generatedUserId = randomString;
    }
    
    return generatedUserId;
}


- (SPCredentials *)uniqueCredentialsItem
{
    NSInteger credentialItemsCount = self.activeCredentialsItems.count;
    
    if (credentialItemsCount != 1) {
        NSString *exceptionReason = credentialItemsCount == 0 ?
        @"Please start the SDK with [SponsorPaySDK startForAppId:userId:securityToken:] "
        "before accessing any of its resources" :
        @"More than one active SponsorPay appId / userId. Please use the credentials token "
        "to specify the appId / userId combination for which you're accessing the desired resource.";
        
        NSException* noUniqueCredentialsException =
            [NSException exceptionWithName:@"SponsorPayNoUniqueCredentialsException"
                                    reason:exceptionReason
                                  userInfo:nil];
        @throw noUniqueCredentialsException;
    }
    
    return [[[self activeCredentialsItems] allValues] lastObject];
}

- (SPCredentials *)credentialsForToken:(NSString *)credentialsToken
{
    SPCredentials *credentials = [self.activeCredentialsItems objectForKey:credentialsToken];
    
    if (!credentials) {
        NSException *invalidCredentialsTokenException =
            [NSException exceptionWithName:@"SponsorPayInvalidCredentialsToken"
                                    reason:@"Please use [SponsorPaySDK startForAppId:userId:securityToken:] "
                                          "to obtain a valid credentials token. "
                                          "(No credentials found for the credentials token specified.)"
                                  userInfo:nil];
        @throw invalidCredentialsTokenException;
    }
    
    return credentials;
}

- (void)sendAdvertiserCallbackForCredentials:(SPCredentials *)credentials
{
    [[SPAdvertiserManager advertiserManagerForAppId:credentials.appId] reportOfferCompleted];
}

#pragma mark - Configuration per credentials item

- (SPCredentials *)setConfigurationValue:(id)value
                                  forKey:(NSString *)key
                  inCredentialsWithToken:(NSString *)token
{
    SPCredentials *credentials = [self credentialsForToken:token];
    credentials.userConfig[key] = value;
    return credentials;
}

- (void)setConfigurationValueInAllCredentials:(id)value
                                       forKey:(NSString *)key
{
    if (!self.activeCredentialsItems.count)
        @throw [NSException exceptionWithName:@"SponsorPaySDKNotStarted"
                                       reason:@"Please start the SDK with "
                                              "[SponsorPaySDK startForAppId:userId:securityToken:] "
                                              "before setting any of its configuration values."
                                     userInfo:nil];
    
    NSArray *allCredentialTokens = self.activeCredentialsItems.allKeys;
    
    for (NSString *token in allCredentialTokens)
        [self setConfigurationValue:value forKey:key inCredentialsWithToken:token];
}

#pragma mark - Currency name

- (void)setCurrencyName:(NSString *)name
{
    [self setConfigurationValueInAllCredentials:name forKey:SPCurrencyNameConfigKey];
    [self triggerCurrencyNameNotificationWithNewName:name forCredentials:nil];
}

- (void)setCurrencyName:(NSString *)name forCredentials:(NSString *)credentialsToken
{
    SPCredentials *affectedCredentials = [self setConfigurationValue:name
                                                              forKey:SPCurrencyNameConfigKey
                                              inCredentialsWithToken:credentialsToken];
    [self triggerCurrencyNameNotificationWithNewName:name forCredentials:affectedCredentials];
}

- (void)triggerCurrencyNameNotificationWithNewName:(NSString *)name
                                    forCredentials:(SPCredentials *)credentials
{
    NSDictionary *notificationInfo = @{
    SPNewCurrencyNameKey : name,
    SPAppIdKey  : (credentials ? credentials.appId  : [NSNull null]),
    SPUserIdKey : (credentials ? credentials.userId : [NSNull null])
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SPCurrencyNameChangeNotification
                                                        object:self
                                                      userInfo:notificationInfo];
}

- (NSString *)currencyNameForCredentials:(NSString *)credentialsToken
{
    SPCredentials *credentials = [self credentialsForToken:credentialsToken];
    id currencyName = credentials.userConfig[SPCurrencyNameConfigKey];
    return [currencyName isKindOfClass:[NSString class]] ? currencyName : @"";
}

#pragma mark - Feedback to user

- (void)setShowPayoffNotificationOnVirtualCoinsReceived:(BOOL)shouldShowNotification
{
    [self setConfigurationValueInAllCredentials:[NSNumber numberWithBool:shouldShowNotification]
                                         forKey:SPShowPayoffNotificationConfigKey];
}

- (void)setShowPayoffNotificationOnVirtualCoinsReceived:(BOOL)shouldShowNotification
                                         forCredentials:(NSString *)credentialsToken
{
    [self setConfigurationValue:[NSNumber numberWithBool:shouldShowNotification]
                         forKey:SPShowPayoffNotificationConfigKey
         inCredentialsWithToken:credentialsToken];
}

- (BOOL)shouldShowPayoffNotificationOnVirtualCoinsReceivedForCredentials:(NSString *)credentialsToken
{
    SPCredentials *credentials = [self credentialsForToken:credentialsToken];
    id shouldShowNotification = credentials.userConfig[SPShowPayoffNotificationConfigKey];
    return [shouldShowNotification isKindOfClass:[NSNumber class]] ?
        [shouldShowNotification boolValue] : SPShowPayoffNotificationConfigDefaultValue;
}

- (void)registerForFeedbackToUserNotifications
{
    [SPLogger log:@"SDK Registering for notification: %@", SPVCSPayoffReceivedNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(vcsPayoffReceived:)
                                                 name:SPVCSPayoffReceivedNotification
                                               object:nil];
}

- (void)vcsPayoffReceived:(NSNotification *)notification
{
    NSDictionary *notificationInfo = notification.userInfo;
    NSString *appId = notificationInfo[SPAppIdKey];
    NSString *userId = notificationInfo[SPUserIdKey];
    
    [SPLogger log:@"SDK received notification for VCS payoff with userInfo=%@", notificationInfo];
    
    NSString *credentialsToken = [SPCredentials credentialsTokenForAppId:appId
                                                                  userId:userId];
    @try {
        SPCredentials *correspondingCredentials = [self credentialsForToken:credentialsToken];
        NSNumber *shouldShowPayoff = correspondingCredentials.userConfig[SPShowPayoffNotificationConfigKey];
        
        if (shouldShowPayoff == nil)
            shouldShowPayoff = [NSNumber numberWithBool:SPShowPayoffNotificationConfigDefaultValue];
        
        [SPLogger log:@"shouldShowPayoff=%@", shouldShowPayoff];
        
        if ([shouldShowPayoff boolValue]) {
            id payoffAmount = notificationInfo[SPVCSPayoffAmountKey];
            if ([payoffAmount isKindOfClass:[NSNumber class]])
                [self showPayoffNotificationForAmount:[payoffAmount doubleValue]
                                         currencyName:correspondingCredentials.userConfig[SPCurrencyNameConfigKey]];
            else
                [SPLogger log:@"Won't show notification to the user - payoffAmount is not of the correct data type: %@", payoffAmount];
        }
    }
    @catch (NSException *invalidCredentialsTokenException) {
        [SPLogger log:@"Won't show notification to the user: %@", invalidCredentialsTokenException];
    }
}

- (void)showPayoffNotificationForAmount:(double)amount currencyName:(NSString *)explicitCurrencyName
{
    NSUInteger flooredAmount = (NSUInteger)floor(amount);
    
    BOOL explicitCurrencyNameGiven =
    (explicitCurrencyName && ![explicitCurrencyName isEqualToString:@""]);
    
    NSString *currencyName =
    explicitCurrencyNameGiven ? explicitCurrencyName : SPCoinsNotificationDefaultCurrencyName;
    
    [[[[SPToast makeText:[NSString stringWithFormat:SPCoinsNotificationText, flooredAmount, currencyName]]
       setGravity:SPToastGravityBottom] setDuration:SPToastDurationNormal] show];
}

#pragma mark - OfferWall

- (SPOfferWallViewController *)offerWallViewController
{
    return [self offerWallViewControllerForCredentials:[self uniqueCredentialsItem].credentialsToken];
}

- (SPOfferWallViewController *)offerWallViewControllerForCredentials:(NSString *)credentialsToken
{
    SPCredentials *credentials = [self credentialsForToken:credentialsToken];
    
    SPOfferWallViewController *offerWallVC = [[SPOfferWallViewController alloc] init];
    offerWallVC.appId = credentials.appId;
    offerWallVC.userId = credentials.userId;
    offerWallVC.currencyName = credentials.userConfig[SPCurrencyNameConfigKey];

    [self.elementsWaitingForDisposal addObject:offerWallVC];
    offerWallVC.disposalBlock = ^(void) {
        [[SPLogger defaultLogger] log:@"disposing of OfferWall VC"];
        [self.elementsWaitingForDisposal removeObject:offerWallVC];
    };
   
    return [offerWallVC autorelease];
}

- (SPOfferWallViewController *)showOfferWallWithParentViewController:
    (UIViewController<SPOfferWallViewControllerDelegate> *)parent
{
    SPOfferWallViewController *offerWallVC = [self offerWallViewController];
    offerWallVC.delegate = parent;
    [offerWallVC showOfferWallWithParentViewController:parent];
    
    return offerWallVC;
}

#pragma mark - Mobile BrandEngage

- (SPBrandEngageClient *)brandEngageClient
{
    return [self brandEngageClientForCredentials:[self uniqueCredentialsItem].credentialsToken];
}

- (SPBrandEngageClient *)brandEngageClientForCredentials:(NSString *)credentialsToken
{
    SPBrandEngageClient *brandEngageClient = [self.brandEngageClientsPool objectForKey:credentialsToken];
    
    if (!brandEngageClient) {
        SPCredentials *credentials = [self credentialsForToken:credentialsToken];
        brandEngageClient = [[SPBrandEngageClient alloc] init];
        brandEngageClient.appId = credentials.appId;
        brandEngageClient.userId = credentials.userId;
        brandEngageClient.currencyName = credentials.userConfig[SPCurrencyNameConfigKey];
        brandEngageClient.mediationCoordinator = self.mediationCoordinator;

        [self.brandEngageClientsPool setObject:brandEngageClient forKey:credentialsToken];
        [brandEngageClient release];
    }
    
    return brandEngageClient;
}

- (SPBrandEngageClient *)requestBrandEngageOffersNotifyingDelegate:(id<SPBrandEngageClientDelegate>)delegate
{
    SPBrandEngageClient *brandEngageClient = [self brandEngageClient];
    brandEngageClient.delegate = delegate;
    [brandEngageClient requestOffers];
    
    return brandEngageClient;
}

#pragma mark - VCS

- (SPVirtualCurrencyServerConnector *)VCSConnector
{
    return [self VCSConnectorForCredentials:[self uniqueCredentialsItem].credentialsToken];
}

- (SPVirtualCurrencyServerConnector *)VCSConnectorForCredentials:(NSString *)credentialsToken
{
    SPVirtualCurrencyServerConnector *VCSConnector = [self.VCSConnectorsPool objectForKey:credentialsToken];

    SPCredentials *credentials = [self credentialsForToken:credentialsToken];

    if (!VCSConnector) {
        VCSConnector = [[SPVirtualCurrencyServerConnector alloc] init];
        VCSConnector.appId = credentials.appId;
        VCSConnector.userId = credentials.userId;
        [self.VCSConnectorsPool setObject:VCSConnector forKey:credentialsToken];
        [VCSConnector autorelease];
    }

    VCSConnector.secretToken = credentials.securityToken;
    
    return VCSConnector;
}

- (SPVirtualCurrencyServerConnector *)requestDeltaOfCoinsNotifyingDelegate:
    (id<SPVirtualCurrencyConnectionDelegate>)delegate
{
    SPVirtualCurrencyServerConnector *VCSConnector = [self VCSConnector];
    VCSConnector.delegate = delegate;
    [VCSConnector fetchDeltaOfCoins];
    
    return VCSConnector;
}


#pragma mark - Rewarded Actions

- (void)reportActionCompleted:(NSString *)actionID
{
    [self reportActionCompleted:actionID forCredentials:[self uniqueCredentialsItem].credentialsToken];
}

- (void)reportActionCompleted:(NSString *)actionId forCredentials:(NSString *)credentialsToken
{
    SPCredentials *credentials = [self credentialsForToken:credentialsToken];

    [SPActionIdValidator validateOrThrow:actionId];
    
    [[SPAdvertiserManager advertiserManagerForAppId:credentials.appId]
     reportActionCompleted:actionId];
}

@end
