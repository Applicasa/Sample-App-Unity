package com.applicasa.ApplicasaManager;

import java.io.IOException;
import java.io.InputStream;

import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.LiFileCacher;
import applicasa.LiCore.LiLogger;
import applicasa.LiCore.communication.LiCallback.LiCallbackGetCachedFile;
import applicasa.LiCore.promotion.sessions.LiEventManager.Actionkind;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback.LiPromotionAction;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback.LiPromotionResult;
import applicasa.LiCore.promotion.sessions.LiPromotionCallback.LiPromotionResultCallback;
import applicasa.LiJson.LiJSONException;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.IAP.LiIapAction;
import applicasa.kit.IAP.Callbacks.LiCallbackIAPPurchase;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualCurrencyRequest;
import applicasa.kit.IAP.Callbacks.LiCallbackVirtualGoodRequest;
import applicasa.kit.IAP.Data.VirtualItem;

import com.applicasa.Chartboost.LiChartboostManager;
import com.applicasa.Promotion.Promotion;
import com.applicasa.User.User;
import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.applicasa.VirtualGood.VirtualGood;



public class LiSinglePromoDialog extends Dialog   {
	
	private static final String TAG = "LiSinglePromoDialog";
	Activity mActivity;
	Context mContext;
	private ImageView mExitButton;
	
	private Promotion mSinglePromo;
	
	FrameLayout mFrameLayout;
	RelativeLayout mRelativeLayout; 
	ProgressBar mProgressBar;
	ImageButton mImageButton;
	RelativeLayout.LayoutParams rl;
	LiPromotionResultCallback mLiPromotionResultCallback;
	
	
	protected boolean isBackgroundAvailable = false;
	protected boolean isButtonAvailable = false;
	protected LiPromotionResult liPromotionResult;
	
    public LiSinglePromoDialog(final Activity activity, Promotion singlePromo, LiPromotionResultCallback liPromotionResultCallback) {
        super(activity, android.R.style.Theme_Translucent_NoTitleBar);
        mActivity = activity;
        mSinglePromo = singlePromo;
        mLiPromotionResultCallback = liPromotionResultCallback;
    }

