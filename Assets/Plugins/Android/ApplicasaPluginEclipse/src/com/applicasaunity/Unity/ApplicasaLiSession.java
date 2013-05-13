package com.applicasaunity.Unity;

import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.promotion.sessions.LiSessionManager.FinishedSendingAnalyticsCallback;
import applicasa.LiCore.promotion.sessions.LiSessionManager.LiGameResult;

import com.applicasa.ApplicasaManager.LiSession;
import com.unity3d.player.UnityPlayer;

public class ApplicasaLiSession {

    static {
        System.loadLibrary("Applicasa");
    }
    
    public static void ApplicasaSessionSessionStart() {
    	LiSession.sessionStart(UnityPlayer.currentActivity);
    }
    
    public static void ApplicasaSessionSessionPause() {
    	LiSession.sessionEnd(UnityPlayer.currentActivity);
    }

	public static void ApplicasaSessionSessionResume() {
		LiSession.sessionResume(UnityPlayer.currentActivity);
	}

	public static void ApplicasaSessionSessionEnd() {
		LiSession.sessionEnd(UnityPlayer.currentActivity);
	}
	
	public static void ApplicasaSessionSessionEndWithCallback(final int uniqueActionID) {
		LiSession.sessionEnd(UnityPlayer.currentActivity, new FinishedSendingAnalyticsCallback() {
			
			@Override
			public void finishedSending() {
				ApplicasaCore.responseCallbackGetObjectFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), null);
			}
		});
	}

	public static void ApplicasaSessionGameStart(String gameName) {
		try {
			LiSession.gameStart(gameName, null);
		} catch (LiErrorHandler e) {
			e.printStackTrace();
		}
	}

	public static void ApplicasaSessionGamePause() throws LiErrorHandler {
		LiSession.gamePause();
	}

	public static void ApplicasaSessionGameResume() throws LiErrorHandler {
		LiSession.gameResume();
	}

	public static void ApplicasaSessionGameFinishedWithResult(int liGameResult, int mainCurrency,int secondaryCurrency, int score,int  bonus) {
		try {
			LiSession.gameFinished(LiGameResult.values()[liGameResult], mainCurrency, secondaryCurrency, score, bonus, null);
		} catch (LiErrorHandler e) {
			e.printStackTrace();
		}
	}
	
}
