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
package com.rmc.projects.happybirthday.controller
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.happybirthday.AssetManager;
	import com.rmc.projects.happybirthday.controller.signals.ViewNavigatorPopViewSignal;
	import com.rmc.projects.happybirthday.model.HappyBirthdayModel;
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.model.events.ViewNavigatorEvent;
	import com.rmc.projects.happybirthday.services.ILoadService;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.transitions.FlipViewTransition;
	
	
	/**
	 * <p>Command: Clearing the message for the application</p>
	 * 
	 */
	public class ClearSelectedLanguageCommand extends Command
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Reference to the MessageModel
		 * 
		 */
		[Inject]
		public var happyBirthdayModel : HappyBirthdayModel;
		
		/**
		 * Signal: Change the View
		 * 
		 */
		[Inject]
		public var viewNavigatorPopViewSignal : ViewNavigatorPopViewSignal;
		
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Execute the command
		 * 
		 * @return void
		 *
		 */
		override public function execute():void
		{
			
			//	CHANGE MESSAGE
			happyBirthdayModel.selectedLanguage = null;
			
			//	CLEAR THE SONG (COMMENT OUT FOR NOW BECAUSE IT VISIBLY GOES BLANK BEFORE WE LEAVE THE SCREEN - WE MAY NEVER WANT THAT ACTUALLY)
			//happyBirthdayModel.currentSong 		= null;
			
			//	CHANGE VIEW
			viewNavigatorPopViewSignal.dispatch(new ViewNavigatorEvent (ViewNavigatorEvent.POP_VIEW, null, AssetManager.getViewTransition(ViewNavigatorEvent.POP_VIEW) ) );
			
		}
	}
}