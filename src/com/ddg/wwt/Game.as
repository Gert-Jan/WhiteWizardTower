package com.ddg.wwt 
{
	import com.ddg.wwt.view.GameView;
	import com.ddg.wwt.view.ViewManager;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Game extends Sprite
	{
		public function Game() 
		{
			//var view:GameView = new GameView();
			//view.Init();
			//addChild(view.Surface);
			ViewManager.Instance.Init(this);
			//this.addEventListener(TouchEvent.TOUCH, OnTouch);
		}
	}
}