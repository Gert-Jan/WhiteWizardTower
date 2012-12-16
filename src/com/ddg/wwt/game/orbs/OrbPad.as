package com.ddg.wwt.game.orbs 
{
	import com.ddg.wwt.game.spells.ISpell;
	import com.ddg.wwt.game.spells.SpellBook;
	import com.ddg.wwt.Settings;
	import com.ddg.wwt.view.GameView;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Image;
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
		public static const DEFAULT_SCALE:Number = 0.8;
		public static const MAX_SCALE:Number = 1.0;
		public static const SCALE_STEP:Number = 0.05;
		
		private var orbs:Vector.<Orb> = new Vector.<Orb>();
		private var sequence:Vector.<int> = new Vector.<int>();
		
		private var lastSpell:ISpell = null;
		
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
			AddOrb(0, X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 0.2, 0.8);
			AddOrb(1, X + WIDTH / 4 * 1.1, Y + HEIGHT / 4 * 1.1, 0.9);
			AddOrb(2, X + WIDTH / 4 * 2.9, Y + HEIGHT / 4 * 1.1, 0.9);
			AddOrb(3, X + WIDTH / 4 * 0.2, Y + HEIGHT / 4 * 2, 0.8);
			AddOrb(4, X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 2, 1.0);
			AddOrb(5, X + WIDTH / 4 * 3.8, Y + HEIGHT / 4 * 2, 0.8);
			AddOrb(6, X + WIDTH / 4 * 1.1, Y + HEIGHT / 4 * 2.9, 0.9);
			AddOrb(7, X + WIDTH / 4 * 2.9, Y + HEIGHT / 4 * 2.9, 0.9);
			AddOrb(8, X + WIDTH / 4 * 2, Y + HEIGHT / 4 * 3.8, 0.8);
		}
		
		public function Update(deltaTime:Number):void
		{
			for each (var orb:Orb in orbs)
				orb.Update(deltaTime);
		}
		
		private function AddOrb(index:int, x:Number, y:Number, baseScale:Number):void
		{
			var orb:Orb = new Orb(index, baseScale);
			orb.SetPosition(x, y);
			orb.Scale = DEFAULT_SCALE;
			orbs.push(orb);
			surface.addChild(orb);
		}
		
		public function get SequenceLength():int
		{
			return sequence.length;
		}
		
		public function HandleOrbTouches(isDrawing:Boolean, points:Vector.<Point>):Boolean
		{
			var orb:Orb;
			if (isDrawing)
			{
				for each (var point:Point in points)
				{
					var obj:DisplayObject = surface.hitTest(surface.globalToLocal(point));
					if (obj != null)
					{
						orb = Orb(Image(obj).parent);
						if (sequence.length == 0 ||
							sequence.length > 0 && sequence[sequence.length - 1] != orb.Index)
						{
							sequence.push(orb.Index);
							gameView.DrawSurface.Color = 0xffffbb;
							orb.Scale = Math.min(orb.Scale + SCALE_STEP, MAX_SCALE);
							orb.Color = orb.Color - 50;
							var spell:ISpell = SpellBook.Instance.GetSpell(sequence);
							if (spell != null && spell != lastSpell)
							{
								if (gameView.ManaPool.Mana >= spell.ManaCost)
								{
									trace(spell.Name);
									gameView.SpellBuffer.BufferSpell(spell);
									lastSpell = spell;
									gameView.ManaPool.Mana = gameView.ManaPool.Mana - spell.ManaCost;
								}
								else
								{
									trace("Not enough mana for: " + spell.Name);
								}
							}
						}
						return true;
					}
				}
			}
			else if (sequence.length > 0)
			{
				sequence.length = 0;
				lastSpell = null;
				for each (orb in orbs)
				{
					orb.Scale = DEFAULT_SCALE;
					orb.Color = 0xffffff;
				}
			}
			return false;
		}
	}
}