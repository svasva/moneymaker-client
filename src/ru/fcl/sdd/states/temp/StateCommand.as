/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 13:21
 */
package ru.fcl.sdd.states.temp
{
import org.robotlegs.mvcs.Command;
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.states.temp.IStateNews;

public class StateCommand extends SignalCommand
{
    public function StateCommand():void
    {
        onEnterCommandClass = Command;
        onExitCommandClass = Command;
    }

    public function set stateNews(value:IStateNews):void
    {
        _stateNews = value;
    }

    public function get stateNews():IStateNews
    {
        return _stateNews;
    }

    protected var _stateNews:IStateNews;

    public function set onEnterCommandClass(value:Class):void
    {
        _onEnterCommandClass = value;
    }

    public function get onEnterCommandClass():Class
    {
        return _onEnterCommandClass;
    }

    protected var _onEnterCommandClass:Class;

    public function set onExitCommandClass(value:Class):void
    {
        _onExitCommandClass = value;
    }

    public function get onExitCommandClass():Class
    {
        return _onExitCommandClass;
    }

    protected var _onExitCommandClass:Class;
}
}
