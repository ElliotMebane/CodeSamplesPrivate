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
package com.rmc.projects.happybirthday.services
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.happybirthday.model.HappyBirthdayModel;
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.model.vo.LanguageVO;
	import com.rmc.projects.happybirthday.model.vo.PhrasesVO;
	import com.rmc.projects.happybirthday.model.vo.SongVO;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * <p>Handles the loading of all languages and songs</p>
	 * 
	 */
	public class HappyBirthdayLoadService extends Actor implements ILoadService
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * Reference to the Model
		 * 
		 */
		[Inject]
		public var happyBirthdayModel:HappyBirthdayModel;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function HappyBirthdayLoadService()
		{
			
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Load data from XML
		 * 
		 * @return void
		 *
		 */
		public function load () : void
		{
			//SETUP
			var xmlDoc:XML = new XML();
			var urlLoader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest("./assets_runtime/xml/happy_birthday.xml");
			
			//LISTEN
			urlLoader.addEventListener(Event.COMPLETE, 			_onComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, 	_onIOError);
			
			//LOAD
			urlLoader.load(urlRequest);
			
		}
		
		/**
		 * Handles the aEvent: <code>Event.COMPLETE</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onComplete (aEvent : Event) : void 
		{
			
			//CONVERT FOREIGN DATA to app-specific usable data (bogus xml->string example here)
			var xml : XML = XML (aEvent.target.data);

			//SAVE SONGRAW XML
			happyBirthdayModel._rawSongs_xmllist = xml.songs;

			//CONVERT languages to objects
			var languages_xmllist : XMLList = xml.languages.language;
			var languages_array : Array = new Array();
			for each (var language:XML in languages_xmllist) {
				languages_array.push (new LanguageVO (language.@title, language.@languageCode) );
			}
			happyBirthdayModel.languagesFullList = languages_array
			
		};
		
			
		/**
		 * Handles the aEvent: <code>IOErrorEvent.IO_ERROR</code>.
		 * 
		 * @param aEvent <code>IOErrorEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		public function _onIOError (aEvent : IOErrorEvent) : void 
		{
			throw new IOError ("HappyBirthdayLoadService() " + aEvent);
			
		};
	}
}