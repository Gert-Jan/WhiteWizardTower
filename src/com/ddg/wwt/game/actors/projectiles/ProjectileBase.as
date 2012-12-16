package com.ddg.wwt.game.actors.projectiles 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.actors.components.ComponentManager;
	import com.ddg.wwt.game.actors.IActor;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ProjectileBase implements IActor 
	{
		// components
		protected var componentManager:ComponentManager;
		
		// drawing
		protected var target:DisplayObjectContainer;
		
		// positioning
		private var position:Point;
		private var velocity:Point;
		
		public function ProjectileBase(target:DisplayObjectContainer, position:Point, velocity:Point) 
		{
			this.target = target;
			this.position = position;
			this.velocity = velocity;
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
			return 100;
		}
		
		public function ApplyHeat(heat:Number, duration:Number):void
		{
		}
	}
}