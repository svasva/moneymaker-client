package social.connector
{
	
	import social.connector.impl.VKConnector;
	

	public class ConnectorFactory
	{
		private var _flashVars : Object;
		
		public function ConnectorFactory(flashVars : Object)
		{
			_flashVars = flashVars;
		}
		
		public function createConnector(onComplete : Function, onSetting:Function =null) : IConnector
		{
			if (_flashVars['viewer_id'] != null)
			{
				return new VKConnector(_flashVars, onComplete,onSetting);
			}
			
		/*	if (_flashVars['vid'] != null)
			{
				return new MailConnector(_flashVars, onComplete);
			}
			
			if (_flashVars['logged_user_id'] != null)
			{
				return new OKConnector(_flashVars, onComplete);
			}

			if (_flashVars['facebook'] != null)
			{
				return new FBConnector(onComplete);
			}*/
			return null;
		}
	}
}