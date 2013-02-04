package ru.fcl.sdd.tempFloorView.controllers {
	import flash.events.Event;

	/**
	 * @author OPashkovskiy
	 */
	public class Uni_event extends Event {
		public var arg : *;

		public function Uni_event(type : String, bubbles : Boolean = false, cancelable : Boolean = false,...a : *) {
			super(type, bubbles, cancelable);
			arg = a;
		}

		override public function clone() : Event {
			return new Uni_event(type, bubbles, cancelable, arg);
		}
	}
}
