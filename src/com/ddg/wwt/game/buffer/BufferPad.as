package com.ddg.wwt.game.buffer 
{
	import com.ddg.wwt.game.spells.ISpell;
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class BufferPad 
	{
		private var bufferedSpells:Vector.<ISpell> = new Vector.<ISpell>(3, true);
		
		public function BufferPad() 
		{
			
		}
		
		public function BufferSpell(spell:ISpell):void
		{
			bufferedSpells[0] = bufferedSpells[1];
			bufferedSpells[1] = bufferedSpells[2];
			bufferedSpells[2] = spell;
			trace(bufferedSpells);
		}
		
		public function CastLastSpell(target:DisplayObjectContainer, position:Point, vector:Point):void
		{
			if (bufferedSpells[2] != null)
			{
				bufferedSpells[2].Cast(target, position, vector);
				bufferedSpells[2] = bufferedSpells[1];
				bufferedSpells[1] = bufferedSpells[0];
				bufferedSpells[0] = null;
				trace(bufferedSpells);
			}
		}
	}
}