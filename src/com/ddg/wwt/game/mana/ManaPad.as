package com.ddg.wwt.game.mana 
{
	import com.ddg.wwt.Assets;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ManaPad 
	{
		private var surface:Sprite;
		private var image:Image;
		
		private var mana:Number = 1;
		private var tweenIn:Tween;
		private var tweenOut:Tween;
		
		private static const IN_TRANSITION:String = Transitions.EASE_IN_BOUNCE;
		private static const OUT_TRANSITION:String = Transitions.EASE_IN_BOUNCE;
		private static const MIN_TIME:Number = 0.5;
		private static const MAX_TIME:Number = 1.0;
		private static const BASE_ALPHA:Number = 0.8;
		
		public function ManaPad() 
		{
			Init();
		}
		
		private function Init():void
		{
			// init surface
			surface = new Sprite();
			image = new Image(Assets.Instance.Managlow);
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			surface.addChild(image);
			
			// tweens
			tweenIn = new Tween(null, 0.0, IN_TRANSITION);
			tweenOut = new Tween(image, RandomTime, OUT_TRANSITION);
			tweenOut.onComplete = StartTweenIn;
			UpdateTweenOut();
			Starling.juggler.add(tweenOut);
		}
		
		private function StartTweenOut():void
		{
			Starling.juggler.remove(tweenIn);
			tweenOut.reset(image, RandomTime, OUT_TRANSITION);
			tweenOut.onComplete = StartTweenIn;
			UpdateTweenOut();
			Starling.juggler.add(tweenOut);
		}
		
		private function UpdateTweenOut():void
		{
			tweenOut.scaleTo(mana + 0.1);
			tweenOut.fadeTo(BASE_ALPHA * Math.max(0.1, mana - 0.1));
		}
		
		private function StartTweenIn():void
		{
			Starling.juggler.remove(tweenOut);
			tweenIn.reset(image, RandomTime, IN_TRANSITION);
			tweenIn.onComplete = StartTweenOut;
			UpdateTweenIn();
			Starling.juggler.add(tweenIn);
		}
		
		private function UpdateTweenIn():void
		{
			tweenIn.scaleTo(mana);
			tweenIn.fadeTo(BASE_ALPHA * mana);
		}
		
		private function get RandomTime():Number
		{
			return Math.random() * (MAX_TIME - MIN_TIME) + MIN_TIME;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function set Mana(mana:Number):void
		{
			this.mana = Math.max(0, Math.min(1, mana));
			UpdateManaStatus();
		}
		
		public function get Mana():Number
		{
			return mana;
		}
		
		private function UpdateManaStatus():void
		{
			UpdateTweenIn();
			UpdateTweenOut();
		}
	}
}