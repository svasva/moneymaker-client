package classes
{
/*************************************
Alex Solodkov, GF Belarus 2013   
**************************************/
	import de.polygonal.ds.HashMap;
	import flash.system.Security;
	import flash.system.System;
 
	import flash.display.MovieClip;
	
	import ru.fcl.gui.CollectChunker;

	import flash.events.MouseEvent;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	
	
	
	
	import flash.display.DisplayObject;
	import social.connector.IConnector;
	import social.connector.ConnectorFactory;
	import social.vo.UserVO;
	import social.connector.Connector;
	import social.vo.ErrorVO;
	

	public class FriendsPanel extends MovieClip
	{
		//private var friendsListDataProvider:DataProvider = new DataProvider();
		public static const TYPE_VK:String = "VK";
		public static const TYPE_OK:String = "OK";
		public static const TYPE_MAIL:String = "MAIL";
		public static const TYPE_FB:String = "FB";
		public static var SOC_TYPE:String = null;
		private var _positionScrollBar:int = 0; //позиция скрола,изначально 0
		private var ITEM_WIDTH:int = 99; //ширина плашки
		public static var FRIEND_RENDERE_DOWN_Y:int = 94//проложение по y в опущеном состоянии
		public static var FRIEND_RENDERE_UP_Y:int = 0;//проложение по y в поднятом состоянии
		private const ITEM_HEIGHT:int = 210; //высота плашки
		public static const SCROLL_TIME : Number = 0.6; // длительность анимации скролла в секундах
		public var USER:UserVO;
	//	private var currentPanel_fb:friends_panel_symbol_fb;
	//	private var currentPanel_vk:friendsVk;
	//	private var currentPanel_ok:friends_panel_symbol_mailGroup;
		
		private var _chunker:CollectChunker;
		private var _friendsHash:HashMap = new HashMap();
		private var panelOfFriends:FriendsPanelView = new FriendsPanelView();
		private var btnLeft:Button_leftarrow_up = new Button_leftarrow_up();
		private var btnRight:Button_rightarrow_up = new Button_rightarrow_up();
		
		
		
		
		private static var _instance : FriendsPanel;
		
		public var connector : IConnector;
		private var flashvars:Object = new Object();
		
		public function FriendsPanel(vars:Object):void
		{
			//Security.allowDomain();
			addChild(panelOfFriends);
			addChild(btnLeft);
			addChild(btnRight);
			btnRight.x = 500;
			btnLeft.x  = -25;
			btnLeft.y = 100;
			btnRight.y = 100;
			flashvars = vars;
			// Эти вещи лучше прятать
			
			btnLeft.addEventListener(MouseEvent.CLICK, btnLeft_click);
			btnRight.addEventListener(MouseEvent.CLICK, btnRight_click);
			
			flashvars["ask"] = "6B2E781D7181243891D009C8" // секретный ключ ОК
			flashvars["private_key"] = "9d798a8fde9e10d07d4d68b7b6a71b0d";//приватный ключ Mail
			if (flashvars['viewer_id'] != null)
			{
				SOC_TYPE = TYPE_VK
			}
			
			if (flashvars['vid'] != null)
			{
				SOC_TYPE = TYPE_MAIL
			}
			
			if (flashvars['logged_user_id'] != null)
			{
				SOC_TYPE = TYPE_OK
			}
			
			if (flashvars['facebook'] != null)
			{
				SOC_TYPE = TYPE_FB;
			}
			
			if(SOC_TYPE == null)
			{
				SOC_TYPE = TYPE_VK;
				trace("SOC_TYPE = TYPE_VK;");
				//для локального теста
				flashvars["api_id"] = "3436887";
				flashvars["viewer_id"] = "180820330";
				flashvars["auth_key"] = "fd088426b82e8e234b29b65b7dfcc913";
				flashvars["sid"] = "ae362e31775bf260887cf9a0e5003dc75560d502ca36a66f5ddf4ca025e22f62d4226daeebfb5ae537e72";
				flashvars["secret"] = "0444019de1"
				flashvars["api_url"] = "https://api.vk.com/api.php"
				flashvars["lc_name"] = "19cbb6b5";
			}
			
			if(SOC_TYPE == TYPE_FB)
			{
			/*	list = new TileList ();
				currentPanel_fb =  new friends_panel_symbol_fb();
				addChild(currentPanel_fb);
				ITEM_WIDTH = 88;
				FRIEND_RENDERE_DOWN_Y = 91
				FRIEND_RENDERE_UP_Y= 1;
				currentPanel_fb.addChild(list);
				list.x = 42;
				list.y = 19;
				list.width = 440;
				list.height = 210;*/
				
			}
			if(SOC_TYPE == TYPE_VK)
			{
			/*	list = new TileList ();
				currentPanel_vk = new friendsVk();
				this.addChild(currentPanel_vk);
				ITEM_WIDTH = 99;
				FRIEND_RENDERE_DOWN_Y= 75;
				FRIEND_RENDERE_UP_Y = 1;
				currentPanel_vk.addChild(list);
				list.x = 47;
				list.y = 13;
				list.width = 495;
				list.height = 218;*/
			}
			if(SOC_TYPE == TYPE_OK || SOC_TYPE == TYPE_MAIL)
			{
			/*	list = new TileList ();
				currentPanel_ok = new friends_panel_symbol_mailGroup();
				addChild(currentPanel_ok);
				ITEM_WIDTH = 112;
				FRIEND_RENDERE_DOWN_Y = 89;
				FRIEND_RENDERE_UP_Y = 0;
				currentPanel_ok.addChild(list);
				list.x = 53;
				list.y = 16;
				list.width = 448;
				list.height = 210;*/
			}		
			
			var factory:ConnectorFactory = new ConnectorFactory(flashvars);
			connector = factory.createConnector(onConnectorReady,getMyFriends);
			//getCurrentPanel().bt_rigth.visible = false;
		///	getCurrentPanel().bt_left.visible = false;
		//	getCurrentPanel().bt_left.addEventListener(MouseEvent.CLICK,scrollLeft);
		//	getCurrentPanel().bt_rigth.addEventListener(MouseEvent.CLICK,scrollRight);
			
		//	setListParameters();			
			_instance = this;	
			panelOfFriends.conector = connector;
		}
		
		private function btnRight_click(e:MouseEvent):void 
		{
			if (_chunker)
			{
				if(_chunker.hasNext())
				panelOfFriends.addData(_chunker.next());
		
			}
		}
		
		private function btnLeft_click(e:MouseEvent):void 
		{
			if (_chunker)
			{
				if (_chunker.hasPrev())
				panelOfFriends.addData(_chunker.prev());
			}
		}
		private function onConnectorReady() : void
		{
			//connector.showInvite(onInvite, onInviteError);
			connector.getCurrentUser(getUserComplete, getFriendsCompleteError);
		
			
		}
		
		private function onSettingReciveErr(e:Object):void 
		{
			trace("onSettingReciveErr");
		}
		
		private function onSettingRecive(e:Object):void 
		{
			trace("onSettingRecive", e);
			var setting:uint = uint( e);
			if (setting != 771)
			{
				connector.showSetting();
			}
			else
			{
				getMyFriends();
			}
			
		}
		
		private function onInviteError():void 
		{
			trace("onInviteError");
		}
		
		private function onInvite():void 
		{
			trace("onInvite");
		}
		private function getFriendsCompleteError(e:Object):void
		{
			trace("Ну удалось получить список друзей");
		}
		 
		/*private function getCurrentPanel():MovieClip
		{
			if(currentPanel_vk != null){
			return currentPanel_vk;}
			if(currentPanel_ok != null){
			return currentPanel_ok;}
			if(currentPanel_fb != null){
			return currentPanel_fb;}
			return null;
		}*/

		private function getUserComplete(e:Vector.<UserVO>):void
		{
			for each(var t: UserVO in e)
			{
				USER = t;
				t.isInstalled = true;
				
			}
			//getMyFriends();
			connector.getSettings(onSettingRecive,onSettingReciveErr);
		}
		private function getMyFriends(e:Object=null):void
		{
			connector.getFriends(flashvars['viewer_id'],0,1000,getFriendsComplete,getFriendsCompleteError);
		}
		private function getFriendsComplete(e:Vector.<UserVO>):void
		{
			/** тут посути должен быть запрос на игровой сервер**/
			var _object:Array = new Array();						
			e.push(USER); 
			
			
			//**эмуляция**//
			for each( var i : UserVO in e)
			{
				//забиваем хардом  каждому пользователю уровень и репутацию 
				i.level = Math.round(Math.random() * 101);
				i.reputation = (Math.round(Math.random() * 3))+1;
				_object.push(i);
			//	_friendsHash.set(i.id, i);
				//trace(i.picture.normal);
			}			
			
			//сортировки
			var notInstalledAppUsers:Array = new Array();
			var installedAppUsers:Array = new Array();
				
			for each (var u:UserVO in _object)
			{
			
				if(!u.isInstalled)
				{
					notInstalledAppUsers.push(u);
				}
				else
				{
					installedAppUsers.push(u);
				}
				
			}
			notInstalledAppUsers.sortOn(["firstName"]);
			_object = new Array();
			var count:int = installedAppUsers.length + notInstalledAppUsers.length;
			var counter:int = 0;
			for (var p:int = 0; p<count;p++)
			{
				var item:int = Math.round(Math.random() * notInstalledAppUsers.length)
				if(p == counter && installedAppUsers.length != 0 && notInstalledAppUsers.length != 0)
				{
					_object.push(notInstalledAppUsers[item]);
					notInstalledAppUsers.splice(item,1)
				//	counter = counter + list.columnCount; 
				}
				else
				{
					if (installedAppUsers.length != 0)
					{
						installedAppUsers.sortOn(["level"]);
						installedAppUsers.reverse();
						_object.push(installedAppUsers[0]);
						installedAppUsers.splice(0,1)
						 
					}
					else
					{
						if (notInstalledAppUsers.length != 0)
						{
							_object.push(notInstalledAppUsers[0]);
							notInstalledAppUsers.splice(0,1)
						}
					}
				}
				
			}
			
			for (var j:int = 0; j < _object.length; j++) 
			{
				_friendsHash.set(j, _object[j]);
			}
			
			_chunker = new CollectChunker(_friendsHash, 5);
			panelOfFriends.addData(_chunker.next());
			//setDataProvider(_object);		
			
		}
		public static function getInstance() : FriendsPanel
		{
			return _instance;
		}
		/*private function set positionScrollBar(e:Number):void
		{
			_positionScrollBar = e;-
			if (_positionScrollBar == 0)
			{
				getCurrentPanel().bt_left.visible = false;				
			}
			else
			{
				getCurrentPanel().bt_left.visible = true;
			}			
			if (friendsListDataProvider.length<list.columnCount)
			{
				getCurrentPanel().bt_rigth.visible = false;
				getCurrentPanel().bt_left.visible = false;
			}
			else
			{
				getCurrentPanel().bt_rigth.visible = true;
			}
			
		}*/
		/*private function get positionScrollBar():Number
		{
			return _positionScrollBar;
		}
		private function setDataProvider(data:Array):void
		{
			for each (var o : UserVO in data)
			{
				friendsListDataProvider.addItem({user : o});
			}
			list.dataProvider = friendsListDataProvider;
			positionScrollBar = list.horizontalScrollPosition;	
			 
			
		}*//*
		private function setListParameters():void
		{
			list.columnWidth = ITEM_WIDTH;
			list.rowHeight = ITEM_HEIGHT;
			list.scrollPolicy = "off";
			list.selectable = false;
			list.setStyle('cellRenderer',FriendItemRenderer);
			//list.setStyle('TileList',TileList_skin);
			list.drawNow();
		
			
		}*/
		/*private function itemRollOut(e:ListEvent):void
		{
			var index:Object = list.getItemAt(e.index);
			if(index == null) 
			{
				return;
			}
			var currentItem:FriendItemRenderer = e.target.itemToCellRenderer(index) as FriendItemRenderer;
			if(!currentItem.currentUser.isInstalled)
			{
				return;
			}
			currentItem.tween.stop();
			currentItem.tween = new Tween(currentItem.tween.obj, "y", Regular.easeOut, currentItem.tween.obj.y,94, SCROLL_TIME, true);
			currentItem.tween.start();
			currentItem.itemMoveDown();
			currentItem.completeEffectFunction = function (e:TweenEvent):void
			{
				FriendsPanel.getInstance().flow.removeChild(currentItem.tween.obj as MovieClip);
				currentItem.tween.removeEventListener(TweenEvent.MOTION_FINISH,currentItem.completeEffectFunction);
				currentItem.completeEffectFunction  = null;
				currentItem.tween = null;
			}
			currentItem.tween.addEventListener(TweenEvent.MOTION_FINISH,currentItem.completeEffectFunction);			 
		}
		private function itemRollOver(e:ListEvent):void
		{
			var currentItem:FriendItemRenderer = e.target.itemToCellRenderer(list.getItemAt(e.index)) as FriendItemRenderer;
			if(!currentItem.currentUser.isInstalled)
			{
				return;
			}
			currentItem.completeEffectFunction = null;
			if(currentItem.tween != null)
			{
				currentItem.tween.stop();
				currentItem.tween = new Tween(currentItem.tween.obj, "y", Regular.easeOut, currentItem.tween.obj.y,0, SCROLL_TIME, true);
				currentItem.tween.start();
				currentItem.itemMoveUp();
			}
			else
			{
				var flow_panel:MovieClip;
				if(SOC_TYPE == TYPE_FB)
				{
					flow_panel = new flowPanel_fb();
				}
				if(SOC_TYPE == TYPE_VK)
				{
					flow_panel = new flowPanel_vk();
				}
				if(SOC_TYPE == TYPE_OK || SOC_TYPE == TYPE_MAIL)
				{
					flow_panel = new flowPanel_mailGroup();
				}
				flow_panel.y = 94;
				flow_panel.x = (e.index - positionScrollBar/ITEM_WIDTH)*ITEM_WIDTH + 35;
				currentItem.tween = new Tween(flow_panel, "y", Regular.easeOut, flow_panel.y, 0, SCROLL_TIME, true);
				currentItem.tween.start();
				currentItem.itemMoveUp();
				getCurrentPanel().flowArea.addChild(flow_panel);
			}
			
			
		}*/
	 
		/*private function get flow():MovieClip
		{
			return getCurrentPanel().flowArea;
		}*/
	/*	public function scrollLeft(e:MouseEvent) : void
		{
			startDragScrollBar(-ITEM_WIDTH*list.columnCount);
		}
			
		public function scrollRight(e:MouseEvent) : void
		{
			startDragScrollBar(ITEM_WIDTH*list.columnCount);
		}
		*/
		/*private function startDragScrollBar(value:int):void
		{
			
			if((positionScrollBar + value)<=0)
			{
				positionScrollBar = 0;
			}
			else
			{
				positionScrollBar = getScrollPosition(value);				
			}
			
			if (tween != null && tween.isPlaying)
			{
				tween.stop();
			}
			tween = new Tween(list, "horizontalScrollPosition", Regular.easeOut, list.horizontalScrollPosition, positionScrollBar, SCROLL_TIME, true);
			tween.addEventListener(TweenEvent.MOTION_START,startTween);
			tween.addEventListener(TweenEvent.MOTION_STOP,stopTween);
			tween.start();
        }*/
	/*	private function startTween(e:TweenEvent):void
		{
			list.mouseEnabled = false;
			list.mouseChildren = false;
		}
		private function stopTween(e:TweenEvent):void
		{
			list.mouseEnabled = true;
			list.mouseChildren = true;
		}*/
		/*private function getScrollPosition(value:int):int
		{
			if((positionScrollBar + value)>(friendsListDataProvider.length*ITEM_WIDTH - list.columnCount*ITEM_WIDTH))
			{
				return friendsListDataProvider.length*ITEM_WIDTH - list.columnCount*ITEM_WIDTH;				
			}
			else
			{
				return positionScrollBar + value;
			}
			return positionScrollBar;			
		}		*/

	}

}