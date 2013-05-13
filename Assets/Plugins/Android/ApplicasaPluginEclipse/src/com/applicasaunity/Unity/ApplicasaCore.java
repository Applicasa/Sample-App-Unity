package com.applicasaunity.Unity;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.List;

import com.applicasa.User.UserData.LiFieldUser;
import com.applicasa.VirtualCurrency.VirtualCurrencyData.LiFieldVirtualCurrency;
import com.applicasa.VirtualGood.VirtualGoodData.LiFieldVirtualGood;
import com.applicasa.VirtualGoodCategory.VirtualGoodCategoryData.LiFieldVirtualGoodCategory;


import applicasa.LiCore.LiField;


public class ApplicasaCore  {
	
    static {
        System.loadLibrary("Applicasa");
    } 
	
    public static native void responseCallbackAction(int uniqueActionID, boolean success, String errorMessage, int errorType, String itemID, int action);
    
	public static native void responseCallbackObjectArrayFinished(
			int uniqueGetVirtualGoodArrayFinishedID, boolean success,
			String errorMessage, int errorType,
			int listSize, List<Object> ObjectArrayPtr);
	
	public static native void responseCallbackGetObjectFinished(
			int uniqueGetUserFinishedID, boolean success, String errorMessage,
			int errorType, Object ObjectPtr);
    
    public static byte[] serializeByte(Object obj) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ObjectOutputStream os;
		try {
			os = new ObjectOutputStream(out);
			os.writeObject(obj);
		} catch (IOException e) {
			e.printStackTrace();
		}
        return out.toByteArray();
    }
    
	public static LiField getField(int fieldInt, String fieldStr) {
	LiField tempField = null;
	if(1 <= fieldInt && fieldInt <= 18){
		tempField=LiFieldUser.getLiFieldUser(fieldStr);
	}
	if(19 <= fieldInt && fieldInt <= 39){
		tempField=LiFieldVirtualCurrency.getLiFieldVirtualCurrency(fieldStr);
	}
	if(40 <= fieldInt && fieldInt <= 67){
		tempField=LiFieldVirtualGood.getLiFieldVirtualGood(fieldStr);
	}
	if(68 <= fieldInt && fieldInt <= 72){
		tempField=LiFieldVirtualGoodCategory.getLiFieldVirtualGoodCategory(fieldStr);
	}
	return tempField;
}
    

}
