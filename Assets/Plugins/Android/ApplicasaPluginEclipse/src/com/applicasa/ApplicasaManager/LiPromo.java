package com.applicasa.ApplicasaManager;

import java.util.List;

import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.communication.LiRequestConst.RequestCallback.LiCallbackGetPromotion;
import applicasa.LiCore.promotion.sessions.LiEventManager;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback;

import com.applicasa.Promotion.LiPromoManager;
import com.applicasa.Promotion.Promotion;

public class LiPromo {

	/**
	 * Sets the promotion callback
	 * @param liPromotionCallback
	 */
	public static void setPromoCallback(LiPromotionCallback liPromotionCallback)
	{
		LiEventManager.setPromoCallback(liPromotionCallback);
	}
	
	/**
	 * Sets the promotion callback
	 * @param liPromotionCallback
	 * @param shouldCheck - indicate whether after setting the callback to check for pending promotions
	 */
	public static void setPromoCallbackAndCheckForAvailablePromotions(LiPromotionCallback liPromotionCallback, boolean shouldCheck)
	{
		LiEventManager.setPromoCallbackAndCheckForAvailablePromotions(liPromotionCallback,shouldCheck);
	}
	
	/**
	 * 
	 * @return the available promotions
	 */
	public static List<Promotion> getAvailablePromotions()
	{
		return LiPromoManager.getAvailablePromotions();
	}
	
	/**
	 * 
	 * @return the available promotions
	 * @throws LiErrorHandler 
	 */
	public static void refreshPromotions(LiCallbackGetPromotion liCallBackGetPromotion) throws LiErrorHandler
	{
		LiPromoManager.getPromotions(liCallBackGetPromotion);
	}
	
	
	
}