    /**
     * Loads all Promotion Data
     */
    public void loadPromotion() {
    	
    	switch (mSinglePromo.PromotionActionKind)
    	{
    	case CHARTBOOST:
    		if (LiConfig.isChartboostEnabled())
				LiChartboostManager.getInstance().show(mActivity,mSinglePromo);
			else
				LiLogger.logError(TAG, "Cant display Chartboost Without Chartboosts SDK");
    		break;
    	case TRIAL_PAY:
    		buildTrialPayPromotion();
    		break;
    		
    	default:
    		buildRegularPromotion();
		break;
    	}
	}
    
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
		            WindowManager.LayoutParams.FLAG_FULLSCREEN);
	}
    
    /**
     * Generate the Promotion layouts
     */
    private void createPromoLayout() {
    	/**
		 * The base Layout 
		 */
		mFrameLayout = new FrameLayout(getContext());
		FrameLayout.LayoutParams fp = new FrameLayout.LayoutParams(
				FrameLayout.LayoutParams.MATCH_PARENT,
				FrameLayout.LayoutParams.MATCH_PARENT);
		
		// Set's the padding of the Promo
		DisplayMetrics displaymetrics = new DisplayMetrics();
		mActivity.getWindowManager().getDefaultDisplay().getMetrics(displaymetrics);
		int height = displaymetrics.heightPixels;
		int width = displaymetrics.widthPixels;
		
		mFrameLayout.setPadding(width/18, height/18, width/18, height/18);
		addContentView(mFrameLayout, fp);
		
		
		/**
		 * Sets the layout of the promo - this layout's bg is the promo image
		 */
		
		mRelativeLayout = new RelativeLayout(getContext());
		rl = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.MATCH_PARENT,
				RelativeLayout.LayoutParams.MATCH_PARENT);
		mRelativeLayout.setBackgroundColor(000000);
	}

    /**
     * Generate the Action Button and adds to View
     */
	private void createActionButton() {
    	mImageButton = new ImageButton(getContext());
		mImageButton.setAdjustViewBounds(true);
		RelativeLayout.LayoutParams btn_rl = new RelativeLayout.LayoutParams(
				RelativeLayout.LayoutParams.WRAP_CONTENT,
				RelativeLayout.LayoutParams.WRAP_CONTENT);
		btn_rl.addRule(RelativeLayout.CENTER_HORIZONTAL);
		btn_rl.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
		mImageButton.setScaleType(ScaleType.FIT_CENTER);
		mImageButton.setAdjustViewBounds(true);
		mImageButton.setPadding(0, 0, 0, pxFromDp(40));
		mImageButton.setBackgroundColor(00000000);
		mImageButton.setOnClickListener(clickHandler);
		mRelativeLayout.addView(mImageButton,btn_rl);
	}

	/**
	 * Generate the Exit Button and adds to View
	 */
	private void createExitImage() {
		mExitButton = new ImageView(getContext());
		try { 
			AssetManager mngr = mActivity.getAssets();
			// Create an input stream to read from the asset folder
            InputStream ins = mngr.open("x_btn.png");
            // Convert the input stream into a bitmap
            Bitmap bitmap= BitmapFactory.decodeStream(ins);
            mExitButton.setImageBitmap(bitmap);
            mExitButton.setClickable(true);
            
		} catch ( IOException e) {
			LiLogger.logError(LiSinglePromoDialog.class.getSimpleName(), "Failed Creating x_btn.png " +e.getMessage());
		}
		
		 mRelativeLayout.addView(mExitButton);
		 
		 mExitButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
        		// updates analytics that the Promo was only viewed
            	handleExit();
            }
        });
       
    }
	
	

	/**
	 * Loads material asynchronously
	 */
    private void LoadRegularPromo() {
    	
		LiLogger.logInfo("**** PromoAvailable ****", "Promo Type "+mSinglePromo.PromotionAppEvent.toString()+" "+mSinglePromo.PromotionAppEvent.getId());
		
		// Load Materials
		LiFileCacher.getBitmapFromCache(mSinglePromo.PromotionImage, new LiCallbackGetCachedFile() {
			
			public void onSuccessfull(InputStream is) {
			}
			
			public void onFailure(LiErrorHandler error) {
				LiLogger.logError("Promo Adapter", "Source not found");
				dismiss();
			}

			public void onSuccessfullBitmap(Bitmap bitmap) {
				Drawable dr = new BitmapDrawable(bitmap);
				mRelativeLayout.setBackgroundDrawable(dr);
				// indicates bg is ready
				isBackgroundAvailable  = true;
				showPromo();
			}
		});
		LiFileCacher.getBitmapFromCache(mSinglePromo.PromotionButton, new LiCallbackGetCachedFile() {
			
			public void onSuccessfull(InputStream is) {
			}
			
			public void onFailure(LiErrorHandler error) {
				LiLogger.logError("Promo Adapter", "Source not found");
				dismiss();
			}

			public void onSuccessfullBitmap(Bitmap bitmap) {
				LiLogger.logInfo("Promo Adapter", "Source found");
				mImageButton.setImageBitmap(bitmap);
				mImageButton.setVisibility(View.VISIBLE);
				mImageButton.setClickable(true);

				// indicate Button is ready
				isButtonAvailable = true;
				showPromo();
			}
		});
	}
    
    /**
	 * Loads material asynchronously
	 */
    private void LoadTrialPayPromo() {
    	
		LiLogger.logDebug("**** PromoAvailable ****", "Promo Type "+mSinglePromo.PromotionAppEvent.toString()+" "+mSinglePromo.PromotionAppEvent.getId());
		
			WebView wv = new WebView(mActivity);
			 StringBuilder link = new StringBuilder();
			 try {
				  if (mSinglePromo.PromotionActionData.has("link"))
				  {	  //  promotion structure
					  link.append(mSinglePromo.PromotionActionData.getString("link"));
				  }
			  } catch (LiJSONException e) {
					// TODO Auto-generated catch block
					LiLogger.logError(TAG, "TrialPay: No link available", e);
				}
				
			  if (link != null && link.length() != 0)
			  {
				  String userId = User.getCurrentUser().UserID;
				  link.append("sid="+userId+"&Promotion="+mSinglePromo.PromotionID);
				  RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
		                    RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
				  mRelativeLayout.setLayoutParams(params);
				  mRelativeLayout.addView(wv);
				  wv.getSettings().setJavaScriptEnabled(true);
				  wv.setWebViewClient(new WebViewClient(){
					  public void onPageFinished(WebView view, String url)
					  {
						 /**
						 * Create the Exit Image
						 */
						createExitImage();
						mProgressBar.setVisibility(View.INVISIBLE);
						mRelativeLayout.removeView(mProgressBar);
						showPromo();
						
					  }
				  });
				  wv.loadUrl(link.toString());
				 
				 
				
			  }
	}

    /**
     * When material are available 
     * removes the spinner and add the promotion View
     */
	protected void showPromo() {
		if ((isBackgroundAvailable && isButtonAvailable) || mSinglePromo.PromotionActionKind == Actionkind.TRIAL_PAY)
		{
			 mFrameLayout.addView(mRelativeLayout, rl);
			 show();
		}
	}

	
	/**
	 * 
	 * 		Display Promotion Builders
	 * 
	 * 
	 */
	
	private void buildRegularPromotion()
	{
		/**
		 * Call to create the layouts
		 */
		createPromoLayout();
		
		/**
		 * Sets the Promos Button
		 */
		createActionButton();
		
		/**
		 * Create the Exit Image
		 */
		createExitImage();
		
		/**
		 * Loads the promotion materials
		 */
		LoadRegularPromo();
	}
	
	
	private void buildTrialPayPromotion()
	{
		/**
		 * Call to create the layouts
		 */
		createPromoLayout();
		
		/**
		 *  add Spinner
		 */
		addSpinner();
		
		/**
		 * Loads the promotion Url and open the webView
		 */
		LoadTrialPayPromo();
		
	}
	
	android.view.View.OnClickListener clickHandler = new android.view.View.OnClickListener() {
		
		public void onClick(View v) {
		try {
			  boolean result = true;
			  mSinglePromo.updateViewUseCount( 1, 1);
			  switch (mSinglePromo.PromotionActionKind)
			  {
				  case NULL:
					  break;
				  case NOTHING:
					  if (mLiPromotionResultCallback != null)
		                 	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Succeded, LiPromotionResult.PromotionResultNothing, null);
					  
					  dismiss();
					  
					  break;
				  case LINK:
					  String link = null;
					  if (mSinglePromo.PromotionActionData.has("link_Android"))
					  {   // Open android link
						  link = mSinglePromo.PromotionActionData.getString("link_Android");
					  }
					  else if (mSinglePromo.PromotionActionData.has("link_iOS"))
					  {	  // case no Android link return iOS link 
						  link = mSinglePromo.PromotionActionData.getString("link_iOS");
					  }
					  else if (mSinglePromo.PromotionActionData.has("link"))
					  {	  // old promotion structure
						  link = mSinglePromo.PromotionActionData.getString("link");
					  }
						
					  if (link != null)
					  {
						  if (!link.startsWith("http://") && !link.startsWith("https://") )
							  	link = "http://"+link;
						  
						  Intent webIntent  = new Intent(Intent.ACTION_VIEW, Uri.parse(link));
						  
						  mActivity.startActivity(webIntent);
					  }
						 
						  if (mLiPromotionResultCallback != null)
			                 	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Succeded, LiPromotionResult.PromotionResultLinkOpened, link);
						  
						 dismiss();
					  break;
				  case STRING:
					  // The promotion text is retrieved 
					  String text = null;
					  if (mSinglePromo.PromotionActionData.has("string_Android"))
					  {   // return Android String
						  text = mSinglePromo.PromotionActionData.getString("string_Android");
					  }
					  else if (mSinglePromo.PromotionActionData.has("string_iOS"))
					  {	  // case no Android String return iOS String as default
						  text = mSinglePromo.PromotionActionData.getString("string_iOS");
					  }
					  else if (mSinglePromo.PromotionActionData.has("string"))
					  {	  // Old structure
						  text = mSinglePromo.PromotionActionData.getString("string");
					  }

					  if (mLiPromotionResultCallback != null)
		                 	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Succeded, LiPromotionResult.PromotionResultStringInfo, text);
					  
					  dismiss();
					  
					  break;
				  case GIVE_VC:
					  int amount = mSinglePromo.PromotionActionData.getInt("amount");
					  int vcKind = mSinglePromo.PromotionActionData.getInt("virtualCurrencyKind");
					  liPromotionResult = (LiCurrency.values()[vcKind] == LiCurrency.MainCurrency)? LiPromotionResult.PromotionResultGiveMainCurrencyVirtualCurrency:LiPromotionResult.PromotionResultGiveSeconedaryCurrencyVirtualCurrency;
					  LiStore.giveVirtualCurrency(amount, LiCurrency.values()[vcKind], virualCurrencyCallback);
					 					  
					  break;
				  case GIVE_VG:
					  String id= mSinglePromo.PromotionActionData.getString("_id");
					  VirtualGood item = LiStore.getVirtualGoodById(id);
					  liPromotionResult = LiPromotionResult.PromotionResultGiveVirtualGood;
					  LiStore.giveVirtualGoods(item, 1 ,virtualGoodCallback );
					 
					  break;
				  case DEAL_VC:
					   id= mSinglePromo.PromotionActionData.getString("_id");
					   VirtualCurrency itemVC = LiStore.getVirtualCurrencyDealById(id);
					   liPromotionResult = (itemVC.VirtualCurrencyKind==LiCurrency.MainCurrency)?LiPromotionResult.PromotionResultDealMainVirtualCurrency:
	                 		LiPromotionResult.PromotionResultDealSeconedaryVirtualCurrency;
					   result = LiStore.buyVirtualCurrency(mActivity, itemVC, virtualCurrencyPurchaseCallback );
					   
					   
					  break;
				  case DEAL_VG:
					   id= mSinglePromo.PromotionActionData.getString("_id");
					   item = LiStore.getVirtualGoodDealById(id);
					   liPromotionResult = LiPromotionResult.PromotionResultDealVirtualGood;
					   if (item.VirtualGoodIsStoreItem)
						   result = LiStore.buyVirtualGoods(mActivity, item, virtualCurrencyPurchaseCallback);
					   else
						   result = LiStore.buyVirtualGoods(item, 1, (item.VirtualGoodMainCurrency!=0) ? LiCurrency.MainCurrency:LiCurrency.SencondaryCurrency, virtualGoodCallback );
					  break;
				  }
			  
			} catch (LiJSONException e) {
				LiLogger.logError(LiSinglePromoDialog.class.getSimpleName(), "Failed generating Promotion action "+e.getMessage());
			}
		  
		}
	};
	
	/**
	 * Handles Back key event 
	 * Closes the dialog and update View analytics
	 */
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
	    if ((keyCode == KeyEvent.KEYCODE_BACK)) {
	        Log.d(this.getClass().getName(), "back button pressed");
	        handleExit();
	    }
	    return super.onKeyDown(keyCode, event);
	}
	
	/**
	 * Handles Exist
	 * whether when pressing back button or the exit button
	 */
	protected void handleExit() {
		mSinglePromo.updateViewUseCount(1, 0);
    	 if (mLiPromotionResultCallback != null)
         	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Cancelled, LiPromotionResult.PromotionResultNothing, null);
    	 
        LiSinglePromoDialog.this.dismiss();
	}
	

	/**
	 * Convert from dp to pixel
	 * @param dp
	 * @return
	 */
    private int pxFromDp(float dp)
    {
        return (int) (dp * this.getContext().getResources().getDisplayMetrics().density);
    }
    
    
    LiCallbackVirtualGoodRequest virtualGoodCallback = new LiCallbackVirtualGoodRequest() {
		
		@Override
		public void onActionFinisedSuccessfully(LiIapAction liIapAction,
				VirtualGood item) {
			// TODO Auto-generated method stub
			if (mLiPromotionResultCallback != null)
             	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Succeded, liPromotionResult, item);
			
			 dismiss();
		}
		
		@Override
		public void onActionFailed(LiIapAction liIapAction, VirtualGood item,
				LiErrorHandler errors) {
			// TODO Auto-generated method stub
			if (mLiPromotionResultCallback != null)
             	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Failed, liPromotionResult, item);
			
			 dismiss();
		}
	};
	
	LiCallbackVirtualCurrencyRequest virualCurrencyCallback = new LiCallbackVirtualCurrencyRequest() {
		
		@Override
		public void onActionFinisedSuccessfully(LiIapAction liIapAction, int coins,
				LiCurrency licurrency) {
			// TODO Auto-generated method stub
			if (mLiPromotionResultCallback != null)
             	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Succeded,liPromotionResult, coins);
			
			 dismiss();
		}
		
		@Override
		public void onActionFailed(LiIapAction liIapAction, int coins,
				LiCurrency licurrency, LiErrorHandler errors) {
			// TODO Auto-generated method stub
			if (mLiPromotionResultCallback != null)
             	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Failed,liPromotionResult, coins);
			
			 dismiss();
		}
	};
	
	LiCallbackIAPPurchase virtualCurrencyPurchaseCallback = new LiCallbackIAPPurchase() {
		
		@Override
		public void onActionFinisedSuccessfully(LiIapAction liIapAction,
				VirtualItem item) {
			// TODO Auto-generated method stub
			if (mLiPromotionResultCallback != null)
             	mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Succeded,liPromotionResult, (item.vcItem != null)?item.vcItem:item.vgItem);
			
			 dismiss();
		}
		
		@Override
		public void onActionFailed(LiIapAction liIapAction, VirtualItem item,
				LiErrorHandler errors) {
			// TODO Auto-generated method stub
			if (mLiPromotionResultCallback != null)
			{
				if  (errors.errorType == ApplicasaResponse.PURCHASED_CANCELED)
					mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Cancelled,liPromotionResult, (item.vcItem != null)?item.vcItem:item.vgItem);
				else
					mLiPromotionResultCallback.onPromotionResultCallback(LiPromotionAction.Failed,liPromotionResult, (item.vcItem != null)?item.vcItem:item.vgItem);
			}
			
			 dismiss();
		}
	};
	
	
	private void addSpinner() {
		// TODO Auto-generated method stub
		mProgressBar = new ProgressBar(mActivity);
		mProgressBar.setClickable(false);
		mProgressBar.setVisibility(View.VISIBLE);
		mRelativeLayout.addView(mProgressBar);
	}
}
