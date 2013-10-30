using UnityEngine;
using System.Collections;
using UnityEditor;
using UnityEditor.Callbacks;
using System.IO;
using UnityEditor.LiXCodeEditor;


public class ApplicasaPostProcess {
	
	// Set your facebbok AppID
	const string FacebookAppID = "	494708670563462";
	

    const bool IsMMediaEnabledAndroid = true;
    const bool IsSponsorPayEnabledAndroid = true;
    const bool IsSupersonicAdsEnabledAndroid = false;
	
	const bool IsFacebookEnablediOS = true;
	const bool IsSponsorPayEnablediOS = true;
	const bool IsSupersonicAdsEnablediOS = true;
	const bool IsMMediaEnablediOS = true;
	const bool IsAppnextEnablediOS = true;
	const bool IsChartboostEnablediOS = true;
	

	const string Permissions = "<!-- AddPermissions -->";
	const string Activities = "<!-- AddActivities -->";
	
	[PostProcessBuild]
	public static void OnPostprocessBuild(BuildTarget target, string pathToBuildProject) {	
	
			
		
		if (target == BuildTarget.iPhone) 
		{
			buildiOS(pathToBuildProject);
			PlistMod.FixPlist(pathToBuildProject);
			//PlistMod.UpdatePlist(pathToBuildProject, FacebookAppID);
		}
		
		
		else if (target == BuildTarget.Android)
		{
		
			buildAndroid();
			
		}
	}
	
	private static void buildAndroid()
	{
		bool isUnity4 = Application.unityVersion.StartsWith("4");
		
		string path;
		if (isUnity4)
			path = Application.dataPath+"/Plugins/Android/AndroidManifest4.xml";
		else
			path = Application.dataPath+"/Plugins/Android/AndroidManifest35.xml";
		
		string outPutPath = Application.dataPath+"/Plugins/Android/AndroidManifest.xml";
		
		if (File.Exists(outPutPath))
			File.Delete(outPutPath);
		
		
		string AndroidManifestString = File.ReadAllText(path);
		AndroidManifestString = AndroidManifestString.Replace("{yourPackage}",PlayerSettings.bundleIdentifier);
		
		string permissions = "";
		string activities = "";
		if (IsMMediaEnabledAndroid)
		{
			permissions = File.ReadAllText(Path.Combine( Application.dataPath, "Editor/MMedia/MMpermissions.txt"));
			//activities = File.ReadAllText(Path.Combine( Application.dataPath, "Editor/MMedia/MMactivities.txt"));
			
			AndroidManifestString = AndroidManifestString.Replace(Permissions, permissions);
			
			// Activities are harcoded 
			//AndroidManifestString = AndroidManifestString.Replace(Activities, activities);
		}
		if(IsSponsorPayEnabledAndroid)
		{
			// Activities are harcoded 
			//activities = File.ReadAllText(Path.Combine( Application.dataPath, "Editor/SponsorPay/SPactivities.txt"));
			//AndroidManifestString = AndroidManifestString.Replace(Activities, activities);
		}
		if(IsSupersonicAdsEnabledAndroid)
		{
			// Activities are harcoded 
			//activities = File.ReadAllText(Path.Combine( Application.dataPath, "Editor/SupersonicAds/SSAactivities.txt"));
			//AndroidManifestString = AndroidManifestString.Replace(Activities, activities);
		}
		
		File.WriteAllText(outPutPath, AndroidManifestString);
	}
	

	private static void buildiOS(string buildPath)
	{
		   	// Create a new project object from build target
		    XCProject project = new XCProject( buildPath );
			
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/main.projmods" );
			
		if (!IsFacebookEnablediOS)
		{
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/facebook.projmods" );
		}
		if (IsMMediaEnablediOS)
		{
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/MMedia.projmods" );
		}
		if(IsSponsorPayEnablediOS)
		{
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/SponsorPay.projmods" );
		}
		if(IsSupersonicAdsEnablediOS)
		{
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/SupersonicAds.projmods" );
		}
		if(IsAppnextEnablediOS)
		{
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/AppNext.projmods" );		
		}
		if(IsChartboostEnablediOS)
		{
			project.ApplyMod( Application.dataPath+"/Editor/PostProcessScript/Chartboost.projmods" );
		}
			
		project.Save();
    }
}
