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
	import com.rmc.projects.happybirthday.AssetManager;
	import com.rmc.projects.happybirthday.controller.signals.ClearSelectedLanguageSignal;
	import com.rmc.projects.happybirthday.controller.signals.LoadPhrasesModelSignal;
	import com.rmc.projects.happybirthday.model.HappyBirthdayModel;
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.model.events.PhrasesModelEvent;
	import com.rmc.projects.happybirthday.model.vo.SongVO;
	import com.rmc.projects.happybirthday.utils.CSSUtility;
	import com.rmc.projects.happybirthday.utils.DensityUtil;
	import com.rmc.projects.happybirthday.utils.SongLyricsFilter;
	import com.rmc.projects.happybirthday.view.components.views.SongViewUI;
	
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.supportClasses.StyleableStageText;
	import spark.components.supportClasses.StyleableTextField;
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>Mediator</code> managing the I/O to the UI: MainUI</p>
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
	public class SongViewUIMediator extends AbstractViewMediator
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
		public var songViewUI : SongViewUI;
		
		/**
		 * Signal: Marks a request to clear the <code>MessageModel</code>
		 * 
		 */	
		[Inject]
		public var clearSelectedLanguageSignal : ClearSelectedLanguageSignal;
		
		/**
		 * Reference: <code>HappyBirthdayModel</code>
		 * 
		 */	
		[Inject]
		public var happyBirthdayModel : HappyBirthdayModel;
		
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function SongViewUIMediator()
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
			//  Super
			super.onRegister()
			
			// 	View Listeners
			songViewUI.backButtonClick.add  (_onHomeButtonClick);
			
			//	Context Listeners
			happyBirthdayModel.currentSongChangedSignal.add (_onCurrentSongChanged);
			
			//	Clear Layout
			happyBirthdayModel.loadCurrentSongFromSelectedLanguage ();
			
		}
		
		
		/**
		 * Robotlegs Requirement: Handles Event of Removal
		 * 
		 * @return void
		 *
		 */
		override public function onRemove():void
		{
			//  SUPER
			super.onRemove();
			
			//THE UI IS REMOVED FOR US, ANY OTHER CLEANUP TO DO?
			
			// 	View Listeners
			songViewUI.backButtonClick.remove (_onHomeButtonClick);
			
			//	Context Listeners
			happyBirthdayModel.currentSongChangedSignal.remove (_onCurrentSongChanged);
			
		}
		
		
		//VIEW
		/**
		 * Handles the aEvent: <code>MouseEvent.CLICK</code>.
		 * 
		 * @param aEvent <code>MouseEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onHomeButtonClick (aEvent : MouseEvent):void
		{
			clearSelectedLanguageSignal.dispatch();
			
		}
		
		//CONTEXT
		/**
		 * Handles the Signal: <code>ChangedPhrasesModelSignal</code>.
		 * 
		 * @param aEvent <code>PhrasesModelEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		override protected function _onPhrasesModelChanged (aEvent : PhrasesModelEvent):void
		{
			super._onPhrasesModelChanged(aEvent);
			
			_doShowSong();
		}
		
		/**
		 * Handles the Signal: <code>ChangedMessageModelSignal</code>.
		 * 
		 * @param String <code>aMessage</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onCurrentSongChanged (aSongVO : SongVO):void
		{
			_doShowSong();
			
		}
		
		/**
		 * Wait for both PhrasesModel and HappyBirthdayModel to 
		 * send data (both are fast but the order is uknown)
		 * 
		 */
		private function _doShowSong () : void
		{
			//WAIT FOR BOTH TO BE READY
			if (songViewUI.phrasesVO != null && happyBirthdayModel.currentSong != null && happyBirthdayModel.selectedLanguage != null) {
				
				//UPDATE TITLE
				songViewUI.title = happyBirthdayModel.selectedLanguage.title; //+ songViewUI.phrasesVO.songViewTitle_str;
				
				//STYLES, TODO - optimize - maybe move this to happen just once?
				CSSUtility.doPrepareStyleableTextField ( StyleableTextField(songViewUI.textarea.textDisplay) );
				StyleableTextField(songViewUI.textarea.textDisplay).wordWrap = true;
				StyleableTextField(songViewUI.textarea.textDisplay).selectable = true;
				
				
				//DO REPLACEMENTS for name/gender - the title too may have some replacements
				var title_str : String = SongLyricsFilter.filterLyricsForGuestVO (happyBirthdayModel.currentSong.title, happyBirthdayModel.guestVO);
				var lyrics_str : String = SongLyricsFilter.filterLyricsForGuestVO (happyBirthdayModel.currentSong.lyrics, happyBirthdayModel.guestVO);
				
				//GRAB VALUE
				var message_str : String = "";
				message_str +=  CSSUtility.WrapWithSpan( title_str, CSSUtility.SONG_NAME);
				message_str += "<BR>";
				message_str += "<BR>";
				message_str +=  CSSUtility.WrapWithSpan( lyrics_str, CSSUtility.SONG_BODY);
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "<BR>";
				message_str += "DEBUGGING INFO...";
				message_str += "<BR>";
				message_str += " .screenDPI      = "+Capabilities.screenDPI;
				message_str += "<BR>";
				message_str += " .getRuntimeDPI() = "+DensityUtil.getRuntimeDPI();
				message_str += "<BR>";
				//
				StyleableTextField(songViewUI.textarea.textDisplay).htmlText = message_str;
			}
			
		}
		
		
		
	}
}