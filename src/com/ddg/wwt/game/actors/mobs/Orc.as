package com.ddg.wwt.game.actors.mobs 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.components.AttackTowerComponent;
	import com.ddg.wwt.game.actors.components.ComponentManager;
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
		
		// positioning
		private static const MAX_WALK_SPEED:Number = 10;
		private static const MASS:Number = 100;
		private static const TOWER_DAMAGE:Number = 10;
		
		public function Orc(target:DisplayObjectContainer, position:Point, direction:int) 
		{
			super(target, position, direction);
		}
		
		public override function Init():void 
		{
			// moving
			componentManager.AddComponent(new MovementGravityComponent(MASS));
			componentManager.AddComponent(new MovementWalkComponent(MAX_WALK_SPEED, direction));
			
			// drawing
			var clip:MovieClip = Assets.Instance.MobOrc;
			clip.pivotX = clip.width / 2;
			clip.pivotY = clip.height - 2;
			componentManager.AddComponent(new DrawMovieClipComponent(clip, direction == Settings.DIRECTION_RIGHT));
			
			// attacking
			componentManager.AddComponent(new AttackTowerComponent(TOWER_DAMAGE));
		}
	}
}