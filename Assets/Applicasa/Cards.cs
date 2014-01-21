//
// Cards.cs
// Created by Applicasa 
// 1/21/2014
//

using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace Applicasa {
	public class Cards {	
		public static Cards[] finalCards;
		
#if UNITY_ANDROID 
		private static AndroidJavaClass javaUnityApplicasaCards;
	
        public AndroidJavaObject innerCardsJavaObject;
		
		[DllImport("Applicasa")]
		public static extern void setGetObjectFinished(GetCardsFinished callback, int uniqueActionID);
        
        [DllImport("Applicasa")]
		public static extern void setGetObjectArrayFinished(GetCardsArrayFinished callback, int uniqueActionID);
		
#endif

		public delegate void GetCardsFinished(bool success, Error error, IntPtr cardsPtr);
		public delegate void GetCardsArrayFinished(bool success, Error error, CardsArray cardsArrayPtr);
		
		public Cards(IntPtr cardsPtr) {
			innerCards = cardsPtr;
#if UNITY_ANDROID 
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			if(innerCardsJavaObject==null)
				innerCardsJavaObject = new AndroidJavaObject("com.applicasa.Cards.Cards",innerCards);
#endif
		}
		
#if UNITY_ANDROID 
		public Cards(IntPtr cardsPtr, AndroidJavaObject cardsJavaObject) {
			innerCards = cardsPtr;
			innerCardsJavaObject = cardsJavaObject;
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
		}
#endif

		#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern IntPtr ApplicasaCards();
		#endif
		public Cards() {
		#if UNITY_ANDROID&&!UNITY_EDITOR
		   if(javaUnityApplicasaCards==null)
			javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
		   innerCardsJavaObject = new AndroidJavaObject("com.applicasa.Cards.Cards");
		   innerCards = innerCardsJavaObject.GetRawObject();
		#elif UNITY_IPHONE && !UNITY_EDITOR
			innerCards = ApplicasaCards();
		#endif
		  }

		public struct CardsArray {
			public int ArraySize;
			public IntPtr Array;
		}
#if UNITY_ANDROID && !UNITY_EDITOR	
			public static Cards[] GetCardsArray(CardsArray cardsArray) {
			
			Cards[] cardsInner = new Cards[cardsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(cardsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					cardsInner[count] = new Cards(tempObj.GetRawObject(),tempObj);
					count++;
				}
			}
			return cardsInner;
		}
		
#elif UNITY_IPHONE && !UNITY_EDITOR
		public static Cards[] GetCardsArray(CardsArray cardsArray) {
			Cards[] cardss = new Cards[cardsArray.ArraySize];

			for (int i=0; i < cardsArray.ArraySize; i++) {

				IntPtr newPtr = Marshal.ReadIntPtr (cardsArray.Array, i * Marshal.SizeOf(typeof(IntPtr)));
				cardss[i] = new Cards(newPtr);
			}
			return cardss;
		}
#else
		public static Cards[] GetCardsArray(CardsArray cardsArray) {
			Cards[] cardss = new Cards[0];
			return cardss;
		}
#endif

#if UNITY_IPHONE&&!UNITY_EDITOR	
    ~Cards()
		{
			Debug.Log("Called Destractor");
			Applicasa.Core.DeallocPointer(innerCards);
		}
#endif


		#region Class Methods and Members
		
		public IntPtr innerCards;
		
			#region Class Members
#if UNITY_IPHONE

		public string CardsID {
			get {return ApplicasaCardsGetCardsID(innerCards);}
			set {ApplicasaCardsSetCardsID(innerCards, value);}
		}
		public DateTime CardsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddSeconds(ApplicasaCardsGetCardsLastUpdate(innerCards));}
		}
		public string CardsName {
			get {return ApplicasaCardsGetCardsName(innerCards);}
			set {ApplicasaCardsSetCardsName(innerCards, value);}
		}
		public float CardsPres {
			get {return ApplicasaCardsGetCardsPres(innerCards);}
			set {ApplicasaCardsSetCardsPres(innerCards, value);}
		}
		public string CardsImg {
			get {return ApplicasaCardsGetCardsImg(innerCards);}
			set {ApplicasaCardsSetCardsImg(innerCards, value);}
		}
		public Languages CardsAaaaa {
			get {return new Languages(ApplicasaCardsGetCardsAaaaa(innerCards));}
			set {ApplicasaCardsSetCardsAaaaa(innerCards, value.innerLanguages);}
		}

	[DllImport("__Internal")]
	private static extern string ApplicasaCardsGetCardsID(System.IntPtr cards);
	[DllImport("__Internal")]
	private static extern void ApplicasaCardsSetCardsID(System.IntPtr cards, string cardsID);
	[DllImport("__Internal")]
	private static extern double ApplicasaCardsGetCardsLastUpdate(System.IntPtr cards);
	[DllImport("__Internal")]
	private static extern string ApplicasaCardsGetCardsName(System.IntPtr cards);
	[DllImport("__Internal")]
	private static extern void ApplicasaCardsSetCardsName(System.IntPtr cards, string cardsName);
	[DllImport("__Internal")]
	private static extern float ApplicasaCardsGetCardsPres(System.IntPtr cards);
	[DllImport("__Internal")]
	private static extern void ApplicasaCardsSetCardsPres(System.IntPtr cards, float cardsPres);
	[DllImport("__Internal")]
	private static extern string ApplicasaCardsGetCardsImg(System.IntPtr cards);
	[DllImport("__Internal")]
	private static extern void ApplicasaCardsSetCardsImg(System.IntPtr cards, string cardsImg);
	[DllImport("__Internal")]
	private static extern IntPtr ApplicasaCardsGetCardsAaaaa(System.IntPtr cards);
	[DllImport("__Internal")]
	private static extern void ApplicasaCardsSetCardsAaaaa(System.IntPtr cards, IntPtr cardsAaaaa);
