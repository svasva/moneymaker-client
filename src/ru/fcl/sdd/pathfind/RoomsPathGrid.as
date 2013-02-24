/**
 * User: Jessie
 * Date: 12.12.12
 * Time: 11:28
 */
package ru.fcl.sdd.pathfind
{

public class RoomsPathGrid extends Grid
{



public override function init(numCols:int, numRows:int):void
{
        _numCols = numCols;
        _numRows = numRows;
        _nodes = [];

        for (var i:int = 0; i < _numCols; i++)
        {
            _nodes[i] = [];
            for (var j:int = 0; j < _numRows; j++)
            {
                _nodes[i][j] = new Node(i, j);
				 _nodes[i][j].walkable = false;
            }
        }
    }
}
}
