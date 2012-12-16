package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.IActor;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IActorComponent 
	{
		function set Actor(actor:IActor):void;
		function Init():void;
		function Update(deltaTime:Number):void;
		function Destroy():void;
	}
}