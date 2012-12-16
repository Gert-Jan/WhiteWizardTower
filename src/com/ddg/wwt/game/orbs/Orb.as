package com.ddg.wwt.game.orbs 
{
	import com.ddg.wwt.Assets;
	import flash.geom.Point;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Orb extends Sprite
	{
		private var index:int;
		private var baseScale:Number;
		private var image:Image;
		private var position:Point = new Point();
		private var positionVariation:Point = new Point();
		private var tween:Tween;
		
		private static const X_VARIATION:Number = 40;
		private static const Y_VARIATION:Number = 40;
		private static const MIN_TIME:Number = 5;
		private static const MAX_TIME:Number = 10;
		
		public function Orb(index:int, baseScale:Number)
		{
			// art
			this.index = index;
			this.baseScale = baseScale;
			image = new Image(Assets.Instance.Orb);
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			this.addChild(image);
			
			// animation
			tween = new Tween(positionVariation, 0, Transitions.EASE_OUT_IN);
			RestartTween();
		}
		
		
		public function get Index():int
		{
			return index;
		}
		
		public function set Scale(scale:Number):void
		{
			image.scaleX = baseScale * scale;
			image.scaleY = baseScale * scale;
		}
		
		public function get Scale():Number
		{
			return image.scaleX / baseScale;
		}
		
		public function SetPosition(x:Number, y:Number):void
		{
			position.x = x;
			position.y = y;
		}
		
		private function RestartTween():void
		{
			Starling.juggler.remove(tween);
			tween.reset(positionVariation, Math.random() * (MAX_TIME - MIN_TIME) + MIN_TIME, Transitions.EASE_OUT_IN);
			tween.onComplete = RestartTween;
			tween.moveTo(Math.random() * X_VARIATION * baseScale - X_VARIATION * baseScale / 2, Math.random() * Y_VARIATION * baseScale - Y_VARIATION * baseScale / 2);
			Starling.juggler.add(tween);
		}
		
		public function Update(deltaTime:Number):void
		{
			image.x = position.x + positionVariation.x;
			image.y = position.y + positionVariation.y;
		}
	}
}