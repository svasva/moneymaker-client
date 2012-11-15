/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 14:02
 */
package ru.fcl.sdd.error
{
import flash.events.ErrorEvent;

import mx.core.UIComponent;

public interface IErrorHandler
{
    /**
     * must be use if need pop-up message error on screen.
     * @param targetView parent display object for pop-up message.
     */
    function init(targetView:UIComponent):void

    function handleError(error:ErrorEvent):void

    function set silentMode(value:Boolean):void
}
}
