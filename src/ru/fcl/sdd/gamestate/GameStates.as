/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:32
 */
package ru.fcl.sdd.gamestate
{
public class GameStates extends EnumBase
{
    public static const VIEW:GameStates = new GameStates("view");
    public static const IN_SHOP:GameStates = new GameStates("in_shop");
    public static const MOVE:GameStates = new GameStates("move");

    public function GameStates(value:String):void
    {
        super(value);
    }
}
}
