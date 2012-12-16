package com.ddg.wwt.game.buffer 
{
	import com.ddg.wwt.game.spells.ISpell;
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class BufferPad 
	{
		private var surface:Sprite = new Sprite();
		private var bufferSlots:Vector.<BufferSlot> = new Vector.<BufferSlot>(3, true);
		
		public function BufferPad() 
		{
			Init();
		}
		
		private function Init():void
		{
			bufferSlots[0] = new BufferSlot(-50, 5, 0.95);
			bufferSlots[1] = new BufferSlot(0, 8, 1);
			bufferSlots[2] = new BufferSlot(50, 5, 0.95);
			for each (var slot:BufferSlot in bufferSlots)
				surface.addChild(slot.Surface);
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function BufferSpell(spell:ISpell):void
		{
			var lastEmptySlot:BufferSlot = null;
			var slotFound:Boolean = false;
			// find a empty slot
			for each (var slot:BufferSlot in bufferSlots)
			{
				if (slot.Spell == null)
				{
					lastEmptySlot = slot;
					slotFound = true;
				}
				else
					break;
			}
			// if no empty slots are left, sheft everything one place and use the first slot
			if (!slotFound)
			{
				for (var i:int = bufferSlots.length - 1; i > 0; i--)
				{
					bufferSlots[i].Spell = bufferSlots[i - 1].Spell;
				}
				lastEmptySlot = bufferSlots[0];
			}
			// buffer spell
			lastEmptySlot.Spell = spell;
		}
		
		private function SetSpell(index:int, spell:ISpell):void
		{
			bufferSlots[index].Spell = spell;
		}
		
		public function CastSpell(target:DisplayObjectContainer, position:Point, vector:Point):void
		{
			for each (var slot:BufferSlot in bufferSlots)
			{
				if (slot.Spell != null)
				{
					slot.Spell.Cast(target, position, vector);
					slot.Spell = null;
					return;
				}
			}
		}
	}
}