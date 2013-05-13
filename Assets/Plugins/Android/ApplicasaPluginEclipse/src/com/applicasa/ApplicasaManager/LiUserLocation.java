package com.applicasa.ApplicasaManager;

import applicasa.LiCore.Applicasa;
import applicasa.LiCore.LiLocationCallback;

public class LiUserLocation {

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////														 /////////////////////////////////////
//////////////////////////////////						Location functions               /////////////////////////////////////
//////////////////////////////////														 /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	/**
	* Location response will return via callback.
	* setLocatoinCallback(LiLocationCallback liLocationCallback) or as parameter
	* if no listener was set, the call won't return the result
	*/
	public static void getLocation(LiLocationCallback locationCallback){
		Applicasa.getLocation(locationCallback);
	}
	
	/**
	 * Automatic Location and Update response will return to callback that was set in:
	 * setLocatoinCallback(LiLocationCallback liLocationCallback)
	 * if no callback was set, the call won't return the result
	 */
	public static void startAutomaticLocationUpdate(){
		Applicasa.startAutomaticLocationUpdate();
	}
	
	public static void stopAutomaticLocationUpdate(){
		Applicasa.stopAutomaticLocationUpdate();
	}
	
	/**
	 * Location and Update response will return to callback that was set in:
	 * setLocatoinCallback(LiLocationCallback liLocationCallback)
	 * if no callback was set, the call won't return the result
	 */
	public static void updateLocation(){
		Applicasa.updateLocation();
	}
	
	
	
	public static void enableGps(){
		Applicasa.enableGps();
	}
	
	public static void enableNetwork(){
		Applicasa.enableNetwork();
	}
	
	public static void disableGps(){
		Applicasa.disableGps();
	}
	
	public static void disableNetwork(){
		Applicasa.disableNetwork();
	}



	/**
	* Sets the callback Of location service.
	* Result from the following function will call this callback
	*  
	*updateLocation()
	*startAutomaticLocationUpdate()
	*getLocation()
	* 
	*@param callback
	*/
	public static void setLocatoinCallback(LiLocationCallback LiLocationCallback){
		Applicasa.setLocatoinCallback(LiLocationCallback);
	}
	
	/**
	* Only Location that are above this minimum distance will be returned and/or updated
	* if value not set, distance is set to 0
	* @param distance
	*/
	public static void setMinimumDistance(float distance){
		Applicasa.setMinimumDistance(distance);
	}
	
	/**
	* Location will be retrieved if the difference between the last location retrieve time and current time is larger the minTime
	* if value not set, minTime is set to 0
	* @param distance
	*/
	public static void setMinimumTime(long minTime){
		Applicasa.setMinimumTime(minTime);
	}
	 /**
	 * Unregister from All location services GPS, Network...
	 */
	 public static void unregisterFromLocationUpdates()
	 {
		Applicasa.unregisterFromLocationUpdates();
	 }
}
