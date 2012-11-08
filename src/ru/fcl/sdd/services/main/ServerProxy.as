/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 15:16
 */
package ru.fcl.sdd.services.main
{

import com.adobe.serialization.json.JSON;
import com.worlize.websocket.WebSocket;
import com.worlize.websocket.WebSocketErrorEvent;
import com.worlize.websocket.WebSocketEvent;
import com.worlize.websocket.WebSocketMessage;

import flash.utils.ByteArray;

public class ServerProxy  implements IServerProxy
{
    private var _webSocket:WebSocket;
    private var _connected:Boolean;

    [PostConstruct]
    public function init():void
    {

    }

    public function connect(url:String, protocol:String):void
    {
        _webSocket = new WebSocket(url, "*",protocol);
//        websocket.enableDeflateStream = true;
        _webSocket.addEventListener(WebSocketEvent.CLOSED, handleWebSocketClosed);
        _webSocket.addEventListener(WebSocketEvent.OPEN, handleWebSocketOpen);
        _webSocket.addEventListener(WebSocketEvent.MESSAGE, handleWebSocketMessage);
        _webSocket.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL, handleConnectionFail);
        _webSocket.connect();
    }


    private function handleWebSocketOpen(event:WebSocketEvent):void
    {
        connected = true;
        _webSocket.sendUTF("Hello World!\n");
        var binaryData:ByteArray = new ByteArray();
        binaryData.writeUTF("Hello as Binary Message!");
        _webSocket.sendBytes(binaryData);
    }

    private function handleWebSocketClosed(event:WebSocketEvent):void
    {
        connected = false;
    }

    private function handleConnectionFail(event:WebSocketErrorEvent):void
    {
        trace("Connection Failure: " +
                event.text);
    }

    private function handleWebSocketMessage(event:WebSocketEvent):void
    {
        if (event.message.type ===
                WebSocketMessage.TYPE_UTF8)
        {
            trace("Got message: " +
                    event.message.utf8Data);
        }
        else if (event.message.type ===
                WebSocketMessage.TYPE_BINARY)
        {
            trace("Got binary message of length " +
                    event.message.binaryData.length);
        }
    }

    public function get connected():Boolean
    {
        return _connected;
    }

    public function set connected(value:Boolean):void
    {
        _connected = value;
    }

    public function sendData(data:JSON):void
    {
        //TODO:send data
    }
}
}
