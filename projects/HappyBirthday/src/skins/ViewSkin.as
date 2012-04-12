package skins
{
	import com.rmc.errors.SwitchStatementDefaultError;
	import com.rmc.projects.happybirthday.utils.DensityUtil;
	import com.rmc.utils.RMCGlobals;
	import com.rmc.utils.ScreenDPIClassification;
	
	import flash.display.Screen;
	import flash.system.Capabilities;
	
	import mx.core.DPIClassification;
	
	import spark.components.Group;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.ViewNavigatorSkin;
	
	public class ViewSkin extends ViewNavigatorSkin
	{
		
		[Embed(source="../assets_compiletime/images/viewBackground160.jpg")]
		private var bgClass160:Class;
		
		[Embed(source="../assets_compiletime/images/viewBackground240.jpg")]
		private var bgClass240:Class;
		
		[Embed(source="../assets_compiletime/images/viewBackground320.jpg")]
		//		[Embed(source="/assets/skins/detailbg320.jpg")]
		private var bgClass320:Class;
		
		private var bgClass:Class;
		
		private var bg:BitmapImage = new BitmapImage();
		private var holder:Group = new Group;
		
		
		public function ViewSkin()
		{
			
			addChild(holder);
			
			//NOTE: Some blog says to use applicationDPI, but that showed 320 for all 3 iOS devices
			//		So I will use DensityUtil.getRuntimeDPI()
			
			//NOTE: this setup is *NOT* traditional. I'm naming my jpgs and choosing which to show in an experimental way
			
			switch (applicationDPI) {
				case 320:
					switch (Capabilities.screenDPI) {
						//ScreenDPI: iPad & iPad 2
						case ScreenDPIClassification.DPI_132:
							bg.source = bgClass160;
							break;
						//ScreenDPI: iPod Touch & iPhone 3
						case ScreenDPIClassification.DPI_163:
							bg.source = bgClass240;
							break;
						//ScreenDPI: iPhone 4
						case ScreenDPIClassification.DPI_326:
							bg.source = bgClass320;
							break;
						default:
							
							
							//DONT MAKE AN ERROR (I'M TESTING ANDROID)
							bg.source = bgClass320;
							//throw new SwitchStatementDefaultError ();
							break;
					}
				case 240:
					bg.source = bgClass240;
					break;
				default:
					bg.source = bgClass160;
					break;
			}
			
			holder.addElement(bg);
			
			trace ("d: " + DensityUtil.getRuntimeDPI());
			trace ("160: " + DPIClassification.DPI_160);
			trace ("240: " + DPIClassification.DPI_240);
			trace ("320: " + DPIClassification.DPI_320);
			trace ("screenDPI: " + Capabilities.screenDPI);
			trace ("applicationDPI: " + applicationDPI);
		}
		
		override protected function childrenCreated():void{
			super.childrenCreated();
			
			//THIS OFFSETS THE BACKGROUND ART, IT DOESN'T ACTUALLY AFFECT THE ACTION BAR, RIGHT?
			this.actionBar.height = 0;
		}
		
		override protected function drawBackground(aWidth_num : Number, aHeight_num : Number ) : void
		{
			bg.width = aWidth_num;
			bg.height = aHeight_num;
		}
		
	}
}