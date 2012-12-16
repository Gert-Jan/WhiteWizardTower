package com.ddg.wwt.game.actors.mobs 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.components.ComponentManager;
	import com.ddg.wwt.game.actors.IActor;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	public class MobBase implements IActor 
	{
		// components
		protected var componentManager:ComponentManager;
		
		// drawing
		protected var target:DisplayObjectContainer;
		
		// positioning
		protected var direction:int;
		private var position:Point;
		private var velocity:Point = new Point();
		
		// gameplay
		protected var health:Number = 100;
		
		public function MobBase(target:DisplayObjectContainer, position:Point, direction:int) 
		{
			this.target = target;
			this.position = position;
			this.direction = direction;
			this.componentManager = new ComponentManager(this);
		}
		
		public function Init():void 
		{}
		
		public function Update(deltaTime:Number):void 
		{
			componentManager.Update(deltaTime);
		}
		
		public function Destroy():void
		{
			componentManager.Destroy();
		}
		
		public function get Position():Point
		{
			return position;
		}
		
		public function set Position(pos:Point):void
		{
			this.position = pos;
		}
		
		public function get Velocity():Point
		{
			return velocity;
		}
		
		public function set Velocity(vel:Point):void
		{
			this.velocity = vel;
		}
		
		public function get DrawTarget():DisplayObjectContainer
		{
			return target;
		}
		
		public function get Health():Number
		{
			return health;
		}
		
		public function ApplyHeat(heat:Number, duration:Number):void
		{
		}
	}
}