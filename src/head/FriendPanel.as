package head
{
	import asst.api.SocialClient;
	
	import com.caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	import head.friendpanel.FriendCard;
	import head.friendpanel.FriendCardSprite;
	
	import legacy.ContentCache;
	
	public class FriendPanel extends Sprite
	{
		private var _sprite:Sprite;
		
		private var _currentUser:FriendCard;
		public var baseCardUser:FriendCard;

		private var _buttonLeft:SimpleButton;
		private var _buttonRight:SimpleButton;
		private var _friendInvite:SimpleButton;
		
		private var _widthCard:uint = 0;
		private var _startx:int = 0;
		private var _starty:int = 0;
		private var _distance:Number = 0;

		private var _limit:uint  	= 0;
		private var _offset:int     = 0;
		private var _items:Array 	= new Array();
		private var _friends:Array  = new Array();
		private var _friends_uids:Array = [];

		private var _currentOpenCard:FriendCard;
	
		private var _phFriends:Sprite;
		
		private function _createSettings():void {
			if (Config.NETWORK == SocialClient.NETWORK_VK) {
				_limit 		= 5;	
				_distance 	= 0;
				_startx 	= 55;
				_starty 	= 79;
				_widthCard	= 99;
				return;
			}
			
			if (Config.NETWORK == SocialClient.NETWORK_OK) {
				_limit 		= 4;	
				_distance 	= 2;
				_startx 	= 48;
				_starty 	= 85;
				_widthCard	= 110;
				return;
			}
			
			if (Config.NETWORK == SocialClient.NETWORK_FB || Config.NETWORK == SocialClient.NETWORK_MM) {
				_limit 		= 5;	
				_distance 	= -2;
				_startx 	= 38;
				_starty 	= 0;
				_widthCard	= 88;
				return;
			}
		}
		
		public function FriendPanel()
		{
			_createSettings();

			ContentCache.getInstance().getSymbol(
				ContentCache.dataDirectory + 'friendbar_' + Config.NETWORK +'.swf',
				'panel',
				_onDataReceived
			);
		}
		
		private function _onDataReceived(data:MovieClip):void
		{
			_sprite = data;
			addChild(_sprite);
			
			_phFriends = _sprite.getChildByName('phFriends') as Sprite;
			
			_buttonLeft 	= _sprite.getChildByName('buttonLeft') as SimpleButton;
			_buttonRight 	= _sprite.getChildByName('buttonRight') as SimpleButton;
			
			_buttonLeft.visible = _buttonRight.visible = false;
			
			init();
		}
		
		private function _onClick(e:MouseEvent):void {
			if (_friends.indexOf(e.target) > -1) {
				if ((e.target as FriendCard).params.inGame == false) {
					SocialClient.adapter.dialogInvite();
					return;
				} 	
			} 
			
			if (e.target == _buttonLeft) _onButtonLeft();
			if (e.target == _buttonRight) _onButtonRight();
		}
		
		public function init():void
		{
			for (var j:int = 0; j < _limit; j++) {
				var card:FriendCardSprite = new FriendCardSprite();
				card.x = _startx + ((_widthCard + _distance) * j);
				card.y = _starty;
				_items.push(card);
				_phFriends.addChild(card);
			}
			
			for (var i:int = 0; i < _limit; i++) {
				_friends.push(new FriendCard(FriendCard.TYPE_LOADING));
			}
			
			_drawList();
			
			Friends.addListener(_onReady);
		}
		
	/*	public function initListners():void {
		//	Main.addEventListener(Event.DATA_CHANGED, _refreshFriends);
		}*/
		
		private function _drawList():void 
		{
			Tweener.addTween(_phFriends, {
				x 		: _offset * (_widthCard + _distance) * -1,
				time	: .5
			});
			
			//var j:int = 0;
			
			/*for (var i:int = _offset; i < (_limit + _offset); i++) {
				if (_items[j] != null) {
					_items[j].setCard(_friends[i]);
					j++;
				}
			} */ 
		}
		
		private function _onButtonLeft():void
		{
			if (_offset > 0) {
				_offset -= _limit;
				
				if (_offset < 0) {
					_offset = 0;
				}
				
				_drawList();
				_visibleButton();
			}
		}
		
		private function _onButtonRight():void
		{
			if (_offset < (_friends.length - _limit)) {
				_offset += _limit;
				
				if (_offset > _friends.length - _limit) {
					_offset = _friends.length - _limit;
				}
				_drawList();
				_visibleButton();
			}
		}
		
		private function _visibleButton():void {
			
			if (_friends.length <= _limit) {
				_buttonLeft.visible = _buttonRight.visible = false;
				return;
			}
			
			_buttonLeft.visible = !(_offset == 0);
			_buttonRight.visible = !(_offset + _limit == _friends.length);
		}
		
		private function _onReady():void
		{
			var profile:Object;
			var profiles:Object;
			var i:int;
			var j:int;

			profiles = Friends.friends;
			
			var list:Array = new Array();
			for each (var o:Object in profiles) {
				list.push(o);
			}

			list.sort(_sortByParams);
			
			_friends = [];
			
			for (i = 0; i < list.length; i++) {
				var friend:FriendCard = new FriendCard(FriendCard.TYPE_PROFILE);
				friend.startup(list[i]);
				
				_friends.push(friend);
				
				if (list[i].uid == Main.viewer_id && _currentUser == null) {
					_currentUser = friend;
				} else {
					if (_currentUser != null && friend.params.oid == _currentUser.params.oid) {
						_currentUser = friend;
					}
				}
			}
			
			if (list.length < _limit) {
				for (j = 0; j < _limit - list.length; j++) {
					friend = new FriendCard(FriendCard.TYPE_EMPTY);
					//friend.addEventListener(MouseEvent.CLICK, _onButtonInvite);
					_friends.push(friend);
				}
			}
			
			while (_phFriends.numChildren > 0) {
				_phFriends.removeChildAt(0);
			}
			
			for (i = 0; i<_friends.length; i++) {
				var card:FriendCard = _friends[i];
				card.x = _startx + ((_widthCard + _distance) * i);
				card.y = _starty;
				_phFriends.addChild(_friends[i]);
			}
			
			_drawList();
			_visibleButton();
			
			_sprite.addEventListener(MouseEvent.CLICK, _onClick);
			_sprite.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			_sprite.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
		}
		
		private function _onMouseOver(e:MouseEvent):void {
			var p:DisplayObject = (e.target) as DisplayObject;
			while (p != null) {
				if (p is FriendCard)
					break;

				p = p.parent;
			}
			
			if (_friends.indexOf(p) > -1) {
				if (p == _currentOpenCard) return;
				if (p==null) return;
				
				if (_currentOpenCard != null) _currentOpenCard.close();
				_currentOpenCard = p as FriendCard;
				
				(p as FriendCard).open();
			}
		}
		
		private function _onMouseOut(e:MouseEvent):void {
			var p:DisplayObject = (e.relatedObject) as DisplayObject;
			while (p != null) {
				if (p is FriendCard) {
					break;
				}
				p = p.parent;
			}
			
			if (p ==_currentOpenCard) return;
			
			if (_currentOpenCard != null) _currentOpenCard.close();
			_currentOpenCard = null;
		}
		
		private function _sortByParams(a:*, b:*):Number 
		{
			if(a['first'] < b['first']) 			return 1;
			else if(a['first'] > b['first']) 		return -1;
			else
				if(a['inGame'] < b['inGame']) 		return 1;
				else if(a['inGame'] > b['inGame']) 	return -1;
				else
					if(a['exp'] < b['exp'])			return 1;
					else if(a['exp'] > b['exp']) 	return -1;
					else 
						if(a['first_name'] > b['first_name']) 		return 1;
						else if(a['first_name'] < b['first_name']) 	return -1;
						else  										return 0;
		}
		
		public function get limit():uint {
			return _limit;
		}
	}
}