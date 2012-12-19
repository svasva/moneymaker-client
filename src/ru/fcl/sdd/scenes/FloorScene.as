/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:02
 */
package ru.fcl.sdd.scenes
{
import as3isolib.display.scene.IsoScene;

import flash.events.Event;

public class FloorScene extends IsoScene
{
    [PostConstruct]
    public function init():void
    {
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

    private function enterFrameHandler(event:Event):void
    {
        render();
    }
}
}
