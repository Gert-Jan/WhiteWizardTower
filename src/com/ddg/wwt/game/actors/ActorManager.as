package com.ddg.wwt.game.actors 
{
	import flash.geom.Point;
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
		public function DestroyProjectile(projectile:IActor):void
		{
			projectile.Destroy();
			projectiles.splice(projectiles.indexOf(projectile), 1);
		}
		
		public function AddMob(mob:IActor):void
		{
			mobs.push(mob);
			mob.Init();
		}
		
		public function DestroyMob(mob:IActor):void
		{
			mob.Destroy();
			mobs.splice(mobs.indexOf(mob), 1);
		}
		
		public function FindMobsInCircle(point:Point, radius:Number):Vector.<IActor>
		{
			var result:Vector.<IActor> = new Vector.<IActor>();
			var delta:Point = new Point();
			var mobPos:Point = new Point();
			for each (var mob:IActor in mobs)
			{
				mobPos = mob.Position;
				delta.x = point.x - mobPos.x;
				delta.y = point.y - mobPos.y;
				if (delta.length < radius)
					result.push(mob);
			}
			return result;
		}
	}
}