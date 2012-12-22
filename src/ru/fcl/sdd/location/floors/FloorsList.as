/**
 * User: Jessie
 * Date: 22.12.12
 * Time: 17:08
 */
package ru.fcl.sdd.location.floors
{

public class FloorsList extends Array
{
    private var _currentFloor:int;

    public function get currentFloor():int
    {
        return _currentFloor;
    }

    public function set currentFloor(value:int):void
    {
        _currentFloor = value;
    }

    public function FloorsList(...rest)
    {
        super(rest);
    }

    public function get nextFloor():*
    {
        if (this[currentFloor + 1])
        {
            currentFloor++;
            return this.currentFloor;
        }
        else
        {
            return null;
        }
    }

    public function get prevFloor():*
    {
        if (currentFloor>0)
        {
            currentFloor--;
            return this[currentFloor];
        }
        else
        {
            return null;
        }
    }
}
}
