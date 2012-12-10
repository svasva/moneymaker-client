package ru.fcl.sdd.services.social
{

/**
 * ...
 * @author www0z0k
 */
public interface ISocialNetService
{
    function get inited():Boolean;

    function init(uid:String):void;

    function wallPost(...rest):void;

    function friendsGet(...rest):void;

    function invite():void;
}

}