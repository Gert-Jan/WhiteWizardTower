package com.ddg.wwt.game.actors 
{
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IActor 
	{
		function Init():void;
		function Update(deltaTime:Number):void;
		function Destroy():void;
		
		function get Position():Point;
		function set Position(pos:Point):void;
		function get Velocity():Point;
		function set Velocity(vel:Point):void;
		function get DrawTarget():DisplayObjectContainer;
		
		function get Health():Number;
		function ApplyHeat(heat:Number, duration:Number):void;
	}
}