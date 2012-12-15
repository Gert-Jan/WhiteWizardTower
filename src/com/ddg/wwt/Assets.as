package com.ddg.wwt 
{
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

		[Embed(source = "../../../../art/Background.png")]
		private static const background:Class;
		[Embed(source = "../../../../art/Ground.png")]
		private static const ground:Class;
		[Embed(source = "../../../../art/Tower.png")]
		private static const tower:Class;
		[Embed(source = "../../../../art/Orb.png")]
		private static const orb:Class;
		[Embed(source = "../../../../art/Brush.png")]
		private static const brush:Class;
		
		public function Init():void
		{
		}
		
		private function CreateTexture(asset:Class):Texture
		{
			return Texture.fromBitmap(new asset());
		}
		
		public function get Background():Texture
		{
			return CreateTexture(background);
		}
		
		public function get Ground():Texture
		{
			return CreateTexture(ground);
		}
		
		public function get Tower():Texture
		{
			return CreateTexture(tower);
		}
		
		public function get Orb():Texture
		{
			return CreateTexture(orb);
		}
		
		public function get Brush():Texture
		{
			return CreateTexture(brush);
		}
	}
}