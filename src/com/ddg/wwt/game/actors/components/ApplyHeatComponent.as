package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.IActor;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.extensions.PDParticleSystem;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ApplyHeatComponent extends ComponentBase implements IActorComponent 
	{
		private var flamesOffset:Point;
		private var flames:PDParticleSystem;
		private var startSize:Number;
		private var endSize:Number;
		private var speed:Number;
		private var flamesActive:Boolean = false;
		
		private var heat:Number;
		private var heatRate:Number = 0;
		
		private var delayedDestroy:DelayedCall;
		private var destroyed:Boolean;
		
		public function ApplyHeatComponent(initialHeat:Number, particleOffset:Point = null) 
		{
			this.heat = initialHeat;
			if (particleOffset == null)
				this.flamesOffset = new Point(0, 0);
			else
				this.flamesOffset = particleOffset;
		}
		
		public function set HeatRate(rate:Number):void
		{
			this.heatRate = rate;
		}
		
		public function get HeatRate():Number
		{
			return this.heatRate;
		}
		
		public function get Heat():Number
		{
			return heat;
		}
		
		public function get IsDestroyed():Boolean
		{
			return destroyed;
		}
		
		public function Init():void 
		{
			var pos:Point = actor.Position;
			flames = Assets.Instance.FireballParticle;
			flames.emitterX = pos.x;
			flames.emitterY = pos.y;
			flames.start();
			if (heat > 0)
				ActivateFlames();
			
			startSize = flames.startSize;
			endSize = flames.endSize;
			speed = flames.speed;
		}
		
		public function Update(deltaTime:Number):void 
		{
			// position particles
			var pos:Point = actor.Position;
			flames.emitterX = pos.x;
			flames.emitterY = pos.y;
			
			// set new heat based on heatRate, activate/deactivate particles
			heat += heatRate * deltaTime;
			if (heat <= 0)
			{
				heat = 0;
				if (flamesActive)
					DeactivateFlames();
			}
			else if (!flamesActive)
			{
				ActivateFlames();
			}
			
			// update particle system
			if (flamesActive)
			{
				var cappedHeat:Number = Math.min(1, heat);
				flames.startSize = startSize * cappedHeat;
				flames.endSize = endSize * cappedHeat;
				flames.speed = speed * cappedHeat;
			}
			
			// aplly heat on the actor
			actor.ApplyHeat(heat, deltaTime);
		}
		
		public function Destroy():void 
		{
			if (flamesActive)
			{
				if (delayedDestroy == null)
				{
					flames.stop();
					delayedDestroy = new DelayedCall(DelayedDestroy, flames.lifespan + flames.lifespanVariance);
					Starling.juggler.add(delayedDestroy);
				}
			}
			else
			{
				destroyed = true;
			}
		}
		
		private function DelayedDestroy():void
		{
			DeactivateFlames();
			Starling.juggler.remove(delayedDestroy);
			destroyed = true;
		}
		
		private function ActivateFlames():void
		{
			if (!flamesActive)
			{
				actor.DrawTarget.addChild(flames);
				Starling.juggler.add(flames);
				flamesActive = true;
			}
		}
		
		private function DeactivateFlames():void
		{
			if (flamesActive)
			{
				actor.DrawTarget.removeChild(flames);
				Starling.juggler.remove(flames);
				flamesActive = false;
			}
		}
	}
}