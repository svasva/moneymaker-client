package ru.fcl.sdd.item 
{
    import de.polygonal.ds.HashMap;
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
        
       [Inject]
       public var updateTab:ShopModelTabUpdatedSignal;
       
       [Inject]
       public var updateCategory:ShopModelCategoryUpdatedSignal;
        
       private var m_selectedTab:String = ShopModel.SHOP_TAB_MAIN;
       private var m_selectedCategory:String;
       private var _wareHouse:HashMap = new HashMap();
       
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
         //  updateCategory.dispatch();
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
        
    }
    

}