/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 15:16
 */
package ru.fcl.sdd.services.main
{
import com.worlize.websocket.WebSocket;
import com.worlize.websocket.WebSocketErrorEvent;
import com.worlize.websocket.WebSocketEvent;
import com.worlize.websocket.WebSocketMessage;

import flash.events.EventDispatcher;
import flash.events.SecurityErrorEvent;
import flash.system.Security;

import org.osflash.signals.ISignal;

import ru.fcl.sdd.error.IErrorHandler;

import ru.fcl.sdd.error.IErrorHandler;

import ru.fcl.sdd.log.ILogger;

public class ServerProxy extends EventDispatcher implements IServerProxy
{
    [Inject(name="main_server_connected")]
    public var connectedSignal:ISignal;

    [Inject(name="main_server_talk")]
    public var serverTalkSignal:ISignal;

    private var _connected:Boolean;
    private var _webSocket:WebSocket;
    private var _socketProtocol:String;
    private var _logger:ILogger;
    private var _errorHandler:IErrorHandler;

    [PostConstruct]
    public function init():void
    {
    }


    public function connect(url:String, protocol:String, logger:ILogger, errorHandler:IErrorHandler, timeout:int = 5000, origin:String = "*"):void
    {
        Security.allowDomain("*");
        this._logger = logger;
        this._errorHandler = errorHandler;
        _webSocket = new WebSocket(url, origin, protocol, timeout);
        _webSocket.addEventListener(WebSocketEvent.CLOSED, handleWebSocketClosed);
        _webSocket.addEventListener(WebSocketEvent.OPEN, handleWebSocketOpen);
        _webSocket.addEventListener(WebSocketEvent.MESSAGE, handleWebSocketMessage);
        _webSocket.addEventListener(WebSocketErrorEvent.IO_ERROR, handleIOError);
        _webSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecurityError);
        _webSocket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, handleConnectionFail);
        _webSocket.connect();
    }

    public function disconnect():void
    {
        if (_webSocket.connected)
        {
            _webSocket.close();
        }
    }

    private function handleWebSocketMessage(event:WebSocketEvent):void
    {
        if (event.message.type ===
                WebSocketMessage.TYPE_UTF8)
        {
            _logger.log(event.message.utf8Data);
            if (event.message.utf8Data.substr(0, 1) == "a")
            {
                serverTalkSignal.dispatch(Object(event.message.utf8Data.slice(1, event.message.utf8Data.length)));
            }
        }
        else if (event.message.type ===
                WebSocketMessage.TYPE_BINARY)
        {
            WebSocket.logger("Binary message received.  Length: " +
                    event.message.binaryData.length);
        }
    }


    private function handleIOError(event:WebSocketErrorEvent):void
    {
        _logger.error(this, event.text);
        _errorHandler.handleError(event);
    }

    private function handleSecurityError(event:SecurityErrorEvent):void
    {
        _logger.error(this, event.text);
        _errorHandler.handleError(event);
    }

    private function handleConnectionFail(event:WebSocketErrorEvent):void
    {
        _logger.log(this, "Connection Failure: " +
                event.text);
        _errorHandler.handleError(event);
    }

    private function handleWebSocketClosed(event:WebSocketEvent):void
    {
        _logger.log(this, "Websocket closed.");
    }

    private function handleWebSocketOpen(event:WebSocketEvent):void
    {
        _logger.log(this, "Websocket Connected");
        _connected = true;
        connectedSignal.dispatch();
    }


    public function get connected():Boolean
    {
        return _connected;
    }

    public function sendData(data:String):void
    {
        _webSocket.sendUTF(data);
    }

    public function get socketProtocol():String
    {
        return _socketProtocol;
    }

    public function set socketProtocol(value:String):void
    {
        _socketProtocol = value;
    }
}
}
