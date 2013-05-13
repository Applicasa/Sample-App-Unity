package com.applicasaunity.Unity;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import android.graphics.Bitmap;
import applicasa.LiCore.LiErrorHandler;
import applicasa.LiCore.LiFileCacher;
import applicasa.LiCore.LiErrorHandler.ApplicasaResponse;
import applicasa.LiCore.communication.LiCallback.LiCallbackGetCachedFile;

public class ApplicasaFileCacher {
	
	static {
        System.loadLibrary("Applicasa");
    }
	
	public static native void responseCallbackGetFileData(int uniqueGetUserArrayFinishedID, boolean success, String errorMessage, int errorType, int listSize, byte[] data);
	
	public static void ApplicasaClearMemory() {
		LiFileCacher.clearMemory();
	}
	
	public static void ApplicasaDeleteAllFiles() {
		LiFileCacher.deleteAllFiles();
	}
	
	public static boolean ApplicasaDeleteFile(String fileName) {
		return LiFileCacher.deleteFile(fileName);
	}
	
	public static void ApplicasaGetCachedData(String url, final int uniqueActionID) {
		LiFileCacher.getFileFromCache(url, new LiCallbackGetCachedFile() {
			
			@Override
			public void onSuccessfullBitmap(Bitmap bitmap) {
				responseCallbackGetFileData(uniqueActionID, false, "", 1, 0, null);
			}
			
			@Override
			public void onSuccessfull(InputStream inputStream) {
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				byte[] buffer = new byte[1024];
				try {
					while (inputStream.read(buffer) != -1)
						out.write(buffer);
				} catch (IOException e) {
					e.printStackTrace();
				}
				byte[] result = out.toByteArray();
				if(result.length>0)
				{
					responseCallbackGetFileData(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), result.length, result);
				}
				else
				{
					responseCallbackGetFileData(uniqueActionID, false, "", 1, 0, null);
				}
			}
			
			@Override
			public void onFailure(LiErrorHandler error) {
				responseCallbackGetFileData(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
			}
		});
	}
	
	public static void ApplicasaGetCachedImage(String url, final int uniqueActionID) {
		LiFileCacher.getBitmapFromCache(url, new LiCallbackGetCachedFile() {
		
			@Override
			public void onSuccessfullBitmap(Bitmap bitmap) {
				if(bitmap!=null)
				{
					ByteArrayOutputStream stream = new ByteArrayOutputStream();
					bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
					byte[] byteArray = stream.toByteArray();
					responseCallbackGetFileData(uniqueActionID, true, "Success", ApplicasaResponse.toInt(ApplicasaResponse.RESPONSE_SUCCESSFUL), byteArray.length, byteArray);
				}
				else
				{
					responseCallbackGetFileData(uniqueActionID, false, "", 1, 0, null);
				}
			}
	
			@Override
			public void onSuccessfull(InputStream inputStream) {
				responseCallbackGetFileData(uniqueActionID, false, "", 1, 0, null);
			}
			
			@Override
			public void onFailure(LiErrorHandler error) {
				responseCallbackGetFileData(uniqueActionID, false, error.errorMessage, ApplicasaResponse.toInt(error.errorType), 0, null);
			}
		});
	}
}