package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.IActor;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.Image;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DrawImageComponent extends ComponentBase implements IActorComponent 
	{
		private var image:Image;
		
		public function DrawImageComponent(image:Image, flipped:Boolean = false) 
		{
			this.image = image;
			if (flipped)
				this.image.scaleX = -1;
		}
		
		public function Init():void 
		{
			actor.DrawTarget.addChild(image);
		}
		
		public function Update(deltaTime:Number):void
		{
			var pos:Point = actor.Position;
			image.x = pos.x;
			image.y = pos.y;
		}
		
		public function Destroy():void 
		{
			actor.DrawTarget.removeChild(image);
		}
	}
}