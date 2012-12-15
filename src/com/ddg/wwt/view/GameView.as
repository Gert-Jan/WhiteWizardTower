package com.ddg.wwt.view 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.OrbPad;
	import com.ddg.wwt.Settings;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class GameView implements IView
	{
		private var surface:Sprite = new Sprite();
		
		public function GameView() 
		{
			
		}
		
		public function Init():void
		{
			var background:Image = new Image(Assets.Instance.Background);
			var ground:Image = new Image(Assets.Instance.Ground);
			ground.y = Settings.Instance.stageHeight - 50;
			var tower:Image = new Image(Assets.Instance.Tower);
			tower.x = (Settings.Instance.stageWidth - tower.width) / 2;
			tower.y = (Settings.Instance.stageHeight - tower.height);
			var orbPad:OrbPad = new OrbPad();
			orbPad.Surface.x = Settings.Instance.stageWidth / 2 - OrbPad.WIDTH / 2;
			orbPad.Surface.y = Settings.Instance.stageHeight - tower.height + 20;
			
			surface.addChild(background);
			surface.addChild(tower);
			surface.addChild(ground);
			surface.addChild(orbPad.Surface);
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
	}
}