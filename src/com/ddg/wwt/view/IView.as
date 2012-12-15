package com.ddg.wwt.view 
{
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Gert-Jan Stolk
	 */
	public interface IView 
	{
		function Init():void;
		function get Surface():Sprite;
	}
}