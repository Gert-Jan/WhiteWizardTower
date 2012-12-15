package com.ddg.wwt 
{
	import flash.display.Stage;
	import flash.utils.getTimer;
	import starling.core.Starling;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Settings 
	{
		private static const instance:Settings = new Settings();
		
		public static function get Instance():Settings
		{
			return instance;
		}
		
		public function Settings() 
		{}
		
		private var starling:Starling = null;
		
		public function get StageWidth():Number
		{
			return Starling.current.stage.stageWidth;
		}
		
		public function get StageHeight():Number
		{
			return Starling.current.stage.stageHeight;
		}
		
		public function GetCurrentTime():int
		{
			return getTimer();
		}
		
		public function GetTimeInSeconds(time:int):Number
		{
			return time * 0.001;
		}
		
		public function get GroundY():Number
		{
			return StageHeight - 50;
		}
	}
}