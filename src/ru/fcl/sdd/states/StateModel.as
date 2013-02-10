/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:31
 */
package ru.fcl.sdd.states
{
public class StateModel implements IStateHolder
{
    private var _currentState:GameStates;
    private var _stateOutCommand:Class;
    private var _currenSubState:String = "shop";

    [PostConstruct]
    public function init():void
    {
    }

    public function get currentState():GameStates
    {
        return _currentState;
    }

    public function set currentState(value:GameStates):void
    {
        _currentState = value;
    }

    public function get stateOutCommand():Class
    {
        return _stateOutCommand;
    }

    public function set stateOutCommand(value:Class):void
    {
        _stateOutCommand = value;
    }
    
    public function get currenSubState():String 
    {
        return _currenSubState;
    }
    
    public function set currenSubState(value:String):void 
    {
        _currenSubState = value;
    }
}
}
