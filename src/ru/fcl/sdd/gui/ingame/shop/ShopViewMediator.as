/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 15:07
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.robotlegs.mvcs.Mediator;

public class ShopViewMediator extends Mediator
{
    [Inject]
    public var shopView:ShopView;

    override public function onRegister():void
    {
        shopView.graphics.beginFill(0xFFFFFF);
        shopView.graphics.drawRect(0,0,150,150);
    }
}
}