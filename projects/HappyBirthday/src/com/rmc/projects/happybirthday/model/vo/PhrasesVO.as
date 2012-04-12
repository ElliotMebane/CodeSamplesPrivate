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
package com.rmc.projects.happybirthday.model.vo
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>Holds the data: For UI display </p>
	 * 
	 */
	[Bindable]
	public class PhrasesVO	
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC GETTER/SETTERS
		
		//PUBLIC
		/**
		 * Display Text: Title for view
		 * 
		 */		
		public var mainViewTitle_str : String;
		
		/**
		 * Display Text: Title for view
		 * 
		 */		
		public var songViewTitle_str : String;
		
		/**
		 * Display Text: Button label before interactivity.
		 * 
		 */		
		public var loadMessageButtonLabel_str : String;
		
		/**
		 * Display Text: Button tooltip  
		 * 
		 */		
		public var loadMessageButtonToolTip_str : String;
		
		/**
		 * Display Text: Button label
		 * 
		 */		
		public var backButtonLabel_str : String;
		
		/**
		 * Display Text: Button label
		 * 
		 */		
		public var shareButtonLabel_str : String;
		
		/**
		 * Display Text: Button tooltip  
		 * 
		 */		
		public var backButtonToolTip_str : String;
		
		/**
		 * Display Text: Label Text
		 * 
		 */		
		public var guestNameLabel_str : String;

		/**
		 * Display Text: Label Text
		 * 
		 */		
		public var guestGenderLabel_str : String;

		/**
		 * Display Text: Label Text
		 * 
		 */		
		public var guestGenderMaleRadioButtonLabel_str : String;

		/**
		 * Display Text: Label Text
		 * 
		 */		
		public var guestGenderFemaleRadioButtonLabel_str : String;
		

		/**
		 * Display Text: Label Text
		 * 
		 */		
		public var createdByUs_str : String;
		

		/**
		 * Display Text: Label Text
		 * 
		 */		
		public var legalText_str : String;
		
			

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function PhrasesVO ()
		{
			//SUPER
			super(); 

		}


		
	}
}
