/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 12:57
 */
package ru.fcl.sdd.item
{

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.scenes.FloorScene;

public class PlaceItemCommand extends SignalCommand
{
    [Inject]
    public var iso:ItemIsoView;
    [Inject]
    public var floor:FloorScene;

    override public function execute():void
    {
        floor.addChild(iso);
        iso.render();
        floor.render();
    }
}
}
