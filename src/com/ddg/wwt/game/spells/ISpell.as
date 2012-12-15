package com.ddg.wwt.game.spells 
{
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface ISpell 
	{
		function get ManaCost():Number;
		function Match(orbSequence:Vector.<int>):Boolean;
		function Cast(vector:Point):void;
	}
}