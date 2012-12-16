package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.IActor;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.MovieClip;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DrawMovieClipComponent extends ComponentBase implements IActorComponent 
	{
		private var clip:MovieClip;
		
		public function DrawMovieClipComponent(clip:MovieClip, flipped:Boolean = false, randomStartFrame:Boolean = true) 
		{
			this.clip = clip;
			if (flipped)
				this.clip.scaleX = -1;
			if (randomStartFrame)
				this.clip.currentFrame = Math.floor(Math.random() * this.clip.numFrames);
		}
		
		public function Init():void 
		{
			Starling.juggler.add(clip);
			actor.DrawTarget.addChild(clip);
		}
		
		public function Update(deltaTime:Number):void 
		{
			var pos:Point = actor.Position;
			clip.x = pos.x;
			clip.y = pos.y;
		}
		
		public function Destroy():void 
		{
			actor.DrawTarget.removeChild(clip);
			Starling.juggler.remove(clip);
		}
	}
}