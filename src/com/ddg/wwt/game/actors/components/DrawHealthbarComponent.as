package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.IActor;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DrawHealthbarComponent extends ComponentBase implements IActorComponent 
	{
		private static const DEFAULT_SIZE:Number = 20; // size for DEFAULT_HEALTH health
		private static const DEFAULT_HEALTH:Number = 100;
		private var maxHealth:Number;
		private var bar:Image;
		private var offset:Point;
		
		public function DrawHealthbarComponent(offset:Point, maxHealth:Number = 100) 
		{
			if (offset == null)
				this.offset = new Point();
			else
				this.offset = offset;
			this.maxHealth = maxHealth;
		}
		
		public function Init():void 
		{
			bar = new Image(Assets.Instance.Healthbar);
			bar.pivotY = bar.height;
			SetPosition(actor.Position);
			actor.DrawTarget.addChild(bar);
		}
		
		public function Update(deltaTime:Number):void 
		{
			SetPosition(actor.Position);
			bar.width = DEFAULT_SIZE * actor.Health / DEFAULT_HEALTH;
		}
		
		private function SetPosition(point:Point):void
		{
			bar.x = point.x + offset.x - DEFAULT_SIZE * maxHealth / DEFAULT_HEALTH / 2;
			bar.y = point.y + offset.y;
		}
		
		public function Destroy():void 
		{
			actor.DrawTarget.removeChild(bar);
		}
	}
}