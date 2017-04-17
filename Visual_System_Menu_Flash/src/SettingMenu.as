package
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	[SWF(width = "1920", height = "1080", frameRate="60", backgroundColor = "#636A74")]
	
	public class SettingMenu extends MovieClip
	{
		public var settingSubmenu:SettingSubmenu_mc = new SettingSubmenu_mc();;
		
		private var controlItem:MovieClip;
		private var resolutionItem:MovieClip;
		private var audioItem:MovieClip;
		private var musicItem:MovieClip;
		
		private var controlSchemeName:MovieClip;
		private var resuNumbers:MovieClip;
		
		private var controlLeft:MovieClip;
		private var controlRight:MovieClip;
		private var resoLeft:MovieClip;
		private var resoRight:MovieClip;
		
		private var audioToggle:MovieClip;
		private var musicToggle:MovieClip;
		
		private var controlSchemeID:int = 1;
		private var resoNumberID:int = 1;
		
		private var audioToggleID:int = 1;
		private var musicToggleID:int = 1;
		
		public function SettingMenu()
		{
			if(stage){
				init();
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(event:Event = null):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			SetElements();
			SetLayout();
		}
		
		private function SetElements():void{
			controlItem = settingSubmenu.SettingBtnList_mc.Control_mc;
			resolutionItem = settingSubmenu.SettingBtnList_mc.Resolution_mc;
			audioItem = settingSubmenu.SettingBtnList_mc.Audio_mc;
			musicItem = settingSubmenu.SettingBtnList_mc.Music_mc;
			
			controlSchemeName = settingSubmenu.controlScheme_mc.ControlNames_mc;
			resuNumbers = settingSubmenu.resos_mc.resolutionNumbers_mc;
			
			controlLeft = settingSubmenu.controlScheme_mc.controlLeft_mc;
			controlRight = settingSubmenu.controlScheme_mc.controlRight_mc;
			
			resoLeft = settingSubmenu.resos_mc.resoLeft_mc;
			resoRight = settingSubmenu.resos_mc.resoRight_mc;
			
			audioToggle = settingSubmenu.AudioToggle_mc;
			musicToggle = settingSubmenu.MusicToggle_mc;
			
			SetItem(controlItem, 1);
			SetItem(resolutionItem, 2);
			SetItem(audioItem, 3);
			SetItem(musicItem, 4);
			
			SetItem(controlSchemeName, 1);
			SetItem(resuNumbers, 1);
			
			SetItem(controlLeft, 1, true);
			SetItem(controlRight, 1, true);
			SetItem(resoLeft, 1, true);
			SetItem(resoRight, 1, true);
			
			SetItem(audioToggle, 7, false, true);
			SetItem(musicToggle, 7, false, true);
		}
		
		private function SetLayout():void{
			this.addChild(settingSubmenu);
		}
		
		private function SetItem(_mc:MovieClip, _frame:int, isButton:Boolean = false, isToggle:Boolean = false):void{
			_mc.gotoAndStop(_frame);
			
			if(isButton){
				_mc.buttonMode = isButton;
				TweenMax.to(_mc, 0, {autoAlpha: 0.3});
				
				_mc.addEventListener(MouseEvent.CLICK, OnClick);
				_mc.addEventListener(MouseEvent.MOUSE_OVER, OnOver);
				_mc.addEventListener(MouseEvent.MOUSE_OUT, OnOut);
			}
			
			if(isToggle){
				_mc.buttonMode = isToggle;
				_mc.addEventListener(MouseEvent.CLICK, OnClick);
			}
		}
		
		private function OnClick(event:MouseEvent):void{
			
			switch(event.target){
				case controlLeft:
					controlSchemeID --;
					if(controlSchemeID == 0){
						controlSchemeID = 2;
					}
					break;
				case controlRight:
					controlSchemeID ++;
					if(controlSchemeID == 3){
						controlSchemeID = 1;
					}
					
					break;
				case resoLeft:
					resoNumberID --;
					if(resoNumberID == 0){
						resoNumberID = 5;
					}
					break;
				case resoRight:
					resoNumberID ++;
					if(resoNumberID == 6){
						resoNumberID = 1;
					}
					break;
				case audioToggle:
					audioToggleID *= -1;
					break;
				case musicToggle:
					musicToggleID *= -1;
					break;
			}
			
			controlSchemeName.gotoAndStop(controlSchemeID);
			resuNumbers.gotoAndStop(resoNumberID);
			
			if(audioToggleID > 0){
				TweenMax.to(audioToggle, 0.3, {frame: 7});
			}else{
				TweenMax.to(audioToggle, 0.3, {frame: 1});
			}
			
			if(musicToggleID > 0){
				TweenMax.to(musicToggle, 0.3, {frame: 7});
			}else{
				TweenMax.to(musicToggle, 0.3, {frame: 1});
			}
		}
		
		private function OnOver(event:MouseEvent):void{
			TweenMax.to(event.target, 0.3, {autoAlpha: 1});
		}
		
		private function OnOut(event:MouseEvent):void{
			TweenMax.to(event.target, 0.3, {autoAlpha: 0.5});
		}
	}
}