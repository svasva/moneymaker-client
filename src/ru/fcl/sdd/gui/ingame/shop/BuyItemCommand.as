/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 19:34
 */
package ru.fcl.sdd.gui.ingame.shop
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.quest.CheckQuestCompleateCommand;

import ru.fcl.sdd.config.IsoConfig;

import ru.fcl.sdd.item.Item;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.item.iso.ItemIsoView;
import ru.fcl.sdd.item.ActiveUserItemList;
import ru.fcl.sdd.money.IMoney;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class BuyItemCommand extends SignalCommand
{
    [Inject]
    public var response:Object;
    [Inject]
    public var changeState:ChangeStateSignal;
    [Inject]
    public var userItems:ActiveUserItemList;
    [Inject]
    public var itemCatalog:ItemCatalog;
    [Inject(name="game_money")]
    public var gameMoney:IMoney;

    override public function execute():void
    {
        var item:Item = itemCatalog.get(response.response.reference_id) as Item;
		
		trace("BuyItemCommand");
		trace("item.item_name " + item.item_name);
		trace("item.catalog_id "+item.key)
		
        if (gameMoney.count >= item.gameMoneyPrice)
        {
            gameMoney.count -= item.gameMoneyPrice;
            var itemForMove:ItemIsoView = new ItemIsoView();
            itemForMove.key = response.response._id;
            itemForMove.catalogKey = item.key;
            itemForMove.direction = item.rotation;
            itemForMove.x = item.x * IsoConfig.CELL_SIZE;
            itemForMove.y = item.y * IsoConfig.CELL_SIZE;
            itemForMove.width = item.isoWidth;
            itemForMove.length = item.isoLength;
            itemForMove.height = item.isoHeight;
            itemForMove.skin = item.skinUrl;

            userItems.set(itemForMove.key, itemForMove);

            injector.mapValue(ItemIsoView, itemForMove, "item_for_move");
			
			commandMap.execute(CheckQuestCompleateCommand);
            changeState.dispatch(GameStates.BUY_ITEM);
        }
    }
}
}
