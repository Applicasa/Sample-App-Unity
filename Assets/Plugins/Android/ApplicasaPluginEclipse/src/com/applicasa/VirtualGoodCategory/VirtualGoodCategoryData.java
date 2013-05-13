package com.applicasa.VirtualGoodCategory;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import applicasa.LiCore.LiLocation;
import applicasa.LiCore.LiField;
import applicasa.LiJson.LiJSONObject;

public class VirtualGoodCategoryData {


	protected static Map<String, LiFieldVirtualGoodCategory> stringMap = new HashMap<String, LiFieldVirtualGoodCategory>();
	LiJSONObject incrementedFields = new LiJSONObject();
	public static boolean EnableOffline = true;
	public enum LiFieldVirtualGoodCategory implements LiField
	{
		VirtualGoodCategory_None
	, VirtualGoodCategoryID
	, VirtualGoodCategoryName
	, VirtualGoodCategoryLastUpdate
	, VirtualGoodCategoryPos

	;

		private LiFieldVirtualGoodCategory() {
			stringMap.put(this.toString(), this);
		}

		public static LiFieldVirtualGoodCategory getLiFieldVirtualGoodCategory(String key) {
			return stringMap.get(key);
	}
	}

	protected static Map<String, Object > virtualGoodCategoryCallbacks = new HashMap<String, Object>();
	//Class Name 
	public final static String kClassName                =  "VirtualGoodCategory";
	
	////
	//// Class fields name - Static Fields
	////
	////
	////
		public String VirtualGoodCategoryID;
	
		public String VirtualGoodCategoryName;
	
		public GregorianCalendar VirtualGoodCategoryLastUpdate;
	
		public int VirtualGoodCategoryPos;
	
	
		public String getVirtualGoodCategoryID() {
			return VirtualGoodCategoryID;
		}
		
		public void setVirtualGoodCategoryID(String VirtualGoodCategoryID) {
			this.VirtualGoodCategoryID = VirtualGoodCategoryID;
		}
		
		public String getVirtualGoodCategoryName() {
			return VirtualGoodCategoryName;
		}
		
		public void setVirtualGoodCategoryName(String VirtualGoodCategoryName) {
			this.VirtualGoodCategoryName = VirtualGoodCategoryName;
		}
		
		public GregorianCalendar getVirtualGoodCategoryLastUpdate() {
			return VirtualGoodCategoryLastUpdate;
		}
		
		public void setVirtualGoodCategoryLastUpdate(GregorianCalendar VirtualGoodCategoryLastUpdate) {
			this.VirtualGoodCategoryLastUpdate = VirtualGoodCategoryLastUpdate;
		}
		
		public int getVirtualGoodCategoryPos() {
			return VirtualGoodCategoryPos;
		}
		
		public void setVirtualGoodCategoryPos(int VirtualGoodCategoryPos) {
			this.VirtualGoodCategoryPos = VirtualGoodCategoryPos;
		}
		
		public static String getVirtualGoodCategorySortField(VirtualGoodCategoryData.LiFieldVirtualGoodCategory field)
		{
			return field.toString();
		}
	public Object getVirtualGoodCategoryFieldbySortType(VirtualGoodCategoryData.LiFieldVirtualGoodCategory field)
	{
		switch (field){
			case VirtualGoodCategory_None:
				return VirtualGoodCategoryID;
				
			case VirtualGoodCategoryID:
				return VirtualGoodCategoryID;
				
			case VirtualGoodCategoryName:
				return VirtualGoodCategoryName;
				
			case VirtualGoodCategoryLastUpdate:
				return VirtualGoodCategoryLastUpdate;
				
			case VirtualGoodCategoryPos:
				return VirtualGoodCategoryPos;
				
			default:
				return "";
		}
		
	}
	
	protected boolean setVirtualGoodCategoryFieldbySortType(VirtualGoodCategoryData.LiFieldVirtualGoodCategory field, Object value)
	{
		switch (field){
			case VirtualGoodCategory_None:
				break;
				
			case VirtualGoodCategoryID:
					VirtualGoodCategoryID = (String)value;
					break;
					
			case VirtualGoodCategoryName:
					VirtualGoodCategoryName = (String)value;
					break;
					
			case VirtualGoodCategoryLastUpdate:
					VirtualGoodCategoryLastUpdate = (GregorianCalendar)value;
					break;
				
			case VirtualGoodCategoryPos:
					VirtualGoodCategoryPos = (Integer)value;
					break;
					
			default:
				break;
		}
		return true;
	}
}
