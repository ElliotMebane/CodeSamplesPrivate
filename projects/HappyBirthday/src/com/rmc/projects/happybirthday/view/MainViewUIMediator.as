/**
 * Copyright (C) 2005-2012 by Rivello Multimedia Consulting (RMC).                    
 * code [at] RivelloMultimediaConsulting [dot] com                                                  
 *                                                                      
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the      
 * "Software"), to deal in the Software without restriction, including  
 * without limitation the rights to use, copy, modify, merge, publish,  
 * distribute, sublicense, and#or sell copies of the Software, and to   
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:                                            
 *                                                                      
 * The above copyright notice and this permission notice shall be       
 * included in all copies or substantial portions of the Software.      
 *                                                                      
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR    
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.                                      
 */
//Marks the right margin of code *******************************************************************
package com.rmc.projects.happybirthday.view
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.happybirthday.controller.signals.GuestChangeSignal;
	import com.rmc.projects.happybirthday.controller.signals.LoadSongSignal;
	import com.rmc.projects.happybirthday.controller.signals.SelectedLanguageChangeSignal;
	import com.rmc.projects.happybirthday.controller.signals.SocialButtonClickedSignal;
	import com.rmc.projects.happybirthday.controller.signals.flexmobile.StageOrientationChangeSignal;
	import com.rmc.projects.happybirthday.model.HappyBirthdayModel;
	import com.rmc.projects.happybirthday.model.events.PhrasesModelEvent;
	import com.rmc.projects.happybirthday.model.vo.GuestVO;
	import com.rmc.projects.happybirthday.model.vo.LanguageVO;
	import com.rmc.projects.happybirthday.utils.DensityUtil;
	import com.rmc.projects.happybirthday.view.components.views.MainViewUI;
	
	import flash.display.Stage;
	import flash.display.StageOrientation;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.system.Capabilities;
	
	import mx.collections.ArrayList;
	import mx.core.DPIClassification;
	
	import spark.components.Button;
	import spark.components.supportClasses.StyleableTextField;
	import spark.events.IndexChangeEvent;
	import spark.events.TextOperationEvent;
	import spark.events.ViewNavigatorEvent;
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>Mediator</code> managing the I/O to the UI: MainUI</p>
	 * 
	 */
	public class MainViewUIMediator extends AbstractViewMediator
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC
		/**
		 * Reference to the UI being mediated
		 * 
		 */	
		[Inject]
		public var mainViewUI : MainViewUI;
		
		/**
		 * Signal: Marks a request to load the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var loadMessageModelSignal : LoadSongSignal;
		
		/**
		 * Signal: Marks a request to load the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var guestChangeSignal : GuestChangeSignal;
		
		/**
		 * Signal: Marks a request to change the Model
		 * 
		 */	
		[Inject]
		public var socialButtonClickedSignal : SocialButtonClickedSignal;
		
		/**
		 * Signal: Marks a request to change the Model
		 * 
		 */	
		[Inject]
		public var selectedLanguageChangeSignal : SelectedLanguageChangeSignal;
		
		/**
		 * Signal: Marks a request to change the stage rotation
		 * 
		 */	
		[Inject]
		public var stageOrientationChangeSignal : StageOrientationChangeSignal;
		
		
		/**
		 * Reference: <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var happyBirthdayModel : HappyBirthdayModel;
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MainViewUIMediator()
		{
			//NOTHING HAPPENS HERE
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Handles Event of Registration
		 * 
		 * @return void
		 *
		 */
		override public function onRegister():void
		{
			//  Super
			super.onRegister();
			
			// 	View Listeners (Note We used a change (model not yet affected) and changed (after model is affected) convention for naming
			mainViewUI.languageSpinnerListChangeSignal.add  	(_onLanguageSpinnerListChange);
			mainViewUI.loadButtonClickSignal.add  				(_onLoadButtonClick);
			mainViewUI.guestNameTextInputChange.add  			(_onGuestNameTextInputChange);
			mainViewUI.guestGenderRadioButtonChange.add			(_onGuestGenderRadioButtonChange);
			mainViewUI.socialButtonClicked.add					(_onSocialButtonClicked);
			
			//
			trace ("stageOrientationChangeSignal: " + stageOrientationChangeSignal);
			stageOrientationChangeSignal.add					(_onStageOrientationChange);
			
			//	Context Listeners
			happyBirthdayModel.languagesFullListChangedSignal.add   (_onLanguageFullListChanged);
			happyBirthdayModel.selectedLanguageChangedSignal.add 	(_onSelectedLanguageChanged);
			happyBirthdayModel.guestChangedSignal.add 				(_onGuestChanged);
			
			//	UPDATE UI
			_onLanguageFullListChanged();
			
		}
		
		/**
		 * Robotlegs Requirement: Handles Event of Removal
		 * 
		 * @return void
		 *
		 */
		override public function onRemove():void
		{
			//  SUPER
			super.onRemove();
			
			//THE UI IS REMOVED FOR US, ANY OTHER CLEANUP TO DO?
			
			// 	View Listeners (Note We used a change (model not yet affected) and changed (after model is affected) convention for naming
			mainViewUI.languageSpinnerListChangeSignal.remove 	(_onLanguageSpinnerListChange);
			mainViewUI.loadButtonClickSignal.remove  			(_onLoadButtonClick);
			mainViewUI.guestNameTextInputChange.remove  		(_onGuestNameTextInputChange);
			mainViewUI.guestGenderRadioButtonChange.remove  	(_onGuestGenderRadioButtonChange);
			
			//	Context Listeners
			happyBirthdayModel.languagesFullListChangedSignal.remove   	(_onLanguageFullListChanged);
			happyBirthdayModel.selectedLanguageChangedSignal.remove 	(_onSelectedLanguageChanged);
			
		}
		
		//VIEW
		
		
		
		
		
		/**
		 * Handles the aEvent: <code>IndexChangedEvent.CHANGE</code>.
		 * 
		 * @param aEvent <code>IndexChangedEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onLanguageSpinnerListChange (aEvent : IndexChangeEvent):void
		{
			//
			selectedLanguageChangeSignal.dispatch (mainViewUI.languageFullList_spinnerlist.selectedItem as LanguageVO);
			
		}
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onSocialButtonClicked (aEvent : MouseEvent):void
		{
			socialButtonClickedSignal.dispatch ((aEvent.target as Button).id);
		}
		
		
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onLoadButtonClick (aEvent : MouseEvent):void
		{
			loadMessageModelSignal.dispatch(mainViewUI.languageFullList_spinnerlist.selectedItem);
		}
		
		/**
		 * Handles the aEvent: <code>TextOperationEvent.CHANGE</code>.
		 * 
		 * @param aEvent <code>TextOperationEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onGuestNameTextInputChange (aEvent : TextOperationEvent):void
		{
			guestChangeSignal.dispatch (
				new GuestVO (
					mainViewUI.guestName_textinput.text, 
					mainViewUI.guestGenderMale_radiobutton.selected==true)
			);
		}
		
		/**
		 * Handles the aEvent: <code>Event.CHANGE</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onGuestGenderRadioButtonChange (aEvent : Event):void
		{
			guestChangeSignal.dispatch (
				new GuestVO (
					mainViewUI.guestName_textinput.text, 
					mainViewUI.guestGenderMale_radiobutton.selected==true)
			);
		}
		
		/**
		 * Handles the Event: <code>ViewNavigatorEvent.VIEW_ACTIVATE</code>.
		 * 
		 * @param aEvent <code>ViewNavigatorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		override protected function _onViewActivatedSignal (aEvent : ViewNavigatorEvent):void
		{
			//this occurs after the View is 100% on the screen. This is often too late to do anything (Right?)
			//keep this here has a reminder...
			
		}
		
		//CONTEXT
		/**
		 * Handles the Signal: <code>StageOrientationEvent</code>.
		 * 
		 * @param aEvent : StageOrientationEvent
		 *  
		 * @return void
		 * 
		 */
		private function _onStageOrientationChange (aEvent : StageOrientationEvent):void
		{
			
			return;
			
			
			
			var nextSpinnerListHeight_uint : uint;
			
			if (mainViewUI.stage.orientation == StageOrientation.ROTATED_LEFT || mainViewUI.stage.orientation == StageOrientation.ROTATED_RIGHT ) {
				
				//
				//		LANDSCAPE
				//
				
				//FOR SMALL SCREENS (itouch/iphone 3gs) EXPERIMENT WITH A SMALLER SPIN LIST SO THE ADS STILL FIT BELOW
				if (DensityUtil.getRuntimeDPI() == DPIClassification.DPI_160) {
					
					//NOT SURE WHY, BUT IPAD IS COMING AS DPI 132 BUT DPICLASSIF OF 160
					if (Capabilities.screenDPI == 132) {
						//nothing for ipad
						nextSpinnerListHeight_uint = 1100;
					} else {
						//NORMAL, SMALL
						nextSpinnerListHeight_uint = 275;
					}
				}
			} else {
				//
				//		PORTRAIT
				//
				//FOR SMALL SCREENS (itouch/iphone 3gs) EXPERIMENT WITH A SMALLER SPIN LIST SO THE ADS STILL FIT BELOW
				if (DensityUtil.getRuntimeDPI() == DPIClassification.DPI_160) {
					
					//NOT SURE WHY, BUT IPAD IS COMING AS DPI 132 BUT DPICLASSIF OF 160
					if (Capabilities.screenDPI == 132) {
						//nothing for ipad
						nextSpinnerListHeight_uint = 1600;
					} else {
						//NORMAL, SMALL
						nextSpinnerListHeight_uint = 600;
					}
				}
			}
			
			trace ("nextSpinnerListHeight_uint: " + nextSpinnerListHeight_uint);
			if (nextSpinnerListHeight_uint != 0 && mainViewUI.languageFullList_spinnerlist.height != nextSpinnerListHeight_uint) {
			
					mainViewUI.languageFullList_spinnerlist.height = nextSpinnerListHeight_uint;
				
			}
			

		}
		
		/**
		 * Handles the Signal: <code>LanguageFullListChangedSignal</code>.
		 * 
		 * @param aLanguageFullList_array : Array
		 *  
		 * @return void
		 * 
		 */
		private function _onLanguageFullListChanged (aLanguageFullList_array : Array = null) :void
		{
			
			//CHEAT, AND POPULATE SOME MODEL DATA HERE, RATHER THAN LISTEN FOR IT TO CHANGE
			mainViewUI.guestName_textinput.text = happyBirthdayModel.guestVO.name;
			mainViewUI.guestGenderMale_radiobutton.selected = happyBirthdayModel.guestVO.isMale==true; //female toggles automatically
			
			
			//THIS VIEW LOADS AFTER THE DATA, SO WE FORCE A CALL HERE AND REACH INTO THE EXISTING MODEL
			if (!aLanguageFullList_array) {
				mainViewUI.languageFullList_spinnerlist.dataProvider = new ArrayList (happyBirthdayModel.languagesFullList);
			} else {
				//IF THE DATA EVER CHANGES DURING THE APP (SO FAR, THIS DOESN'T HAPPEN) WE'LL CATCH THE UPDATES
				mainViewUI.languageFullList_spinnerlist.dataProvider = new ArrayList (aLanguageFullList_array);
			}
			
			//IF WE HAVE A SELECTED LANGUAGE USE IT
			if (happyBirthdayModel.selectedLanguage != null) {
				mainViewUI.languageFullList_spinnerlist.selectedItem = happyBirthdayModel.selectedLanguage
			}
			
			//WE MAY BE RETURNING FROM 'SONG VIEW' AND HAVE A LANGUAGE SET
			_onSelectedLanguageChanged(happyBirthdayModel.selectedLanguage);
		}
		
		
		/**
		 * Handles the Signal: <code>SelectedLanguageChangedSignal</code>.
		 * 
		 * @param aSelectedLanguage_str : String
		 *  
		 * @return void
		 * 
		 */
		private function _onSelectedLanguageChanged (aSelectedLanguage : LanguageVO):void
		{
			if (aSelectedLanguage && aSelectedLanguage.languageCode.length > 0) {
				mainViewUI.loadMessage_button.enabled = true;
			} else {
				mainViewUI.loadMessage_button.enabled = false;
			}
		}
		
		
		/**
		 * Handles the Signal: <code>GuestChangedSignal</code>.
		 * 
		 * @param aGuestVO : GuestVO
		 *  
		 * @return void
		 * 
		 */
		private function _onGuestChanged (aGuestVO : GuestVO):void
		{
			//SOMETIMES CHANGING GENDER SHOULD CHANGE THE NAME (ONLY IF THE USER HAS NEVER SET THE NAME)
			//SET IT, BUT ONLY IF ITS NOT A MATCH (TO PREVENT A POTENTIAL INVINITE LOOP OF VIEW->MODEL->VIEW->ECT...
			if (mainViewUI.guestName_textinput.text != aGuestVO.name) {
				mainViewUI.guestName_textinput.text = aGuestVO.name;
			}		
		}
		
	}
}