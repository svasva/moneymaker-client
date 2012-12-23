/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:12
 */
package ru.fcl.sdd.scenes
{
import as3isolib.display.IsoView;
import as3isolib.display.scene.IIsoScene;

import flash.events.Event;

public class MainIsoView extends IsoView
{
    private var _currentFloor:IIsoScene;
    private var _currentFloorNumber:int;
    public function get currentFloor():IIsoScene
    {
        return _currentFloor;
    }

    public function set currentFloor(value:IIsoScene):void
    {
        if (_currentFloor)
        {
            removeScene(_currentFloor);
            _currentFloor.render();
            _currentFloor.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }
        if (value)
        {
            value.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            addScene(value);
            value.render();
        }
        _currentFloor = value;
    }


    private function enterFrameHandler(event:Event):void
    {
        _currentFloor.render();
    }

    public function get currentFloorNumber():int
    {
        return _currentFloorNumber;
    }

    public function set currentFloorNumber(value:int):void
    {
        _currentFloorNumber = value;
    }
}
}
