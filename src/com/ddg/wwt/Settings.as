package com.ddg.wwt 
{
	import flash.display.Stage;
	import starling.core.Starling;
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
		
		public function get stageWidth():Number
		{
			return Starling.current.stage.stageWidth;
		}
		
		public function get stageHeight():Number
		{
			return Starling.current.stage.stageHeight;
		}
	}
}