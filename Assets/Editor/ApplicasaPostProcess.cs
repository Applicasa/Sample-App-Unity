using UnityEngine;
using System.Collections;
using UnityEditor;
using UnityEditor.Callbacks;
using System.IO;


public class ApplicasaPostProcess {
	
	const string FacebookAppID = "377364785706401";
	const string AppID = "[APPID]";
	const string BundleID = "[BUNDLEID]";
	
	[PostProcessBuild]
	public static void OnPostprocessBuild(BuildTarget target, string pathToBuildProject) {		
		if (target == BuildTarget.iPhone) {
			string infoPlistText = File.ReadAllText(Path.Combine( Application.dataPath, "Applicasa/infoFixTemplate.plist"));
			infoPlistText = infoPlistText.Replace(AppID, FacebookAppID);
			infoPlistText = infoPlistText.Replace(BundleID, PlayerSettings.iPhoneBundleIdentifier);
			            File.WriteAllText(Path.Combine(Application.dataPath, "Applicasa/infoFix.plist"), infoPlistText);
			
			string FixerPath = Path.Combine (System.Environment.CurrentDirectory, "Assets/Editor/InfoPlistMerge");
			Debug.Log ("Fixing info.plist...");		
			
			System.Diagnostics.Process.Start("sudo", "chmod 777 " + FixerPath);
			Debug.Log ("Path:" + "/bin/sh"+ FixerPath + " " + pathToBuildProject);		
			System.Diagnostics.Process.Start("/bin/sh", FixerPath + " " + pathToBuildProject);
			Debug.Log ("Info.plist finish");		
		}
	}
}
