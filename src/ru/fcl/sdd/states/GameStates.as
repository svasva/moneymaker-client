/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:32
 */
package ru.fcl.sdd.states
{
import ru.fcl.ds.EnumBase;

public class GameStates extends EnumBase
{
    public static const VIEW:GameStates = new GameStates("view");
    public static const IN_SHOP:GameStates = new GameStates("in_shop");
    public static const MOVE_ITEM:GameStates = new GameStates("move_item");
    public static const BUY_ITEM:GameStates = new GameStates("buyitem");
    public static const STATE_OUT:GameStates = new GameStates("state_out");

    public function GameStates(value:String):void
    {
        super(value);
    }
}
}
