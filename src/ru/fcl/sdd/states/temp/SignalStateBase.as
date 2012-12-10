/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 13:27
 */
package ru.fcl.sdd.states.temp
{
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import ru.fcl.sdd.states.temp.IStateNews;
import ru.fcl.sdd.states.temp.IStatus;

public class SignalStateBase implements IStatus, IStateNews
{
    public function SignalStateBase()
    {
        _entered = new Signal();
        _exited = new Signal();
    }

    public function enter():void
    {
        _inState = true;
        _entered.dispatch();
    }

    public function exit():void
    {
        _inState = false;
        _exited.dispatch();
    }

    public function get entered():ISignal
    {
        return _entered;
    }

    private var _entered:Signal;

    public function get exited():ISignal
    {
        return _exited;
    }

    private var _exited:Signal;

    public function get yes():Boolean
    {
        return _inState;
    }

    private var _inState:Boolean;
}
}
