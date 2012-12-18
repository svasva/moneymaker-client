/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 16:21
 */
package ru.fcl.sdd.homus
{
import as3isolib.geom.Pt;

import com.flashdynamix.motion.Tweensy;
import com.flashdynamix.motion.TweensySequence;

import flash.geom.Point;
import flash.utils.setTimeout;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.config.IsoConfig;

import ru.fcl.sdd.config.IsoConfig;
import ru.fcl.sdd.item.ItemIsoView;

import ru.fcl.sdd.item.UserItemList;
import ru.fcl.sdd.pathfind.AStar;

import ru.fcl.sdd.pathfind.PathGrid;
import ru.fcl.sdd.scenes.FloorScene;

public class ClientusIsoViewMediator extends Mediator
{
    [Inject]
    public var pathGrid:PathGrid;
    [Inject]
    public var userItems:UserItemList;
    [Inject]
    public var clientusView:ClientusIsoView;
    [Inject]
    public var floor:FloorScene;
    private var path:Array;

    override public function onRegister():void
    {
        clientusView.x = 14*IsoConfig.CELL_SIZE;
        pathGrid.setStartNode(clientusView.x/IsoConfig.CELL_SIZE, clientusView.y/IsoConfig.CELL_SIZE);
        var item:ItemIsoView = userItems.get(clientusView.needItemId) as ItemIsoView;
        pathGrid.setEndNode((item.x+item.width)/IsoConfig.CELL_SIZE,(item.y+item.height)/IsoConfig.CELL_SIZE);
        findPath();
    }

    protected function findPath():void
    {
        var astar:AStar = new AStar();
        var speed:Number = .3;
        if(astar.findPath(pathGrid))
        {
            path = astar.path;
        }

//        var sequence:TweensySequence = new TweensySequence();
        for (var i:int = 0; i <path.length; i++)
        {
            var targetX:Number = path[i].x * IsoConfig.CELL_SIZE;
            var targetY:Number = path[i].y * IsoConfig.CELL_SIZE;

//            sequence.push(clientusView,{x:targetX, y:targetY}, speed);
        }

        gotoCell();
//        sequence.start();
    }

    private function gotoCell():void
    {
        clientusView.x = path[0].x*IsoConfig.CELL_SIZE;
        clientusView.y = path[0].y*IsoConfig.CELL_SIZE;
        if(path.length-1)
        {
            path.shift();
            setTimeout(gotoCell,200);
        }
        floor.render();
    }

}
}
