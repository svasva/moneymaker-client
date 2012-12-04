/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 12:57
 */
package ru.fcl.sdd.item
{

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.scenes.FloorScene;
import ru.fcl.sdd.scenes.grid.PathGrid;

public class PlaceItemCommand extends SignalCommand
{
    [Inject]
    public var iso:Item;
    [Inject]
    public var floor:FloorScene;
    [Inject]
    public var pathGreed:PathGrid;

    override public function execute():void
    {
        //todo: Тут эмуляция внешнего вида айтемов. Как только появятся скины - убрать к чертям и поменять на них.
        floor.addChild(iso);
        iso.render();
        floor.render();
    }
}
}
