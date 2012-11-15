/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 14:02
 */
package ru.fcl.sdd.error
{
import mx.core.UIComponent;

public interface IErrorDispatcher
{
    /**
     * must be use if need pop-up message error on screen.
     * @param targetView parent display object for pop-up message.
     */
    function init(targetView:UIComponent):void

    function handleError(error:Error):void

    function set silentMode(value:Boolean):void
}
}
