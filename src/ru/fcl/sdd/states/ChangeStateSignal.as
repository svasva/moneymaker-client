/**
 * User: Jessie
 * Date: 07.12.12
 * Time: 17:48
 */
package ru.fcl.sdd.states
{
import org.osflash.signals.Signal;

public class ChangeStateSignal extends Signal
{
    public function ChangeStateSignal()
    {
        super(GameStates);
    }
}
}
