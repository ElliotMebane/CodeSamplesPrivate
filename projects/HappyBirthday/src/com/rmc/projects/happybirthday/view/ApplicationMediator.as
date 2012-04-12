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
	import com.rmc.projects.happybirthday.controller.signals.flexmobile.StageOrientationChangeSignal;
	import com.rmc.projects.happybirthday.controller.signals.flexmobile.ViewNavigatorPopViewSignal;
	import com.rmc.projects.happybirthday.controller.signals.flexmobile.ViewNavigatorPushViewSignal;
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.model.events.PhrasesModelEvent;
	import com.rmc.projects.happybirthday.model.events.ViewNavigatorEvent;
	import com.rmc.projects.happybirthday.model.vo.PhrasesVO;
	
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.ViewNavigator;
	
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
	public class ApplicationMediator extends Mediator
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
		public var application : Main;
		
		/**
		 * Signal: Marks a request on <code>ViewNavigator</code>
		 * 
		 */	
		[Inject]
		public var viewNavigatorPushViewSignal : ViewNavigatorPushViewSignal;
		
		/**
		 * Signal: Marks a request on <code>ViewNavigator</code>
		 * 
		 */	
		[Inject]
		public var viewNavigatorPopViewSignal : ViewNavigatorPopViewSignal;
		
		/**
		 * Signal: Marks a request on <code>ViewNavigator</code>
		 * 
		 */	
		[Inject]
		public var stageOrientationChangeSignal : StageOrientationChangeSignal;
		
		/**
		 * Reference: <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var phrasesModel : PhrasesModel;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function ApplicationMediator()
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
			//	UI
			//	I WASN'T SURE WHEN 'STAGE' IS AVAILABLE ON THE UI SO I JUST DECLARE THIS HERE
			//	Context Listeners
			viewNavigatorPushViewSignal.add 			(_onViewNavigatorPushViewSignal);
			viewNavigatorPopViewSignal.add 				(_onViewNavigatorPopViewSignal);
			phrasesModel.changedPhrasesModelSignal.add 	(_onPhrasesModelChanged);
			
			//
		
		}
		
		//--------------------------------------
		//  Events
		//--------------------------------------
		//VIEW
		/**
		 * Handles the Event: <code>StageOrientationEvent.ORIENTATON_CHANGE</code>.
		 * 
		 * @param aEvent <code>StageOrientationEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onAddedToStageSignal (aEvent : Event) : void
		{
			application.stageOrientationChangeNativeSignal.add (_onStageOrientationChange);
			
		}
		/**
		 * Handles the Event: <code>StageOrientationEvent.ORIENTATON_CHANGE</code>.
		 * 
		 * @param aEvent <code>StageOrientationEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onStageOrientationChange(aEvent:StageOrientationEvent):void
		{
			stageOrientationChangeSignal.dispatch(aEvent);
			
		}
		
		
		//CONTEXT
		
		/**
		 * Handles the Signal: <code>ViewNavigatorPushViewSignal</code>.
		 * 
		 * @param aEvent <code>ViewNavigatorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onViewNavigatorPushViewSignal (aEvent : ViewNavigatorEvent):void
		{
			
			//	CHANGE VIEW
			(application.navigator as ViewNavigator).pushView(aEvent.viewClass, null, null, aEvent.viewTransition);
			
		}
		
		
		/**
		 * Handles the Signal: <code>ViewNavigatorPushViewSignal</code>.
		 * 
		 * @param aEvent <code>ViewNavigatorEvent</code> The incoming aEvent payload.
		 * 
		 * @return void
		 * 
		 */
		private function _onViewNavigatorPopViewSignal (aEvent : ViewNavigatorEvent):void
		{
			
			//	CHANGE VIEW
			application.navigator.popView(aEvent.viewTransition);
			
		}
		
		/**
		 * Handles the Signal: <code>ChangedPhrasesModelSignal</code>.
		 * 
		 * @param aEvent <code>PhrasesModelEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onPhrasesModelChanged (aEvent : PhrasesModelEvent):void
		{
			
			var phrasesVO : PhrasesVO = aEvent.phrasesModel.phrasesVO;
			
		}
		
	}
}