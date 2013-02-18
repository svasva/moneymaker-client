/**
 * User: Jessie
 * Date: 11.12.12
 * Time: 11:23
 */
package ru.fcl.sdd.item.iso
{
import as3isolib.display.scene.IsoScene;
import ru.fcl.sdd.item.*;
import ru.fcl.sdd.location.floors.FloorsList;

import as3isolib.core.ClassFactory;
import as3isolib.display.renderers.DefaultShadowRenderer;
import as3isolib.geom.Pt;

import com.flashdynamix.motion.Tweensy;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.pathfind.ItemsPathGrid;

import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;


public class ItemIsoViewMoveMediator extends Mediator
{
   
    [Inject(name="item_for_move")]
    public var cursor:ItemIsoView;
    [Inject]
    public var _view:MainIsoView;
    [Inject(name="place_moved_item")]
    public var placeMovedItem:ISignal;
    [Inject]
    public var mainIsoView:MainIsoView;
    private var inThisFrame:Boolean;
    private var shadowFactory:ClassFactory;
    private var _dragPt:Pt;
    [Inject]
    public var pathGrid:ItemsPathGrid;
    [Inject]
    public var changeState:ChangeStateSignal;
	
	
    override public function onRegister():void
    {
        contextView.stage.addEventListener(MouseEvent.CLICK, onDrop);
        contextView.stage.addEventListener(KeyboardEvent.KEY_DOWN, onEscKeyDown);
        contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false, 0, true);
        contextView.stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheelMouse, false, 0, true);
//        _dragPt = new Pt();//
        _dragPt = _view.localToIso(new Point(contextView.stage.mouseX, contextView.stage.mouseY));
        _dragPt.x = contextView.stage.mouseX;
        _dragPt.y = contextView.stage.mouseY;
        cursor.moveBy(0, 0, 25);
        (mainIsoView.currentFloor as IsoScene).stylingEnabled = true;
        shadowFactory = new ClassFactory(DefaultShadowRenderer);
        checkPlaceable();
        cursor.render();
        mainIsoView.currentFloor.render();
    }

    private function onEscKeyDown(event:KeyboardEvent):void
    {
        if (event.charCode == Keyboard.ESCAPE)
        {
             mainIsoView.currentFloor.removeChild(cursor);
            changeState.dispatch(GameStates.VIEW);
        }
    }

    private function onDrop(e:Event):void
    {
        if (checkPlaceable())
        {
            placeMovedItem.dispatch(cursor);
            cursor.z = 0;
            Tweensy.to(cursor, { z: 0}, 0.05, null, 0, null, onDropComplete);
        }
    }

    private function checkPlaceable():Boolean
    {
        var cursorX:int = cursor.x / IsoConfig.CELL_SIZE;
        var cursorY:int = cursor.y / IsoConfig.CELL_SIZE;
        var cursorWidth:int = (cursor.width + cursor.x) / IsoConfig.CELL_SIZE;
        var cursorLength:int = (cursor.length + cursor.y) / IsoConfig.CELL_SIZE;
        var isPlaceable:Boolean = true;
        shadowFactory.properties = {shadowColor: 0x049C02, shadowAlpha: 0.5, drawAll: false};
        if (!pathGrid.getNode(cursor.enterPoint.x, cursor.enterPoint.y))
        {
            shadowFactory.properties = {shadowColor: 0xD43C3C, shadowAlpha: 0.5, drawAll: false};
            isPlaceable = false;
        }
        else if (!pathGrid.getNode(cursor.enterPoint.x, cursor.enterPoint.y).walkable)
        {
            shadowFactory.properties = {shadowColor: 0xD43C3C, shadowAlpha: 0.5, drawAll: false};
            isPlaceable = false;
        }
        else
        {
            for (var i:int = cursorY; i < cursorLength; i++)
            {
                for (var j:int = cursorX; j < cursorWidth; j++)
                {
                    if (pathGrid.getNode(j, i))
                    {
                        if (!pathGrid.getNode(j, i).walkable)
                        {
                            shadowFactory.properties = {shadowColor: 0xD43C3C, shadowAlpha: 0.5, drawAll: false};
                            isPlaceable = false;
                        }
                    }
                    else
                    {
                        shadowFactory.properties = {shadowColor: 0xD43C3C, shadowAlpha: 0.5, drawAll: false};
                        isPlaceable = false;
                    }
                }
            }
        }
         (mainIsoView.currentFloor as IsoScene).styleRenderers = [shadowFactory];
        return isPlaceable;
    }

    private function onDropComplete():void
    {
        contextView.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler_OnDropComplete);
        inThisFrame = true;
        mainIsoView.panBy(0, -3);
    }

    private function enterFrameHandler_OnDropComplete(event:Event):void
    {
        if (!inThisFrame)
        {
            contextView.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler_OnDropComplete);
            mainIsoView.panBy(0, 3);
        }
        inThisFrame = false;
    }


    override public function onRemove():void
    {
        contextView.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheelMouse, false);
        contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false);
        contextView.stage.removeEventListener(MouseEvent.CLICK, onDrop);
        contextView.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onEscKeyDown);
    }

    private function updateMouse(e:MouseEvent):void
    {
        var pt:Pt = _view.localToIso(new Point(contextView.stage.mouseX, contextView.stage.mouseY));
        if ((pt.x != cursor.x) && (pt.y != cursor.y))
        {
            cursor.moveTo(Math.floor(pt.x / IsoConfig.CELL_SIZE) * IsoConfig.CELL_SIZE /*- _dragPt.x*/, Math.floor(pt.y / IsoConfig.CELL_SIZE) * IsoConfig.CELL_SIZE /*- _dragPt.y*/, cursor.z);
            cursor.render();
            mainIsoView.currentFloor.render();
            e.updateAfterEvent();
            checkPlaceable();
        }
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
        checkPlaceable();
    }

}
}
