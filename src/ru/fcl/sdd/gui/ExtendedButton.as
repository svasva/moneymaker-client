package ru.fcl.sdd.gui
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class ExtendedButton extends SimpleButton
	{
		private var _disabledState:DisplayObject = null;
		private var remembedUpState:DisplayObject = null;
		private var remembedOverState:DisplayObject = null;
		private var remembedDownState:DisplayObject = null;
		private var _locked:Boolean = false;
		private var _disabled:Boolean = false;
		
		public function ExtendedButton( upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null, disabledState:DisplayObject=null )
		{
			super(upState, overState, downState, hitTestState);
			
			_disabledState = disabledState;
			remembedUpState = upState;
			remembedOverState = overState;
			remembedDownState = downState;
		}
		
		public function get locked():Boolean
		{
			return _locked;
		}

		public function set locked(value:Boolean):void
		{
			if ( _locked == value )
				return;
			
			_locked = value;
			enabled = !_locked;
			
			if ( _locked )
			{
				upState = _disabledState;
				overState = _disabledState;
				downState = _disabledState;
			}
			else
			{
				upState = remembedUpState;
				overState = remembedOverState;
				downState = remembedDownState;
			}
		}

		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			if ( _disabled == value )
				return;
			
			_disabled = value;
			enabled = !_disabled;
			
			if ( _disabled )
			{
				upState.transform.colorTransform = new ColorTransform(0.4,0.4,0.4);
				overState.transform.colorTransform = new ColorTransform(0.4,0.4,0.4);
				downState.transform.colorTransform = new ColorTransform(0.4,0.4,0.4);
				_disabledState.transform.colorTransform = new ColorTransform(0.4,0.4,0.4);
			}
			else
			{
				upState.transform.colorTransform = new ColorTransform();
				overState.transform.colorTransform = new ColorTransform();
				downState.transform.colorTransform = new ColorTransform();
				_disabledState.transform.colorTransform = new ColorTransform();
			}
		}
	}
}