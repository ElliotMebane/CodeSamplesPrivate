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
package com.rmc.projects.happybirthday.model.events
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.model.vo.PhrasesVO;
	
	import flash.events.Event;
	
	import spark.transitions.ViewTransitionBase;
	
	/**
	 * <p>Event: For changes-to and changes-from the ViewNavigator</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello (code [at] RivelloMultimediaConsulting [dot] com)</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * <p>CREATION DATE 	: Apr 05, 2010</p>
	 * 
	 * @example Here is a code example.  
	 * 
	 * <listing version="3.0" >
	 * 	//Code example goes here.
	 * </listing>
	 *
	 */
	public class ViewNavigatorEvent extends Event
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Reference to the <code>ViewClass</code> to be pushed.
		 * 
		 */	
		public function get viewClass() 						: Class 		{ return _viewClass; }
		public function set viewClass(aValue : Class) 		: void 			{ _viewClass = aValue; }
		private var _viewClass : Class;
		
		/**
		 * Reference to the <code>ViewTransitionBase</code> to be used between views (such as fade/zoom)
		 * 
		 */	
		public function get viewTransition() 							: ViewTransitionBase 	{ return _viewTransition; }
		public function set viewTransition(aValue : ViewTransitionBase) 	: void 					{ _viewTransition = aValue; }
		private var _viewTransition : ViewTransitionBase;
		
		
		
		
		/**
		 * EventType Name
		 * 
		 */	
		public static const PUSH_VIEW : String = "PUSH_VIEW";
		
		/**
		 * EventType Name
		 * 
		 */	
		public static const POP_VIEW : String = "POP_VIEW";
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function ViewNavigatorEvent (aType_str : String, aViewClass : Class = null, aViewTransition : ViewTransitionBase = null)
		{
			super (aType_str);
			viewClass = aViewClass;
			viewTransition = aViewTransition
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Robotlegs Requirement: Clone the event
		 * 
		 * @return Event
		 *
		 */
		override public function clone () : Event
		{
			return new ViewNavigatorEvent (type, viewClass);
		}
		
		
	}
}