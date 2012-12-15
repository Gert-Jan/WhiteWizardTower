package com.ddg.wwt.game.actors 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ActorManager 
	{
		private static const instance:ActorManager = new ActorManager();
		
		public static function get Instance():ActorManager
		{
			return instance;
		}
		
		public function ActorManager() 
		{
		}
		
		private var projectiles:Vector.<IActor> = new Vector.<IActor>();
		private var mobs:Vector.<IActor> = new Vector.<IActor>();
		
		public function Update(deltaTime:Number):void
		{
			for each (var projectile:IActor in projectiles)
				projectile.Update(deltaTime);
			for each (var mob:IActor in mobs)
				mob.Update(deltaTime);
		}
		
		public function AddProjectile(projectile:IActor):void
		{
			projectiles.push(projectile);
			projectile.Init();
		}
	}
}