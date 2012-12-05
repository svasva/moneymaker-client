/**
 * User: Jessie
 * Date: 29.11.12
 * Time: 13:40
 */
package ru.fcl.gui
{
/**
 * Class for provide portion of collection.
 */

import de.polygonal.ds.HashMap;
import de.polygonal.ds.HashMapValIterator;

public class CollectChunker
{
    private var _collection:HashMap;
    private var _chunkSize:int;
    private var _preparedArray:Array;
    private var _currentChunk:int;
    private var _iterator:HashMapValIterator;

    public function CollectChunker(collection:HashMap, chunkSize:int):void
    {
        _collection = collection;
        _chunkSize = chunkSize;
        _iterator = _collection.iterator() as HashMapValIterator;
    }

    public function Destroy():void
    {
        _collection = null;
        _preparedArray = null;
        _iterator = null;
    }

    public function reset():void
    {
        _iterator.reset();
        _currentChunk = 0;
        _preparedArray = [];
    }

    public function next():Array
    {
        _preparedArray = [];
        for (var i:int = 0; i < _chunkSize; i++)
        {
            if (_iterator.hasNext())
            {
                _preparedArray.push(_iterator.next());
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
            _iterator.reset();

            for (var i:int = 0; i < _currentChunk - 2; i++)
            {
                for (var j:int = 0; j < _chunkSize; j++)
                {
                    _iterator.next();
                }
            }

            for (var k:int = 0; k < _chunkSize; k++)
            {
                if (_iterator.hasNext())
                {
                    _preparedArray.push(_iterator.next());
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
        return _iterator.hasNext();

    }
}
}
