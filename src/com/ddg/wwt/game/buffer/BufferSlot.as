package com.ddg.wwt.game.buffer 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.spells.ISpell;
	import com.ddg.wwt.Settings;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class BufferSlot 
	{
		private var surface:Sprite = new Sprite();
		private var background:Image;
		private var icon:Image;
		private var spell:ISpell;
		
		public function BufferSlot(x:Number, y:Number, alpha:Number) 
		{
			surface.x = x;
			surface.y = y;
			
			background = new Image(Assets.Instance.Spellbuffer);
			background.pivotX = background.width / 2;
			background.pivotY = background.height / 2;
			background.scaleX = alpha;
			
			icon = new Image(Assets.Instance.IconEmpty);
			icon.pivotX = icon.width / 2;
			icon.pivotY = icon.height / 2;
			icon.alpha = alpha;
			icon.scaleX = alpha;
			
			surface.addChild(background);
			surface.addChild(icon);
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function get Spell():ISpell
		{
			return spell;
		}
		
		public function set Spell(spell:ISpell):void
		{
			this.spell = spell;
			if (this.spell != null)
				icon.texture = spell.Icon;
			else
				icon.texture = Assets.Instance.IconEmpty;
		}
	}
}