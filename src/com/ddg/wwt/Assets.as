package com.ddg.wwt 
{
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Assets 
	{
		private static const instance:Assets = new Assets();
		
		public static function get Instance():Assets
		{
			return instance;
		}
		
		public function Assets() 
		{}

		[Embed(source = "../../../../art/image/Background.png")]
		private static const background:Class;
		[Embed(source = "../../../../art/image/Ground.png")]
		private static const ground:Class;
		[Embed(source = "../../../../art/image/Tower.png")]
		private static const tower:Class;
		[Embed(source = "../../../../art/image/Orb.png")]
		private static const orb:Class;
		[Embed(source = "../../../../art/image/Brush.png")]
		private static const brush:Class;
		[Embed(source = "../../../../art/image/Spellbuffer.png")]
		private static const spellbuffer:Class;
		[Embed(source = "../../../../art/image/Managlow.png")]
		private static const managlow:Class;
		
		[Embed(source = "../../../../art/image/IconEmpty.png")]
		private static const iconEmpty:Class;
		[Embed(source = "../../../../art/image/IconFireball.png")]
		private static const iconFireball:Class;
		
		[Embed(source = "../../../../art/particle/FireParticle.png")]
        private static const FireParticle:Class;
		
		[Embed(source="../../../../art/particle/FireballSpell.pex", mimeType="application/octet-stream")]
        private static const FireballSpell:Class;
		
		public function Init():void
		{
		}
		
		private function CreateTexture(asset:Class):Texture
		{
			return Texture.fromBitmap(new asset());
		}
		
		private function CreateParticleSystem(config:Class, asset:Class):PDParticleSystem
		{
			return new PDParticleSystem(XML(new config()), CreateTexture(asset));
		}
		
		public function get Background():Texture { return CreateTexture(background); }
		public function get Ground():Texture { return CreateTexture(ground); }
		public function get Tower():Texture { return CreateTexture(tower); }
		public function get Orb():Texture { return CreateTexture(orb); }
		public function get Spellbuffer():Texture { return CreateTexture(spellbuffer); }
		public function get Managlow():Texture { return CreateTexture(managlow); }
		public function get Brush():Texture { return CreateTexture(brush); }
		
		public function get IconEmpty():Texture { return CreateTexture(iconEmpty); }
		public function get IconFireball():Texture { return CreateTexture(iconFireball); }
		
		public function get FireballParticle():PDParticleSystem { return CreateParticleSystem(FireballSpell, FireParticle); }
	}
}