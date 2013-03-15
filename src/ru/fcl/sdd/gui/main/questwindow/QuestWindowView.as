package ru.fcl.sdd.gui.main.questwindow 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import ru.fcl.sdd.quest.MiniItemVO;
	import ru.fcl.sdd.quest.QuestVO;
	import ru.fcl.sdd.rsl.GuiRsl;
	
	/**
	 * ...
	 * @author 
	 */
	public class QuestWindowView extends Sprite 
	{
		private var _view:Sprite;
		
		private var _title:TextField;
		private var _descr:TextField;
		private var _goldSp:Sprite;
		private var _goldTf:TextField;
		
		private var _moneySp:Sprite;
		private var _moneyTf:TextField;
		
		private var _expSp:Sprite;
		private var _expTf:TextField;
		
		private var _repSp:Sprite;
		private var _repTf:TextField;
		
		private var _q1Sp:Sprite;
		private var _q1Tf:TextField;
		private var _q2Sp:Sprite;
		private var _q2Tf:TextField;
		private var _q3Sp:Sprite;
		private var _q3Tf:TextField;
		
		private var _titleS:String;
		private var _descrS:String;
		private var _moneyCount:String;
		private var _goldCount:String;
		private var _expCount:String;
		private var _repCount:String;
		
		private var _questAim1:String;
		private var _questAim2:String;
		private var _questAim3:String;		
		private var _data:QuestVO;
		private var _tfVec:Vector.<TextField>;
		private var iterator:int = 0;
		private var _okBtn:MovieClip;
		private var _content:MovieClip;
		private var _loader:Loader;
		
		public function QuestWindowView(rsl:GuiRsl,app_w:int,app_h:int)
		{
			
			_view = rsl.getAsset("gui.QuestWindowCom");
			addChild(_view);
			
			_title = _view.getChildByName("title") as TextField;			
			_descr =  _view.getChildByName("descr") as TextField;		
			
			_goldSp = _view.getChildByName("goldSp") as Sprite;
			_goldTf = _goldSp.getChildByName("tf") as TextField;		
			
			_moneySp = _view.getChildByName("moneySp") as Sprite;
			_moneyTf = _moneySp.getChildByName("tf") as TextField;			
			
			_expSp = _view.getChildByName("expSp") as Sprite;
			_expTf = _expSp.getChildByName("tf") as TextField;			
			
			_repSp = _view.getChildByName("repSp") as Sprite;
			_repTf = _repSp.getChildByName("tf") as TextField;		
			
			_q1Sp = _view.getChildByName("q1") as Sprite;
			_q1Tf = _q1Sp.getChildByName("tf") as TextField;		
			
			_q2Sp = _view.getChildByName("q2") as Sprite;
			_q2Tf = _q2Sp.getChildByName("tf") as TextField;			
			
			_q3Sp = _view.getChildByName("q3") as Sprite;
			_q3Tf = _q3Sp.getChildByName("tf") as TextField;
			
			_okBtn = _view.getChildByName("okBtn") as MovieClip;
			_okBtn.buttonMode = true;
			
			_content = _view.getChildByName("content") as MovieClip;
			_loader = new Loader();
		
			_content.addChild(_loader);
			
			this.visible = false;
			_tfVec = new Vector.<TextField>;
			_tfVec.push(_q1Tf);
			_tfVec.push(_q2Tf);
			_tfVec.push(_q3Tf);
			_q1Tf.text = "";
			_q2Tf.text = "";
			_q3Tf.text = "";
			
		}
		public function reset():void
		{
			_q1Tf.text = "";
			_q2Tf.text = "";
			_q3Tf.text = "";
			iterator = 0;
			
			
		}
		
		
		public function addData(data:QuestVO):void
		{			
			if (data != null)
			{	 reset();
				_data = data;
				_title.text = data.name;
				_descr.text = data.desc;
				checkTasks();
				checkRewards();
				_loader.load(new URLRequest(_data.character_swf));	
			}
				
		}
		
		private function checkRewards():void 
		{
			if (_data.rewards.money)
			{
				_moneyTf.text = _data.rewards.money;
				_moneySp.visible = true;
			}
			else
			{
				_moneySp.visible = false;
			}
			if (_data.rewards.coins)
			{
				_goldTf.text = _data.rewards.coins;
				_goldSp.visible = true;
			}
			else
			{
				_goldSp.visible = false;
			}
			if (_data.rewards.experience)
			{
				_expTf.text = _data.rewards.experience;
				_expSp.visible = true;
			}
			else
			{
				_expSp.visible = false;
			}
			if (_data.rewards.reputation)
			{
				_repTf.text = _data.rewards.reputation;
				_repSp.visible = true;
			}
			else
			{
				_repSp.visible = false;
			}
			if ( _data.isAccept)
			{
				okBtn.visible = false;
			}
			else
			{
				okBtn.visible = true;
			}
			
		}
		
		private function checkTasks():void 
		{
			if (_data.complete_requirements.level)
			{
				_tfVec[iterator].text = "Получить " + _data.complete_requirements.level + " уровень.";
				iterator++;
			}
			else if (_data.complete_requirements.money)
			{
				_tfVec[iterator].text = "Накопить " + _data.complete_requirements.money + " монет";
				iterator++;
			}
			else if (_data.complete_requirements.reputation)
			{
				_tfVec[iterator].text = "Заработать " + _data.complete_requirements.reputation + " репутации";
				iterator++;
			}
			else if (_data.itemReq)
			{
				
					for each (var item:MiniItemVO in _data.itemReq) 
					{
						if (iterator <= 2)
						{
							_tfVec[iterator].text = "Купить " + item.itemName;						
						}
						iterator++;
					}
			}
			else if (_data.roomReq)
			{
				for each (var room:MiniItemVO in _data.roomReq) 
					{
						if (iterator <= 2)
						{
							_tfVec[iterator].text = "Купить " + room.itemName;						
						}
						iterator++;
					}
			}
		}
		
		public function get titleS():String 
		{
			return _titleS;
		}
		
		public function set titleS(value:String):void 
		{
			_titleS = value;
			_title.text = _titleS;
		}
		
		public function get descrS():String 
		{
			return _descrS;
		}
		
		public function set descrS(value:String):void 
		{
			_descrS = value;
			_descr.text = _descrS;
		}
		
		public function get moneyCount():String 
		{
			return _moneyCount;
		}
		
		public function set moneyCount(value:String):void 
		{
			_moneyCount = value;
			_moneyTf.text = _moneyCount;
		}
		
		public function get goldCount():String 
		{
			return _goldCount;
		}
		
		public function set goldCount(value:String):void 
		{
			_goldCount = value;
			_goldTf.text = _goldCount;
		}
		
		public function get expCount():String 
		{
			return _expCount;
		}
		
		public function set expCount(value:String):void 
		{
			_expCount = value;
			_expTf.text = _expCount;
		}
		
		public function get repCount():String 
		{
			return _repCount;
		}
		
		public function set repCount(value:String):void 
		{
			_repCount = value;
			_repTf.text = _repCount;
		}
		
		public function get questAim1():String 
		{
			return _questAim1;
		}
		
		public function set questAim1(value:String):void 
		{
			_questAim1 = value;
			_q1Tf.text = _questAim1;
		}
		
		public function get questAim2():String 
		{
			return _questAim2;
		}
		
		public function set questAim2(value:String):void 
		{
			_questAim2 = value;
			_q2Tf.text = _questAim2;
		}
		
		public function get questAim3():String 
		{
			return _questAim3;
		}
		
		public function set questAim3(value:String):void 
		{
			_questAim3 = value;
			_q3Tf.text = _questAim3;
		}
		
		public function get okBtn():MovieClip 
		{
			return _okBtn;
		}
		
		public function set okBtn(value:MovieClip):void 
		{
			_okBtn = value;
		}
		
	}

}