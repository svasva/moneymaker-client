/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 11:41
 */
package ru.fcl.sdd.user
{
public class UserDataModel
{
    private var _id:String;
    private var _bank_name:String;
    private var _client_interval:int;
    private var _coins:int;
    private var _coins_max:int;
    private var _coins_spent:int;
    private var _created_at:String;
    private var _credit_percent:int;
    private var _credits:int;
    private var _crime_interval:int;
    private var _deposit_percent:int;
    private var _deposit:int;
    private var _experience:int;
    private var _level:int;
    private var _socialNet:String;

    public function get id():String
    {
        return _id;
    }

    public function set id(value:String):void
    {
        _id = value;
    }

    public function get bank_name():String
    {
        return _bank_name;
    }

    public function set bank_name(value:String):void
    {
        _bank_name = value;
    }

    public function get client_interval():int
    {
        return _client_interval;
    }

    public function set client_interval(value:int):void
    {
        _client_interval = value;
    }

    public function get coins():int
    {
        return _coins;
    }

    public function set coins(value:int):void
    {
        _coins = value;
    }

    public function get coins_max():int
    {
        return _coins_max;
    }

    public function set coins_max(value:int):void
    {
        _coins_max = value;
    }

    public function get coins_spent():int
    {
        return _coins_spent;
    }

    public function set coins_spent(value:int):void
    {
        _coins_spent = value;
    }

    public function get created_at():String
    {
        return _created_at;
    }

    public function set created_at(value:String):void
    {
        _created_at = value;
    }

    public function get credit_percent():int
    {
        return _credit_percent;
    }

    public function set credit_percent(value:int):void
    {
        _credit_percent = value;
    }

    public function get credits():int
    {
        return _credits;
    }

    public function set credits(value:int):void
    {
        _credits = value;
    }

    public function get crime_interval():int
    {
        return _crime_interval;
    }

    public function set crime_interval(value:int):void
    {
        _crime_interval = value;
    }

    public function get deposit_percent():int
    {
        return _deposit_percent;
    }

    public function set deposit_percent(value:int):void
    {
        _deposit_percent = value;
    }

    public function get deposit():int
    {
        return _deposit;
    }

    public function set deposit(value:int):void
    {
        _deposit = value;
    }

    public function get experience():int
    {
        return _experience;
    }

    public function set experience(value:int):void
    {
        _experience = value;
    }

    public function get level():int
    {
        return _level;
    }

    public function set level(value:int):void
    {
        _level = value;
    }

    public function get socialNet():String
    {
        return _socialNet;
    }

    public function set socialNet(value:String):void
    {
        _socialNet = value;
    }
}
}
