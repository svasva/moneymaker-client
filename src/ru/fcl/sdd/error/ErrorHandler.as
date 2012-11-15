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

public class ErrorHandler extends ErrorHandleBase implements IErrorHandler
{

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


}
}
