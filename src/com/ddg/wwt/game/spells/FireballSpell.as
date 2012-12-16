package com.ddg.wwt.game.spells 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.actors.projectiles.Fireball;
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class FireballSpell implements ISpell 
	{
		private static const spellSequence:Vector.<int> = Vector.<int>([3, 4, 7, 5, 2, 4]);
		
		public function FireballSpell() 
		{
			
		}
		
		public function get Name():String
		{
			return "Fireball!!!";
		}
		
		public function get ManaCost():Number 
		{
			return 0.1;
		}
		
		public function get Icon():Texture
		{
			return Assets.Instance.IconFireball;
		}
		
		public function Match(orbSequence:Vector.<int>):Boolean 
		{
			return SpellBook.ExactSequentialMatch(orbSequence, spellSequence);
		}
		
		public function Cast(target:DisplayObjectContainer, position:Point, vector:Point):void 
		{
			var projectile:Fireball = new Fireball(target, position, vector);
			ActorManager.Instance.AddProjectile(projectile);
		}
	}
}