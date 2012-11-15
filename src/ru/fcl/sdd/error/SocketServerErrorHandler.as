/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 13:00
 */
package ru.fcl.sdd.error
{
import flash.events.ErrorEvent;
import mx.core.UIComponent;

public class SocketServerErrorHandler implements IErrorHandler
{
    private var viewTarget:UIComponent;
    private var _silentMode:Boolean = false;

    public function init(viewTarget:UIComponent):void
    {
        this.viewTarget = viewTarget;
    }

    public function handleError(e:ErrorEvent):void
    {
        trace("cool");
    }

    public function get silentMode():Boolean
    {
        return _silentMode;
    }

    public function set silentMode(value:Boolean):void
    {
        _silentMode = value;
    }
}
}
