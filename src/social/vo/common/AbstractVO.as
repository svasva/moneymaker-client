package social.vo.common
{	
	import social.connector.ConnectorType;
	import social.tools.ObjectCopier;

	public class AbstractVO
	{
		protected var _type:ConnectorType;
		
		public function AbstractVO(type:ConnectorType, obj:Object)
		{
			_type = type;
			
			convertFromJson(obj);
		}
		
		public function clone() : AbstractVO
		{
			return ObjectCopier.clone(this) as AbstractVO;
		}
		
		public function convertFromJson(obj:Object):void
		{
			switch(_type)
			{
				case ConnectorType.CONNECTOR_VK:
				{
					convertFromVkJson(obj); break;
				}
				case ConnectorType.CONNECTOR_OK:
				{
					convertFromOkJson(obj); break;
				}
				case ConnectorType.CONNECTOR_FACEBOOK:
				{
					convertFromFacebookJson(obj); break;
				}
				case ConnectorType.CONNECTOR_MAILRU:
				{
					convertFromMailJson(obj); break;
				}
				default: new Error("Unsupported connector type");
			}
		}
		
		protected function convertFromVkJson(obj:Object):void { throw new Error("Unsupported method") }
		protected function convertFromMailJson(obj:Object):void { throw new Error("Unsupported method") }
		protected function convertFromOkJson(obj:Object):void { throw new Error("Unsupported method") }
		protected function convertFromFacebookJson(obj:Object):void { throw new Error("Unsupported method") }
	}
}