package com.ddg.wwt.view 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.ActorManager;
	import com.ddg.wwt.game.actors.mobs.Orc;
	import com.ddg.wwt.game.actors.mobs.Wizard;
	import com.ddg.wwt.game.buffer.BufferPad;
	import com.ddg.wwt.game.drawing.DrawPad;
	import com.ddg.wwt.game.mana.ManaPad;
	import com.ddg.wwt.game.orbs.OrbPad;
	import com.ddg.wwt.game.spells.FireballSpell;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
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
		
		// monster spawning
		private var startTime:int;
		private var lastSpawnTime:int;
		
		//ui
		private var scoreField:TextField;
		
		public function GameView() 
		{
			startTime = Settings.Instance.GetCurrentTime();
			Init();
			InitTest();
		}
		
		private function Init():void
		{
			// decoration
			var background:Image = new Image(Assets.Instance.Background);
			background.height = Settings.Instance.StageHeight;
			background.width = Settings.Instance.StageWidth;
			var ground:Image = new Image(Assets.Instance.Ground);
			ground.y = Settings.Instance.StageHeight - 50;
			ground.width = Settings.Instance.StageWidth;
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
			surface.addChild(ground);
			surface.addChild(tower);
			surface.addChild(bufferPad.Surface);
			surface.addChild(orbPad.Surface);
			surface.addChild(drawPad.Surface);
			
			// ui
			scoreField = new TextField(Settings.Instance.StageWidth - 10, 30, "0", "Verdana", 14, 0xffffff, false);
			scoreField.hAlign = HAlign.RIGHT;
			scoreField.vAlign = VAlign.BOTTOM;
			surface.addChild(scoreField);
		}
		
		private function InitTest():void
		{
			Settings.Instance.wizard = new Wizard(surface);
			ActorManager.Instance.AddMob(Settings.Instance.wizard);
			bufferPad.BufferSpell(new FireballSpell());
			bufferPad.BufferSpell(new FireballSpell());
			bufferPad.BufferSpell(new FireballSpell());
			ActorManager.Instance.AddMob(new Orc(surface, new Point(100, 0), Settings.DIRECTION_RIGHT));
			ActorManager.Instance.AddMob(new Orc(surface, new Point(800, 0), Settings.DIRECTION_LEFT));
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
			if (!Settings.Instance.wizard.IsDead)
			{
				orbPad.Update(deltaTime);
				ActorManager.Instance.Update(deltaTime);
				SpawnMobs(deltaTime);
				RefillMana(deltaTime);
				UpdateUI();
			}
		}
		
		private function SpawnMobs(deltaTime:Number):void
		{
			var timeInGame:int = Math.round((Settings.Instance.GetCurrentTime() - startTime) * 0.001);
			if (timeInGame % 8 == 0 && timeInGame != lastSpawnTime)
			{
				lastSpawnTime = timeInGame;
				for (var i:int = 0; i < Math.min(timeInGame / 10, 10); i++)
					ActorManager.Instance.AddMob(new Orc(surface, new Point(0 - i * 5 - 10, Settings.Instance.GroundY), Settings.DIRECTION_RIGHT));
			}
			if ((timeInGame + 4) % 8 == 0 && timeInGame != lastSpawnTime)
			{
				lastSpawnTime = timeInGame;
				for (var j:int = 0; j < Math.min(10, timeInGame / 10); j++)
					ActorManager.Instance.AddMob(new Orc(surface, new Point(Settings.Instance.StageWidth + j * 5 + 10, Settings.Instance.GroundY), Settings.DIRECTION_LEFT));
			}
		}
		
		private function RefillMana(deltaTime:Number):void
		{
			manaPad.Mana = Math.min(1, manaPad.Mana + deltaTime * 0.02);
		}
		
		private function UpdateUI():void
		{
			scoreField.text = String(Settings.Instance.score);
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
		
		public function get DrawSurface():DrawPad
		{
			return drawPad;
		}
		
		public function OnTouch(event:TouchEvent):Boolean
		{
			if (!Settings.Instance.wizard.IsDead)
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
			}
			return false;
		}
	}
}