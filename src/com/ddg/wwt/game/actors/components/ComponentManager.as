package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.IActor;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ComponentManager 
	{
		private var actor:IActor;
		private var components:Vector.<IActorComponent> = new Vector.<IActorComponent>();
		
		public function ComponentManager(actor:IActor) 
		{
			this.actor = actor;
		}
		
		public function Update(deltaTime:Number):void
		{
			for each (var component:IActorComponent in components)
				component.Update(deltaTime);
		}
		
		public function Destroy():void
		{
			for each (var component:IActorComponent in components)
				component.Destroy();
		}
		
		public function AddComponent(component:IActorComponent):void
		{
			component.Actor = actor;
			component.Init();
			components.push(component);
		}
		
		public function RemoveComponent(component:IActorComponent):void
		{
			component.Destroy();
			components.splice(components.indexOf(component), 1);
		}
	}
}