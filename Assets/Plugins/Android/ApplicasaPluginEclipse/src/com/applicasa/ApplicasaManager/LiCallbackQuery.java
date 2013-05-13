package com.applicasa.ApplicasaManager;

import java.util.List;
import applicasa.LiCore.LiErrorHandler;
import org.apache.http.NameValuePair;
import com.applicasa.User.User;
import com.applicasa.VirtualCurrency.VirtualCurrency;
import com.applicasa.VirtualGood.VirtualGood;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;
public class LiCallbackQuery {
	// User Get By Id Callback
	public static interface LiUserGetByIDCallback {
	
		public void onGetUserComplete(User items);
		public void onGetUserFailure(LiErrorHandler error);
	}

	// User GetArray Callback
		public static interface LiUserGetArrayCallback {

		public void onGetUserComplete(List<User> items);
		public void onGetUserFailure(LiErrorHandler error);
	}
	// VirtualCurrency Get By Id Callback
	public static interface LiVirtualCurrencyGetByIDCallback {
	
		public void onGetVirtualCurrencyComplete(VirtualCurrency items);
		public void onGetVirtualCurrencyFailure(LiErrorHandler error);
	}

	// VirtualCurrency GetArray Callback
		public static interface LiVirtualCurrencyGetArrayCallback {

		public void onGetVirtualCurrencyComplete(List<VirtualCurrency> items);
		public void onGetVirtualCurrencyFailure(LiErrorHandler error);
	}
	// VirtualGood Get By Id Callback
	public static interface LiVirtualGoodGetByIDCallback {
	
		public void onGetVirtualGoodComplete(VirtualGood items);
		public void onGetVirtualGoodFailure(LiErrorHandler error);
	}

	// VirtualGood GetArray Callback
		public static interface LiVirtualGoodGetArrayCallback {

		public void onGetVirtualGoodComplete(List<VirtualGood> items);
		public void onGetVirtualGoodFailure(LiErrorHandler error);
	}
	// VirtualGoodCategory Get By Id Callback
	public static interface LiVirtualGoodCategoryGetByIDCallback {
	
		public void onGetVirtualGoodCategoryComplete(VirtualGoodCategory items);
		public void onGetVirtualGoodCategoryFailure(LiErrorHandler error);
	}

	// VirtualGoodCategory GetArray Callback
		public static interface LiVirtualGoodCategoryGetArrayCallback {

		public void onGetVirtualGoodCategoryComplete(List<VirtualGoodCategory> items);
		public void onGetVirtualGoodCategoryFailure(LiErrorHandler error);
	}
}
