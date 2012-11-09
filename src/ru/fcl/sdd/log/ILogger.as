/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 12:13
 */
package ru.fcl.sdd.log
{
public interface ILogger
{
    function log(target:Object, ...params):void;

    function error(target:Object, ...params):void;
}
}
