package ru.fcl.sdd.services.main
{
import ru.fcl.sdd.error.IErrorHandler;
import ru.fcl.sdd.log.ILogger;

public interface IServerProxy
{
    function get connected():Boolean;

    /**
     * Connect to game server api.
     * @param url - game server url.
     * @param protocol - protocol (if not need, use "").
     * @param logger - logger.
     * @param timeout - try connection timeout.
     * @param origin - origin, optional.
     */
    function connect(url:String, protocol:String, logger:ILogger, errorHandler:IErrorHandler, timeout:int = 5000, origin:String = "*"):void;

    function disconnect():void

    function sendData(data:String):void;
}
}
