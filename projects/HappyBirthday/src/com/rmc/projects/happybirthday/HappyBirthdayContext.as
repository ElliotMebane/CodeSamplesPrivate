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
package com.rmc.projects.happybirthday
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.happybirthday.controller.ClearSelectedLanguageCommand;
	import com.rmc.projects.happybirthday.controller.LoadHappyBirthdayModelCommand;
	import com.rmc.projects.happybirthday.controller.LoadPhrasesCommand;
	import com.rmc.projects.happybirthday.controller.LoadSongCommand;
	import com.rmc.projects.happybirthday.controller.SelectedLanguageChangeCommand;
	import com.rmc.projects.happybirthday.controller.ShutdownCommand;
	import com.rmc.projects.happybirthday.controller.StartupCommand;
	import com.rmc.projects.happybirthday.controller.signals.ClearSelectedLanguageSignal;
	import com.rmc.projects.happybirthday.controller.signals.LoadHappyBirthdayModelSignal;
	import com.rmc.projects.happybirthday.controller.signals.LoadPhrasesModelSignal;
	import com.rmc.projects.happybirthday.controller.signals.LoadSongSignal;
	import com.rmc.projects.happybirthday.controller.signals.SelectedLanguageChangeSignal;
	import com.rmc.projects.happybirthday.controller.signals.ViewNavigatorPopViewSignal;
	import com.rmc.projects.happybirthday.controller.signals.ViewNavigatorPushViewSignal;
	import com.rmc.projects.happybirthday.model.HappyBirthdayModel;
	import com.rmc.projects.happybirthday.model.PhrasesModel;
	import com.rmc.projects.happybirthday.services.HappyBirthdayLoadService;
	import com.rmc.projects.happybirthday.services.ILoadService;
	import com.rmc.projects.happybirthday.services.PhrasesLoadService;
	import com.rmc.projects.happybirthday.view.AbstractViewMediator;
	import com.rmc.projects.happybirthday.view.ApplicationMediator;
	import com.rmc.projects.happybirthday.view.MainViewUIMediator;
	import com.rmc.projects.happybirthday.view.SongViewUIMediator;
	import com.rmc.projects.happybirthday.view.components.views.AbstractView;
	import com.rmc.projects.happybirthday.view.components.views.MainViewUI;
	import com.rmc.projects.happybirthday.view.components.views.SongViewUI;
	
	import flash.events.Event;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.SignalContext;
	
	/**
	 * <p>The Context is the 'glue' or 'brains of the application 
	 * 			    linking together the Model, View, Controller, and Services</p>
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
	public class HappyBirthdayContext extends SignalContext
	{
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function HappyBirthdayContext ()
		{
			super();
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		
		//--------------------------------------
		//  Methods
		//--------------------------------------		
		//PUBLIC	
		/**
		 * Start the application. Map model, view, controller concerns and kickoff the first event.
		 * 
		 * @return void
		 * 
		 */
		override public function startup() : void
		{

			//Do in this order so the injections and references work well
			_startupModel();        //1
			_startupServices();     //2
			_startupController();   //3
			_startupView();         //4
			
			// And we're done
			super.startup();
			dispatchEvent(new Event (ContextEvent.STARTUP));
			
		}
		
		/**
		 * Map: Model
		 * 
		 * @return void
		 * 
		 */
		protected function _startupModel() : void
		{	
			//	Model
			var phrasesModel : PhrasesModel = new PhrasesModel(); 	//Instantiated manually so I can set a default value (langcode)
			phrasesModel.langCode 			= PhrasesModel.EN;
			injector.mapValue		(PhrasesModel, phrasesModel);
			injector.mapSingleton	(HappyBirthdayModel);			//Instantiated automatically by RL	
			injector.mapSingleton	(ViewNavigatorPushViewSignal);	
			injector.mapSingleton	(ViewNavigatorPopViewSignal);	
			
			//SIGNALS SETUP WITHIN THIS CONTEXT - 1 OF 2: SIGNALS THAT ARE *NOT* MAPPED TO COMMANDS, BUT JUST OBSERVED DIRECTLY
			//b. RESPONSES
			//injector.mapSingleton(Some_signal_class); //not needed in our example
			
		}
		
		
		/**
		 * Map: View
		 * 
		 * @return void
		 * 
		 */
		protected function _startupView() : void
		{
			
			mediatorMap.mapView		(Main, 		 	ApplicationMediator);
			mediatorMap.mapView		(MainViewUI, 	MainViewUIMediator); //optional 3rd parameter, [MainViewUI]);
			mediatorMap.mapView		(SongViewUI, 	SongViewUIMediator);  //optional 3rd parameter, [SongViewUI]);
			
		}
		
		/**
		 * Map: Controller
		 * 
		 * @return void
		 * 
		 */
		protected function _startupController() : void
		{
			
			//SIGNALS SETUP WITHIN THIS CONTEXT - 2 OF 2: SIGNALS THAT ARE MAPPED TO COMMANDS
			//a. REQUESTS
			signalCommandMap.mapSignalClass(SelectedLanguageChangeSignal,	SelectedLanguageChangeCommand);
			signalCommandMap.mapSignalClass(LoadSongSignal,					LoadSongCommand);
			signalCommandMap.mapSignalClass(ClearSelectedLanguageSignal,    ClearSelectedLanguageCommand);
			//
			signalCommandMap.mapSignalClass(LoadPhrasesModelSignal,   		LoadPhrasesCommand);
			signalCommandMap.mapSignalClass(LoadHappyBirthdayModelSignal,  	LoadHappyBirthdayModelCommand);
			
			//
			commandMap.mapEvent 		(ContextEvent.STARTUP,  StartupCommand);
			commandMap.mapEvent 		(ContextEvent.SHUTDOWN, ShutdownCommand);
		}
		
		/**
		 * Map: Services
		 * 
		 * @return void
		 * 
		 */
		protected function _startupServices() : void
		{	

			injector.mapSingletonOf (ILoadService, 	PhrasesLoadService, 		"PhrasesLoadService");
			injector.mapSingletonOf (ILoadService, HappyBirthdayLoadService, 	"HappyBirthdayLoadService");
			
		}
		
	}
}