package com.ddg.wwt.game 
{
	import com.ddg.wwt.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Orb 
	{
		private var surface:Sprite = new Sprite();
		
		public function Orb()
		{
			var orb:Image = new Image(Assets.Instance.Orb);
			orb.pivotX = orb.width / 2;
			orb.pivotY = orb.height / 2;
			surface.addChild(orb);
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function SetPosition(x:Number, y:Number):void
		{
			surface.x = x;
			surface.y = y;
		}
	}
}