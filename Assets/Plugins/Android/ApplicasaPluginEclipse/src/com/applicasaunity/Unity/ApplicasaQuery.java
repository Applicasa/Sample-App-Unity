package com.applicasaunity.Unity;

import applicasa.LiCore.LiLocation;
import applicasa.LiCore.communication.LiFilters;
import applicasa.LiCore.communication.LiQuery;
import applicasa.LiCore.communication.LiRequestConst.SortType;
public class ApplicasaQuery {

    static {
        System.loadLibrary("Applicasa");
    }
    
    	public static LiQuery ApplicasaQueryCreate() {
    		LiQuery query = new LiQuery();
    		return query;
    	}
    	
    	public static LiFilters ApplicasaQueryGetFilter(Object query) {
    		return ((LiQuery)query).Lifilters;
    	}
    	
    	public static void ApplicasaQuerySetFilter(Object query, Object filter) {
    		((LiQuery)query).Lifilters = (LiFilters)filter;
    	}
    
    	public static void ApplicasaQuerySetGeoFilter(Object query, int fieldInt, String fieldStr, double locationLatitude, double locationLongitude, int radius) {
    		((LiQuery)query).setGeoFilter(ApplicasaCore.getField(fieldInt,fieldStr), new LiLocation(locationLongitude, locationLatitude), radius);
    	}
    	
    	public static void ApplicasaQueryAddOrder(Object query, int fieldInt, String fieldStr, int sortType) {
    		((LiQuery)query).addOrderBy(ApplicasaCore.getField(fieldInt,fieldStr), SortType.values()[sortType]);
    	}
		
    	public static void ApplicasaQueryAddPager(Object query, int page, int recsPerPage) {
    		((LiQuery)query).setPager(page, recsPerPage);
    	}
    	
		// Pass arrays to filters
}
