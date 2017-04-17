package
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	
	[SWF(width = "1920", height = "1080", frameRate="60", backgroundColor = "#636A74")]
	
	public class Main extends Sprite
	{
		private var farBuilding:FarBuilding_mc;
		private var helicopter:HelicopterAnim_mc;
		private var nearBuilding:NearBuilding_mc;
		private var light:LightAnim_mc;
		private var characterBuilding:CharactersBuilding_mc;
		private var title:Title_mc;
		private var menu:Menu_mc;
		
		private var samplePage:SamplePage;
		
		private var loadGameMenu:LoadGameMenu_mc;
		
		private var settingMenu:SettingMenu;
		
		private var characters:MovieClip;
		
		private var resumeBtn:MovieClip;
		private var newGameBtn:MovieClip;
		private var loadGameBtn:MovieClip;
		private var settingsBtn:MovieClip;
		private var quitBtn:MovieClip;
		
		private var slot1Btn:MovieClip;
		private var slot2Btn:MovieClip;
		private var slot3Btn:MovieClip;
		private var slot4Btn:MovieClip;
		private var slot5Btn:MovieClip;
		
		private var backBtn:MovieClip;
		
		private var settingBack:MovieClip;
		
		private var buttonArray:Array;
		private var slotBtnArray:Array;
		
		private var currentMenu:String;
		
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
			stage.displayState = StageDisplayState.FULL_SCREEN;
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
			
			samplePage = new SamplePage();
			
			loadGameMenu = new LoadGameMenu_mc();
			
			settingMenu = new SettingMenu();
			
			characters = characterBuilding.CharacterUI_mc;
			
			resumeBtn = menu.Resume_mc;
			newGameBtn = menu.NewGame_mc
			loadGameBtn = menu.LoadGame_mc;
			settingsBtn = menu.Settings_mc;
			quitBtn = menu.Quit_mc;
			
			slot1Btn = loadGameMenu.loadGameBtnList_mc.Slot1;
			slot2Btn = loadGameMenu.loadGameBtnList_mc.Slot2;
			slot3Btn = loadGameMenu.loadGameBtnList_mc.Slot3;
			slot4Btn = loadGameMenu.loadGameBtnList_mc.Slot4;
			slot5Btn = loadGameMenu.loadGameBtnList_mc.Slot5;
			backBtn = loadGameMenu.loadGameBtnList_mc.Back_mc;
			
			buttonArray = new Array(resumeBtn, newGameBtn, loadGameBtn, settingsBtn, quitBtn);
			slotBtnArray = new Array(slot1Btn, slot2Btn, slot3Btn, slot4Btn, slot5Btn, backBtn);
			
			for(var i:int = 0; i < menu.numChildren; i++){
				ActiveButton(buttonArray[i]);
				buttonArray[i].gotoAndStop(i + 1);
				TweenMax.to(buttonArray[i], 0, {autoAlpha: 0.3});
			}
			
			for(var j:int = 0; j < loadGameMenu.loadGameBtnList_mc.numChildren; j++){
				ActiveButton(slotBtnArray[j]);
				slotBtnArray[j].gotoAndStop(j + 1);
				TweenMax.to(slotBtnArray[j], 0, {autoAlpha: 0.5});
			}
			
			for(var k:int = 0; k < slotBtnArray.length - 1; k++){
				InactiveButton(slotBtnArray[k]);
			}
			
			settingBack = settingMenu.settingSubmenu.SettingBtnList_mc.Back_mc;
			
			settingBack.gotoAndStop(5);
			
			ActiveButton(settingBack);
		}
		
		private function SetLayout():void{
			this.addChild(farBuilding);
			this.addChild(helicopter);
			this.addChild(nearBuilding);
			this.addChild(light);
			this.addChild(characterBuilding);
			this.addChild(title);
			this.addChild(menu);
			this.addChild(samplePage);
			this.addChild(loadGameMenu);
			this.addChild(settingMenu);
			
			title.x = 100; title.y = 265;
			menu.x = 100; menu.y = 493;
			
			loadGameMenu.x = 100; loadGameMenu.y = 282;
			settingMenu.x = 100; settingMenu.y = 282;
			
			TweenMax.to(loadGameMenu, 0, {autoAlpha: 0});
			TweenMax.to(settingMenu, 0, {autoAlpha: 0});
		}
		
		private function ActiveButton(_mc:MovieClip):void{
			_mc.buttonMode = true;
			_mc.addEventListener(MouseEvent.CLICK, OnClick);
			_mc.addEventListener(MouseEvent.MOUSE_OVER, OnOver);
			_mc.addEventListener(MouseEvent.MOUSE_OUT, OnOut);
			
		}
		
		private function InactiveButton(_mc:MovieClip):void{
			//_mc.buttonMode = false;
			_mc.removeEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function OnClick(event:MouseEvent):void{
			switch(event.target.name){
				case "Resume_mc":
					TweenMax.to(samplePage.loadingGame, 0.45, {autoAlpha: 1});
					break;
				case "NewGame_mc":
					TweenMax.to(samplePage.newGame, 0.45, {autoAlpha: 1});
					break;
				case "LoadGame_mc":
					TweenMax.to(menu, 0.7, {autoAlpha: 0, onComplete: SubMenuShow});
					SwitchCharacter(event.target.name);
					TweenMax.to(title, 0.7, {y: 97, ease:Strong.easeInOut});
					break;
				case "Settings_mc":
					TweenMax.to(menu, 0.7, {autoAlpha: 0, onComplete: SubMenuShow});
					SwitchCharacter(event.target.name);
					TweenMax.to(title, 0.7, {y: 97, ease:Strong.easeInOut});
					break;
				case "Quit_mc":
					fscommand("quit");
					break;
				case "Back_mc":
					TweenMax.to(title, 0.7, {y: 265, ease:Strong.easeInOut});
					if(currentMenu == "LoadGame_mc"){
						TweenMax.to(loadGameMenu, 0.7, {autoAlpha: 0, onComplete: MainMenuShow});
					}else if(currentMenu == "Settings_mc"){
						TweenMax.to(settingMenu, 0.7, {autoAlpha: 0, onComplete: MainMenuShow});
					}
					
					SwitchCharacter(event.target.name);
					break;
			}
			
			currentMenu = event.target.name
			
		}
		
		private function OnOver(event:MouseEvent):void{
			TweenMax.to(event.target, 0.5, {autoAlpha: 1});
		}
		
		private function OnOut(event:MouseEvent):void{
			TweenMax.to(event.target, 0.5, {autoAlpha: 0.5});
		}
		
		private function SubMenuShow():void{
			if(currentMenu == "LoadGame_mc"){
				TweenMax.to(loadGameMenu, 0.7, {autoAlpha: 1});
			}else if(currentMenu == "Settings_mc"){
				TweenMax.to(settingMenu, 0.7, {autoAlpha: 1});
			}
			
		}
		
		private function SwitchCharacter(buttonName:String):void{
			switch(buttonName){
				case "LoadGame_mc":
					TweenMax.to(characters, 1.3, {x: -1273, y: -531, ease:Strong.easeInOut});
					TweenMax.to(farBuilding, 1.3, {y: -40, ease:Strong.easeInOut});
					TweenMax.to(nearBuilding.NearBuildingUI_mc, 1.3, {x: -50, y: 389, ease:Strong.easeInOut});
					break;
				case "Settings_mc":
					TweenMax.to(characters, 1.3, {x: 1117, y: -1019, ease:Strong.easeInOut});
					TweenMax.to(farBuilding, 1.3, {y: -60, ease:Strong.easeInOut});
					TweenMax.to(nearBuilding.NearBuildingUI_mc, 1.3, {x: 0, y: 349, ease:Strong.easeInOut});
					break;
				case "Back_mc":
					TweenMax.to(characters, 1.3, {x: 483, y: 169, ease:Strong.easeInOut});
					TweenMax.to(farBuilding, 1.3, {y: 0, ease:Strong.easeInOut});
					TweenMax.to(nearBuilding.NearBuildingUI_mc, 1.3, {x: 0, y: 459, ease:Strong.easeInOut});
					break;
			}
		}
		
		private function MainMenuShow():void{
			TweenMax.to(menu, 0.7, {autoAlpha: 1});
		}
	}
}