/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 13:22
 */
package ru.fcl.sdd.states.temp
{
import org.osflash.signals.ISignal;

public interface IStateNews
{
    function get entered():ISignal;
    function get exited():ISignal;
}
}
