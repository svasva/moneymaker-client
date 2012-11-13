/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 14:31
 */
package ru.fcl.sdd.services.main.listen
{
import org.robotlegs.mvcs.Command;
import org.robotlegs.mvcs.SignalCommand;

public class CallCommandClassMap
{
    private var _commandClass:Class;

    public function CallCommandClassMap(commandClass:Class)
    {
        if ((commandClass is Command) || (commandClass is SignalCommand))
        {
            _commandClass = commandClass;
        }else
        {
            throw new IllegalCommandMapError("bad command class for map, must be Command or SignalCommand class.",9000);
        }
    }

    public function get commandClass():Class
    {
        return _commandClass;
    }

    public function set commandClass(value:Class):void
    {
        if ((value is Command) || (value is SignalCommand))
        {
            _commandClass = value;
        }else
        {
            throw new IllegalCommandMapError("bad command class for map, must be Command or SignalCommand class.",9000);
        }
    }

}
}
