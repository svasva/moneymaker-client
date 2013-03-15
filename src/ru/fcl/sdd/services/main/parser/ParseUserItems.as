/**
 * User: Jessie
 * Date: 22.11.12
 * Time: 13:45
 */
package ru.fcl.sdd.services.main.parser
{
    
    import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.ItemStatus;
    import ru.fcl.sdd.item.ShopModel;
	import ru.fcl.sdd.tools.PrintJSON;
    
    import ru.fcl.sdd.config.IsoConfig;
    import ru.fcl.sdd.item.Item;
    import ru.fcl.sdd.item.ItemCatalog;
    import ru.fcl.sdd.item.iso.ItemIsoView;
    import ru.fcl.sdd.item.ActiveUserItemList;
    
    public class ParseUserItems extends SignalCommand
    {
        [Inject]
        public var items:Array;
        [Inject]
        public var itemCatalog:ItemCatalog;
        [Inject]
        public var userItems:ActiveUserItemList;
        [Inject]
        public var shopMdl:ShopModel;
        
        
        
        override public function execute():void
        {
			trace("ParseUserItems");
			PrintJSON.deepTrace(items);
			
			if (!userItems.isEmpty)
				userItems.clear();
		
            items.forEach(parseItems);
        }
        
        private function parseItems(object:Object, index:int, array:Array):void
        {
            
            
            
            var catalogItem:Item = Item(itemCatalog.get(object.reference_id));
            if (object.room_id == null)
            {
                shopMdl.wareHouse.set(object._id, catalogItem);
            }
            else
            {
                var item:ItemIsoView = new ItemIsoView();
                catalogItem.room_id = object.room_id;
                item.key = object._id;
                item.catalogKey = object.reference_id;
                item.setSize(catalogItem.isoWidth, catalogItem.isoLength, catalogItem.isoHeight);
                //set direction only after setSize!
                item.direction = object.rotation;
                item.x = object.x * IsoConfig.CELL_SIZE;
                item.y = object.y * IsoConfig.CELL_SIZE;
                item.room_id = object.room_id;
                if (object.state)
                {
                   item.status =  object.state;
                   if (item.status == ItemStatus.EMPTY)
                   item.sprites.push(item.giveMoney);
                }
                
                
                if (object.capacity)
                item.capacity = object.capacity;
                
                 
                item.skin = catalogItem.skinUrl;
                if (object.cash)
                {
                    item.cashMoney = object.cash;
                }
                
                userItems.set(item.key, item);
            }
        
//        commandMap.execute(PlaceItemCommand,item);
        }
    }
}
