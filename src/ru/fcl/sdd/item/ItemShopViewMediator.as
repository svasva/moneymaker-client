/**
 * User: Jessie
 * Date: 30.11.12
 * Time: 13:57
 */
package ru.fcl.sdd.item
{
import org.robotlegs.mvcs.Mediator;

public class ItemShopViewMediator  extends Mediator
{
    [Inject]
    public var itemView:ItemShopView;

    [PostConstruct]
    public function init():void
    {

    }

    override public function onRegister():void
    {

    }

    override public function onRemove():void
    {

    }
}
}
