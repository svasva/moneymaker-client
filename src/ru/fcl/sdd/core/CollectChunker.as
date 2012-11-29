/**
 * User: Jessie
 * Date: 29.11.12
 * Time: 13:40
 */
package ru.fcl.sdd.core
{
import de.polygonal.ds.HashMap;

public class CollectChunker
{
    private var _collection:HashMap;
    private var _chunkSize:int;
    private var _preparedArray:Array;
    private var _currentChunk:int;

    public function CollectChunker(collection:HashMap, chunkSize:int):void
    {
        _collection = collection;
        _chunkSize = chunkSize;
        _collection.iterator().reset();
    }

    public function Destroy():void
    {
        _collection = null;
        _preparedArray = null;
    }

    public function reset():void
    {
        _collection.iterator().reset();
        _currentChunk = 0;
        _preparedArray = [];
    }

    public function next():Array
    {
        _preparedArray = [];
        for (var i:int = 0; i < _chunkSize; i++)
        {
            if (_collection.iterator().hasNext())
            {
                _preparedArray.push(_collection.iterator().next());
            }
        }
        if (_preparedArray.length)
        {
            _currentChunk++;
        }
        return _preparedArray;
    }

    public function prev():Array
    {
        _preparedArray = [];
        if (hasPrev)
        {
            _collection.iterator().reset();

            for (var i:int = 0; i < _currentChunk - 2; i++)
            {
                for (var j:int = 0; j < _chunkSize; j++)
                {
                    _collection.iterator().next();
                }
            }

            for (var k:int = 0; k < _chunkSize; k++)
            {
                if (_collection.iterator().hasNext())
                {
                    _preparedArray.push(_collection.iterator().next());
                }
            }
        }
        return _preparedArray;
    }

    public function hasPrev():Boolean
    {
        var has:Boolean;
        if (_currentChunk > 1)
        {
            has = true;
        } else
        {
            has = false;
        }
        return has;
    }

    public function hasNext():Boolean
    {
        return _collection.iterator().hasNext();

    }
}
}
