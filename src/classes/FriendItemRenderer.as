package classes
{
	import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;
	import fl.transitions.Tween;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.DataEvent;
	import fl.transitions.easing.Regular;
	import social.vo.UserVO;
	import social.vo.PhotoVO;
	import social.vo.common.Picture;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;

	public class FriendItemRenderer extends CellRenderer
	{
	
		public var completeEffectFunction:Function;
		private var loader:Loader;
		public var currentUser:UserVO;
		private var ItemGraphics:MovieClip = new MovieClip();

		public function FriendItemRenderer()
		{
			if(FriendsPanel.SOC_TYPE == FriendsPanel.TYPE_FB)
			{
				ItemGraphics = new friend_item_symbol_fb()
			}
			if(FriendsPanel.SOC_TYPE == FriendsPanel.TYPE_VK)
			{
				ItemGraphics = new friend_item_symbol_vk()
			}
			if(FriendsPanel.SOC_TYPE == FriendsPanel.TYPE_OK || FriendsPanel.SOC_TYPE == FriendsPanel.TYPE_MAIL)
			{
			    ItemGraphics = new friend_item_symbol_mailGroup()
			}		
			this.addChild(ItemGraphics);
			var originalStyles:Object = CellRenderer.getStyleDefinition();
			this.buttonMode = true;
			this.mouseChildren = true;
			ItemGraphics.flowAvatarPanel.online_panel.visible = false;
			ItemGraphics.flowAvatarPanel.offlline_panel.visible = false;
			ItemGraphics.flowAvatarPanel.invite_button.visible = false;
			ItemGraphics.flowAvatarPanel.avatar.avatar_offline.visible = false;
			ItemGraphics.flowAvatarPanel.avatar.avatar_online.visible = false;
			ItemGraphics.postMsgToWall_bt.visible = false;
			ItemGraphics.home_bt.visible = false;
			ItemGraphics.postMsgToWall_bt.addEventListener(MouseEvent.CLICK,lettereClick);
			ItemGraphics.home_bt.addEventListener(MouseEvent.CLICK,homeClick);
			ItemGraphics.lettere.visible = false;
			ItemGraphics.present.visible = false;
			ItemGraphics.visit.visible = false;			
			ItemGraphics.flowAvatarPanel.invite_button.addEventListener(MouseEvent.CLICK,showInvite);
			ItemGraphics.visit.addEventListener(MouseEvent.CLICK,visitClick);
			ItemGraphics.present.addEventListener(MouseEvent.CLICK,presentClick);
			ItemGraphics.lettere.addEventListener(MouseEvent.CLICK,lettereClick);
			setStyle("upSkin",ItemGraphics.background_area);
			setStyle("downSkin",ItemGraphics.background_area);
			setStyle("overSkin",ItemGraphics.background_area);
			setStyle("selectedUpSkin",ItemGraphics.background_area);
			setStyle("selectedDownSkin",ItemGraphics.background_area);
			setStyle("selectedOverSkin",ItemGraphics.background_area);
			
		}
		
		private function isMe(e:Boolean):void
		{
			if(e)
			{
				ItemGraphics.postMsgToWall_bt.visible = true;
				ItemGraphics.home_bt.visible = true;
				ItemGraphics.lettere.visible = false;
				ItemGraphics.present.visible = false;
				ItemGraphics.visit.visible = false;				
			}
			else
			{
				ItemGraphics.home_bt.visible = false;
				ItemGraphics.postMsgToWall_bt.visible = false;
				ItemGraphics.lettere.visible = true;
				ItemGraphics.present.visible = true;
				ItemGraphics.visit.visible = true;			
			}
		}
		
		private function lettereClick (e:MouseEvent):void
		{
			FriendsPanel.getInstance().connector.postToWall(currentUser.id,"Hello word",function(e:Object = null):void{return;},function (e:Object = null):void{return});
		}
		private function homeClick (e:MouseEvent):void
		{
			//Действие по нажатию на кнопку "Домой"
		}
		private function presentClick (e:MouseEvent):void
		{
			//Действие по нажатию на кнопку "Подарок"
		}
		private function visitClick (e:MouseEvent):void
		{
			//Действие по нажатию на кнопку "В гости"
		}
		
		private function showInvite(e:MouseEvent)
		{
			FriendsPanel.getInstance().connector.showInvite(function (e:Object = null):void{return},function (e:Object = null):void{return},currentUser.id);
		}
		
		public function itemMoveUp():void
		{
			if (item_tween != null && item_tween.isPlaying)
			{
				item_tween.stop();
			}
			item_tween = new Tween(ItemGraphics.flowAvatarPanel,"y",Regular.easeOut,ItemGraphics.flowAvatarPanel.y,FriendsPanel.FRIEND_RENDERE_UP_Y,FriendsPanel.SCROLL_TIME,true);
			item_tween.start();
		}
		public function itemMoveDown():void
		{
			if (item_tween != null && item_tween.isPlaying)
			{
				item_tween.stop();
			}
			item_tween = new Tween(ItemGraphics.flowAvatarPanel,"y",Regular.easeOut,ItemGraphics.flowAvatarPanel.y,FriendsPanel.FRIEND_RENDERE_DOWN_Y,FriendsPanel.SCROLL_TIME,true);
			item_tween.start();
		}
		private function setUsers(data:UserVO):void
		{
			var userName:String = data.firstName;
			if(userName.length>9)
			{
				var name:String = "";
				for (var i:int = 0;i<7;i++)
				{
					name = name+userName.charAt(i);
				}
				name = name+"...";
				userName = name;
			}
			if(data.id == FriendsPanel.getInstance().USER.id)
			{
				isMe(true);
			}
			else
			{
				isMe(false);
			}

			ItemGraphics.flowAvatarPanel.friend_name.text = userName;
			ItemGraphics.flowAvatarPanel.online_panel.level.text = data.level;
			ItemGraphics.flowAvatarPanel.offlline_panel.level.text = data.level;
			(ItemGraphics.flowAvatarPanel.online_panel.reputation as MovieClip).gotoAndStop(data.reputation);
			
			if(data.isInstalled)
			{
				if(data.isOnline)
				{
					ItemGraphics.flowAvatarPanel.online_panel.visible = true;
					ItemGraphics.flowAvatarPanel.avatar.avatar_online.visible = true;
					ItemGraphics.flowAvatarPanel.offlline_panel.visible = false;
					ItemGraphics.flowAvatarPanel.avatar.avatar_offline.visible = false;
					ItemGraphics.flowAvatarPanel.invite_button.visible = false;
				}
				else
				{
					ItemGraphics.flowAvatarPanel.offlline_panel.visible = true;
					ItemGraphics.flowAvatarPanel.avatar.avatar_offline.visible = true;
					ItemGraphics.flowAvatarPanel.online_panel.visible = false;
					ItemGraphics.flowAvatarPanel.avatar.avatar_online.visible = false;
					ItemGraphics.flowAvatarPanel.invite_button.visible = false;
				}
			}
			else
			{
				ItemGraphics.flowAvatarPanel.online_panel.visible = false;
				ItemGraphics.flowAvatarPanel.avatar.avatar_online.visible = true;
				ItemGraphics.flowAvatarPanel.offlline_panel.visible = false;
				ItemGraphics.flowAvatarPanel.avatar.avatar_offline.visible = false;
				ItemGraphics.flowAvatarPanel.invite_button.visible = true;
			}
			if(data.picture.normal != null)
			{
				loadAvatar(data.picture.normal);
			}			
		}
		private function loadAvatar(url:String):void
		{
			Security.allowDomain('*');
			
			var ldr : LoaderContext = new LoaderContext();
			if (Security.sandboxType!='localTrusted')
			{
				ldr.securityDomain = SecurityDomain.currentDomain;
			}
			ldr.checkPolicyFile = true;
			
			loader = new Loader(); 
			loader.contentLoaderInfo.addEventListener(Event.INIT, loadBitmapComplete);
			loader.load(new URLRequest(url),ldr); 
		}
		private function loadBitmapComplete(e:Event):void
		{
				if(loader.content != null)
				{
					var myBitmap = Bitmap(loader.content).bitmapData;     
					loader.unload();     
					var _bitmap:Bitmap = new Bitmap(myBitmap);     
					_bitmap.smoothing = true; 
					_bitmap.width = 50;
					_bitmap.height = 50;
					ItemGraphics.flowAvatarPanel.avatar.avatar_area.addChild(_bitmap);
				}
		}
		public override function set data(e:Object):void
		{
			setUsers(e.user as UserVO);
			currentUser = (e.user as UserVO);
			super.data = e;
		}
	}
}