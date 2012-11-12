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

import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.system.Security;
import flash.system.System;

import org.osflash.signals.ISignal;

import ru.fcl.sdd.log.ILogger;

public class ServerProxy implements IServerProxy
{
    [Inject(name="main_server_connected")]
    public var connectedSignal:ISignal;

    private var _connected:Boolean;
    private var _webSocket:WebSocket;
    private var _socketProtocol:String;
    private var _logger:ILogger;

    [PostConstruct]
    public function init():void
    {
    }


    public function connect(url:String, protocol:String, logger:ILogger, timeout:int = 5000, origin:String = "*"):void
    {

        Security.allowDomain("*");
//        Security.allowInsecureDomain("*");
////        Security.loadPolicyFile("http://app.so14.org:9999/crossdomain.xml");
//        Security.loadPolicyFile("xmlsocket://10.0.0.102:3000");
        this._logger = logger;
        _webSocket = new WebSocket(url, origin, protocol, timeout);
        _webSocket.addEventListener(WebSocketEvent.CLOSED, handleWebSocketClosed);
        _webSocket.addEventListener(WebSocketEvent.OPEN, handleWebSocketOpen);
        _webSocket.addEventListener(WebSocketEvent.MESSAGE, handleWebSocketMessage);
        _webSocket.addEventListener(IOErrorEvent.IO_ERROR, handleIOError);
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
        }
        else if (event.message.type ===
                WebSocketMessage.TYPE_BINARY)
        {
            WebSocket.logger("Binary message received.  Length: " +
                    event.message.binaryData.length);
        }
    }


    private function handleIOError(event:IOErrorEvent):void
    {
        _logger.error(this, event.text);
    }

    private function handleSecurityError(event:SecurityErrorEvent):void
    {
        _logger.error(this, event.text);
    }

    private function handleConnectionFail(event:WebSocketErrorEvent):void
    {
        _logger.log(this, "Connection Failure: " +
                event.text);
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
        //TODO:send data
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
