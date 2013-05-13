package com.applicasaunity.Unity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;
import applicasa.kit.IAP.IAP.LiIapAction;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPPurchase;
import applicasa.kit.IAP.Data.VirtualItem;

import com.applicasa.ApplicasaManager.LiStore;
import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.applicasa.VirtualGood.VirtualGood;

public class InAppActivity extends Activity {
	
    public static int uniqueActionID;
    public static VirtualCurrency virtualCurrency;
    public static VirtualGood virtualGood;
    
    public static boolean isVC;
    
    private int CallBackuniqueActionID;
    private boolean success;
    private String errorMessage;
    private int errorType;
    private String itemID;
    private int CallBackaction;
    
    static {
        System.loadLibrary("Applicasa");
    }
    
    
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if(uniqueActionID==0)
        {
            finish();
            return;
        }
        //LiStore.buyVirtualCurrency(this, virtualCurrency,
        
        LiCallbackIAPPurchase IAPPurchaseCallback=new LiCallbackIAPPurchase() {
            
            @Override
            public void onActionFinisedSuccessfully(LiIapAction action,
                                                    VirtualItem item ) {
                CallBackuniqueActionID=uniqueActionID;
                success=true;
                errorMessage="Success";
                errorType=ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL);
                itemID=(item.vcItem==null) ? item.vgItem.VirtualGoodID:item.vcItem.VirtualCurrencyID;
                CallBackaction=action.ordinal();
                InAppActivity.this.finish();
            }
			
            @Override
            public void onActionFailed(LiIapAction action, VirtualItem item,
                                       LiErrorHandler error) {
                CallBackuniqueActionID=uniqueActionID;
                success=false;
                errorMessage=error.errorMessage;
                errorType=ApplicasaResponse.toInt(error.errorType);
                itemID=(item.vcItem==null) ? item.vgItem.VirtualGoodID:item.vcItem.VirtualCurrencyID;
                CallBackaction=RequestAction.NONE.ordinal();
                InAppActivity.this.finish();
            }
        };
        
        if(isVC)
        {
            LiStore.buyVirtualCurrency(this, virtualCurrency, IAPPurchaseCallback);
        }else{
            LiStore.buyVirtualGoods(this, virtualGood, IAPPurchaseCallback);
        }
    }
	
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (LiStore.IAB_REQUEST == requestCode )
        {
            LiStore.onActivityResult(requestCode, resultCode, data);
        }
		else
		{
			CallBackuniqueActionID=uniqueActionID;
			success=false;
			errorMessage="Closed";
			errorType=1;
			itemID="";
			CallBackaction=RequestAction.NONE.ordinal();
			finish();
		}
    }
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        if(uniqueActionID==0)
        {
            finish();
            return;
        }
        ApplicasaCore.responseCallbackAction(CallBackuniqueActionID, success, errorMessage, errorType, itemID, CallBackaction);
    }
    
}
