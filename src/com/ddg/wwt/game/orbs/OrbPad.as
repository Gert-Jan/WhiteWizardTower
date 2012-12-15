package com.ddg.wwt.game.orbs 
{
	import com.ddg.wwt.Settings;
	import com.ddg.wwt.view.GameView;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class OrbPad 
	{
		private var gameView:GameView;
		private var surface:Sprite = new Sprite();
		private static const X:Number = 0;
		private static const Y:Number = 0;
		public static const WIDTH:Number = 280;
		public static const HEIGHT:Number = 280;
		
		private var orbs:Vector.<Orb> = new Vector.<Orb>();
		private var sequence:Vector.<int> = new Vector.<int>();
		
		public function OrbPad(gameView:GameView)
		{
			this.gameView = gameView;
			InitOrbs();
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		private function InitOrbs():void
		{
			AddOrb(0, X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 0);
			AddOrb(1, X + WIDTH / 4 * 1, Y + HEIGHT / 4 * 1);
			AddOrb(2, X + WIDTH / 4 * 3, Y + HEIGHT / 4 * 1);
			AddOrb(3, X + WIDTH / 4 * 0, Y + HEIGHT / 4 * 2);
			AddOrb(4, X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 2);
			AddOrb(5, X + WIDTH / 4 * 4, Y + HEIGHT / 4 * 2);
			AddOrb(6, X + WIDTH / 4 * 1, Y + HEIGHT / 4 * 3);
			AddOrb(7, X + WIDTH / 4 * 3, Y + HEIGHT / 4 * 3);
			AddOrb(8, X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 4);
		}
		
		private function AddOrb(index:int, x:Number, y:Number):void
		{
			var orb:Orb = new Orb(index.toString());
			orb.SetPosition(x, y);
			orbs.push(orb);
			surface.addChild(orb.Surface);
		}
		
		public function HandleOrbTouches(isDrawing:Boolean, points:Vector.<Point>):void
		{
			if (isDrawing)
			{
				for each (var point:Point in points)
				{
					var orb:DisplayObject = surface.hitTest(surface.globalToLocal(point));
					if (orb != null)
					{
						if (sequence.length == 0 ||
							sequence.length > 0 && sequence[sequence.length - 1] != int(orb.name))
						{
							sequence.push(int(orb.name));
						}
					}
				}
			}
			else if (sequence.length > 0)
			{
				trace("Cast spell: " + sequence);
				sequence = new Vector.<int>();
			}
		}
	}
}