package com.ddg.wwt.game.drawing 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DrawPad 
	{
		private static const DEFAULT_BRUSH_SCALE:Number = 0.5;
		private var surface:Sprite;
		
		private var fadingImages:Vector.<Image> = new Vector.<Image>();
		
		private var drawBrush:Image;
		private var drawImage:Image;
		private var drawTexture:RenderTexture;
		
		private var isDrawing:Boolean = false;
		private var previousPos:Point;
		private var currentPos:Point;
		public var drawPoints:Vector.<Point> = new Vector.<Point>();
		
		public function DrawPad() 
		{
			Init();
		}
		
		private function Init():void
		{
			// init surface
			surface = new Sprite();
			drawTexture = new RenderTexture(Settings.Instance.StageWidth, Settings.Instance.StageHeight);
			drawImage = new Image(drawTexture);
			surface.addChild(drawImage);
			
			// init brush
			drawBrush = new Image(Assets.Instance.Brush);
			drawBrush.pivotX = drawBrush.width / 2;
			drawBrush.pivotY = drawBrush.height / 2;
			BrushScale = DEFAULT_BRUSH_SCALE;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function get IsDrawing():Boolean
		{
			return isDrawing;
		}
		
		private function set BrushScale(scale:Number):void
		{
			drawBrush.scaleX = scale;
			drawBrush.scaleY = scale;
		}
		
		public function OnTouch(event:TouchEvent):Boolean
		{
			var touch:Touch;
			if (!isDrawing)
			{
				touch = event.getTouch(surface, TouchPhase.BEGAN);
				if (touch)
					StartDrawing(touch);
			}
			else
			{
				touch = event.getTouch(surface, TouchPhase.ENDED);
				if (touch)
					StopDrawing(touch);
				else
				{
					touch = event.getTouch(surface, TouchPhase.MOVED);
					if (touch)
						UpdateDrawing(touch);
				}
			}
			return false;
		}
		
		private function StartDrawing(touch:Touch):void
		{
			// status
			isDrawing = true;
			
			// start drawing instantly
			currentPos = touch.getLocation(drawImage);
			previousPos = currentPos;
			drawBrush.x = Math.round(currentPos.x);
			drawBrush.y = Math.round(currentPos.y);
			drawTexture.draw(drawBrush);
		}
		
		private function UpdateDrawing(touch:Touch):void
		{
			currentPos = touch.getLocation(drawImage);
			drawTexture.drawBundled(DrawLine);
			previousPos = currentPos;
		}
		
		private function DrawLine():void
		{
			var counter:int = 0;
			drawPoints.length = 0;
			var x:Number, y:Number, factorX:Number, factorY:Number;
			var deltaX:Number = Math.round(currentPos.x - previousPos.x);
			var deltaY:Number = Math.round(currentPos.y - previousPos.y);
			if (Math.abs(deltaX) > Math.abs(deltaY))
			{
				y = previousPos.y;
				factorX = deltaX / Math.abs(deltaX);
				if (deltaX == 0)
					factorY = 0;
				else
					factorY = deltaY / Math.abs(deltaX);
				
				for (x = previousPos.x; deltaX > 0 ? x <= currentPos.x : x >= currentPos.x; x += factorX)
				{
					drawBrush.x = x;
					drawBrush.y = y;
					drawTexture.draw(drawBrush);
					if (counter % 10 == 0)
						drawPoints.push(new Point(x, y));
					y += factorY;
					counter++;
				}
			}
			else
			{
				x = previousPos.x;
				factorY = deltaY / Math.abs(deltaY);
				if (deltaY == 0)
					factorX = 0;
				else
					factorX = deltaX / Math.abs(deltaY);
				for (y = previousPos.y; deltaY > 0 ? y <= currentPos.y : y >= currentPos.y; y += factorY)
				{
					drawBrush.x = x;
					drawBrush.y = y;
					drawTexture.draw(drawBrush);
					if (counter % 10 == 0)
						drawPoints.push(new Point(x, y));
					x += factorX;
					counter++;
				}
			}
		}
		
		private function StopDrawing(touch:Touch):void
		{
			// status
			isDrawing = false;
			
			// fade out current draw image
			fadingImages.push(drawImage);
			var tween:Tween = new Tween(drawImage, 0.6, Transitions.LINEAR);
			tween.fadeTo(0);
			tween.onComplete = RemoveFadingImage;
			Starling.juggler.add(tween);
			
			// prepare new drawing surface
			drawTexture = new RenderTexture(Settings.Instance.StageWidth, Settings.Instance.StageHeight);
			drawImage = new Image(drawTexture);
			drawImage.alpha = 0.8;
			surface.addChild(drawImage);
			
			// cleanup drawPoints
			drawPoints.length = 0;;
		}
		
		private function RemoveFadingImage():void
		{
			surface.removeChild(fadingImages.splice(0, 1)[0]);
		}
	}
}