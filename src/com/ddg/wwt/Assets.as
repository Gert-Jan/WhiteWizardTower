package com.ddg.wwt 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	public dynamic class Assets 
	{
		private static const instance:Assets = new Assets();
		
		public static function get Instance():Assets
		{
			return instance;
		}
		
		public function Assets() 
		{}
		
		// images
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
		
		// icons
		[Embed(source = "../../../../art/image/IconEmpty.png")]
		private static const iconEmpty:Class;
		[Embed(source = "../../../../art/image/IconFireball.png")]
		private static const iconFireball:Class;
		
		// sprite sheets
		[Embed(source="../../../../art/sprite/MobOrc.xml", mimeType="application/octet-stream")]
		private static const mobOrcXml:Class;
		[Embed(source = "../../../../art/sprite/MobOrc.png")]
		private static const mobOrcAtlas:Class;
		
		// particle images
		[Embed(source = "../../../../art/particle/FireParticle.png")]
		private static const fireParticle:Class;
		
		// particle config
		[Embed(source="../../../../art/particle/FireballSpell.pex", mimeType="application/octet-stream")]
		private static const fireballSpell:Class;
		
		public function Init():void
		{
		}
		
		private function CreateTexture(asset:Class):Texture
		{
			if (this[asset] == null)
				this[asset] = Texture.fromBitmap(new asset());
			return this[asset];
		}
		
		private function CreateTextureAtlas(config:Class, asset:Class):TextureAtlas
		{
			if (this[config] == null)
				this[config] = new TextureAtlas(CreateTexture(asset), XML(new config()));
			return this[config];
		}
		
		private function CreateMovieClip(config:Class, asset:Class, frameRate:int):MovieClip
		{
			return new MovieClip(CreateTextureAtlas(config, asset).getTextures("MobOrc"), frameRate);
		}
		
		private function CreateParticleSystem(config:Class, asset:Class):PDParticleSystem
		{
			return new PDParticleSystem(XML(new config()), CreateTexture(asset));
		}
		
		// images
		public function get Background():Texture { return CreateTexture(background); }
		public function get Ground():Texture { return CreateTexture(ground); }
		public function get Tower():Texture { return CreateTexture(tower); }
		public function get Orb():Texture { return CreateTexture(orb); }
		public function get Spellbuffer():Texture { return CreateTexture(spellbuffer); }
		public function get Managlow():Texture { return CreateTexture(managlow); }
		public function get Brush():Texture { return CreateTexture(brush); }
		
		// icons
		public function get IconEmpty():Texture { return CreateTexture(iconEmpty); }
		public function get IconFireball():Texture { return CreateTexture(iconFireball); }
		
		// sprite sheets
		public function get MobOrc():MovieClip { return CreateMovieClip(mobOrcXml, mobOrcAtlas, 8); }
		
		// partic systems
		public function get FireballParticle():PDParticleSystem { return CreateParticleSystem(fireballSpell, fireParticle); }
	}
}