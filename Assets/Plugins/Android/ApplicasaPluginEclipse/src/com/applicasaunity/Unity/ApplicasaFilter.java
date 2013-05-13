package com.applicasaunity.Unity;

import applicasa.LiCore.communication.LiFilters;
import applicasa.LiCore.communication.LiFilters.Operation;
import applicasa.LiCore.communication.LiFilters.Condition;

public class ApplicasaFilter {
	
    static {
        System.loadLibrary("Applicasa");
    }
    
    	public static LiFilters ApplicasaFilterNOT(Object filterObj) {
    		LiFilters filter=(LiFilters)filterObj;
    		LiFilters retFilter = filter.NOT();
    		return retFilter;
    	}
				
		public static LiFilters ApplicasaFilterGetFilterInt(int fieldInt, String fieldStr, int op, int val)
	    {
			LiFilters filter = new LiFilters(ApplicasaCore.getField(fieldInt,fieldStr), Operation.values()[op], val);
			return filter;
	    }

		public static LiFilters ApplicasaFilterGetFilterFloat(int fieldInt, String fieldStr, int op, float val)
	    {
			LiFilters filter = new LiFilters(ApplicasaCore.getField(fieldInt,fieldStr), Operation.values()[op], val);
			return filter;
	    }
		
		public static LiFilters ApplicasaFilterGetFilterBool(int fieldInt, String fieldStr, int op, boolean val)
	    {
			LiFilters filter = new LiFilters(ApplicasaCore.getField(fieldInt,fieldStr), Operation.values()[op], val);
			return filter;
	    }
		
		public static LiFilters ApplicasaFilterGetFilterString(int fieldInt, String fieldStr, int op, String val)
	    {
			LiFilters filter = new LiFilters(ApplicasaCore.getField(fieldInt,fieldStr), Operation.values()[op], val);
			return filter;
	    }
		
		public static LiFilters ApplicasaFilterGetFilterComplex(Object OperandA, int op, Object OperandB)
		{
			LiFilters filter = new LiFilters((LiFilters)OperandA, Condition.values()[op], (LiFilters)OperandB);
			return filter;
		}
		
		// Pass arrays to filters
}
