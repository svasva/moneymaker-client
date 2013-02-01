package ru.fcl.sdd.item 
{
    import de.polygonal.ds.HashMap;
    import ru.fcl.sdd.gui.ingame.shop.ForPurshRoomIdUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.OveredShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.SelectedShopItemUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.ShopModelCategoryUpdatedSignal;
    import ru.fcl.sdd.gui.ingame.shop.ShopModelTabUpdatedSignal;
	/**
     * ...
     * @author atuzov
     */
    public class ShopModel extends HashMap
    {
       
        public static const SHOP_TAB_MAIN:String = "main";
        public static const SHOP_TAB_PREMIUM:String = "premium";
        public static const SHOP_TAB_WAREHOUSE:String = "warehouse";
        public static const SHOP_TAB_BONUS:String = "bonus"; 
        
        private var tempHash:HashMap;
        private var tempVec:Vector.<Object>;
        private var _curentSelectedShopItemRoom:ShopItemRoom;
        private var _mainSortedShopObj:HashMap;
        private var _forPurshRoomId:String;
        
        private var _outputMainShop:HashMap = new HashMap();
        private var _outputPremium:HashMap = new HashMap();
        private var _outputBonus:HashMap = new HashMap();
        private var _outputWarehouse:HashMap = new HashMap();
         
        
       [Inject]
       public var updateTab:ShopModelTabUpdatedSignal;
       
       [Inject]
       public var updateCategory:ShopModelCategoryUpdatedSignal;
       
       [Inject]
       public var  selectedItemUpdated:SelectedShopItemUpdatedSignal;
       
       [Inject]
       public var overedItemUpdated:OveredShopItemUpdatedSignal;
       
       [Inject]
       public var forPurshRoomIdUpdated:ForPurshRoomIdUpdatedSignal;
       
       private var m_selectedTab:String = ShopModel.SHOP_TAB_MAIN;
       private var m_selectedCategory:String;
       private var _wareHouse:HashMap = new HashMap();
       
       private var _selectedShopItem:Item;
       private var _overedShopItem:Item;
       
       
       
       public function getWareHouse():HashMap
       {
           return  this.get("warehouse") as HashMap;
       }
       
       public function getShopItemByOrder(tabId:String,order:int):ShopItemRoom
       {
          tempHash =  this.get(tabId) as HashMap;
          tempVec = tempHash.toVector()
          for each (var item:ShopItemRoom in tempVec) 
          {
              if (item.order == order)
              return item
          }
          return null;
       }
       public function setCategory(order:int, tabId:String = ShopModel.SHOP_TAB_MAIN ):void
       {
           _curentSelectedShopItemRoom = this.getShopItemByOrder(tabId, order);        
       //    selectedCategory = order;
           updateCategory.dispatch();
       }
       
       public function get selectedTab():String 
       {
           return m_selectedTab;
       }
       
       public function set selectedTab(value:String):void 
       {
          m_selectedTab = value;
          updateTab.dispatch();
       }
       
       public function get selectedCategory():String 
       {
           return m_selectedCategory;
       }
       
       public function set selectedCategory(value:String):void 
       {
           m_selectedCategory = value;
        
       }
       
       public function get curentSelectedShopItemRoom():ShopItemRoom 
       {
           return _curentSelectedShopItemRoom;
       }
       
       public function get wareHouse():HashMap 
       {
           return _wareHouse;
       }
       
       public function set wareHouse(value:HashMap):void 
       {
           _wareHouse = value;
       }
       
       public function get selectedShopItem():Item 
       {
           return _selectedShopItem;
       }
       
       public function set selectedShopItem(value:Item):void 
       {
           _selectedShopItem = value;
           selectedItemUpdated.dispatch();
           
       }
       
       public function get overedShopItem():Item 
       {
           return _overedShopItem;
       }
       
       public function set overedShopItem(value:Item):void 
       {
           _overedShopItem = value;
           overedItemUpdated.dispatch();
       }
       
       public function get outputMainShop():HashMap 
       {
           return _outputMainShop;
       }
       
       public function set outputMainShop(value:HashMap):void 
       {
           _outputMainShop = value;
       }
       
       public function get outputPremium():HashMap 
       {
           return _outputPremium;
       }
       
       public function set outputPremium(value:HashMap):void 
       {
           _outputPremium = value;
       }
       
       public function get outputBonus():HashMap 
       {
           return _outputBonus;
       }
       
       public function set outputBonus(value:HashMap):void 
       {
           _outputBonus = value;
       }
       
       public function get outputWarehouse():HashMap 
       {
           return _outputWarehouse;
       }
       
       public function set outputWarehouse(value:HashMap):void 
       {
           _outputWarehouse = value;
       }
       
       public function get forPurshRoomId():String 
       {
           return _forPurshRoomId;
       }
       
       public function set forPurshRoomId(value:String):void 
       {
           _forPurshRoomId = value;
           forPurshRoomIdUpdated.dispatch();
       }
        
    }
    

}