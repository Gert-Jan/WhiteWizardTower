package com.ddg.wwt.game.actors.mobs 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.actors.components.ApplyHeatComponent;
	import com.ddg.wwt.game.actors.components.AttackTowerComponent;
	import com.ddg.wwt.game.actors.components.ComponentManager;
	import com.ddg.wwt.game.actors.components.DrawHealthbarComponent;
	import com.ddg.wwt.game.actors.components.DrawMovieClipComponent;
	import com.ddg.wwt.game.actors.components.MovementGravityComponent;
	import com.ddg.wwt.game.actors.components.MovementWalkComponent;
	import com.ddg.wwt.game.actors.IActor;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.MovieClip;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Orc extends MobBase implements IActor 
	{
		// drawing
		private var sprite:MovieClip;
		
		// settings
		private static const HEALTH:Number = 100;
		private static const MAX_WALK_SPEED:Number = 10;
		private static const MAX_WALK_SPEED_STRESSED:Number = 50;
		private static const MASS:Number = 10;
		private static const TOWER_DAMAGE:Number = 10;
		private static const MAX_HEAT:Number = 0.3;
		private static const HEAT_RATE:Number = -0.15;
		
		// components
		private var walkComponent:MovementWalkComponent;
		private var heatComponent:ApplyHeatComponent;
		
		public function Orc(target:DisplayObjectContainer, position:Point, direction:int) 
		{
			super(target, position, direction);
			health = HEALTH;
		}
		
		public override function Init():void 
		{
			// moving
			componentManager.AddComponent(new MovementGravityComponent(MASS));
			walkComponent = new MovementWalkComponent(MAX_WALK_SPEED, direction, 50);
			componentManager.AddComponent(walkComponent);
			
			// enviroment
			heatComponent = new ApplyHeatComponent(0, new Point(0, -20));
			heatComponent.HeatRate = HEAT_RATE;
			componentManager.AddComponent(heatComponent);
			componentManager.AddComponent(new DrawHealthbarComponent(new Point(0, -32), HEALTH)); 
			
			// drawing
			var clip:MovieClip = Assets.Instance.MobOrc;
			clip.pivotX = clip.width / 2;
			clip.pivotY = clip.height - Math.random() * 4 - 2;
			componentManager.AddComponent(new DrawMovieClipComponent(clip, direction == Settings.DIRECTION_RIGHT));
			
			// attacking
			componentManager.AddComponent(new AttackTowerComponent(TOWER_DAMAGE));
		}
		
		public override function Update(deltaTime:Number):void
		{
			super.Update(deltaTime);
			health -= heatComponent.Heat * 400 * deltaTime;
			if (health < 0)
			{
				Settings.Instance.score += 10;
				ActorManager.Instance.DestroyMob(this);
			}
		}
		
		public override function get Heat():Number
		{
			return heatComponent.Heat;
		}
		
		public override function ApplyHeat(heat:Number, duration:Number):void
		{
			heatComponent.Heat = Math.min(heat, MAX_HEAT);
			if (heatComponent.Heat > 0)
				walkComponent.MaxWalkSpeed = MAX_WALK_SPEED_STRESSED;
			else
				walkComponent.MaxWalkSpeed = MAX_WALK_SPEED;
		}
	}
}