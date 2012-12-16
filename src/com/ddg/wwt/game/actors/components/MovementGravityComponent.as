package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class MovementGravityComponent extends ComponentBase implements IActorComponent
	{
		private static const SETTINGS:Settings = Settings.Instance;
		private static const DEFAULT_GRAVITY:Number = 10;
		private static const DEFAULT_TERMINAL_VELOCITY:Number = 100;
		private var mass:Number;
		private var gravity:Number;
		private var terminalVelocity:Number;
		
		public function MovementGravityComponent(mass:Number, terminalVelocity:Number = DEFAULT_TERMINAL_VELOCITY, gravity:Number = DEFAULT_GRAVITY) 
		{
			this.mass = mass;
			this.terminalVelocity = terminalVelocity;
			this.gravity = gravity;
		}

		public function Init():void 
		{}
		
		public function Update(deltaTime:Number):void 
		{
			var pos:Point = actor.Position;
			// apply gravity if above ground
			if (pos.y > SETTINGS.GroundY)
			{
				var vel:Point = actor.Velocity;
				vel.y = Math.min(terminalVelocity, vel.y + gravity * deltaTime);
				actor.Velocity = vel;
				// only integrate y movement, we got other components for x movement
				pos.y = Math.min(SETTINGS.GroundY, pos.y + vel.y * deltaTime);
				actor.Position = pos;
			}
		}
		
		public function Destroy():void 
		{}
	}
}