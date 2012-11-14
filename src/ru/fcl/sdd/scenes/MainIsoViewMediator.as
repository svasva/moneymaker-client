/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 14:39
 */
package ru.fcl.sdd.scenes
{
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.robotlegs.mvcs.Mediator;

public class MainIsoViewMediator extends Mediator
{
    [Inject]
    public var view:MainIsoView;

    private var panPoint:Point;
    private var zoom:Number = 1;

    override public function onRegister():void
    {
        view.stage.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
        view.stage.addEventListener(MouseEvent.MOUSE_WHEEL, viewZoom);
    }

    private function viewMouseDown(e:MouseEvent):void
    {
        panPoint = new Point(view.stage.mouseX, view.stage.mouseY);
        view.stage.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
        view.stage.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
    }

    private function viewPan(event:MouseEvent):void
    {
        view.panBy(panPoint.x - view.stage.mouseX, panPoint.y - view.stage.mouseY);
        panPoint.x = view.stage.mouseX;
        panPoint.y = view.stage.mouseY;
    }

    private function viewMouseUp(event:MouseEvent):void
    {
        view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
        view.stage.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
    }

    private function viewZoom(e:MouseEvent)
    {
        if(e.delta > 0)
        {
            zoom +=  0.10;
        }
        if(e.delta < 0)
        {
            zoom -=  0.10;
        }
        view.currentZoom = zoom;
    }
}
}
