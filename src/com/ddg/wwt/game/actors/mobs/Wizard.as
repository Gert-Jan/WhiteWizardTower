package com.ddg.wwt.game.actors.mobs 
{
	import com.ddg.wwt.Assets;
	import com.ddg.wwt.game.actors.components.DrawHealthbarComponent;
	import com.ddg.wwt.game.actors.components.DrawImageComponent;
	import com.ddg.wwt.game.actors.IActor;
	import com.ddg.wwt.Settings;
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Wizard extends MobBase implements IActor 
	{
		// settings
		private static const HEALTH:Number = 200;
		
		private var isDead:Boolean = false;
		private var image:Image;
		
		public function Wizard(target:DisplayObjectContainer) 
		{
			super(target, new Point(Settings.Instance.StageWidth / 2, Settings.Instance.GroundY), Settings.DIRECTION_RIGHT);
			health = HEALTH;
		}
		
		public function get IsDead():Boolean
		{
			return isDead;
		}
		
		public override function Init():void 
		{
			// drawing
			image = new Image(Assets.Instance.Wizard);
			image.pivotX = image.width / 2;
			image.pivotY = image.height - 2;
			componentManager.AddComponent(new DrawImageComponent(image));
			componentManager.AddComponent(new DrawHealthbarComponent(new Point(0, -40), HEALTH)); 
		}
		
		public override function Update(deltaTime:Number):void
		{
			super.Update(deltaTime);
			health = Math.min(HEALTH, health + deltaTime * 2);
		}
		
		public function DecreaseHealth(amount:Number):void
		{
			health = Math.max(0, health - amount);
			if (health <= 0)
			{
				isDead = true;
				image.scaleY = 0.3;
			}
		}
	}
}