/**
 * User: Jessie
 * Date: 26.11.12
 * Time: 15:18
 */
package ru.fcl.sdd.config
{
import as3isolib.geom.IsoMath;
import as3isolib.geom.Pt;

public class IsoConfig
{
    public static const CELL_SIZE:int = 50//screen2Iso(50);

    public static function screen2Iso(value:int):int
    {
        var pt:Pt = new Pt(value,value);
        IsoMath.screenToIso(pt);

        return pt.x;
    }
}
}
