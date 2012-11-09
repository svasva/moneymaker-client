/**
 * User: Jessie
 * Date: 09.11.12
 * Time: 11:50
 */
package ru.fcl.sdd.log
{
import com.junkbyte.console.Cc;

public class Logger implements ILogger
{
    public function log(target:Object, ...params):void
    {
        Cc.log(target, params);
        trace(target, params);
    }

    public function error(target:Object, ...params):void
    {
        Cc.error(target, params);
        trace(target, params);
    }
}
}
