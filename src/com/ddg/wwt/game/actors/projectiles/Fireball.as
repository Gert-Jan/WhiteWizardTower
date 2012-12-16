package com.ddg.wwt.game.actors.projectiles 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.actors.components.ApplyHeatComponent;
	import com.ddg.wwt.game.actors.components.DamageRadiateHeatComponent;
	import com.ddg.wwt.game.actors.components.MovementSkyfallComponent;
	import com.ddg.wwt.game.actors.IActor;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.extensions.ParticleSystem;
	import starling.extensions.PDParticleSystem;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Fireball extends ProjectileBase implements IActor 
	{
		// positioning
		private static const MIN_Y_VEL:Number = 50;
		private static const MAX_Y_VEL:Number = 400;
		
		// heat
		private static const HEAT_RADIUS: Number = 20;
		private static const EXTINGUISH_TIME:Number = 5.0;
		
		// components
		private var heatComponent:ApplyHeatComponent;
		private var fallComponent:MovementSkyfallComponent;
		
		public function Fireball(target:DisplayObjectContainer, position:Point, velocity:Point) 
		{
			super(target,  position, velocity);
		}
		
		public override function Init():void 
		{
			super.Init();
			
			fallComponent = new MovementSkyfallComponent();
			componentManager.AddComponent(fallComponent);
			heatComponent = new ApplyHeatComponent(1.0);
			componentManager.AddComponent(heatComponent);
			componentManager.AddComponent(new DamageRadiateHeatComponent(HEAT_RADIUS));
		}
		
		public override function Update(deltaTime:Number):void 
		{
			super.Update(deltaTime);
			
			if (fallComponent.Landed)
			{
				heatComponent.HeatRate = -1 / EXTINGUISH_TIME;
			}
			
			if (heatComponent.IsDestroyed)
				ActorManager.Instance.DestroyProjectile(this);
		}
		
		public override function get Heat():Number
		{
			return heatComponent.Heat;
		}
		
		public override function ApplyHeat(heat:Number, duration:Number):void
		{
			if (heatComponent.Heat <= 0)
			{
				heatComponent.Destroy();
			}
		}
	}
}