package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AttackTowerComponent extends ComponentBase implements IActorComponent
	{
		private static const SETTINGS:Settings = Settings.Instance;
		private var damage:Number;
		
		public function AttackTowerComponent(damage:Number) 
		{
			this.damage = damage;
		}

		public function Init():void 
		{}
		
		public function Update(deltaTime:Number):void 
		{
			var pos:Point = actor.Position;
			var vel:Point = actor.Velocity;
			if ((vel.x > 0 && pos.x > SETTINGS.TowerLeft) ||
				(vel.x < 0 && pos.x < SETTINGS.TowerRight))
			{
				SETTINGS.wizard.DecreaseHealth(actor.Health / 10);
				ActorManager.Instance.DestroyMob(actor);
			}
		}
		
		public function Destroy():void 
		{}
	}
}