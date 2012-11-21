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
     */
    public function addResponseHandler(value:Class):String
    {
        var date:Date = new Date();
        var time2Hash:String = String(date.time);
        var key:String = MD5.hash(time2Hash);
        this.set(key, value);
        return key;
    }
}
}
