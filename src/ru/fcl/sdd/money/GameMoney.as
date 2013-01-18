/**
 * User: Jessie
 * Date: 14.12.12
 * Time: 13:18
 */
package ru.fcl.sdd.money
{
public class GameMoney implements IMoney
{
    [Inject]
    public var updated:GameMoneyUpdateSignal;
    private var _count:int;

    public function get count():int
    {
        return _count;
    }

    public function set count(value:int):void
    {
        if (count != value)
        {
           trace("GameMoney");
            _count = value;
            updated.dispatch();
        }
    }
}
}
