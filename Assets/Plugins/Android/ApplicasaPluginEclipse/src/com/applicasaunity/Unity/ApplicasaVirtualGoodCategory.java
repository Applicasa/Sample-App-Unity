//
// VirtualGoodCategory.java
// Created by Applicasa 
// 5/13/2013
//

package com.applicasaunity.Unity;

import java.util.Arrays;
import java.util.List;

import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualGoodCategoryGetArrayCallback;
import com.applicasa.ApplicasaManager.LiManager.LiObject;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategory;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategoryData.LiFieldVirtualGoodCategory;



import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiCallback.LiCallbackAction;
import com.applicasa.ApplicasaManager.LiCallbackQuery.LiVirtualGoodCategoryGetByIDCallback;

import applicasa.LiCore.communication.LiQuery;
import applicasa.LiCore.communication.LiRequestConst.QueryKind;
import applicasa.LiCore.communication.LiRequestConst.RequestAction;

public class ApplicasaVirtualGoodCategory {

	static {
		System.loadLibrary("Applicasa");
	}
	
		
	

public static String ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryID(Object virtualGoodCategory)
{
	return ((VirtualGoodCategory)virtualGoodCategory).VirtualGoodCategoryID;
}
public static void ApplicasaVirtualGoodCategorySetVirtualGoodCategoryID(Object virtualGoodCategory, String virtualGoodCategoryID)
	{
	((VirtualGoodCategory)virtualGoodCategory).VirtualGoodCategoryID = virtualGoodCategoryID;
}
public static String ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryName(Object virtualGoodCategory)
{
	return ((VirtualGoodCategory)virtualGoodCategory).VirtualGoodCategoryName;
}
public static void ApplicasaVirtualGoodCategorySetVirtualGoodCategoryName(Object virtualGoodCategory, String virtualGoodCategoryName)
	{
	((VirtualGoodCategory)virtualGoodCategory).VirtualGoodCategoryName = virtualGoodCategoryName;
}
public static double ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryLastUpdate(Object virtualGoodCategory)
{
	return ((VirtualGoodCategory)virtualGoodCategory).VirtualGoodCategoryLastUpdate.getTimeInMillis();
}
public static int ApplicasaVirtualGoodCategoryGetVirtualGoodCategoryPos(Object virtualGoodCategory)
{
return ((VirtualGoodCategory)virtualGoodCategory).VirtualGoodCategoryPos;
}


	
	
	
	public static void ApplicasaVirtualGoodCategorySaveWithBlock(Object Ptr, final int uniqueActionID) {
		((VirtualGoodCategory)Ptr).save(new LiCallbackAction() {
			
			@Override
			public void onFailure(LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", RequestAction.NONE.ordinal());
			}
			
			@Override
			public void onComplete(ApplicasaResponse applicasaResponse, String message,
					RequestAction action, String itemID, LiObject arg4) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), itemID, action.ordinal());
			}
		});
	}

	public static void ApplicasaVirtualGoodCategoryIncreaseFieldInt(Object Ptr, int fieldInt, String fieldStr, int val) {
		try {
			((VirtualGoodCategory)Ptr).increment((LiFieldVirtualGoodCategory)ApplicasaCore.getField(fieldInt,fieldStr), val);
		} catch (LiErrorHandler e) {

			e.printStackTrace();
		}
	}
	
	public static void ApplicasaVirtualGoodCategoryIncreaseFieldFloat(Object Ptr, int fieldInt, String fieldStr, float val) {
		try {
			((VirtualGoodCategory)Ptr).increment((LiFieldVirtualGoodCategory)ApplicasaCore.getField(fieldInt,fieldStr), val);
		} catch (LiErrorHandler e) {

			e.printStackTrace();
		}
	}
	
	public static void ApplicasaVirtualGoodCategoryDeleteWithBlock(Object Ptr, final int uniqueActionID) {
		((VirtualGoodCategory)Ptr).delete(new LiCallbackAction() {
			
			@Override
			public void onFailure(LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", RequestAction.NONE.ordinal());
			}
			
			@Override
			public void onComplete(ApplicasaResponse applicasaResponse, String message,
					RequestAction action, String itemID, LiObject arg4) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), itemID, action.ordinal());
			}
		});
	}
	
	public static void ApplicasaVirtualGoodCategoryUploadFile(Object Ptr, int fieldInt, String fieldStr, final int uniqueActionID) {
		//
		((VirtualGoodCategory)Ptr).updloadFile((LiFieldVirtualGoodCategory)ApplicasaCore.getField(fieldInt,fieldStr), "", new LiCallbackAction() {
			
			@Override
			public void onFailure(LiErrorHandler error) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), "", RequestAction.NONE.ordinal());
			}
			
			@Override
			public void onComplete(ApplicasaResponse applicasaResponse, String message,
					RequestAction action, String itemID, LiObject arg4) {
				ApplicasaCore.responseCallbackAction(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), itemID, action.ordinal());
			}
		});
	}
	
	public static void ApplicasaVirtualGoodCategoryGetById(String id, int queryKind, final int uniqueActionID) {
		VirtualGoodCategory.getByID(id, QueryKind.values()[queryKind], new LiVirtualGoodCategoryGetByIDCallback() {
			
			@Override
			public void onGetVirtualGoodCategoryFailure(LiErrorHandler error) {	
				ApplicasaCore.responseCallbackGetObjectFinished(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), null);
			}
			
			@Override
			public void onGetVirtualGoodCategoryComplete(VirtualGoodCategory items) {
				ApplicasaCore.responseCallbackGetObjectFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items);
			}
		});
	}
	
	public static void ApplicasaVirtualGoodCategoryGetArrayWithQuery(Object query, int queryKind, final int uniqueActionID) {
		VirtualGoodCategory.getArrayWithQuery((LiQuery)query, QueryKind.values()[queryKind], new LiVirtualGoodCategoryGetArrayCallback() {
			
			@Override
			public void onGetVirtualGoodCategoryFailure(LiErrorHandler error) {
				ApplicasaCore.responseCallbackObjectArrayFinished(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
			}
			
			@Override
			public void onGetVirtualGoodCategoryComplete(List<VirtualGoodCategory> items) {
				Object[] itemsArray =new Object[items.size()];
				items.toArray(itemsArray);
			    List<Object> listOfObjects = Arrays.asList(itemsArray);
			    ApplicasaCore.responseCallbackObjectArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), listOfObjects);
				}
		});
	}


	public static void ApplicasaVirtualGoodCategoryGetLocalArrayWithRawSqlQuery(String whereClause, final int uniqueActionID) {
		VirtualGoodCategory.getLocalyWithRawSQLQuery(whereClause, null, new LiVirtualGoodCategoryGetArrayCallback() {   
		@Override
		public void onGetVirtualGoodCategoryFailure(LiErrorHandler error) {
			ApplicasaCore.responseCallbackObjectArrayFinished(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
	   }
		   
		@Override
		public void onGetVirtualGoodCategoryComplete(List<VirtualGoodCategory> items) {
			Object[] itemsArray =new Object[items.size()];
			items.toArray(itemsArray);
			   List<Object> listOfObjects = Arrays.asList(itemsArray);
			   ApplicasaCore.responseCallbackObjectArrayFinished(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), items.size(), listOfObjects);
			}
		});
 }
	
	public static List<VirtualGoodCategory> ApplicasaVirtualGoodCategoryGetArrayWithQuerySync(Object query, int queryKind) {
		try {
			return VirtualGoodCategory.getArrayWithQuery((LiQuery)query, QueryKind.values()[queryKind]);
			} catch (LiErrorHandler e) {
				e.printStackTrace();
				return null;
			}
	}

		
}