#elif UNITY_ANDROID && !UNITY_EDITOR

		public string CardsID {
			get {return javaUnityApplicasaCards.CallStatic<string>("ApplicasaCardsGetCardsID", innerCardsJavaObject);}
			set {javaUnityApplicasaCards.CallStatic("ApplicasaCardsSetCardsID", innerCardsJavaObject, value);}
		}
		public DateTime CardsLastUpdate {
			get {return new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).AddMilliseconds(javaUnityApplicasaCards.CallStatic<double>("ApplicasaCardsGetCardsLastUpdate",innerCardsJavaObject));}
		}
		public string CardsName {
			get {return javaUnityApplicasaCards.CallStatic<string>("ApplicasaCardsGetCardsName", innerCardsJavaObject);}
			set {javaUnityApplicasaCards.CallStatic("ApplicasaCardsSetCardsName", innerCardsJavaObject, value);}
		}
		public float CardsPres {
			get {return javaUnityApplicasaCards.CallStatic<float>("ApplicasaCardsGetCardsPres",innerCardsJavaObject);}
			set {javaUnityApplicasaCards.CallStatic("ApplicasaCardsSetCardsPres",innerCardsJavaObject, value);}
		}
		public string CardsImg {
			get {return javaUnityApplicasaCards.CallStatic<string>("ApplicasaCardsGetCardsImg",innerCardsJavaObject);}
			set {javaUnityApplicasaCards.CallStatic("ApplicasaCardsSetCardsImg",innerCardsJavaObject, value);}
		}
		public Languages CardsAaaaa {
			get {
				AndroidJavaObject temp = javaUnityApplicasaCards.CallStatic<AndroidJavaObject>("ApplicasaCardsGetCardsAaaaa",innerCardsJavaObject);
				return new Languages(temp.GetRawObject(),temp);}
			set {javaUnityApplicasaCards.CallStatic("ApplicasaCardsSetCardsAaaaa",innerCardsJavaObject, value.innerLanguagesJavaObject);}
		}

#else

		public string CardsID {
			get {return "";}
			set { }
		}
		public DateTime CardsLastUpdate {
			get {return new DateTime();}
		}
		public string CardsName {
			get {return "";}
			set { }
		}
		public float CardsPres {
			get {return 0;}
			set { }
		}
		public string CardsImg {
			get {return "";}
			set { }
		}
		public Languages CardsAaaaa {
			get {return null;}
			set { }
		}
