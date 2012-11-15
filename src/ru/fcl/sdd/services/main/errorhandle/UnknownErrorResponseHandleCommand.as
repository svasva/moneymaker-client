/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 15:07
 */
package ru.fcl.sdd.services.main.errorhandle
{
import flash.events.ErrorEvent;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.error.IErrorHandler;

public class UnknownErrorResponseHandleCommand extends SignalCommand
{
    [Inject]
    public var response:Object;
    [Inject(name="unknown_error_handler")]
    public var errorHandler:IErrorHandler;

    override public function execute():void
    {
        var e:ErrorEvent = new ResponseErrorEvent(ResponseErrorEvent.UNCNOWN_ERROR);
        e.text= response.response.error;
        errorHandler.handleError(e);
    }
}
}
