/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 13:00
 */
package ru.fcl.sdd.error
{
import com.worlize.websocket.WebSocketErrorEvent;

import flash.events.ErrorEvent;

import mx.controls.Alert;
import mx.core.UIComponent;

public class ErrorHandler implements IErrorHandler
{
    private var viewTarget:UIComponent;
    private var _silentMode:Boolean = false;

    public function init(viewTarget:UIComponent):void
    {
        this.viewTarget = viewTarget;
    }

    public function handleError(e:ErrorEvent):void
    {
        switch (e.type)
        {
            case WebSocketErrorEvent.IO_ERROR:
            {
                showError(e.text,"Ошибка подключения к серверу.");
                break;
            }
            default :
            {
                showError(e.text,"Неизвестная ошибка");
            }
        }
    }

    public function get silentMode():Boolean
    {
        return _silentMode;
    }

    public function set silentMode(value:Boolean):void
    {
        _silentMode = value;
    }

    private function showError(title:String, text:String):void
    {
        if(!silentMode)
        {
            Alert.show(title, text,4,viewTarget);
        }
    }
}
}
