package com.ddg.wwt.game.spells 
{
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface ISpell 
	{
		function get Name():String;
		function get ManaCost():Number;
		function Match(orbSequence:Vector.<int>):Boolean;
		function Cast(target:DisplayObjectContainer, position:Point, vector:Point):void;
	}
}