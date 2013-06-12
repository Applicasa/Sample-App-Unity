Sample-App-Unity
================
The sample app is ready for use but you need to build an iOS project to test it.

Please follow step 4 - 7 in order to build the project.

If you want test the Chartboost integration please refer to the Chartboost section in the end of this readme file.

Using Applicasa - iOS Unity
===========================
You need Xcode in order to build your project.
(Download Xcode from the app store https://developer.apple.com/xcode/).

1.  Download Unity SDK (http://main.applicasa.com).
2.	Unzip Applicasa_Unity_X.zip & Copy folders to main project root.
3.	Unzip ApplicasaFramework.zip from Assest/Plugins/iOS/.
  * Make sure you edit your bundle Identifier in the Build Setting-> iOS-> Player Setting.
  * If you use Facebook please refer to the Applicasa Facebook guide now (in the end of this readme file).

4.	Click “Build & Run” in unity and then cancel when it reaches Xcode.
5.	Copy the 3 folders from Assest/Plugins/iOS/ (ApplicasaFramework, ApplicasaSDK, ApplicasaUnity) to your Xcode project under classes folder (Make sure you drag/copy the files to Xcode and not in finder, then select “Copy files” option). 
6.	Go to: Target -> Build Phases -> Link Binary with Libraries -> "+" -> Choose StoreKit.framework, libsqlite3.0.dylib, CoreLocation.framework,social.framework, accounts.framework, adSupport.framework, security.framework.
7.	Go to: Build settings -> search ”other linker flags” - > "+" -> Add -ObjC -all_load.
  
 ####Done! Run the project!  

* Check the Xcode log to see that everything is ready. Good luck!
  
      LiLog 11:29:39.530: ENABLE_SANDBOX = YES: sandbox.applicasa.com

      LiLog 11:29:39.530: Applicasa Debug OFF ...
      
      LiLog 11:29:40.395: Finished Initialize Applicasa
      
      LiLog 11:29:47.532: Finished Initialize Applicasa with In App Purchase
      
      LiLog 11:29:47.532: Applicasa session start
      
      LiLog 11:29:47.616: Checking promo For Event userReturnSession = 1201 
      
      LiLog 11:29:47.621: Checking promo For Event appStart = 1100
      

### Don’t forget: When you re-build your Unity project ALWAYS CHOOSE APPEND and NOT REPLACE.

##Facebook:

1. Open the file /Assets/Editor/ApplicasaPostProcess.cs. 

2. Change the contents of the constant “FACEBOOKID” to your own application’s facebook App Id.

* This will automatically setup facebook connect into your xcode project in your next build.

##Chartboost

You can use Chartboost messages in Applicasa’s promotion, you just need a Chartboost account and set one of your promotion to “Chartboost” type. 

1.  Download & unzip both Applicasa’s Chartboost framework (https://s3.amazonaws.com/applicasamaterials/LiChartboost.framework.zip) and Chartboost library (https://help.chartboost.com/downloads/ios) and drag and drop the folders to your xCode project under ApplicasaFramework folder. (Select Copy files option)
  * If you use the sample app both files are located in the project under Assets/Plugins/iOS/ApplicasaFramework/LiChartboost.framework
2.	Open Classes/ApplicasaSDK/LiManager/LiConfig.h.

3.	Edit the file:

  define ENABLE_CHARTBOOST 1

  define CHARTBOOST_ID @"App ID" (Chartboost sample app id for test:4f21c409cd1cb2fb7000001b)
  
  define CHARTBOOST_SIGNATURE @"App signature" (sample for test: 92e2de2fd7070327bdeb54c15a5295309c6fcd2d)

4.	Go to: Target -> Build Phases -> Link Binary with Libraries -> "+" -> Choose adSupport and set it as optional.


Using Applicasa - Android Unity
===========================
## Configuring Unity Android Sample app
1. Open Build Settings ->player settings -> publishing setting -> select browse keystore -> select the keystore "unitySample.keystore". Keystore password 123456, key Password 123456


# Configuring Applicasa Android Unity 


1.      Download Unity SDK (http://main.applicasa.com).
2.	Unzip Applicasa_Unity_X.zip & Copy folders to main project root.

3.      Go to assets/plugins/Android/ and open the AndroidManivest35 or AndroidManifest4 file, replace all {yourPackage} with your game Package (3 occurences), and save as AndroidManifest.xml
##Done! Run the project!  
4.      Click build & run.
  
*You can open Android DDMS to see android logcat it should look like:
 
##In App Purchase :

1. Open the file /Assets/Plugins/Android/assets/ApplicasaConfig.xml 
2. change "ENABLE_IAP" value to true
3. change "GOOGLE_PLAY_PUBLIC_KEY" value to the google play public key (from google play developer console).
 
##Facebook:

1. Open the file /Assets/Plugins/Android/assets/ApplicasaConfig.xml 
2. change "ENABLE_FACEBOOK" value to true
3. change "FB_APPLICATION_KEY" value to Facebook app ID.
4. You should sign your keystore as 

##Chartboost

1. Download Chartboost library (https://help.chartboost.com/downloads/ios) and drag and drop the .jar file to /Assets/Plugins/Android/
2. Open the file /Assets/Plugins/Android/assets/ApplicasaConfig.xml 
3. change "ENABLE_CHARTBOOST" value to true
4. change "CHARTBOOST_ID" value to chartboost ID.
5. change "CHARTBOOST_SIGNATURE" value to chart boost key.

