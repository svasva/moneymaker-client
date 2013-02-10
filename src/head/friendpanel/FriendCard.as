package head.friendpanel
{
	import asst.api.SocialClient;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.ColorMatrixFilter;
	import flash.net.*;
	import flash.text.*;
	import flash.utils.Timer;
	
	import legacy.ContentCache;
	
	
	public class FriendCard extends Sprite
	{
		public static var TYPE_LOADING:uint 	 = 0;
		public static var TYPE_PROFILE:uint 	 = 1;
		public static var TYPE_EMPTY:uint   	 = 2;
		
		private var _userNameText:TextField;
		private var _scoreText:TextField;

		private var _type:uint;
		private var _params:Object;
		private var _options:Object;
		private var _sprite:Sprite;
		private var _scoreboard:Sprite;
		private var _scoreboardFill:Boolean = false;
		
		private var _photo:Sprite;
		
		private var _iconOnLine:Sprite;
		private var _iconOffLine:Sprite;
		private var _borderOffLine:Sprite;
		private var _iconScore:Sprite;
		
		private var _btnInvite:Sprite;
		private var _btnSend:Sprite;
		private var _btnGift:Sprite;
		private var _btnVisit:Sprite;
		private var _btnHome:Sprite;
		
		private var _body:MovieClip;
		private var _tools:Sprite;
		
		private var _matrix:Array = [0.212671, 0.715160, 0.072169, 0, 0,
									 0.212671, 0.715160, 0.072169, 0, 0,
									 0.212671, 0.715160, 0.072169, 0, 0,
									 0, 0, 0, 1, 0];
		
		private var _filter:ColorMatrixFilter = new ColorMatrixFilter(_matrix);
		
		public function FriendCard(type:uint, options:Object = null)
		{
			_type = type;
			_options = options;
			
			ContentCache.getInstance().getSymbol(
				ContentCache.dataDirectory + 'friendbar_' + Config.NETWORK +'.swf',
				'cardProfile',
				_onDataReceived
			);
		}
		
		private function _onDataReceived(data:MovieClip):void
		{
			_sprite = data;
			addChild(_sprite);
			
			_body  = _sprite.getChildByName('body') as MovieClip;
			_body.gotoAndStop(1);
			
			_btnSend    = _body.getChildByName('btnSend') as Sprite;
			_btnGift    = _body.getChildByName('btnGift') as Sprite;
			_btnVisit   = _body.getChildByName('btnVisit') as Sprite;
			_btnInvite	= _body.getChildByName('btnInvite') as Sprite;
			_btnHome	= _body.getChildByName('btnHome') as Sprite;
			
			_btnSend.visible = _btnGift.visible = _btnVisit.visible = _btnInvite.visible = _btnHome.visible = false;
			_btnSend.mouseChildren = _btnGift.mouseChildren = _btnVisit.mouseChildren = _btnInvite.mouseChildren = _btnHome.mouseChildren = false;
			_btnSend.buttonMode = _btnGift.buttonMode = _btnVisit.buttonMode = _btnInvite.buttonMode = _btnHome.buttonMode = true;
		}

		public function startup(config:Object = null):void
		{
			_params = config;
			
			_tools = _body.getChildByName('tools') as Sprite;
			
			var masking:Sprite = _tools.getChildByName('masking') as Sprite;
			var sizePhoto:int = Math.max(masking.width, masking.height);
			
		/*	if (_params && _params.photo) {
				var photo:FriendCardPhoto = new FriendCardPhoto();
				
				if (_params.photo.indexOf('deactivated_c') > -1 || 
					_params.photo.indexOf('camera_c') > -1) {
					masking.parent.removeChild(masking);
				} else {	
					photo.init(_params.photo, sizePhoto, sizePhoto, masking);
					photo.x = masking.x; 
					photo.y = masking.y;
				}
				
				//Подравниваем
				if (masking.width < sizePhoto)  photo.x -= (sizePhoto - masking.width)/2;
				if (masking.height < sizePhoto) photo.y -= (sizePhoto - masking.height)/2;
					
				(_tools.getChildByName('phPhoto') as Sprite).addChild(photo);
			} else {
				masking.parent.removeChild(masking);
			}*/

			if (_irlPhoto != null) {
				var photo:FriendCardPhoto = new FriendCardPhoto();
				
			/*	if (_irlPhoto.indexOf('deactivated_c') > -1 || 
					_irlPhoto.indexOf('camera_c') > -1) {
					masking.parent.removeChild(masking);
				} else {*/	
					photo.init(_irlPhoto, sizePhoto, sizePhoto, masking);
					photo.x = masking.x; 
					photo.y = masking.y;
				//}
				
				//Подравниваем
				if (masking.width < sizePhoto)  photo.x -= (sizePhoto - masking.width)/2;
				if (masking.height < sizePhoto) photo.y -= (sizePhoto - masking.height)/2;
				
				(_tools.getChildByName('phPhoto') as Sprite).addChild(photo);
			} else {
				masking.parent.removeChild(masking);
			}
			
			_setParams();
		}
		
		private function _setParams():void {
			
			if (_iconOnLine == null) 	_iconOnLine	 	= _tools.getChildByName('iconOnLine') as Sprite;
			if (_iconOffLine == null) 	_iconOffLine 	= _tools.getChildByName('iconOffLine') as Sprite;
			if (_borderOffLine == null) _borderOffLine 	= _tools.getChildByName('borderOffLine') as Sprite;
			if (_iconScore == null) 	_iconScore 		= _tools.getChildByName('iconScore') as Sprite;
			if (_userNameText == null)  _userNameText 	= _tools.getChildByName('txtName') as TextField;
			if (_scoreText == null)		_scoreText 		= _tools.getChildByName('txtScore') as TextField;
			
			exp = _params.exp;
			userNameText = _params.first_name;
			
			_btnInvite.visible = !_params.inGame;	
			
			if (_params.inGame) {
				_iconOnLine.visible = _params.online;
				_iconOffLine.visible = _borderOffLine.visible = !_params.online;
				
				if (!_params.online) {
					var newFilters:Array = _iconScore.filters.splice(0);
					newFilters.push(_filter);
					_iconScore.filters = newFilters;
					
					newFilters = _scoreText.filters.splice(0);
					newFilters.push(_filter);
					_scoreText.filters = newFilters;
				}
			} else  {
				_iconOnLine.visible = _iconOffLine.visible = _borderOffLine.visible = _iconScore.visible = _scoreText.visible = false;
			}
			
			if (!_params.inGame) {
				this.mouseChildren = false;
				this.buttonMode = true;
			} else {
				_tools.mouseChildren = false;
				_tools.mouseEnabled  = false;
			}
		}
		
		public function open():void {
			if (!_params.inGame)  return;
			
			_body.play();
			
			//Постоянно меняем индекс потому, что на кнопку накатывает фиолетовый декор в fb
			this.parent.setChildIndex(this, this.parent.numChildren-2);
			
			if (!_body.hasEventListener(Event.ENTER_FRAME))
				_body.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			
			if (!_body.hasEventListener(MouseEvent.CLICK))
				_body.addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		public function close():void {
			_body.gotoAndStop(1);
			_body.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
			_btnSend.visible = _btnGift.visible = _btnVisit.visible = _btnHome.visible = false;
			
		}

		private function _onEnterFrame(e:Event):void {
			if (_body.totalFrames == _body.currentFrame) {
				_body.stop();
				_body.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				_btnHome.visible = itsMe;
				_btnSend.visible = _btnGift.visible = _btnVisit.visible = !itsMe;
			}
		}
		
		private function _onClick(e:MouseEvent):void {
			if (e.target == _btnInvite)  SocialClient.adapter.dialogInvite();
			if (e.target == _btnSend)  trace(1);
			if (e.target == _btnVisit) trace(2);
			if (e.target == _btnGift)  trace(3);
			if (e.target == _btnHome)  trace(4);
		}

		public function get sprite():Sprite
		{
			return _sprite;
		}
		
		public function get exp():int {
			if (_scoreText == null) return 0;
			
			return int(_scoreText.text); 
		}
		
		public function set exp(v:int):void 
		{
			if (_scoreText == null) return;
			
			_scoreText.text = v.toString();
		}
		
		public function set userNameText(userName:String):void {

			if (_userNameText == null) return;
			
			_userNameText.text = userName.length < 10 ? userName : userName.slice(0,9) + '...';
		}
		
		private function get itsMe():Boolean {
			return _params.uid.toString() == Main.viewer_id.toString();
		}
		
		private function get _irlPhoto():String {
			if (Config.NETWORK == SocialClient.NETWORK_VK) {
				if (_params != null && _params.photo != null ) {
					if (_params.photo.indexOf('deactivated_c') > -1 || _params.photo.indexOf('camera_c') > -1) {
						return Friends.PHOTO_DEFAULT;
					} else {
						if (_params.photo_medium != null) {
							return _params.photo_medium;
						}
						return _params.photo;
					}
				}
			} 
			
		/*	if (Config.NETWORK == SocialClient.NETWORK_MM) {
				if (_params != null && _params.photo != null ) {
					trace(_params.photo);
					if (_params.photo.indexOf('_avatar') > -1 || _params.photo.indexOf('camera_c') > -1) {
						return Friends.PHOTO_DEFAULT;
					}
					return _params.photo;

				}
			}*/
			
			if (_params != null && _params.photo != null ) {
				return _params.photo;
			}
			return null;
		}
		
		public function get params():Object {
			return _params;
		}
	}
}