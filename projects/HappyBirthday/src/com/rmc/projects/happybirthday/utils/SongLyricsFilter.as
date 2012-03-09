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
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.rmc.projects.happybirthday.AssetManager;
	import com.rmc.projects.happybirthday.model.vo.GuestVO;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>LyricsFilter</code> class.</p>
	 * 
	 */
	public class SongLyricsFilter
	{
		// --------------------------------------
		// Properties
		// --------------------------------------
		/**
		 *  NAME: 
		 */		
		private static var _NAME_TOKEN : String = "{name}";
		
		/**
		 *  NAME: 1
		 */		
		private static var _GENDER_TOKEN : RegExp = /({gender:values)\((.*)\)}/g
		
		/**
		 * Create and return a version of the Lyrics with name/gender tokens swapped out for data from GuestVO
		 *  
		 * @param aLyrics_str
		 * @param aGuestVO
		 * 
		 * @return filteredLyrics_str
		 */		
		public static function filterLyricsForGuestVO (aLyrics_str : String, aGuestVO : GuestVO) : String
		{
			var filteredLyrics_str : String;
			
			//SWAP NAME (MULTIPLE SWAPS POSSIBLE) -the 'g' does the multiples
			filteredLyrics_str = aLyrics_str.replace(new RegExp (_NAME_TOKEN,"g"), CSSUtility.WrapWithSpan (aGuestVO.name, CSSUtility.GUEST_NAME) );

			//SWAP GENDER (MULTIPLE SWAPS POSSIBLE)
			// search for '{gender:values(liebe, lieber)}' and replace with 'liebe' or 'lieber' depending on gender
			// MALE = FIRST, FEMALE = SECOND
			filteredLyrics_str = filteredLyrics_str.replace( 
				_GENDER_TOKEN, 
				
				function (a : String, b : String, aValues_str : String, d : String, e : String) : String {
					
					var values_array : Array = aValues_str.split(",");
					
					if (aGuestVO.isMale) {
						return CSSUtility.WrapWithSpan ( values_array[0] as String , CSSUtility.GUEST_GENDER);
					} else {
						return CSSUtility.WrapWithSpan ( values_array[1] as String , CSSUtility.GUEST_GENDER);
					}
				} 
			);
			
			
			//     
			
			return filteredLyrics_str;
		}
		
		
	}
}