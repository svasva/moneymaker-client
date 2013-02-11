package ru.fcl.sdd.services.main.parser 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.config.FlashVarsModel;
    import ru.fcl.sdd.item.AdvertsCatalog;
    import ru.fcl.sdd.item.Item;
    import ru.fcl.sdd.item.MarketingCatalog;
    import ru.fcl.sdd.tools.PrintJSON;
	
	/**
     * ...
     * @author atuzov
     */
    public class ParseMarketingCommand extends SignalCommand 
    {
        [Inject]
        public var marketObj:Object
        
        [Inject]
        public var marketingObj:MarketingCatalog;
        [Inject]
        public var advObj:AdvertsCatalog;
        
        [Inject]
        public var flashVars:FlashVarsModel;
        
        override public function execute():void 
        {
           // PrintJSON.deepTrace(marketObj);
            
          
             var itemsArray:Array = marketObj.response;     
            itemsArray.forEach(parseItem);
          
        }
        private function parseItem(object:Object, index:int, array:Array):void
        {
             var contentUrl:String = flashVars.content_url + object.swf_url;
            var item:Item = new Item();
            injector.mapValue(Item, item);
            injector.injectInto(item);
            item.key = object._id;
            item.item_name = object.name;
            if(object.swf_url)
            item.skinUrl = contentUrl;
            
            item.requirementLevel = object.requirements.level; 
            item.description = object.desc; 
             item.gameMoneyPrice = object.coins_cost as int;
            item.money_cost = object.money_cost;
            if(object.icon_url)
            item.iconUrl = flashVars.content_url + object.icon_url;
            
            if(object.is_advert)
                advObj.set(item.key, item);
            else
               marketingObj.set(item.key, item);
        }
        
        
    }

}