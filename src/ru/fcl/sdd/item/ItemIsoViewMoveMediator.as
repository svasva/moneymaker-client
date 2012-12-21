/**
 * User: Jessie
 * Date: 11.12.12
 * Time: 11:23
 */
package ru.fcl.sdd.item
{
import as3isolib.core.ClassFactory;
import as3isolib.display.renderers.DefaultShadowRenderer;
import as3isolib.geom.Pt;

import com.flashdynamix.motion.Tweensy;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.setTimeout;

import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.scenes.FloorScene;
import ru.fcl.sdd.scenes.MainIsoView;

public class ItemIsoViewMoveMediator extends Mediator
{
    [Inject]
    public var floor:FloorScene;
    [Inject(name="item_for_move")]
    public var cursor:ItemIsoView;
    [Inject]
    public var _view:MainIsoView;
    [Inject(name="place_moved_item")]
    public var placeMovedItem:ISignal;
    [Inject]
    public var mainIsoView:MainIsoView;
    private var inFrame:Boolean;

    private var shadowFactory:ClassFactory;
    private var _dragPt:Pt;

    override public function onRegister():void
    {
        contextView.stage.addEventListener(MouseEvent.CLICK, onDrop);
        contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false, 0, true);
        contextView.stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheelMouse, false, 0, true);
//        _dragPt = new Pt();//
        _dragPt = _view.localToIso(new Point(contextView.stage.mouseX, contextView.stage.mouseY));
        _dragPt.x = contextView.stage.mouseX;
        _dragPt.y = contextView.stage.mouseY;
        cursor.moveBy(0, 0, 25);
        floor.stylingEnabled = true;
        shadowFactory = new ClassFactory(DefaultShadowRenderer);
        shadowFactory.properties = {shadowColor: 0x049C02, shadowAlpha: 0.5, drawAll: false};
        floor.styleRenderers = [shadowFactory];
        cursor.render();
        floor.render();
    }

    private function onDrop(e:Event):void
    {
        placeMovedItem.dispatch(cursor);
        cursor.z = 0;
        Tweensy.to(cursor, { z: 0}, 0.05, null, 0, null, onDropComplete);
//        setTimeout(function():void{mainIsoView.panBy(0,-3)},100);
//        setTimeout(function():void{mainIsoView.panBy(0,3)},150);
    }

    private function onDropComplete():void
    {
        contextView.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler_OnDropComplete);
        inFrame=true;
        mainIsoView.panBy(0, -3);
    }

    private function enterFrameHandler_OnDropComplete(event:Event):void
    {
        if(!inFrame)
        {
            contextView.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler_OnDropComplete);
            mainIsoView.panBy(0, 3);
        }
        inFrame=false;
    }


    override public function onRemove():void
    {
        contextView.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheelMouse, false);
        contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false);
        contextView.stage.removeEventListener(MouseEvent.CLICK, onDrop);
    }

    private function updateMouse(e:MouseEvent):void
    {
        var pt:Pt = _view.localToIso(new Point(contextView.stage.mouseX, contextView.stage.mouseY));
        cursor.moveTo(Math.floor(pt.x / IsoConfig.CELL_SIZE) * IsoConfig.CELL_SIZE /*- _dragPt.x*/, Math.floor(pt.y / IsoConfig.CELL_SIZE) * IsoConfig.CELL_SIZE /*- _dragPt.y*/, cursor.z);
        cursor.render();
        floor.render();
        e.updateAfterEvent();
    }

    private function wheelMouse(e:MouseEvent):void
    {
        if (e.delta > 0)
        {
            if (cursor.direction > 2)
            {
                cursor.direction = 0;
            }
            else
            {
                cursor.direction++;
            }
        }
        else
        {
            if (cursor.direction < 1)
            {
                cursor.direction = 3
            }
            else
            {
                cursor.direction--;
            }
        }
    }

}
}
