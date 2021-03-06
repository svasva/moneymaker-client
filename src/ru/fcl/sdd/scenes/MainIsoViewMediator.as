/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 14:39
 */
package ru.fcl.sdd.scenes
{
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;
import ru.fcl.sdd.gui.main.MainInterfaceView;

import org.osflash.signals.ISignal;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.Graphic;

public class MainIsoViewMediator extends Mediator
{
    [Inject]
    public var view:MainIsoView;

    [Inject(name="zoom_in")]
    public var zoomInSignal:ISignal;
    [Inject(name="zoom_out")]
    public var zoomOutSignal:ISignal;
    
    [Inject]
    public var viewMain:MainInterfaceView;

    private var panPoint:Point;
    private var zoom:Number = 0.75;

    override public function onRegister():void
    {
        view.stage.addEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
        view.stage.addEventListener(KeyboardEvent.KEY_DOWN, viewZoom);
        zoomInSignal.add(zoomIn);
        zoomOutSignal.add(zoomOut);
        view.currentZoom = zoom;
    }

    override public function onRemove():void
    {
        view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
        view.stage.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
        view.stage.removeEventListener(MouseEvent.MOUSE_DOWN, viewMouseDown);
        view.stage.removeEventListener(KeyboardEvent.KEY_DOWN, viewZoom);
        zoomInSignal.remove(zoomIn);
        zoomOutSignal.remove(zoomOut);
    }

    private function viewMouseDown(e:MouseEvent):void
    {
       
        panPoint = new Point(view.stage.mouseX, view.stage.mouseY);
        view.stage.addEventListener(MouseEvent.MOUSE_MOVE, viewPan);
        view.stage.addEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
        
    }

    private function viewPan(event:MouseEvent):void
    {
        viewMain.itemControl.visible = false;
        view.panBy(panPoint.x - view.stage.mouseX, panPoint.y - view.stage.mouseY);
        panPoint.x = view.stage.mouseX;
        panPoint.y = view.stage.mouseY;
    }

    private function viewMouseUp(event:MouseEvent):void
    {
        view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, viewPan);
        view.stage.removeEventListener(MouseEvent.MOUSE_UP, viewMouseUp);
    }

    private function zoomIn():void
    {
        if (zoom < Graphic.MAX_ZOOM)
        {
            zoom += Graphic.ZOOM_STEP;
            view.currentZoom = zoom;
        }
    }

    private function zoomOut():void
    {
        if (zoom > Graphic.MIN_ZOOM)
        {
            zoom -= Graphic.ZOOM_STEP;
            view.currentZoom = zoom;
        }
    }

    private function viewZoom(e:KeyboardEvent):void
    {
        if (e.keyCode == Keyboard.NUMPAD_ADD)
        {
            zoomIn();
        }
        if (e.keyCode == Keyboard.NUMPAD_SUBTRACT)
        {
            zoomOut();
        }
    }
}
}
