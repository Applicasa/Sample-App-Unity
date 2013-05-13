package com.applicasa.VirtualCurrency;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import applicasa.LiCore.LiLocation;
import applicasa.LiCore.LiField;
import applicasa.LiJson.LiJSONObject;
import applicasa.kit.IAP.IAP.LiCurrency;
import applicasa.kit.IAP.billing.Utils.LiSkuDetails;

public class VirtualCurrencyData {


	protected static Map<String, LiFieldVirtualCurrency> stringMap = new HashMap<String, LiFieldVirtualCurrency>();
	LiJSONObject incrementedFields = new LiJSONObject();
	public static boolean EnableOffline = true;
	public enum LiFieldVirtualCurrency implements LiField
	{
		VirtualCurrency_None
	, VirtualCurrencyID
	, VirtualCurrencyTitle
	, VirtualCurrencyAppleIdentifier
	, VirtualCurrencyGoogleIdentifier
	, VirtualCurrencyDescription
	, VirtualCurrencyPrice
	, VirtualCurrencyIOSBundleMin
	, VirtualCurrencyIOSBundleMax
	, VirtualCurrencyAndroidBundleMin
	, VirtualCurrencyAndroidBundleMax
	, VirtualCurrencyPos
	, VirtualCurrencyCredit
	, VirtualCurrencyKind
	, VirtualCurrencyImageA
	, VirtualCurrencyImageB
	, VirtualCurrencyImageC
	, VirtualCurrencyIsDeal
	, VirtualCurrencyInAppleStore
	, VirtualCurrencyInGoogleStore
	, VirtualCurrencyLastUpdate

	;

		private LiFieldVirtualCurrency() {
			stringMap.put(this.toString(), this);
		}

		public static LiFieldVirtualCurrency getLiFieldVirtualCurrency(String key) {
			return stringMap.get(key);
	}
	}

	protected static Map<String, Object > virtualCurrencyCallbacks = new HashMap<String, Object>();
	//Class Name 
	public final static String kClassName                =  "VirtualCurrency";
	
	////
	//// Class fields name - Static Fields
	////
	////
	////
		public String VirtualCurrencyID;
	
		public String VirtualCurrencyTitle;
	
		public String VirtualCurrencyAppleIdentifier;
	
		public String VirtualCurrencyGoogleIdentifier;
	
		public String VirtualCurrencyDescription;
	
		public float VirtualCurrencyPrice;
	
		public float VirtualCurrencyIOSBundleMin;
	
		public float VirtualCurrencyIOSBundleMax;
	
		public float VirtualCurrencyAndroidBundleMin;
	
		public float VirtualCurrencyAndroidBundleMax;
	
		public int VirtualCurrencyPos;
	
		public int VirtualCurrencyCredit;
	
		public LiCurrency VirtualCurrencyKind;
	
		public String VirtualCurrencyImageA;
	
		public String VirtualCurrencyImageB;
	
		public String VirtualCurrencyImageC;
	
		public Boolean VirtualCurrencyIsDeal;
	
		public Boolean VirtualCurrencyInAppleStore;
	
		public Boolean VirtualCurrencyInGoogleStore;
	
		public GregorianCalendar VirtualCurrencyLastUpdate;
	
		public LiSkuDetails VirtualCurrencySkuDetail;
	
		public String getVirtualCurrencyID() {
			return VirtualCurrencyID;
		}
		
		public void setVirtualCurrencyID(String VirtualCurrencyID) {
			this.VirtualCurrencyID = VirtualCurrencyID;
		}
		
		public String getVirtualCurrencyTitle() {
			return VirtualCurrencyTitle;
		}
		
		public void setVirtualCurrencyTitle(String VirtualCurrencyTitle) {
			this.VirtualCurrencyTitle = VirtualCurrencyTitle;
		}
		
		public String getVirtualCurrencyAppleIdentifier() {
			return VirtualCurrencyAppleIdentifier;
		}
		
		public void setVirtualCurrencyAppleIdentifier(String VirtualCurrencyAppleIdentifier) {
			this.VirtualCurrencyAppleIdentifier = VirtualCurrencyAppleIdentifier;
		}
		
		public String getVirtualCurrencyGoogleIdentifier() {
			return VirtualCurrencyGoogleIdentifier;
		}
		
		public void setVirtualCurrencyGoogleIdentifier(String VirtualCurrencyGoogleIdentifier) {
			this.VirtualCurrencyGoogleIdentifier = VirtualCurrencyGoogleIdentifier;
		}
		
		public String getVirtualCurrencyDescription() {
			return VirtualCurrencyDescription;
		}
		
		public void setVirtualCurrencyDescription(String VirtualCurrencyDescription) {
			this.VirtualCurrencyDescription = VirtualCurrencyDescription;
		}
		
