/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 14:19
 */
package ru.fcl.sdd.services.main.listen
{
import com.adobe.crypto.MD5;

import de.polygonal.ds.HashMap;


public class CallHashMap extends HashMap
{
    /**
     * add SocketCall 2 HashMap with md5 key from current DateTime
     * @param value SocketCall object
     *
     * @return key of value
     * @param preInitKey use for pre sever push events.
     */
    public function addResponseHandler(value:Class, preInitKey:int = 0):String
    {
        var key:String;
        if (preInitKey == 0)
        {
            var date:Date = new Date();
            var time2Hash:String = String(date.time);
             key = MD5.hash(time2Hash);
            this.set(key, value);
        }
        else
        {
            key = preInitKey.toString();
        }
        return key;
    }
}
}
