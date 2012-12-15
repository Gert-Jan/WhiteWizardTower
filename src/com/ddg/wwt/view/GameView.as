package com.ddg.wwt.view 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.buffer.BufferPad;
	import com.ddg.wwt.game.drawing.DrawPad;
	import com.ddg.wwt.game.mana.ManaPad;
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
		
		private var manaPad:ManaPad;
		private var orbPad:OrbPad;
		private var bufferPad:BufferPad;
		private var drawPad:DrawPad;
		
		public static const DRAW_STATE_NONE:int = 0;
		public static const DRAW_STATE_BUFFER:int = 1;
		public static const DRAW_STATE_CAST:int = 2;
		private var drawState:int = 0;
		
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
			// mana pad
			manaPad = new ManaPad();
			manaPad.Surface.x = Settings.Instance.StageWidth / 2;
			manaPad.Surface.y = Settings.Instance.StageHeight - tower.height + 160;
			// orb pad
			orbPad = new OrbPad(this);
			orbPad.Surface.x = Settings.Instance.StageWidth / 2 - OrbPad.WIDTH / 2;
			orbPad.Surface.y = Settings.Instance.StageHeight - tower.height + 20;
			// buffer pad
			bufferPad = new BufferPad();
			bufferPad.Surface.x = Settings.Instance.StageWidth / 2;
			bufferPad.Surface.y = Settings.Instance.StageHeight - 125;
			// draw pad
			drawPad = new DrawPad();
			
			surface.addChild(background);
			surface.addChild(manaPad.Surface);
			surface.addChild(tower);
			surface.addChild(ground);
			surface.addChild(bufferPad.Surface);
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
		
		public function Update(deltaTime:Number):void
		{
			orbPad.Update(deltaTime);
			ActorManager.Instance.Update(deltaTime);
		}
		
		public function get IsActive():Boolean
		{
			return isActive;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function get SpellBuffer():BufferPad
		{
			return bufferPad;
		}
		
		public function get ManaPool():ManaPad
		{
			return manaPad;
		}
		
		public function OnTouch(event:TouchEvent):Boolean
		{
			drawPad.OnTouch(event);
			if (drawPad.IsDrawing && drawState == DRAW_STATE_NONE)
				drawState = DRAW_STATE_CAST;
			if (orbPad.HandleOrbTouches(drawPad.IsDrawing, drawPad.drawPoints))
				drawState = DRAW_STATE_BUFFER;
			if (!drawPad.IsDrawing && drawState == DRAW_STATE_CAST)
				bufferPad.CastSpell(surface, drawPad.DrawPosition, drawPad.DrawVelocity);
			if (!drawPad.IsDrawing)
				drawState = DRAW_STATE_NONE;
			return false;
		}
	}
}