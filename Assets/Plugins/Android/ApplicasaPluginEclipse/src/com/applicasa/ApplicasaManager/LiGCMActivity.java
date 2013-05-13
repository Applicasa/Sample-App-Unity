package com.applicasa.ApplicasaManager;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import applicasa.LiJson.LiJSONException;
import applicasa.LiJson.LiJSONObject;

public class LiGCMActivity extends Activity{
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		String TAG = LiGCMActivity.class.getSimpleName();
		/**
		 *  Set Push message content View
		 */
		//setContentView(R.layout.main);
		super.onCreate(savedInstanceState);
		Bundle extras = getIntent().getExtras();
		LiJSONObject jsonTag;
		
		// If push message contains data
		if (extras != null) {
			String message = extras.getString("alert");
			String tag = extras.getString("tag");
			Log.i(TAG,"tag "+ tag);
			
			if (tag != null && tag != "")
			{
				try {
					jsonTag = new LiJSONObject(tag);
				} catch (LiJSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		
	}
}