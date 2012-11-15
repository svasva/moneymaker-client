/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 14:17
 */
package ru.fcl.sdd.error
{
import mx.core.UIComponent;

import org.robotlegs.mvcs.SignalCommand;

public class BuildErrorHandlers extends SignalCommand
{
    override public function execute():void
    {
        var socketServerErrorHandler:IErrorHandler = new SocketServerErrorHandler();
        injector.mapValue(IErrorHandler,socketServerErrorHandler,"socket_server_error_handler");
        socketServerErrorHandler.init(contextView as UIComponent);
    }
}
}
