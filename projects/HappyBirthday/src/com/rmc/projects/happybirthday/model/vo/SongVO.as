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
	 * <p>Holds the data: For a song </p>
	 * 
	 *
	 */
	public class SongVO	
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC GETTER/SETTERS
		
		//PUBLIC
		/**
		 * Display Text: Title 
		 * 
		 */		
		public var title : String;
		
		/**
		 * Display Text: Lyrics 
		 * 
		 */		
		public var lyrics : String;
		
		/**
		 * 
		 * Data: Used for lookup 
		 * 
		 */		
		public var languageCode : String;
		
		/**
		 * 
		 * Data: Used for showing the web page 
		 * 
		 */		
		public var wikipediaURL : String;
		

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function SongVO (aTitle_str : String, aLyrics_str : String, aLanguageCode_str : String, aWikipediaURL_str : String)
		{
			//SUPER
			super(); 
			title 			= aTitle_str;
			lyrics 			= aLyrics_str;
			languageCode 	= aLanguageCode_str;
			wikipediaURL    = aWikipediaURL_str;

		}


		
	}
}
