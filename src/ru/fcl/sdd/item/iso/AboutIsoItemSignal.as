/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 16:48
 */
package ru.fcl.sdd.item.iso
{
import org.osflash.signals.Signal;

import ru.fcl.sdd.item.iso.ItemIsoView;

public class AboutIsoItemSignal extends Signal
{
    public function AboutIsoItemSignal()
    {
        super(ItemIsoView);
    }
}
}
