package
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	
	public class SamplePage extends MovieClip
	{
		public var newGame:NewGame_mc = new NewGame_mc();
		public var loadingGame:LoadingGame_mc = new LoadingGame_mc();
		
		public function SamplePage()
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
			
			SetLayout();
		}
		
		private function SetLayout():void{
			this.addChild(newGame);
			this.addChild(loadingGame);
			
			TweenMax.to(newGame, 0, {autoAlpha: 0});
			TweenMax.to(loadingGame, 0, {autoAlpha: 0});
			
			newGame.addEventListener(MouseEvent.CLICK, OnClick);
			loadingGame.addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function OnClick(event:MouseEvent):void{
			TweenMax.to(event.target, 0.45, {autoAlpha: 0});
		}
	}
}