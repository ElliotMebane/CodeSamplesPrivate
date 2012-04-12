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
package com.rmc.projects.happybirthday.utils
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	
	import mx.core.DPIClassification;
	
	import spark.components.supportClasses.StyleableTextField;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>Help with CSS </p>
	 * 
	 */
	public class CSSUtility	
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC STATIC
		/**
		 * CSS STYLE
		 */	
		public static const SONG_NAME : String 		= "songName";
		
		/**
		 * CSS STYLE
		 * 
		 */	
		public static const SONG_BODY : String 		= "songBody";
		
		/**
		 * CSS STYLE
		 * 
		 */	
		public static const GUEST_NAME : String 	= "guestName";
		
		/**
		 * CSS STYLE
		 * 
		 */	
		public static const GUEST_GENDER : String 	= "guestGender";
		
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		
		// --------------------------------------
		// Programmatic styling
		//
		//	We use ./styles/styles.css for most things, 
		//  but this is for the SongViewUI.mxml's lyrics 
		//	textbox (the big one)
		//
		// --------------------------------------
		/**
		 * Wrap a span tag
		 * 
		 * @param aSource_str
		 * @param aSpanClass_str
		 * 
		 * @string of wrapped goodness 
		 * 
		 */		
		public static function WrapWithSpan (aSource_str : String, aSpanClass_str : String) : String
		{
			return "<span class = '"+aSpanClass_str+"' >" + aSource_str + "</span>";
		}
		
		/**
		 * Add the styles to the textfield. We do it here, so its easy to edit/ammend
		 * This is for the SongViewUI.mxml's lyrics textbox (the big one)
		 *  
		 * @param aStyleableTextField : StyleableTextField
		 * 
		 * @return void
		 * 
		 */		
		public static function doPrepareStyleableTextField (aStyleableTextField : StyleableTextField) : void 
		{
			var songNameFontSize_uint : uint;
			var songBodyFontSize_uint : uint;
			
			/*
			
				PROPERLY DETECTING SCREEN SIZE NEEDS SOME WORK
			
			*/
			
			switch (DensityUtil.getRuntimeDPI()) {
				
				//DROID 2
				case DPIClassification.DPI_240:
					songNameFontSize_uint = 50;
					songBodyFontSize_uint = 30;
					break;
				//SMALL SCREENS (3GS) and IPHONE4
				case DPIClassification.DPI_320:
				case DPIClassification.DPI_160:
					
					//NOT SURE WHY, BUT IPAD IS COMING AS DPI 132 BUT DPICLASSIF OF 160
					if (Capabilities.screenDPI == 132) {
						//iPAD
						songNameFontSize_uint = 100;
						songBodyFontSize_uint = 80;
						
					} else {
						//NORMAL
						songNameFontSize_uint = 50;
						songBodyFontSize_uint = 30;
					}
					break;
				default:
					throw new Error ("Error With DensityUtil.getRuntimeDPI() of " + DensityUtil.getRuntimeDPI());
					break;
			}
			
			var myStyles:String;
			//
			myStyles =  ".requiredDummyStyle { fontSize: 80;   }"; //declare here but never use
			//
			myStyles += ".songName  { fontSize: "+songNameFontSize_uint+"; textAlign: center; fontWeight: bold;  }";
			myStyles += ".songBody  { fontSize: "+songBodyFontSize_uint+"; fontStyle : italic;   }";
			//
			myStyles += ".guestName   { fontWeight: bold; }"; //works, keep 'empty' as {} (no spaces) add properties as needed
			myStyles += ".guestGender { textDecoration:underline; }";
			//
			var myStyleSheet:StyleSheet = new StyleSheet();
			myStyleSheet.parseCSS(myStyles);
			aStyleableTextField.styleSheet = myStyleSheet;
			
		}
		
		
	}
	
}
