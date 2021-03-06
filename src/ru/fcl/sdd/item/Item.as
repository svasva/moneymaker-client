/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.item
{
public class Item extends ItemShopView
{
    private var _key:String;
    private var _item_name:String;
    private var _item_type:String;
    private var _money_cost:String;
    private var _gameMoneyPrice:int;
    private var _sell_cost:String;
    private var _reputation_bonus:String;
    private var _room_id:String;
    private var _catalog_id:String;
    private var _skinUrl:String;
    private var _shopView:ItemShopView;
    private var _isoWidth:int;
    private var _isoLength:int;
    private var _isoHeight:int;
    private var _operations:Array;
    private var _serviceSpeed:int;
    private var _requirementLevel:int;
    private var _description:String;
    private var _currentUserLevel:int;
	private var _reqExp:int=NaN;
	private var _reqRoom:String;
	private var _reqRoomName:String;
	private var _isLock:Boolean = false;
	private var _sucssiseRep:Boolean = true;
	private var _sucssiseLvl:Boolean = true;
	private var _sucssiseRoom:Boolean = true;
	private var _order:int;
	private var _is_advert:Boolean;
	private var _nonIsoItems:Boolean = false;

    public function get key():String
    {
        return _key;
    }

    public function set key(value:String):void
    {
        _key = value;
    }

    public function get item_name():String
    {
        return _item_name;
    }

    public function set item_name(value:String):void
    {
        _item_name = value;
        itemNameTf.text = _item_name;
    }

    public function get item_type():String
    {
        return _item_type;
    }

    public function set item_type(value:String):void
    {
        _item_type = value;
    }

    public function get money_cost():String
    {
        return _money_cost;
    }

    public function set money_cost(value:String):void
    {
        _money_cost = value;
        trace("_money_cost " + _money_cost); 
        if (_money_cost == null)
        {
            _money_cost = "";
            this.realMoneySp.visible = false;
			realMoneyPriceTextField.visible = false;
        }
        else             
            realMoneyPriceTextField.text = _money_cost;
    }

    public function get gameMoneyPrice():int
    {
        return _gameMoneyPrice;
    }

    public function set gameMoneyPrice(value:int):void
    {
        gameMoneyPriceTextField.text = value.toString();
        _gameMoneyPrice = value;
    }

    public function get sell_cost():String
    {
        return _sell_cost;
    }

    public function set sell_cost(value:String):void
    {
        _sell_cost = value;
    }

    public function get reputation_bonus():String
    {
        return _reputation_bonus;
    }

    public function set reputation_bonus(value:String):void
    {
        _reputation_bonus = value;
    }


    public function get room_id():String
    {
        return _room_id;
    }

    public function set room_id(value:String):void
    {
        _room_id = value;
       
    }

    public function get catalog_id():String
    {
        return _catalog_id;
    }

    public function set catalog_id(value:String):void
    {
        _catalog_id = value;
    }

    public function get skinUrl():String
    {
        return _skinUrl;
    }

    public function set skinUrl(value:String):void
    {
        _skinUrl = value;
    }

    public function get shopView():ItemShopView
    {
        return _shopView;
    }

    public function set shopView(value:ItemShopView):void
    {
        _shopView = value;
    }

    public function get isoWidth():int
    {
        return _isoWidth;
    }

    public function set isoWidth(value:int):void
    {
        _isoWidth = value;
    }

    public function get isoLength():int
    {
        return _isoLength;
    }

    public function set isoLength(value:int):void
    {
        _isoLength = value;
    }

    public function get isoHeight():int
    {
        return _isoHeight;
    }

    public function set isoHeight(value:int):void
    {
        _isoHeight = value;
    }

    public function get operations():Array
    {
        if(!_operations)
        {
            _operations = [];
        }
        return _operations;
    }

    public function set operations(value:Array):void
    {
        _operations = value;
    }

    public function get serviceSpeed():int
    {
        return _serviceSpeed;
    }

    public function set serviceSpeed(value:int):void
    {
        _serviceSpeed = value;
       
    }
    
    public function get requirementLevel():int 
    {
        return _requirementLevel;
    }
    
    public function set requirementLevel(value:int):void 
    {
        _requirementLevel = value;
        if (_requirementLevel == 0)
		{
          //  blockedSp.visible = false;
		}
        else
        {
             this.levelNeeded.text = "Уровень " + _requirementLevel.toString();
          //  realMoneySp.visible = false;
          //  gameMoneyContainer.visible = false; 
        }
        
      
    }
    
    public function get description():String 
    {
        return _description;
    }
    
    public function set description(value:String):void 
    {
        _description = value;
    }
    
    public function get currentUserLevel():int 
    {
        return _currentUserLevel;
    }
    
    public function set currentUserLevel(value:int):void 
    {
        _currentUserLevel = value;
        if (_currentUserLevel >= _requirementLevel)
		{
			 // blockedSp.visible = false;
		}          
        else{
             this.levelNeeded.text = "Уровень " + _requirementLevel.toString();
           // realMoneySp.visible = false;
           // gameMoneyContainer.visible = false; 
        }
    }
	
	public function get isLock():Boolean 
	{
		return _isLock;
	}
	
	public function set isLock(value:Boolean):void 
	{
		_isLock = value;
		if (_isLock)
		{
			  blockedSp.visible = true;
			  gameMoneyContainer.visible = false; 
			_realMoneySp.visible = false;
			 
		}
		else
		{
			  blockedSp.visible = false;
			   gameMoneyContainer.visible = true; 
			if(money_cost)
			_realMoneySp.visible = true;
			
		}
			
	}
	
	public function get reqExp():int 
	{
		return _reqExp;
	}
	
	public function set reqExp(value:int):void 
	{
		_reqExp = value;
	}
	
	public function get reqRoom():String 
	{
		return _reqRoom;
	}
	
	public function set reqRoom(value:String):void 
	{
		_reqRoom = value;
	
	}
	
	public function get reqRoomName():String 
	{
		return _reqRoomName;
	}
	
	public function set reqRoomName(value:String):void 
	{
		_reqRoomName = value;
	}
	
	public function get sucssiseRep():Boolean 
	{
		return _sucssiseRep;
	}
	
	public function set sucssiseRep(value:Boolean):void 
	{
		_sucssiseRep = value;
	}
	
	public function get sucssiseLvl():Boolean 
	{
		return _sucssiseLvl;
	}
	
	public function set sucssiseLvl(value:Boolean):void 
	{
		_sucssiseLvl = value;
	}
	
	public function get sucssiseRoom():Boolean 
	{
		return _sucssiseRoom;
	}
	
	public function set sucssiseRoom(value:Boolean):void 
	{
		_sucssiseRoom = value;
	}
	
	public function get order():int 
	{
		return _order;
	}
	
	public function set order(value:int):void 
	{
		_order = value;
	}
	
	public function get is_advert():Boolean 
	{
		return _is_advert;
	}
	
	public function set is_advert(value:Boolean):void 
	{
		_is_advert = value;
		blockedSp.visible = false;
		
	}
	
	public function get nonIsoItems():Boolean 
	{
		return _nonIsoItems;
	}
	
	public function set nonIsoItems(value:Boolean):void 
	{
		_nonIsoItems = value;
	}
}
}
