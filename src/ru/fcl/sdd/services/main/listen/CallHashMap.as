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
    public function addValue(value:Class):String
    {
        var key:String = MD5.hash(String(new Date()));
        this.set(key, value);
        return key;
    }
}
}
