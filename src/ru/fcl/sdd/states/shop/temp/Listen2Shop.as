/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 13:35
 */
package ru.fcl.sdd.states.shop.temp
{
import ru.fcl.sdd.states.shop.*;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.states.temp.IStateNews;

import ru.fcl.sdd.states.temp.ListenToStateCommand;

public class Listen2Shop extends ListenToStateCommand
{
    public function Listen2Shop()
    {
        onEnterCommandClass = EnterShopCommand;
        onExitCommandClass = OutShopCommand;
    }

    [Inject(name="shop_activity")]
    override public function set stateNews(value:IStateNews):void
    {
        super.stateNews = value;
    }
}
}
