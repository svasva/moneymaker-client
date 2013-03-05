/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 14:05
 */
package ru.fcl.sdd.location.room
{
import flash.geom.Point;

public class Room
{
    private var _offset:Point;
    private var _size:Point;
    private var _id:String;
    private var _type:int;
    private var _name:String;
    private var _catalogId:String;
    private var _room_type_id:String;
    private var _decription:String;
    private var _coins_cost:int;
    private var _money_cost:int;
    private var _icon_url:String;
    private var _order:int;
	private var _floor:int;
	private var _requirementLevel:int;	
	private var _reqExp:int=NaN;
	private var _reqRoom:String;
	
	public function get order():int
    {
        return _order;
    }

    public function set order(value:int):void
    {
        _order = value;
    }

	

    public function set floor(value:int):void
    {
        _floor = value;
    }
	
    public function get floor():int
    {
        return _floor;
    }

    public function set offset(value:Point):void
    {
        _offset = value;
    }
	public function get offset():Point
    {
       return  _offset;
    }

    public function get size():Point
    {
        return _size;
    }

    public function set size(value:Point):void
    {
        _size = value;
    }

    public function get id():String
    {
        return _id;
    }

    public function set id(value:String):void
    {
        _id = value;
    }

    public function get type():int
    {
        return _type;
    }

    public function set type(value:int):void
    {
        _type = value;
    }

    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
    }

    public function get catalogId():String
    {
        return _catalogId;
    }

    public function set catalogId(value:String):void
    {
        _catalogId = value;
    }
    
    public function get room_type_id():String 
    {
        return _room_type_id;
    }
    
    public function set room_type_id(value:String):void 
    {
        _room_type_id = value;
    }
    
    public function get decription():String 
    {
        return _decription;
    }
    
    public function set decription(value:String):void 
    {
        _decription = value;
    }
    
    public function get coins_cost():int 
    {
        return _coins_cost;
    }
    
    public function set coins_cost(value:int):void 
    {
        _coins_cost = value;
    }
    
    public function get money_cost():int 
    {
        return _money_cost;
    }
    
    public function set money_cost(value:int):void 
    {
        _money_cost = value;
    }
    
    public function get icon_url():String 
    {
        return _icon_url;
    }
    
    public function set icon_url(value:String):void 
    {
        _icon_url = value;
    }
	
	public function get requirementLevel():int 
	{
		return _requirementLevel;
	}
	
	public function set requirementLevel(value:int):void 
	{
		_requirementLevel = value;
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
}
}
