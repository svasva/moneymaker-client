/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:44
 */
package ru.fcl.sdd.gamestate
{
public interface IStateSwitcher
{
    function set state(value:GameStates):void
    function get state():GameStates
}
}
