package com.ddg.wwt.game.spells 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class SpellBook 
	{
		private static const instance:SpellBook = new SpellBook();
		
		public static function get Instance():SpellBook
		{
			return instance;
		}
		
		public function SpellBook() 
		{}
		
		private static const spells:Vector.<ISpell> = Vector.<ISpell> ([
			new FireballSpell()
		]);
		
		public function GetSpell(query:Vector.<int>):ISpell
		{
			for each (var spell:ISpell in spells)
			{
				if (spell.Match(query))
					return spell;
			}
			return null;
		}
		
		public static function ExactSequentialMatch(query:Vector.<int>, spell:Vector.<int>):Boolean
		{
			// if the sequence is too short anyway, no match
			if (query.length < spell.length)
				return false;
			// exact matching
			for (var i:int = 0; i < query.length; i++)
			{
				// check each inidividual orb
				if (query[i] != spell[i])
					return false;
				// if not returned for the full length of the spell: we have a match!
				if (i >= spell.length - 1)
					return true;
			}
			return false;
		}
	}
}