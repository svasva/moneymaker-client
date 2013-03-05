package ru.fcl.sdd.item 
{
	/**
	 * ...
	 * @author 
	 */
	public class ItemVO 
	{
		private var _itemName:String;
		private var _itemDesc:String;
		private var _itemIconUrl:String;
		private var _itemGoldPrice:int;
		private var _itemGamePrice:int;
		private var _itemLevelReq:int;
		private var _itemRepReq:int;
		private var _itemRoomReq:String;
		
		public function ItemVO() 
		{
			
		}
		
		public function get itemName():String 
		{
			return _itemName;
		}
		
		public function set itemName(value:String):void 
		{
			_itemName = value;
		}
		
		public function get itemDesc():String 
		{
			return _itemDesc;
		}
		
		public function set itemDesc(value:String):void 
		{
			_itemDesc = value;
		}
		
		public function get itemIconUrl():String 
		{
			return _itemIconUrl;
		}
		
		public function set itemIconUrl(value:String):void 
		{
			_itemIconUrl = value;
		}
		
		public function get itemGoldPrice():int 
		{
			return _itemGoldPrice;
		}
		
		public function set itemGoldPrice(value:int):void 
		{
			_itemGoldPrice = value;
		}
		
		public function get itemGamePrice():int 
		{
			return _itemGamePrice;
		}
		
		public function set itemGamePrice(value:int):void 
		{
			_itemGamePrice = value;
		}
		
		public function get itemLevelReq():int 
		{
			return _itemLevelReq;
		}
		
		public function set itemLevelReq(value:int):void 
		{
			_itemLevelReq = value;
		}
		
		public function get itemRepReq():int 
		{
			return _itemRepReq;
		}
		
		public function set itemRepReq(value:int):void 
		{
			_itemRepReq = value;
		}
		
		public function get itemRoomReq():String 
		{
			return _itemRoomReq;
		}
		
		public function set itemRoomReq(value:String):void 
		{
			_itemRoomReq = value;
		}
		
	}

}