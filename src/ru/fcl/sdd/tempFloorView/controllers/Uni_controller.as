package ru.fcl.sdd.tempFloorView.controllers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	

	/**
	 * @author OPashkovskiy
	 */
	public class Uni_controller extends EventDispatcher {
		private static var _instance : Uni_controller;

		private static function hidden() : void {
		}

		public function Uni_controller(h : Function) {
			if(h !== hidden) {
				throw new Error("use getInstance, babe");
			}
		}

		public static function getInstance() : Uni_controller {
			if (_instance == null) {
				_instance = new Uni_controller(hidden);
			}
			return _instance;
		}

		
	}
}
