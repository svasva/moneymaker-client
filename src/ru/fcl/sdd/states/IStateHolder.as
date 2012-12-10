/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:44
 */
package ru.fcl.sdd.states
{
public interface IStateHolder
{
    function set currentState(value:GameStates):void
    function get currentState():GameStates

    function set stateOutCommand(value:Class):void
    function get stateOutCommand():Class
}
}