#endif
#endregion

		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsSaveWithBlock(System.IntPtr cards, Action callback);
		public void Save(Action action) {
			ApplicasaCardsSaveWithBlock(innerCards, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsIncreaseFieldInt(System.IntPtr cards, Fields field, int val);
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsIncreaseFieldFloat(System.IntPtr cards, Fields field, float val);
		public void IncreaseField(Fields field, int val) {
			ApplicasaCardsIncreaseFieldInt(innerCards, field, val);
		}
		public void IncreaseField(Fields field, float val) {
			ApplicasaCardsIncreaseFieldFloat(innerCards, field, val);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsDeleteWithBlock(System.IntPtr cards, Action callback);
		public void Delete(Action action) {
			ApplicasaCardsDeleteWithBlock(innerCards, action);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsUploadFile(System.IntPtr cards, Fields field, byte[] data, int dataLen, AMAZON_FILE_TYPES fileType, string extension,  Action callback);
		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			ApplicasaCardsUploadFile(innerCards, field, data, data.Length, fileType, extension, action);
		}
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public void Save(Action action) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsSaveWithBlock", innerCardsJavaObject, uniqueActionID);
		}

		public void IncreaseField(Fields field, int val) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsIncreaseFieldInt", innerCardsJavaObject, (int)field, field.ToString(), val);
		}
		public void IncreaseField(Fields field, float val) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsIncreaseFieldFloat", innerCardsJavaObject, (int)field, field.ToString(), val);
		}

		public void Delete(Action action) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsDeleteWithBlock", innerCardsJavaObject, uniqueActionID);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			Core.setActionCallback(action, uniqueActionID);
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsUploadFile", innerCardsJavaObject, (int)field, field.ToString(), data, data.Length, (int)fileType, extension, uniqueActionID);
		}
#else
		public void Save(Action action) {
			action(true,new Error(),"",Actions.Update);
		}

		public void IncreaseField(Fields field, int val) {
		}
		public void IncreaseField(Fields field, float val) {
		}

		public void Delete(Action action) {
			action(true,new Error(),"",Actions.Update);
		}

		public void UploadFile(byte[] data, Fields field, AMAZON_FILE_TYPES fileType, string extension, Action action) {
			action(true,new Error(),"",Actions.Update);
		}
#endif

		#endregion
		
		#region Static Methods
		
