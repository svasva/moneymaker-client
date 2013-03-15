package ru.fcl.sdd.quest 
{
	import flash.display.Loader;
	/**
	 * ...
	 * @author 
	 */
	public class QuestVO 
	{
		private var _desc:String;
		private var _requirements:Object;
		private var _complete_requirements:Object;
		private var _name:String;
		private var _id:String;
		private var _character_swf:String;
		private var _quest_character_id:String;
		private var _rewards:Object;
		private var _complete_text:String;
		private var _character_icon:String;
		private var _isAccept:Boolean = false;
		private var _isCompleated:Boolean = false;	
		private var _itemReq:Vector.<MiniItemVO>;
		private var _roomReq:Vector.<MiniItemVO>;
		
		
		public function QuestVO() 
		{		
			
		}
		
		public function get desc():String 
		{
			return _desc;
		}
		
		public function set desc(value:String):void 
		{
			_desc = value;
		}
		
		public function get requirements():Object 
		{
			return _requirements;
		}
		
		public function set requirements(value:Object):void 
		{
			_requirements = value;
		}
		
		public function get complete_requirements():Object 
		{
			return _complete_requirements;
		}
		
		public function set complete_requirements(value:Object):void 
		{
			_complete_requirements = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get character_swf():String 
		{
			return _character_swf;
		}
		
		public function set character_swf(value:String):void 
		{
			_character_swf = value;
		}
		
		public function get quest_character_id():String 
		{
			return _quest_character_id;
		}
		
		public function set quest_character_id(value:String):void 
		{
			_quest_character_id = value;
		}
		
		public function get rewards():Object 
		{
			return _rewards;
		}
		
		public function set rewards(value:Object):void 
		{
			_rewards = value;
		}
		
		public function get complete_text():String 
		{
			return _complete_text;
		}
		
		public function set complete_text(value:String):void 
		{
			_complete_text = value;
		}
		
		public function get character_icon():String 
		{
			return _character_icon;
		}
		
		public function set character_icon(value:String):void 
		{
			_character_icon = value;
		}
		
		public function get isAccept():Boolean 
		{
			return _isAccept;
		}
		
		public function set isAccept(value:Boolean):void 
		{
			_isAccept = value;
		}
		
		public function get isCompleated():Boolean 
		{
			return _isCompleated;
		}
		
		public function set isCompleated(value:Boolean):void 
		{
			_isCompleated = value;
		}
		
		public function get itemReq():Vector.<MiniItemVO> 
		{
			return _itemReq;
		}
		
		public function set itemReq(value:Vector.<MiniItemVO>):void 
		{
			_itemReq = value;
		}
		
		public function get roomReq():Vector.<MiniItemVO> 
		{
			return _roomReq;
		}
		
		public function set roomReq(value:Vector.<MiniItemVO>):void 
		{
			_roomReq = value;
		}
		
	}

}