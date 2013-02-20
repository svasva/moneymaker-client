package social.vo
{
	import social.connector.ConnectorType;
	import social.vo.common.AbstractVO;
	
	public class ErrorVO extends AbstractVO
	{
		private var _code:uint;
		private var _message:String;
		private var _info:Object;
		
		public function ErrorVO(type:ConnectorType, obj:Object)
		{
			super(type, obj);
		}
		
		protected override function convertFromVkJson(obj:Object):void
		{
            if (obj is String)
            {
                _message = obj.toString();
            }
            else
            {
			    _code = obj.error_code;
			    _message = obj.error_msg;
			    _info = obj.request_params;
            }
		}
		
		protected override function convertFromOkJson(obj:Object):void
		{
			_code = obj.error_code;
			_message = obj.error_msg;
			_info = obj.error_data;
		}

		public function get code():uint
		{
			return _code;
		}

		public function get message():String
		{
			return _message;
		}

		public function get info():Object
		{
			return _info;
		}

	}
}