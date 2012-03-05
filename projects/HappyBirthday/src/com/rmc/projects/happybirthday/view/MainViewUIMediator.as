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
	import com.rmc.projects.happybirthday.controller.signals.LoadSongSignal;
	import com.rmc.projects.happybirthday.controller.signals.SelectedLanguageChangeSignal;
	import com.rmc.projects.happybirthday.model.HappyBirthdayModel;
	import com.rmc.projects.happybirthday.model.vo.LanguageVO;
	import com.rmc.projects.happybirthday.view.components.views.MainViewUI;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayList;
	
	import spark.events.IndexChangeEvent;
	
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
		 * Signal: Marks a request to change the Model
		 * 
		 */	
		[Inject]
		public var selectedLanguageChangeSignal : SelectedLanguageChangeSignal;

		
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
			
			//	Context Listeners
			happyBirthdayModel.languagesFullListChangedSignal.add   (_onLanguageFullListChanged);
			happyBirthdayModel.selectedLanguageChangedSignal.add 	(_onSelectedLanguageChanged);
			
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
		private function _onLoadButtonClick (aEvent : MouseEvent):void
		{
			loadMessageModelSignal.dispatch(mainViewUI.languageFullList_spinnerlist.selectedItem);
		}
		
		//CONTEXT
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
			//THIS VIEW LOADS AFTER THE DATA, SO WE FORCE A CALL HERE AND REACH INTO THE EXISTING MODEL
			if (!aLanguageFullList_array) {
				mainViewUI.languageFullList_spinnerlist.dataProvider = new ArrayList (happyBirthdayModel.languagesFullList);
				
			//IF THE DATA EVER CHANGES DURING THE APP (SO FAR, THIS DOESN'T HAPPEN) WE'LL CATCH THE UPDATES
			} else {
				mainViewUI.languageFullList_spinnerlist.dataProvider = new ArrayList (aLanguageFullList_array);
			}
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
			
			//IF NOTHING IS SET - RESET IT OR IF THE FIRST, 'EMPTY' SPINNER LIST IS SELECTED, DO NOT ALLOW A SELECTION
			if (aSelectedLanguage == null || aSelectedLanguage.languageCode == "") {
				//WHEN RESETING TO THIS VIEW FROM 'SONGVIEW'
				mainViewUI.languageFullList_spinnerlist.selectedIndex = 0;
				mainViewUI.loadMessage_button.enabled = false;
			} else {
				
				if (mainViewUI) {
					mainViewUI.loadMessage_button.enabled = true;
				}
			}
		}
		
	}
}