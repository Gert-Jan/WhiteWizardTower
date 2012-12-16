package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class MovementWalkComponent extends ComponentBase implements IActorComponent
	{
		private static const SETTINGS:Settings = Settings.Instance;
		private static const DEFAULT_ACCELERATION:Number = 10;
		private static const DEFAULT_DECELERATION:Number = 10;
		private var maxWalkSpeed:Number = 1;
		private var direction:int;
		private var acceleration:Number = DEFAULT_ACCELERATION;
		private var deceleration:Number = DEFAULT_DECELERATION;
		
		public function MovementWalkComponent(maxWalkSpeed:Number, direction:int, acceleration:Number = DEFAULT_ACCELERATION, deceleration:Number = DEFAULT_DECELERATION) 
		{
			this.maxWalkSpeed = maxWalkSpeed;
			this.direction = direction;
			this.acceleration = acceleration;
			this.deceleration = deceleration;
		}

		public function Init():void 
		{}
		
		public function Update(deltaTime:Number):void 
		{
			var pos:Point = actor.Position;
			// update velocity
			if (pos.y <= SETTINGS.GroundY)
			{
				var vel:Point = actor.Velocity;
				pos.y = SETTINGS.GroundY;
				vel.x = Math.abs(vel.x);
				if (vel.x > maxWalkSpeed)
					vel.x = Math.max(maxWalkSpeed, vel.x -= deceleration * deltaTime);
				else if (vel.x < maxWalkSpeed)
					vel.x = Math.min(maxWalkSpeed, vel.x += acceleration * deltaTime);
				vel.x = vel.x * direction;
				actor.Velocity = vel;
			}
			// only integrate x movement, we got other components for y movement
			pos.x = pos.x + vel.x * deltaTime;
			actor.Position = pos;
		}
		
		public function Destroy():void 
		{}
	}
}