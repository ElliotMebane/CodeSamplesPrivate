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
package com.rmc.projects.happybirthday.model
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.happybirthday.controller.signals.CurrentSongChangedSignal;
	import com.rmc.projects.happybirthday.controller.signals.SelectedLanguageChangeSignal;
	import com.rmc.projects.happybirthday.model.vo.LanguageVO;
	import com.rmc.projects.happybirthday.model.vo.SongVO;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * <p>Model managing data: Core Data for app</p>
	 * 
	 */
	public class HappyBirthdayModel extends Actor
	{
		//--------------------------------------
		//  Properties
		//--------------------------------------
		
		//PUBLIC SETTER/GETTER
		/**
		 * The selected language for the song to show
		 * 
		 */
		public function get selectedLanguage () 					: LanguageVO 	{ 	return _selectedLanguage; }
		public function set selectedLanguage (aValue : LanguageVO) 	: void 		{ 
			_selectedLanguage = aValue; 
			selectedLanguageChangedSignal.dispatch (_selectedLanguage);	

		}
		private var _selectedLanguage : LanguageVO; 
		
		
		/**
		 *  The current song to show
		 */		
		/**
		 *  
		 */		
		private var _currentSong : SongVO;
		public function get currentSong () 					: SongVO 	{ return _currentSong; }
		public function set currentSong (aValue : SongVO) 	: void 		{ 
			_currentSong = aValue; 
			currentSongChangedSignal.dispatch (_currentSong);		
		
		}
		
		
		/**
		 *  
		 */		
		private var _languagesFullList_array : Array;
		public function get languagesFullList () 					: Array 	{ return _languagesFullList_array; }
		public function set languagesFullList (aValue : Array) 	: void 		{ 
			_languagesFullList_array = aValue; 
			languagesFullListChangedSignal.dispatch (_languagesFullList_array);
		}
		
		//PUBLIC
		/**
		 * Signal: Marks a change to the <code>HappyBirthdayModel</code>
		 * 
		 * MUST BE CUSTOM TYPE: ONLY IF MAPPED TO A COMMAND
		 * 
		 */	
		public var selectedLanguageChangedSignal : SelectedLanguageChangeSignal;
		
		
		/**
		 * Signal: Marks a change to the <code>HappyBirthdayModel</code>
		 * 
		 * MUST BE CUSTOM TYPE: ONLY IF MAPPED TO A COMMAND
		 * 
		 */	
		public var currentSongChangedSignal : CurrentSongChangedSignal;
		
		
		/**
		 * Signal: Marks a change to the <code>HappyBirthdayModel</code>
		 * 
		 */	
		public var languagesFullListChangedSignal : Signal;
		
		/**
		 * The model will hold the raw xml for all songs. If we reach too many songs, we can load only 1 at a time in the future
		 * 
		 * using "_" to discourage use (but it must be public for the service to pass it in)
		 */	
		public var _rawSongs_xmllist : XMLList;
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function HappyBirthdayModel()
		{
			//SIGNALS
			languagesFullListChangedSignal 	= new Signal ();
			selectedLanguageChangedSignal 	= new SelectedLanguageChangeSignal ();
			currentSongChangedSignal 		= new CurrentSongChangedSignal ();
			
			//PROPERTIES
			_selectedLanguage 	= null;
			_currentSong		= null;
			languagesFullList 	= [{name: "(Select A Language)", data : null}, {name: "English", data : "ENGLISH"}, {name: "Portuguese", data : "PORTUGUESE"}]
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		//PUBLIC
		/**
		 * Load Song From External XML
		 * 
		 * @param aSelectedLanguage_str : String
		 * 
		 * @return void
		 * 
		 */
		public function loadCurrentSongFromSelectedLanguage () : void
		{
			//FETCH NEEDED XML FROM RAW XML
			
			var song_xmllist : XMLList = _rawSongs_xmllist.song.(@languageCode== _selectedLanguage.languageCode) ;		
			
			//	USE SETTER
			currentSong =  new SongVO (song_xmllist.title.toString(), song_xmllist.lyrics.toString(), song_xmllist.@languageCode);
			
			trace (currentSong.title);
		}

	
	}
}