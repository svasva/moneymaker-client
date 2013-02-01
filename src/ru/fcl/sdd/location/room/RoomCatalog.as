/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 15:56
 */
package ru.fcl.sdd.location.room
{
import de.polygonal.ds.HashMap;

public class RoomCatalog extends HashMap
{
    private var _roomCatalogByRommTypeId:HashMap;
    
    public function RoomCatalog()
    {
        _roomCatalogByRommTypeId = new HashMap();
    }
    
    public function get roomCatalogByRommTypeId():HashMap 
    {
        return _roomCatalogByRommTypeId;
    }
    
    public function set roomCatalogByRommTypeId(value:HashMap):void 
    {
        _roomCatalogByRommTypeId = value;
    }
   
}
}
