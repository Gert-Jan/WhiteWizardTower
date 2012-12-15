package com.ddg.wwt.view 
{
	import com.ddg.wwt.Settings;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ViewManager 
	{
		private static const instance:ViewManager = new ViewManager();
		
		public static function get Instance():ViewManager
		{
			return instance;
		}
		
		public function ViewManager() 
		{}
		
		private var viewStack:Vector.<IView> = new Vector.<IView>();
		private var root:Sprite;
		
		
		public function Init(root:Sprite):void
		{
			this.root = root;
			root.addEventListener(TouchEvent.TOUCH, OnTouch);
			viewStack.push(new GameView());
			viewStack[0].Activate();
		}
		
		public function get RootSurface():Sprite
		{
			return root;
		}
		
		private function OnTouch(event:TouchEvent):void
		{
			for each (var view:IView in viewStack)
			{
				if (view.IsActive && view.OnTouch(event))
					return;
			}
		}
	}
}