		public float getVirtualCurrencyPrice() {
			return VirtualCurrencyPrice;
		}
		
		public void setVirtualCurrencyPrice(float VirtualCurrencyPrice) {
			this.VirtualCurrencyPrice = VirtualCurrencyPrice;
		}
		
		public float getVirtualCurrencyIOSBundleMin() {
			return VirtualCurrencyIOSBundleMin;
		}
		
		public void setVirtualCurrencyIOSBundleMin(float VirtualCurrencyIOSBundleMin) {
			this.VirtualCurrencyIOSBundleMin = VirtualCurrencyIOSBundleMin;
		}
		
		public float getVirtualCurrencyIOSBundleMax() {
			return VirtualCurrencyIOSBundleMax;
		}
		
		public void setVirtualCurrencyIOSBundleMax(float VirtualCurrencyIOSBundleMax) {
			this.VirtualCurrencyIOSBundleMax = VirtualCurrencyIOSBundleMax;
		}
		
		public float getVirtualCurrencyAndroidBundleMin() {
			return VirtualCurrencyAndroidBundleMin;
		}
		
		public void setVirtualCurrencyAndroidBundleMin(float VirtualCurrencyAndroidBundleMin) {
			this.VirtualCurrencyAndroidBundleMin = VirtualCurrencyAndroidBundleMin;
		}
		
		public float getVirtualCurrencyAndroidBundleMax() {
			return VirtualCurrencyAndroidBundleMax;
		}
		
		public void setVirtualCurrencyAndroidBundleMax(float VirtualCurrencyAndroidBundleMax) {
			this.VirtualCurrencyAndroidBundleMax = VirtualCurrencyAndroidBundleMax;
		}
		
		public int getVirtualCurrencyPos() {
			return VirtualCurrencyPos;
		}
		
		public void setVirtualCurrencyPos(int VirtualCurrencyPos) {
			this.VirtualCurrencyPos = VirtualCurrencyPos;
		}
		
		public int getVirtualCurrencyCredit() {
			return VirtualCurrencyCredit;
		}
		
		public void setVirtualCurrencyCredit(int VirtualCurrencyCredit) {
			this.VirtualCurrencyCredit = VirtualCurrencyCredit;
		}
		
		public LiCurrency getVirtualCurrencyKind() {
			return VirtualCurrencyKind;
		}
		
		public void setVirtualCurrencyKind(LiCurrency VirtualCurrencyKind) {
			this.VirtualCurrencyKind = VirtualCurrencyKind;
		}
		
		public String getVirtualCurrencyImageA() {
			return VirtualCurrencyImageA;
		}
		
		public void setVirtualCurrencyImageA(String VirtualCurrencyImageA) {
			this.VirtualCurrencyImageA = VirtualCurrencyImageA;
		}
		
		public String getVirtualCurrencyImageB() {
			return VirtualCurrencyImageB;
		}
		
		public void setVirtualCurrencyImageB(String VirtualCurrencyImageB) {
			this.VirtualCurrencyImageB = VirtualCurrencyImageB;
		}
		
		public String getVirtualCurrencyImageC() {
			return VirtualCurrencyImageC;
		}
		
		public void setVirtualCurrencyImageC(String VirtualCurrencyImageC) {
			this.VirtualCurrencyImageC = VirtualCurrencyImageC;
		}
		
		public Boolean getVirtualCurrencyIsDeal() {
			return VirtualCurrencyIsDeal;
		}
		
		public void setVirtualCurrencyIsDeal(Boolean VirtualCurrencyIsDeal) {
			this.VirtualCurrencyIsDeal = VirtualCurrencyIsDeal;
		}
		
		public Boolean getVirtualCurrencyInAppleStore() {
			return VirtualCurrencyInAppleStore;
		}
		
		public void setVirtualCurrencyInAppleStore(Boolean VirtualCurrencyInAppleStore) {
			this.VirtualCurrencyInAppleStore = VirtualCurrencyInAppleStore;
		}
		
		public Boolean getVirtualCurrencyInGoogleStore() {
			return VirtualCurrencyInGoogleStore;
		}
		
		public void setVirtualCurrencyInGoogleStore(Boolean VirtualCurrencyInGoogleStore) {
			this.VirtualCurrencyInGoogleStore = VirtualCurrencyInGoogleStore;
		}
		
		public GregorianCalendar getVirtualCurrencyLastUpdate() {
			return VirtualCurrencyLastUpdate;
		}
		
		public void setVirtualCurrencyLastUpdate(GregorianCalendar VirtualCurrencyLastUpdate) {
			this.VirtualCurrencyLastUpdate = VirtualCurrencyLastUpdate;
		}
		
