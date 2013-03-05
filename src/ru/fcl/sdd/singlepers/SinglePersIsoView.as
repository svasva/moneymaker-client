/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:05
 */
package ru.fcl.sdd.singlepers
{
import as3isolib.display.IsoSprite;
import flash.utils.getDefinitionByName;

import ru.fcl.sdd.item.iso.ItemIsoView;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.utils.Timer;
import flash.utils.getTimer;


public class SinglePersIsoView extends IsoSprite
{

    private var _currentDirection:int;   
	private var _mcSkin:MovieClip;

    public static const NORTH:int = 1;
    public static const EAST:int = 2;
    public static const SOUTH:int = 3;
    public static const WEST:int = 4;

    public static const WALK:int = 0;
    public static const STOP:int = 1;
	
	private var _currentFrame:int;
    public function SinglePersIsoView()
    {
      
        super();
    }

   

    public function setDirection(direction:int, anim:Boolean = true):void
    {
        this._currentDirection = direction;       
        if (_mcSkin)
        {
            if (anim)
			{
                if (_mcSkin.currentFrame < 5)
                {
                    _currentFrame = MovieClip(_mcSkin.getChildAt(0)).currentFrame;
                }
                _mcSkin.gotoAndStop(_currentDirection);
                if (_currentFrame < 24)
                {
                    MovieClip(_mcSkin.getChildAt(0)).gotoAndPlay(_currentFrame + 1);
                }
                else
                {
                    MovieClip(_mcSkin.getChildAt(0)).gotoAndPlay(1);
                }
			}
			else
				MovieClip(_mcSkin.gotoAndStop(direction + 4));
            }
          
        
    }

  
    public function set skin(value:String):void
    {
        _mcSkin = new gairl03();
        //_skin = value;
        if (_mcSkin)
        {
			this.sprites = [_mcSkin];
			setDirection(_currentDirection);
			this.render();
        }
    }
   
  

    public function get currentDirection():int
    {
        return _currentDirection;
    }

   
	
}
}
