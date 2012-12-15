package com.ddg.wwt.game 
{
	import com.ddg.wwt.Settings;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class OrbPad 
	{
		private var surface:Sprite = new Sprite();
		private static const X:Number = 0;
		private static const Y:Number = 0;
		public static const WIDTH:Number = 280;
		public static const HEIGHT:Number = 280;
		
		private var orbs:Vector.<Orb> = new Vector.<Orb>();
		
		public function OrbPad() 
		{
			InitOrbs();
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		private function InitOrbs():void
		{
			// 0
			AddOrb(X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 0);
			// 1
			AddOrb(X + WIDTH / 4 * 1, Y + HEIGHT / 4 * 1);
			// 2
			AddOrb(X + WIDTH / 4 * 3, Y + HEIGHT / 4 * 1);
			// 3
			AddOrb(X + WIDTH / 4 * 0, Y + HEIGHT / 4 * 2);
			// 4
			AddOrb(X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 2);
			// 5
			AddOrb(X + WIDTH / 4 * 4, Y + HEIGHT / 4 * 2);
			// 6
			AddOrb(X + WIDTH / 4 * 1, Y + HEIGHT / 4 * 3);
			// 7
			AddOrb(X + WIDTH / 4 * 3, Y + HEIGHT / 4 * 3);
			// 8
			AddOrb(X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 4);
		}
		
		private function AddOrb(x:Number, y:Number):void
		{
			var orb:Orb = new Orb();
			orb.SetPosition(x, y);
			orbs.push(orb);
			surface.addChild(orb.Surface);
		}
	}
}