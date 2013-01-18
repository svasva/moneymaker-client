/**
 * User: Jessie
 * Date: 18.01.13
 * Time: 16:40
 */
package ru.fcl.sdd.gui.info.experience
{
public class FreeObjectsHolder
{
    private var _objects:Vector.<IBusynessable>;

    public function getFreeObject(value:Class):IBusynessable
    {
        for (var i:int = 0; i < _objects.length; i++)
        {
            if (_objects[i].isBussy==false)
            {
                return _objects[i];
            }
        }
        _objects.push(new value);
        return _objects[length-1];
    }
}
}
