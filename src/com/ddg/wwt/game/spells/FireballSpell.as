package com.ddg.wwt.game.spells 
{
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class FireballSpell implements ISpell 
	{
		private static const spellSequence:Vector.<int> = Vector.<int>([3, 1, 4, 7, 5, 2, 4]);
		
		public function FireballSpell() 
		{
			
		}
		
		public function get Name():String
		{
			return "Fireball!!!";
		}
		
		public function get ManaCost():Number 
		{
			return 10;
		}
		
		public function Match(orbSequence:Vector.<int>):Boolean 
		{
			return SpellBook.ExactSequentialMatch(orbSequence, spellSequence);
		}
		
		public function Cast(vector:Point):void 
		{
			
		}
	}
}