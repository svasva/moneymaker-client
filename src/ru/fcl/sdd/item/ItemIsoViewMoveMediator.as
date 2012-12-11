/**
 * User: Jessie
 * Date: 11.12.12
 * Time: 11:23
 */
package ru.fcl.sdd.item
{
import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;

public class ItemIsoViewMoveMediator extends Mediator
{
    [Inject]
    public var cursor:ItemIsoView;

    override public function onRegister():void
    {
        contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false, 0, true);
//        cursor.mouseEnabled = false;
    }

    override public function onRemove():void
    {
        contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateMouse, false);
//        mouseEnabled = true;
    }

    private function updateMouse(e:MouseEvent) : void
    {
        cursor.x = contextView.stage.mouseX;
        cursor.y = contextView.stage.mouseY;
        e.updateAfterEvent();
    }
}
}
