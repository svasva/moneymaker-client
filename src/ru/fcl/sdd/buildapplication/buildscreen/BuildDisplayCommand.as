/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:15
 */
package ru.fcl.sdd.buildapplication.buildscreen
{
import flash.display.DisplayObject;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.scenes.MainIsoView;
import ru.fcl.sdd.scenes.grid.GridScene;

public class BuildDisplayCommand extends SignalCommand
{
    [Inject]
    public var mainIsoView:MainIsoView;
    [Inject]
    public var grid:GridScene;
    override public function execute():void
    {
        contextView.addChild(mainIsoView);
//        contextView.addChild(grid);
    }
}
}
