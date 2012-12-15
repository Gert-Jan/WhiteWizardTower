package com.ddg.wwt.game.actors 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.extensions.ParticleSystem;
	import starling.extensions.PDParticleSystem;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Fireball implements IActor 
	{
		// drawing
		private var target:DisplayObjectContainer;
		private var particleSystem:PDParticleSystem;
		
		// positioning
		private static const MIN_Y_VEL:Number = 50;
		private static const MAX_Y_VEL:Number = 400;
		private var position:Point;
		private var velocity:Point;
		
		// extinguishing
		private static const EXTINGUISH_TIME:Number = 2;
		private var landed:Boolean = false;
		private var extinguishFactor:Number = 1;
		private var startSize:Number;
		private var endSize:Number;
		private var speed:Number;
		
		public function Fireball(target:DisplayObjectContainer, position:Point, velocity:Point) 
		{
			if (velocity.y < 0)
				velocity.y *= -1;
			velocity.y = Math.max(velocity.y, MIN_Y_VEL);
			if (velocity.y > MAX_Y_VEL)
			{
				velocity.x *= MAX_Y_VEL / velocity.y;
				velocity.y = MAX_Y_VEL;
			}
			position.x -= position.y * (velocity.x / velocity.y);
			position.y = 0;
			this.target = target;
			this.position = position;
			this.velocity = velocity;
		}
		
		public function Init():void 
		{
			particleSystem = Assets.Instance.FireballParticle;
			particleSystem.emitterX = position.x;
			particleSystem.emitterY = position.y;
			particleSystem.start();
			target.addChild(particleSystem);
			Starling.juggler.add(particleSystem);
			
			// save defaults
			startSize = particleSystem.startSize;
			endSize = particleSystem.endSize;
			speed = particleSystem.speed;
		}
		
		public function Update(deltaTime:Number):void 
		{
			if (!landed)
			{
				position.x += velocity.x * deltaTime;
				position.y += velocity.y * deltaTime;
				particleSystem.emitterX = position.x;
				particleSystem.emitterY = position.y;
			}
			if (position.y > Settings.Instance.GroundY)
			{
				position.x = Settings.Instance.GroundY;
				landed = true;
				extinguishFactor -= deltaTime / EXTINGUISH_TIME;
				particleSystem.startSize = startSize * extinguishFactor;
				particleSystem.endSize = startSize * extinguishFactor;
				particleSystem.speed = speed * extinguishFactor;
			}
		}
	}
}