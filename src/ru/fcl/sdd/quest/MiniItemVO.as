package ru.fcl.sdd.quest 
{
	/**
	 * ...
	 * @author 
	 */
	public class MiniItemVO 
	{
		
		private var _catalogId:String;
		private var _itemName:String;
		private var _isCheck:Boolean;
		
		public function MiniItemVO() 
		{
			
		}
		
		public function get isCheck():Boolean 
		{
			return _isCheck;
		}
		
		public function set isCheck(value:Boolean):void 
		{
			_isCheck = value;
		}
		
		public function get itemName():String 
		{
			return _itemName;
		}
		
		public function set itemName(value:String):void 
		{
			_itemName = value;
		}
		
		public function get catalogId():String 
		{
			return _catalogId;
		}
		
		public function set catalogId(value:String):void 
		{
			_catalogId = value;
		}
		
	}

}