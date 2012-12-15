package com.ddg.wwt.game.actors 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IActor 
	{
		function Init():void;
		function Update(deltaTime:Number):void;
	}
}