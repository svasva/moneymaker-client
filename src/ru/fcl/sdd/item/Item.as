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
    private var _coins_cost:String;
    private var _sell_cost:String;
    private var _reputation_bonus:String;
    private var _room_id:String;
    private var _catalog_id:String;
    private var _skinUrl:String;
    private var _shopView:ItemShopView;
    private var _isoWidth:int;
    private var _isoLength:int;
    private var _isoHeight:int;

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
    }

    public function get coins_cost():String
    {
        return _coins_cost;
    }

    public function set coins_cost(value:String):void
    {
        _coins_cost = value;
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
}
}
