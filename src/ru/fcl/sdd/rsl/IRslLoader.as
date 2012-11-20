/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 15:19
 */
package ru.fcl.sdd.rsl
{
public interface IRslLoader
{
    /**
     * load all rsl.
     * @param url - rsl url for current social net.
     * @param swfNameStack - stack of names swf files 2 load.
     */
    function loadRsl(url:String, swfNameStack:Vector.<String>):void;
}
}
