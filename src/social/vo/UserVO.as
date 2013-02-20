package social.vo
{
	import social.vo.common.AbstractVO;
	import social.connector.ConnectorType;
	import social.vo.common.Picture;
	
	public class UserVO extends AbstractVO
	{
		private var _id:String;		
		private var _firstName:String;
		private var _picture:Picture;
		private var _isOnline:Boolean;
		private var _level:int;
		private var _reputation:int;
		private var _isInstalled:Boolean = true;
		
		public function UserVO(type:ConnectorType, obj:Object)
		{
			super(type, obj);
		}
		
		protected override function convertFromMailJson(obj:Object):void
		{
			_id = obj.uid;
			_firstName = obj.first_name;
			_picture = new Picture(obj.pic_small, obj.pic, obj.pic_big);
			_isOnline = obj.online;
			if (int(obj.installed) == 1)
			{
				_isInstalled = true;
			}
			else
			{
				_isInstalled = false;
			}
		}
		
		protected override function convertFromVkJson(obj:Object):void
		{
			_id = obj.uid;
			_firstName= obj.first_name;
			_picture = new Picture(obj.photo, obj.photo_medium, obj.photo_big);
			_isOnline = obj.online;		
			if (int(obj.installed) == 1)
			{
				_isInstalled= true;
			}
			else
			{
				_isInstalled = false;
			}
		}		

		protected override function convertFromFacebookJson(obj:Object):void
		{
			_id = obj.uid;
			_firstName= obj.first_name;
			_picture = new Picture(obj.pic_square, obj.pic_square, obj.pic_square);
			_isOnline = obj.online_presence == "active" || obj.online_presence == "idle";
			_isInstalled= obj.is_app_user;
		}		

		protected override function convertFromOkJson(obj:Object):void
		{
			_id = obj.uid;
			_firstName = obj.first_name;
			_picture = new Picture(obj.pic_1, obj.pic_2, obj.pic_3);
			_isOnline = obj.online;
			if (int(obj.installed) == 1)
			{
				_isInstalled = true;
			}
			else
			{
				_isInstalled = false;
			}
		}
				
		public function get id():String
		{
			return _id;
		}

		public function get firstName():String
		{
			return _firstName;
		}
		public function get picture():Picture
		{
			return _picture;
		}
		public function get isOnline():Boolean
		{
			return _isOnline;
		}
		public function set isOnline(e:Boolean):void
		{
			_isOnline = e;
		}
		public function get level():int
		{
			return _level;
		}
		public function get reputation():int
		{
			return _reputation;
		}	
		public function get isInstalled():Boolean
		{
			return _isInstalled
		}
		public function set level(e:int):void
		{
			_level = e;
		}
		public function set reputation(e:int):void
		{
			 _reputation = e;
		}	
		public function set isInstalled(e:Boolean):void
		{
			_isInstalled = e;
		}

	}
}