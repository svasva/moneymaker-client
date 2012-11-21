/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 13:34
 */
package ru.fcl.sdd.services.main
{
public interface ISender
{
    /**
     * Send object 2 server.
     * @param value - object 2 send {command:String, args:Array=null}
     * @param handlerCommandClass - Command/SignalCommand handler class 4 handle server response. Must have inject Object, parsed server response.
     * @example
     * <Listing>
     *     ...
     *     sender.send({command:"getItems"},ResponseHandleCommand);
     *     ...
     *
     *     public class ResponseHandleCommand extends Command
     *     {
     *     [Inject] public var response:Object;
     *          override public function execute():void
     *          {
     *              doSomething(response);
     *          }
     *     }
     * </Listing>
     */
    function send(value:Object, handlerCommandClass:Class, errorHandlerCommandClass:Class=null):void;
}
}
