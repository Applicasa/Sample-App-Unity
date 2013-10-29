Sample-App-Unity  
=======================================
for unity Version 4.2+


The sample app is ready for use but you need to build as an iOS or Android project to test it.

## New SDK and Framework features:
1. Postprocess automation for easy integration
2. Custom events for monetization.
3. More Ad networks to the monetization section.
4. Send delayed push messages
5. Bug Fix



Using Applicasa - Unity
===========================
1. Open the project in Unity
2. Build to Project for your desired OS (iOS or Android)

For iOS:
1. You need Xcode in order to build your project.
(Download Xcode from the app store https://developer.apple.com/xcode/).
2. Open the 'Facebook' toolbar menu then 'Edit settings' and verify there's a valid Facebook Id, if not set this 494708670563462
3. Open 'Applicasa' toolbar menu then 'iOS settings' and verify there's a valid Facebook Id, if not set this 494708670563462

4. Click “Build & Run” in unity and then cancel when it reaches Xcode.
5. Open the Xcode project go to -> Build settings -> search ”Enable Objective-C Exceptions” and set to YES.

For Android:
1. open the "Build setting" ->player settings -> publishing setting -> select browse keystore -> select the keystore "unitySample.keystore".
 Keystore password 123456, key Password 123456.



## Raise Custom events

	
	Sample app Introduces the variety of Ad networks, All you need to do is:
	
	A. Go to ApplicasaMenu.cs.
	
	B. Set the value of 'customEvent' to the Ad Network you wish to display from the list (see below)
	
	C. Build & Run, and press on the "Show Promo" button


```

 /**
         Instruction to raise custom events.
         The "Egg" sample app implemented custom events that will raise the different ad network possible (TrialPay, MMedia, SupersonicAds, SponsorPay Appnext and Chartboost)

         To raise different AdNetwork just change the name of the variable "customEvent" below.
         use the the following names to raise the different ad network:

         1. TrialPay:
                A. MainCurrency ------------------->OfferwallMainCurrency
                 B. SecondaryCurrency -------------->OfferwallSecondaryCurrency
         2. Millennial Media ------------------>@"MMedia"
         3. SupersonicAds
                 A. SupersonicAds BrandConnect ----->@"SuperSonicBrand"
                 B. SupersonicAds offerwall -------->@"SuperSonic"
         3. SponsorPay
                 A. SponsorPay BrandEngage --------->@"SponsorPayBrand"
                 B. SponsorPay offerwall ----------->@"SponsorPay"
         4.Appnext ---------------------------->@"Appnext"
         5.Chartboost ------------------------->@"Chartboost"
         
     **/
	
	private static string customEvent = "MMedia";
```


  
### Making Test IAP Purchases -iOS

Because this is a sandboxed app, you must use a test account to make IAP purchases (for virtual currencies). We have created a test user that can be used with the app as-is. The credentials are:

* username: eggtest@applicasa.com
* password: EggTest1


### Making Test IAP Purchases - Android

We have created a test item that can be purchased with the app as-is. 

####Done! Run the project!  




