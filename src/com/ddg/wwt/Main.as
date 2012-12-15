package com.ddg.wwt
{
	import flash.display.Sprite;
	import starling.core.Starling;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	[SWF(width="800", height="480", frameRate="60", backgroundColor="#6495ED")]
	public class Main extends Sprite 
	{
		private var starling:Starling;
		
		public function Main():void 
		{
			Assets.Instance.Init();
			starling = new Starling(Game, stage);
			starling.start();
		}
	}
}