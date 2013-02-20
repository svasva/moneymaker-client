package classes 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import social.connector.IConnector;
	
	/**
	 * ...
	 * @author 
	 */
	public class FriendsPanelView extends Sprite 
	{
		
		private var cardProf:FriendBarItem;
		private var _cardVec:Vector.<FriendBarItem>;
		private const RANGE:int = 100;
		private var _conector:IConnector;
	
		
		public function FriendsPanelView() 
		{
			
			
			_cardVec = new Vector.<FriendBarItem>();
			createProfiles();
		}
		
		private function createProfiles():void 
		{
			for (var i:int = 0; i < 5; i++) 
			{
				cardProf = new FriendBarItem();
				cardProf.x = i * RANGE;
				cardProf.btnInvite.addEventListener(MouseEvent.CLICK, cardProf_click);
				addChild(cardProf);
				_cardVec[i] = cardProf;
			}
			
		}
		
		private function cardProf_click(e:MouseEvent):void 
		{
			_conector.showInvite(onCompl, onError);
		}
		
		private function onError():void 
		{
			trace("invaite Error");
		}
		
		private function onCompl():void 
		{
				
		}
		public function addData(arr:Array):void
		{
			for (var i:int = 0; i <_cardVec.length ; i++) 
			{
				_cardVec[i].clearItem();
			}
			
			for (var i:int = 0; i <arr.length ; i++) 
			{
				
				if(arr[i].firstName)
				_cardVec[i].userName = arr[i].firstName;
				_cardVec[i].imgUrl = arr[i].picture.normal;
				_cardVec[i].isAppUser = arr[i].isInstalled;
			}
		}
		
		public function get conector():IConnector 
		{
			return _conector;
		}
		
		public function set conector(value:IConnector):void 
		{
			_conector = value;
		}
		
	}

}