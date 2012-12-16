package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.actors.IActor;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DamageRadiateHeatComponent extends ComponentBase implements IActorComponent
	{
		private static const ACTOR_MANAGER:ActorManager = ActorManager.Instance;
		private var radius:Number;
		
		public function DamageRadiateHeatComponent(radius:Number) 
		{
			this.radius = radius;
		}

		public function Init():void 
		{}
		
		public function Update(deltaTime:Number):void 
		{
			var targets:Vector.<IActor> = ACTOR_MANAGER.FindMobsInCircle(actor.Position, radius);
			for each (var target:IActor in targets)
				target.ApplyHeat(actor.Heat, deltaTime);
		}
		
		public function Destroy():void 
		{}
	}
}