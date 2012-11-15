/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 13:00
 */
package ru.fcl.sdd.error
{
/**
 * Class for handle application error. First, use init(view).
 * @example this example demonstration how to use this class:
 * <listing version = "1.0">
 *     public class Main extends UIComponent
 *     {
 *         private function addedToStageHandler(e:Event):void
 *         {
 *              ErrorHandler.init(this);
 *              ErrorHandler.addErrorDispatcher(this);
 *              this.dispatch(new ErrorEvent(CustomError.INPUT_ERROR)));
 *         }
 *</listing>
 */

import flash.display.DisplayObject;
import flash.events.ErrorEvent;
import flash.events.IEventDispatcher;

public class ServerErrorDispatcher
{
    private static var viewTarget:DisplayObject;

    public static function init(viewTarget:DisplayObject):void
    {
        ServerErrorDispatcher.viewTarget = viewTarget;
    }

    public static function handleWebSocketError(e:ErrorEvent):void
    {
        trace("cool");
    }

    public static function addErrorDispatcher(dispatcher:IEventDispatcher):void
    {
        dispatcher.addEventListener(ErrorEvent.ERROR,parseErrorHandler);
    }

    public static function parseErrorHandler(e:ErrorEvent):void
    {
        trace('cool');
    }
}
}
