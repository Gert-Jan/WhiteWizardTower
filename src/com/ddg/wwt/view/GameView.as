package com.ddg.wwt.view 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.drawing.DrawPad;
	import com.ddg.wwt.game.orbs.OrbPad;
	import com.ddg.wwt.Settings;
	import flash.events.IMEEvent;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class GameView implements IView
	{
		private var surface:Sprite = new Sprite();
		private var isActive:Boolean = false;
		
		private var orbPad:OrbPad;
		private var drawPad:DrawPad;
		
		public function GameView() 
		{
			Init();
		}
		
		private function Init():void
		{
			// decoration
			var background:Image = new Image(Assets.Instance.Background);
			var ground:Image = new Image(Assets.Instance.Ground);
			ground.y = Settings.Instance.StageHeight - 50;
			var tower:Image = new Image(Assets.Instance.Tower);
			tower.x = (Settings.Instance.StageWidth - tower.width) / 2;
			tower.y = (Settings.Instance.StageHeight - tower.height);
			// orb pad
			orbPad = new OrbPad(this);
			orbPad.Surface.x = Settings.Instance.StageWidth / 2 - OrbPad.WIDTH / 2;
			orbPad.Surface.y = Settings.Instance.StageHeight - tower.height + 20;
			// draw pad
			drawPad = new DrawPad();
			
			surface.addChild(background);
			surface.addChild(tower);
			surface.addChild(ground);
			surface.addChild(orbPad.Surface);
			surface.addChild(drawPad.Surface);
		}
		
		public function Activate():void
		{
			if (!isActive)
			{
				isActive = true;
				ViewManager.Instance.RootSurface.addChild(surface);
			}
		}
		
		public function Deactivate():void
		{
			if (isActive)
			{
				isActive = false;
				ViewManager.Instance.RootSurface.removeChild(surface);
			}
		}
		
		public function get IsActive():Boolean
		{
			return isActive;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function OnTouch(event:TouchEvent):Boolean
		{
			drawPad.OnTouch(event);
			orbPad.HandleOrbTouches(drawPad.IsDrawing, drawPad.drawPoints);
			return false;
		}
	}
}