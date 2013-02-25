package ru.fcl.sdd.homus 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class HomusEvent extends Event 
	{
		
		public static const NO_SERVICE:String = "no_service";
		
		public function HomusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new HomusEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("HomusEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}