		public static String getVirtualCurrencySortField(VirtualCurrencyData.LiFieldVirtualCurrency field)
		{
			return field.toString();
		}
	public Object getVirtualCurrencyFieldbySortType(VirtualCurrencyData.LiFieldVirtualCurrency field)
	{
		switch (field){
			case VirtualCurrency_None:
				return VirtualCurrencyID;
				
			case VirtualCurrencyID:
				return VirtualCurrencyID;
				
			case VirtualCurrencyTitle:
				return VirtualCurrencyTitle;
				
			case VirtualCurrencyAppleIdentifier:
				return VirtualCurrencyAppleIdentifier;
				
			case VirtualCurrencyGoogleIdentifier:
				return VirtualCurrencyGoogleIdentifier;
				
			case VirtualCurrencyDescription:
				return VirtualCurrencyDescription;
				
			case VirtualCurrencyPrice:
				return VirtualCurrencyPrice;
				
			case VirtualCurrencyIOSBundleMin:
				return VirtualCurrencyIOSBundleMin;
				
			case VirtualCurrencyIOSBundleMax:
				return VirtualCurrencyIOSBundleMax;
				
			case VirtualCurrencyAndroidBundleMin:
				return VirtualCurrencyAndroidBundleMin;
				
			case VirtualCurrencyAndroidBundleMax:
				return VirtualCurrencyAndroidBundleMax;
				
			case VirtualCurrencyPos:
				return VirtualCurrencyPos;
				
			case VirtualCurrencyCredit:
				return VirtualCurrencyCredit;
				
			case VirtualCurrencyKind:
					return VirtualCurrencyKind;
					
			case VirtualCurrencyImageA:
				return VirtualCurrencyImageA;
				
			case VirtualCurrencyImageB:
				return VirtualCurrencyImageB;
				
			case VirtualCurrencyImageC:
				return VirtualCurrencyImageC;
				
			case VirtualCurrencyIsDeal:
					return VirtualCurrencyIsDeal;
					
			case VirtualCurrencyInAppleStore:
					return VirtualCurrencyInAppleStore;
					
			case VirtualCurrencyInGoogleStore:
					return VirtualCurrencyInGoogleStore;
					
			case VirtualCurrencyLastUpdate:
				return VirtualCurrencyLastUpdate;
				
			default:
				return "";
		}
		
	}
	
	protected boolean setVirtualCurrencyFieldbySortType(VirtualCurrencyData.LiFieldVirtualCurrency field, Object value)
	{
		switch (field){
			case VirtualCurrency_None:
				break;
				
			case VirtualCurrencyID:
					VirtualCurrencyID = (String)value;
					break;
					
			case VirtualCurrencyTitle:
					VirtualCurrencyTitle = (String)value;
					break;
					
			case VirtualCurrencyAppleIdentifier:
					VirtualCurrencyAppleIdentifier = (String)value;
					break;
					
			case VirtualCurrencyGoogleIdentifier:
					VirtualCurrencyGoogleIdentifier = (String)value;
					break;
					
			case VirtualCurrencyDescription:
					VirtualCurrencyDescription = (String)value;
					break;
					
			case VirtualCurrencyPrice:
					VirtualCurrencyPrice = (Float)value;
					break;
					
			case VirtualCurrencyIOSBundleMin:
					VirtualCurrencyIOSBundleMin = (Float)value;
					break;
					
			case VirtualCurrencyIOSBundleMax:
					VirtualCurrencyIOSBundleMax = (Float)value;
					break;
					
			case VirtualCurrencyAndroidBundleMin:
					VirtualCurrencyAndroidBundleMin = (Float)value;
					break;
					
			case VirtualCurrencyAndroidBundleMax:
					VirtualCurrencyAndroidBundleMax = (Float)value;
					break;
					
			case VirtualCurrencyPos:
					VirtualCurrencyPos = (Integer)value;
					break;
					
			case VirtualCurrencyCredit:
					VirtualCurrencyCredit = (Integer)value;
					break;
					
			case VirtualCurrencyKind:
					VirtualCurrencyKind = (LiCurrency)value;
					break;
					
			case VirtualCurrencyImageA:
					VirtualCurrencyImageA = (String)value;
					break;
					
			case VirtualCurrencyImageB:
					VirtualCurrencyImageB = (String)value;
					break;
					
			case VirtualCurrencyImageC:
					VirtualCurrencyImageC = (String)value;
					break;
					
			case VirtualCurrencyIsDeal:
					VirtualCurrencyIsDeal = (Boolean)value;
					break;
					
			case VirtualCurrencyInAppleStore:
					VirtualCurrencyInAppleStore = (Boolean)value;
					break;
					
			case VirtualCurrencyInGoogleStore:
					VirtualCurrencyInGoogleStore = (Boolean)value;
					break;
					
			case VirtualCurrencyLastUpdate:
					VirtualCurrencyLastUpdate = (GregorianCalendar)value;
					break;
				
			default:
				break;
		}
		return true;
	}
}
