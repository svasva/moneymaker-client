package ru.fcl.sdd.services.main.parser 
{
    import de.polygonal.ds.HashMap;
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.gui.ingame.shop.ConstructShopViewFromModel;
    import ru.fcl.sdd.gui.ingame.shop.ShopItemRoomSignal;
    import ru.fcl.sdd.item.ItemCatalog;
    import ru.fcl.sdd.item.ShopItemRoom;
    import ru.fcl.sdd.item.ShopModel;
    import ru.fcl.sdd.location.room.Room;
    import ru.fcl.sdd.tools.PrintJSON;
	
	/**
     * ...
     * @author atuzov
     */
    public class ParseShopObjectCommand extends SignalCommand 
    {
        
        [Inject]
        public var shopObj:Object
        
        [Inject]
        public var shopMdl:ShopModel;
        
        [Inject]
        public var itemCatalog:ItemCatalog;
        
        
        override public function execute():void 
        {
           //trace("ParseShopObjectCommand");
           
          // PrintJSON.deepTrace(shopObj.response);
           
           var mainShopHash:HashMap = new HashMap();
         //  var wareHouseHash:HashMap = new HashMap();
           
           shopMdl.set(ShopModel.SHOP_TAB_MAIN,mainShopHash);
           shopMdl.set(ShopModel.SHOP_TAB_PREMIUM,new HashMap());
          // shopMdl.set(ShopModel.SHOP_TAB_WAREHOUSE,wareHouseHash);
           shopMdl.set(ShopModel.SHOP_TAB_BONUS, new HashMap());
           
           var shopMain:Object = shopObj.response.main;
           var shopItemRoom:ShopItemRoom;
           var roomItemId:Array;
           var lim:int;
           var i:int = 0;
           
           for each (var item:Object in shopMain) 
           {
              // PrintJSON.deepTrace(item, 0);
               shopItemRoom = new ShopItemRoom()
              // trace("-----="+item.name+"=---------------")
               shopItemRoom.desc = item.desc;
               shopItemRoom.id = item._id;
               shopItemRoom.item_name = item.name;
               shopItemRoom.order =  int(item.order);
            
               
               mainShopHash.set( shopItemRoom.id, shopItemRoom);
               shopMdl.outputMainShop.set( shopItemRoom.id, shopItemRoom);
               
               roomItemId = [];
               roomItemId = item.ref_items as Array;
               lim = roomItemId.length;
               if (roomItemId.length != 0)
               {
                   i = 0;
                   for (i; i < lim; i++) 
                   {
                      shopItemRoom.ref_items.set(roomItemId[i], itemCatalog.get(roomItemId[i]));
                    
                    }                   
               }
           }
        
           
         
           commandMap.execute(ConstructShopViewFromModel);
           
           
           
           
        }
       
        
    }

}