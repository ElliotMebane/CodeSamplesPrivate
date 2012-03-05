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
	import com.rmc.projects.happybirthday.controller.signals.LoadPhrasesModelSignal;
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.model.events.PhrasesModelEvent;
	import com.rmc.projects.happybirthday.view.components.views.AbstractView;
	
	import org.robotlegs.mvcs.Mediator;
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	
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
	public class AbstractViewMediator extends Mediator
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC
		/**
		 * Signal: Marks a request to load the <code>PhrasesModel</code>
		 * 
		 */	
		[Inject]
		public var loadPhrasesModelSignal : LoadPhrasesModelSignal;
		
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
		public function AbstractViewMediator()
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
			//Model
			phrasesModel.changedPhrasesModelSignal.add (_onPhrasesModelChanged);
			
			//	RE-CALL EACH TIME THIS VIEW IS POPPED ON
			//trace ("abm.onRegister() for " + getViewComponent());
			loadPhrasesModelSignal.dispatch ();
			
		}
		
		/**
		 * Robotlegs Requirement: Handles Event of Removal
		 * 
		 * @return void
		 *
		 */
		override public function onRemove():void
		{
			//THE UI IS REMOVED FOR US, ANY OTHER CLEANUP TO DO?
			//trace ("abm.onRemove() for  " + getViewComponent());
			
			//Model
			phrasesModel.changedPhrasesModelSignal.remove (_onPhrasesModelChanged);
			
		}
		
		
		/**
		 * Handles the Signal: <code>ChangedPhrasesModelSignal</code>.
		 * 
		 * @param aEvent <code>PhrasesModelEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		protected function _onPhrasesModelChanged (aEvent : PhrasesModelEvent):void
		{
			
			//WE SEE MAIN THEN SONG PROPERLY, WHEN WE RETURN TO MAIN getViewComponent() is null, but somehow its phrases still render. Fine for now.
			if (getViewComponent()) {
				(getViewComponent() as AbstractView).phrasesVO = aEvent.phrasesModel.phrasesVO;
			}
		}
		
		
	}
}