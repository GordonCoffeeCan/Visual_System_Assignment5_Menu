package
{
	import com.greensock.TweenMax;
	import flash.system.fscommand;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width = "1920", height = "1080", frameRate="30", backgroundColor = "#636A74")]
	
	public class Main extends Sprite
	{
		private var farBuilding:FarBuilding_mc;
		private var helicopter:HelicopterAnim_mc;
		private var nearBuilding:NearBuilding_mc;
		private var light:LightAnim_mc;
		private var characterBuilding:CharactersBuilding_mc;
		private var title:Title_mc;
		private var menu:Menu_mc;
		
		private var resumeBtn:MovieClip;
		private var newGameBtn:MovieClip;
		private var loadGameBtn:MovieClip;
		private var settingsBtn:MovieClip;
		private var quitBtn:MovieClip;
		
		private var buttonArray:Array;
		
		public function Main()
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
			farBuilding = new FarBuilding_mc();
			helicopter = new HelicopterAnim_mc();
			nearBuilding = new NearBuilding_mc();
			light = new LightAnim_mc();
			characterBuilding = new CharactersBuilding_mc();
			title = new Title_mc();
			menu = new Menu_mc();
			
			resumeBtn = menu.Resume_mc;
			newGameBtn = menu.NewGame_mc
			loadGameBtn = menu.LoadGame_mc;
			settingsBtn = menu.Settings_mc;
			quitBtn = menu.Quit_mc;
			
			buttonArray = new Array(resumeBtn, newGameBtn, loadGameBtn, settingsBtn, quitBtn);
			
			for(var i:int; i < menu.numChildren; i++){
				ActiveButton(buttonArray[i]);
				buttonArray[i].gotoAndStop(i + 1);
				TweenMax.to(buttonArray[i], 0, {autoAlpha: 0.3});
			}
		}
		
		private function SetLayout():void{
			this.addChild(farBuilding);
			this.addChild(helicopter);
			this.addChild(nearBuilding);
			this.addChild(light);
			this.addChild(characterBuilding);
			this.addChild(title);
			this.addChild(menu);
			
			title.x = 100; title.y = 265;
			menu.x = 100; menu.y = 493;
		}
		
		private function ActiveButton(_mc:MovieClip):void{
			_mc.buttonMode = true;
			_mc.addEventListener(MouseEvent.CLICK, OnClick);
			_mc.addEventListener(MouseEvent.MOUSE_OVER, OnOver);
			_mc.addEventListener(MouseEvent.MOUSE_OUT, OnOut);
			
		}
		
		private function InactiveButton(_mc:MovieClip):void{
			_mc.buttonMode = false;
			_mc.removeEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function OnClick(event:MouseEvent):void{
			switch(event.target.name){
				case "Quit_mc":
					fscommand("quit");
					break;
			}
		}
		
		private function OnOver(event:MouseEvent):void{
			TweenMax.to(event.target, 0.5, {autoAlpha: 1});
		}
		
		private function OnOut(event:MouseEvent):void{
			TweenMax.to(event.target, 0.5, {autoAlpha: 0.3});
		}
	}
}