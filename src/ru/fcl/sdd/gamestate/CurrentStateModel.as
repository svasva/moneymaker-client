/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:31
 */
package ru.fcl.sdd.gamestate
{
public class CurrentStateModel implements IStateSwitcher
{
    private var _state:GameStates;

    [PostConstruct]
    public function init():void
    {

    }

    public function get state():GameStates
    {
        return _state;
    }

    public function set state(value:GameStates):void
    {
        _state = value;
    }
}
}