#if UNITY_IPHONE && !UNITY_EDITOR
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsGetById(string id, QueryKind queryKind, GetCardsFinished callback);
		public static void GetById(string id, QueryKind queryKind, GetCardsFinished callback) {
			ApplicasaCardsGetById (id, queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsGetArrayWithQuery(IntPtr query, QueryKind queryKind, GetCardsArrayFinished callback);
		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetCardsArrayFinished callback) {
			ApplicasaCardsGetArrayWithQuery((query != null ? query.innerQuery : IntPtr.Zero), queryKind, callback);
		}
		
		[DllImport("__Internal")]
		private static extern void ApplicasaCardsGetLocalArrayWithRawSqlQuery(string rawQuery, GetCardsArrayFinished callback);
		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetCardsArrayFinished callback) {
			ApplicasaCardsGetLocalArrayWithRawSqlQuery(rawQuery, callback);
		}
		
		[DllImport("__Internal")]
		private static extern CardsArray ApplicasaCardsGetArrayWithQuerySync(IntPtr query, QueryKind queryKind);
		public static Cards[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			return GetCardsArray(ApplicasaCardsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind));
		}
		
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			CardsArray cardsArray = ApplicasaCardsGetArrayWithQuerySync((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
			finalCards = GetCardsArray(cardsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		public static  IEnumerator GetCardsArrayIEnumerator(CardsArray cardsArray) {
			finalCards = GetCardsArray(cardsArray);
			yield return new WaitForSeconds(0.1f);
		}
		
		[DllImport("__Internal")]
		private static extern int ApplicasaCardsUpdateLocalStorage(IntPtr query, QueryKind queryKind);
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return ApplicasaCardsUpdateLocalStorage((query != null ? query.innerQuery : IntPtr.Zero), queryKind);
		}
		
#elif UNITY_ANDROID&&!UNITY_EDITOR
		public static void GetById(string id, QueryKind queryKind, GetCardsFinished callback) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectFinished(callback, uniqueActionID);
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsGetById", id, (int)queryKind, uniqueActionID);
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetCardsArrayFinished callback) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsGetArrayWithQuery", query.innerQueryJavaObject, (int)queryKind, uniqueActionID);
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetCardsArrayFinished callback) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
			int uniqueActionID=Core.currentCallbackID;
			Core.currentCallbackID++;
			setGetObjectArrayFinished(callback, uniqueActionID);
			javaUnityApplicasaCards.CallStatic("ApplicasaCardsGetLocalArrayWithRawSqlQuery", rawQuery, uniqueActionID);
		}
				
		public static Cards[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaCards.CallStatic<AndroidJavaObject[]>("ApplicasaCardsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Cards[] cardsInner= null;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Cards[] cardstemp = new Cards[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					cardstemp[j] = new Cards(tempObj.GetRawObject(),tempObj);
				}
				if (cardsInner == null)
					cardsInner = cardstemp;
				else{
				   Cards[] firstOne = cardsInner;
				    cardsInner = new Cards[firstOne.Length+cardstemp.Length];
					firstOne.CopyTo(cardsInner,0);
					cardstemp.CopyTo(cardsInner,firstOne.Length);
				}
				
			}
			return cardsInner;
		}
		
		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
				
				int count = javaUnityApplicasaCards.CallStatic<int>("ApplicasaCardsUpdateLocalStorage", query.innerQueryJavaObject, (int)queryKind);
				
				return count;
		}
		
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
		
			if(javaUnityApplicasaCards==null)
				javaUnityApplicasaCards = new AndroidJavaClass("com.applicasaunity.Unity.ApplicasaCards");
				
				AndroidJavaObject[] bigArray = javaUnityApplicasaCards.CallStatic<AndroidJavaObject[]>("ApplicasaCardsGetArrayWithQuerySync", query.innerQueryJavaObject, (int)queryKind);
			
			Cards[] cardsInner= null;;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());
				Cards[] cardstemp = new Cards[InnerArray.Length];
				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					cardstemp[j] = new Cards(tempObj.GetRawObject(),tempObj);
				}
				if (cardsInner == null)
					cardsInner = cardstemp;
				else{
				   Cards[] firstOne = cardsInner;
				    cardsInner = new Cards[firstOne.Length+cardstemp.Length];
					firstOne.CopyTo(cardsInner,0);
					cardstemp.CopyTo(cardsInner,firstOne.Length);
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalCards = cardsInner;
		}
		
		public static  IEnumerator GetCardsArrayIEnumerator(CardsArray cardsArray) {
		
			Cards[] cardsInner = new Cards[cardsArray.ArraySize];
			AndroidJavaObject[] bigArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(cardsArray.Array);
   
			int count = 0;
			for (int i = 0;i < bigArray.Length;i++)
			{
				AndroidJavaObject tempJavaObject = bigArray[i];
				AndroidJavaObject[] InnerArray = AndroidJNIHelper.ConvertFromJNIArray<AndroidJavaObject[]>(tempJavaObject.GetRawObject());

				for (int j = 0;j < InnerArray.Length;j++)
				{
					AndroidJavaObject tempObj = InnerArray[j];
					cardsInner[count] = new Cards(tempObj.GetRawObject(),tempObj);
					count++;
				}
				yield return new WaitForSeconds(0.2f);
			}
			finalCards = cardsInner;
		}

#else

		public static int UpdateLocalStorage(Query query, QueryKind queryKind)
		{
			return -1;
		}
		public static IEnumerator GetArrayWithQuerySyncIEnumerator(Query query, QueryKind queryKind) {
			yield return new WaitForSeconds(0.2f);
				Cards[]  cardsInner = new Cards[0];
			    finalCards = cardsInner;
		}
		public static void GetById(string id, QueryKind queryKind, GetCardsFinished callback) {
			callback(true,new Error(),new IntPtr());
		}

		public static void GetArrayWithQuery(Query query, QueryKind queryKind, GetCardsArrayFinished callback) {
			callback(true,new Error(),new CardsArray());
		}

		public static void GetLocalArrayWithRawSqlQuery(string rawQuery, GetCardsArrayFinished callback) {
			callback(true,new Error(),new CardsArray());
		}
		
		public static Cards[] GetArrayWithQuerySync(Query query, QueryKind queryKind) {

			Cards[] cards = new Cards[0];
		    
			return cards;
		}	
		
		public static  IEnumerator GetCardsArrayIEnumerator(CardsArray cardsArray) {
			yield return new WaitForSeconds(0.2f);
			Cards[]  cardsInner = new Cards[0];
			finalCards = cardsInner;
		}
#endif
		
		#endregion
	}
}

