#import "ApplicasaCore.h"
#import "LiSession.h"
#import <LiCore/LiKitIAP.h>

extern "C" {
    
    static BOOL calledPauseDuringIAP = FALSE;
    void ApplicasaSessionSessionStart() {
        [LiSession sessionStart];
    }
    
    void ApplicasaSessionSessionPause() {
        if([LiKitIAP isDuringInApp] && !calledPauseDuringIAP)
            calledPauseDuringIAP = TRUE;
        else
        {
            [LiSession sessionPause];
            calledPauseDuringIAP = FALSE;
        }
    }
    
    void ApplicasaSessionSessionResume() {
        if(!calledPauseDuringIAP)
            [LiSession sessionResume];
        else
            calledPauseDuringIAP = FALSE;
            
    }
    
    void ApplicasaSessionSessionEnd() {
        [LiSession sessionEnd];
    }
    
    void ApplicasaSessionGameStart(const char * gameName) {
        [LiSession gameStart:CharPointerToNSString(gameName)];
    }
    
    void ApplicasaSessionGamePause() {
        [LiSession gamePause];
    }
    
    void ApplicasaSessionGameResume() {
        [LiSession gameResume];
    }
    
    void ApplicasaSessionGameFinishedWithResult(LiGameResult gameResult, int mainCurrencyBalance, int secondaryCurrencyBalance, int finalScore, int bonus) {
        [LiSession gameFinishedWithResult:gameResult mainCurrencyBalance:mainCurrencyBalance secondaryCurrencyBalance:secondaryCurrencyBalance finalScore:finalScore andBonus:bonus];
    }
    
    
    
}