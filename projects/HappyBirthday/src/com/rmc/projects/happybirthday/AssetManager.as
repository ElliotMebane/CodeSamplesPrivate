package com.rmc.projects.happybirthday
{
	import com.rmc.projects.happybirthday.model.events.ViewNavigatorEvent;
	
	import flash.text.StyleSheet;
	
	import spark.components.View;
	import spark.components.supportClasses.StyleableTextField;
	import spark.transitions.CrossFadeViewTransition;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionBase;
	import spark.transitions.ViewTransitionDirection;
	
	[Bindable]
	public class AssetManager
	{
		
		
		// --------------------------------------
		// URLS For Loading
		//
		// --------------------------------------
		/**
		 *	URL : Load the languages for the spinner and all song data
		 *  
		 */		
		public static var SONGS_XML_URL:String = "./assets_runtime/xml/songs.xml";
		
		/**
		 *	URL : Load the static display text for the UI
		 *  
		 */		
		public static var PHRASES_XML_URL:String = "./assets_runtime/xml/phrases.xml";
		
		
		// --------------------------------------
		// All The Icons
		//
		// TAKEN FROM FREE WEBSITE : http://www.smashingmagazine.com/2010/04/15/the-ultimate-free-web-designer-s-icon-set-750-icons-incl-psd-sources/
		// --------------------------------------
		
		//EMBED: ICON
		[Embed(source ='../assets_compiletime/images/icons/mail_plain.png')] 
		public static var ICON_EMAIL : Class;
		
		//EMBED: ICON
		[Embed(source ='../assets_compiletime/images/icons/social_facebook.png')] 
		public static var ICON_FACEBOOK : Class;
		
		//EMBED: ICON
		[Embed(source ='../assets_compiletime/images/icons/social_twitter_bird.png')] 
		public static var ICON_TWITTER : Class;
		
		//EMBED: ICON
		[Embed(source ='../assets_compiletime/images/icons/social_linked_in.png')] 
		public static var ICON_LINKED_IN : Class;
		
		//EMBED: ICON
		[Embed(source ='../assets_compiletime/images/icons/social_vimeo_V.png')] 
		public static var ICON_VIMEO : Class;
		
		//EMBED: ICON
		[Embed(source ='../assets_compiletime/images/icons/social_rmc_website.png')] 
		public static var ICON_RMC_WEBSITE : Class;
		
		
		// --------------------------------------
		// All The Flags
		//
		// TAKEN FROM FREE WEBSITE : http://www.smashingmagazine.com/2010/04/15/the-ultimate-free-web-designer-s-icon-set-750-icons-incl-psd-sources/
		// --------------------------------------
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_AR.png')] 
		public static var FLAG_AR : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_CZ.png')] 
		public static var FLAG_CZ : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_DE.png')] 
		public static var FLAG_DE : Class;

		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_DU.png')] 
		public static var FLAG_DU : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_EN.png')] 
		public static var FLAG_EN : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_ES.png')] 
		public static var FLAG_ES : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_FR.png')] 
		public static var FLAG_FR : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_GR.png')] 
		public static var FLAG_GR : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_HE.png')] 
		public static var FLAG_HE : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_IT.png')] 
		public static var FLAG_IT : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_KO.png')] 
		public static var FLAG_KO : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_NO.png')] 
		public static var FLAG_NO : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_PO.png')] 
		public static var FLAG_PO : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_PT.png')] 
		public static var FLAG_PT : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_RO.png')] 
		public static var FLAG_RO : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_RU.png')] 
		public static var FLAG_RU : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_SW.png')] 
		public static var FLAG_SW : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_TA.png')] 
		public static var FLAG_TA : Class;
		
		//EMBED: FLAG
		[Embed(source ='../assets_compiletime/images/flags/FLAG_TU.png')] 
		public static var FLAG_TU : Class;
		
		//Embed the graphic
		[Embed(source ='../assets_compiletime/images/flags/FLAG_DEFAULT.png')] 
		public static var FLAG_DEFAULT : Class;
		
		//Embed the graphic
		[Embed(source ='../assets_compiletime/fla/HappyBirthday_Assets_v1.swf#SPINNER_ARROW')] 
		public static var SPINNER_ARROW : Class;
		
		
		
		/**
		 * If a flag asset exists, use it. If not, use default
		 *  
		 * @param aLanguageCode_str
		 * 
		 * @return Class for flag
		 * 
		 */		
		public static function GetFlagByLanguageCode (aLanguageCode_str : String) : Class {
			
			var returnClass : Class;
			
			if (aLanguageCode_str == "") {
				returnClass = AssetManager.SPINNER_ARROW;
				
			} else {
				if (AssetManager["FLAG_" + aLanguageCode_str]) {
					returnClass = AssetManager["FLAG_" + aLanguageCode_str];
				} else {
					returnClass = AssetManager.FLAG_DEFAULT
				}
			}
			
			return returnClass;
		}
		
		public static function getViewTransition (aViewNavigatorEventType_str : String) : ViewTransitionBase
		{
			
			/*
			
			var flipTrans:FlipViewTransition = new FlipViewTransition();
			flipTrans.direction = ViewTransitionDirection.UP;
			flipTrans.mode = FlipViewTransitionMode.CUBE; //or CARD mode
			navigator.pushView(SampleZoom,null,null,flipTrans);
			
			var zoomTrans:ZoomViewTransition = new ZoomViewTransition();
			zoomTrans.direction = ViewTransitionDirection.RIGHT;
			zoomTrans.mode = ZoomViewTransitionMode.IN; //or OUT mode
			navigator.popToFirstView(zoomTrans);
			
			var slideTrans:SlideViewTransition = new SlideViewTransition();
			slideTrans.direction = ViewTransitionDirection.DOWN;
			slideTrans.mode = SlideViewTransitionMode.UNCOVER;  //or COVER and PUSH modes
			navigator.pushView(SampleZoom,null,null,slideTrans);
			
			var fadeTrans:CrossFadeViewTransition = new CrossFadeViewTransition();
			fadeTrans.direction = ViewTransitionDirection.LEFT;
			// no modes are available for CrossFadeViewTransition
			navigator.pushView(SampleZoom,null,null,fadeTrans);
			
			*/
			
			
			if (true) {
				
				var viewTransition:SlideViewTransition = new SlideViewTransition();
				
				//USE DIFFERENT DIRECTION FOR POP VS PUSH
				if (aViewNavigatorEventType_str == ViewNavigatorEvent.POP_VIEW) {
					viewTransition.direction 	= ViewTransitionDirection.RIGHT;
				} else {
					viewTransition.direction 	= ViewTransitionDirection.LEFT;
					
				}
				
				viewTransition.mode 			= SlideViewTransitionMode.PUSH;  //UNCOVER, or COVER and PUSH modes
				return viewTransition;
				
			} else {
				
				var viewTransition : CrossFadeViewTransition = new CrossFadeViewTransition ();
				viewTransition.duration = 200;
				viewTransition.transitionControlsWithContent = true;
				return viewTransition;
				
			}
			
		}
	}
}