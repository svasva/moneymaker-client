/**
 * User: Jessie
 * Date: 11.12.12
 * Time: 11:23
 */
package ru.fcl.sdd.item
{
import as3isolib.geom.Pt;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

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

    private var _dragPt:Pt;

    override public function onRegister():void
    {
        contextView.stage.addEventListener(MouseEvent.CLICK, onDrop);
        contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false, 0, true);
        contextView.stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheelMouse, false, 0, true);
        _dragPt = new Pt();//_view.localToIso( new Point( contextView.stage.mouseX, contextView.stage.mouseY ) );
//        _dragPt.x -= cursor.x;
//        _dragPt.y -= cursor.y;
        _dragPt.x = contextView.stage.mouseX;
        _dragPt.y = contextView.stage.mouseY;
        cursor.z = 25;

//        Tweener.addTween( _dragObject, { z:25, time:0.5 } );
    }

    private function onDrop(e:Event):void
    {
        placeMovedItem.dispatch(cursor);
        cursor.z = 0;
//        Tweener.addTween( _dragObject, { z:0, time:0.5 } );
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
        cursor.moveTo(Math.floor(pt.x / IsoConfig.CELL_SIZE) * IsoConfig.CELL_SIZE /*- _dragPt.x*/, Math.floor(pt.y / IsoConfig.CELL_SIZE) * IsoConfig.CELL_SIZE /*- _dragPt.y*/, 0);
        cursor.render();
        floor.render();
        e.updateAfterEvent();
    }

    private function wheelMouse(e:MouseEvent):void
    {
        if (e.delta > 0)
        {
            cursor.rotationIso++;
        }else
        {
            cursor.rotationIso--;
        }
    }
}
}