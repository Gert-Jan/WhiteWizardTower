package com.ddg.wwt.game.actors.components 
{
	import com.ddg.wwt.game.actors.IActor;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ComponentBase 
	{
		protected var actor:IActor;
		
		public function ComponentBase() 
		{}
		
		public function set Actor(actor:IActor):void
		{
			this.actor = actor;
		}
	}
}