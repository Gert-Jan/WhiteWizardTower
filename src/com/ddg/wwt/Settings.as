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
		
		public static const DIRECTION_LEFT:int = -1;
		public static const DIRECTION_RIGHT:int = 1;
		
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
		
		public function get TowerLeft():Number
		{
			return StageWidth / 2 - 50;
		}
		
		public function get TowerRight():Number
		{
			return StageWidth / 2 + 50;
		}
		
		public function get ScreenLeft():Number
		{
			return 0;
		}
		
		public function get ScreenRight():Number
		{
			return StageWidth;
		}
	}
}