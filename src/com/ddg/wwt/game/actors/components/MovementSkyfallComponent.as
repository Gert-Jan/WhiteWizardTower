package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class MovementSkyfallComponent extends ComponentBase implements IActorComponent
	{
		private static const SETTINGS:Settings = Settings.Instance;
		private static const DEFAULT_MIN_Y_VELOCITY:Number = 50;
		private static const DEFAULT_MAX_Y_VELOCITY:Number = 400;
		private var minYVelocity:Number;
		private var maxYVelocity:Number;
		private var landed:Boolean;
		
		public function MovementSkyfallComponent(minYVelocity:Number = DEFAULT_MIN_Y_VELOCITY, maxYVelocity:Number = DEFAULT_MAX_Y_VELOCITY) 
		{
			this.minYVelocity = minYVelocity;
			this.maxYVelocity = maxYVelocity;
		}
		
		public function get Landed():Boolean
		{
			return landed;
		}

		public function Init():void 
		{
			var pos:Point = actor.Position;
			var vel:Point = actor.Velocity;
			if (vel.y < 0)
				vel.y *= -1;
			vel.y = Math.max(vel.y, minYVelocity);
			if (vel.y > maxYVelocity)
			{
				vel.x *= maxYVelocity / vel.y;
				vel.y = maxYVelocity;
			}
			pos.x -= pos.y * (vel.x / vel.y);
			pos.y = 0;
			actor.Position = pos;
			actor.Velocity = vel;
		}
		
		public function Update(deltaTime:Number):void 
		{
			var pos:Point = actor.Position;
			var vel:Point = actor.Velocity;
			if (pos.y < SETTINGS.GroundY)
			{
				pos.x += vel.x * deltaTime;

				pos.y += vel.y * deltaTime;
			}
			else
			{
				pos.y = SETTINGS.GroundY;
				landed = true;
			}
			actor.Position = pos;
			actor.Velocity = vel;
		}
		
		public function Destroy():void 
		{
		}
	}
}