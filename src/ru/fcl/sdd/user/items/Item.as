/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.user.items
{

public class Item
{
    private var _id:String;
    private var _name: String;
    private var _item_type: String;
    private var _money_cost: String;
    private var _coins_cost: String;
    private var _sell_cost:String;
    private var _size_x:String;
    private var _size_y:String;
    private var _reputation_bonus:String;
    private var _reqirements:*;
    private var _rewards:*;

    public function get id():String
    {
        return _id;
    }

    public function set id(value:String):void
    {
        _id = value;
    }

    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
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

    public function get size_x():String
    {
        return _size_x;
    }

    public function set size_x(value:String):void
    {
        _size_x = value;
    }

    public function get size_y():String
    {
        return _size_y;
    }

    public function set size_y(value:String):void
    {
        _size_y = value;
    }

    public function get reputation_bonus():String
    {
        return _reputation_bonus;
    }

    public function set reputation_bonus(value:String):void
    {
        _reputation_bonus = value;
    }

    public function get reqirements():*
    {
        return _reqirements;
    }

    public function set reqirements(value:*):void
    {
        _reqirements = value;
    }

    public function get rewards():*
    {
        return _rewards;
    }

    public function set rewards(value:*):void
    {
        _rewards = value;
    }
}
}
