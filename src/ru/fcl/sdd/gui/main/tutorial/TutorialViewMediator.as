/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 15:07
 */
package ru.fcl.sdd.gui.main.tutorial
{
import de.polygonal.ds.HashMap;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import ru.fcl.sdd.item.ShopItemRoom;
import ru.fcl.sdd.item.ShopModel;

import org.osflash.signals.ISignal;

import org.robotlegs.base.CommandMap;

import org.robotlegs.mvcs.Mediator;

import ru.fcl.gui.CollectChunker;
import ru.fcl.sdd.gui.ingame.shop.events.ItemEvent;
import ru.fcl.sdd.item.ItemCatalog;
import ru.fcl.sdd.states.ChangeStateSignal;
import ru.fcl.sdd.states.GameStates;

public class TutorialViewMediator extends Mediator
{
    [Inject]
    public var tutorialView:TutorialView;
    [Inject]
    public var hidetutorial:ChangeStateSignal;
    [Inject]
 //   public var itemCatalog:ItemCatalog;
    [Inject(name="buy_item")]
//    public var buyItem:ISignal;
     [Inject]
//    public var clickedSignal:ShopItemRoomSignal;
     [Inject]
//     public var shopMdl:ShopModel;
     
     [Inject]
//     public var updatedCategory:ShopModelCategoryUpdatedSignal;
     [Inject]
//     public var updatedTabe:ShopModelTabUpdatedSignal;    
     
    
///     private var _collectChunker:CollectChunker;
     
//     private var currentSelectedTabBtn:SimpleButton;
     
//     private var btnVec:Vector.<SimpleButton> = new Vector.<SimpleButton>();

    override public function onRegister():void
    {
       tutorialView.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
      //  shopView.prevItemsBtn.addEventListener(MouseEvent.CLICK, prevItemsClickHandler);
      //  shopView.nextItemsBtn.addEventListener(MouseEvent.CLICK, nextItemsClickHandler);
      //  shopView.addEventListener(ItemEvent.ITEM_CLICKED, shopItemClickHandler);
      //  shopView.addEventListener(ItemEvent.ITEM_OVERED, shopView_itemOvered);
     //   shopView.addEventListener(ItemEvent.ITEM_MOUSE_OUT, shopView_itemMouseOut);
        
  //      shopView.roomsShopBtn.addEventListener(MouseEvent.CLICK, tabBtnClick);
  //      shopView.storeShopBtn.addEventListener(MouseEvent.CLICK, tabBtnClick);
 //       shopView.moneyShopBtn.addEventListener(MouseEvent.CLICK, tabBtnClick);
 //       shopView.specialShopBtn.addEventListener(MouseEvent.CLICK, tabBtnClick);
        
 //        clickedSignal.add(itemClicked);
 //         var tempShopRoomItm:HashMap = shopMdl.outputMainShop;
 //         var tempShopRooms:ShopItemRoom = tempShopRoomItm.get("50fd35a25dae91f8b1000001") as ShopItemRoom;
        
 /*       if (tempShopRooms)
        {
            _collectChunker = new CollectChunker(tempShopRooms.ref_items, 6);
            _collectChunker.reset();
            shopView.items = _collectChunker.next();
           
        }
        
        checkItemsBtnVisible();
        updatedTabe.add(setTab);
        updatedCategory.add(setCategory);
        
        btnVec.push(shopView.roomsShopBtn);
        btnVec.push(shopView.storeShopBtn);
        btnVec.push(shopView.specialShopBtn);
        btnVec.push(shopView.moneyShopBtn);
        currentSelectedTabBtn = shopView.roomsShopBtn;
        
        setSelectetTab(ShopModel.SHOP_TAB_MAIN);*/
      
    }   
	
	 override public function onRemove():void
    {
        tutorialView.closeButton.removeEventListener(MouseEvent.CLICK, closeClickHandler);
      //  shopView.prevItemsBtn.removeEventListener(MouseEvent.CLICK, prevItemsClickHandler);
     //   shopView.nextItemsBtn.removeEventListener(MouseEvent.CLICK, nextItemsClickHandler);
    //    shopView.removeEventListener(ItemEvent.ITEM_CLICKED, shopItemClickHandler);
    //    shopView.items = [];
    }

    private function closeClickHandler(event:MouseEvent):void
    {
        hidetutorial.dispatch(GameStates.STATE_OUT);
    }
  /*  private function setTab():void 
    {
        setSelectetTab(shopMdl.selectedTab);
    }
    
    private function tabBtnClick(e:MouseEvent):void 
    {
        currentSelectedTabBtn.x = e.target.x;
        currentSelectedTabBtn.y = e.target.y;
        currentSelectedTabBtn.visible = true;
        
        currentSelectedTabBtn = e.target as SimpleButton;
        currentSelectedTabBtn.visible = false;
        shopMdl.selectedTab = e.target.name as String;
        setSelectetTab(e.target.name);
    }
    private function setSelectetTab(tabNam:String):void
    {
          shopView.clearIcon();
         
        if (tabNam == ShopModel.SHOP_TAB_MAIN)
        {          
           shopView.iconSprite.addChild(shopView.iconVec[0])
           btnVec[0].visible = false;
           addOperationRoom();
        }
        else if (tabNam == ShopModel.SHOP_TAB_WAREHOUSE)
        {
            shopView.iconSprite.addChild(shopView.iconVec[1])
            btnVec[1].visible = false;
            addWarehouseShopItems();
        }
        else if (tabNam == ShopModel.SHOP_TAB_BONUS)
        {
             shopView.iconSprite.addChild(shopView.iconVec[2])
              btnVec[2].visible = false;
        }
         else if (tabNam == ShopModel.SHOP_TAB_PREMIUM)
        {
             shopView.iconSprite.addChild(shopView.iconVec[3])
              btnVec[3].visible = false;
        }
    }
    private function addOperationRoom():void
    {
         //shopMdl.setCategory(0)
         if(!shopMdl.curentSelectedShopItemRoom)
         return;
         
        _collectChunker = new CollectChunker(shopMdl.curentSelectedShopItemRoom.ref_items, 6);
        _collectChunker.reset();
        shopView.items = _collectChunker.next();
        checkItemsBtnVisible();
    }
    
    
    private function addWarehouseShopItems():void
    {
        if (!shopMdl.wareHouse)
        return
        
        _collectChunker = new CollectChunker(shopMdl.wareHouse, 6);
        _collectChunker.reset();
        shopView.items = _collectChunker.next();
        checkItemsBtnVisible();
    }
    
    private function setCategory():void 
    {
          if (shopMdl.curentSelectedShopItemRoom.isPurshed)
          {
             _collectChunker = new CollectChunker(shopMdl.curentSelectedShopItemRoom.ref_items, 6) 
             _collectChunker.reset();
             shopView.items = _collectChunker.next();
             checkItemsBtnVisible();
          }
          else
          {
             shopView.clearItems();
             shopView.itemsJPanel.append(shopMdl.curentSelectedShopItemRoom.shopItemRoomView);
             _collectChunker = null;
             checkItemsBtnVisible();
          }
          
       
    }
    
    private function itemClicked(id:String):void 
    {
       
        trace("itemClicked");
        var tempShopRoomItm:HashMap = shopMdl.get("main") as HashMap;
        
        var tempShopRooms:ShopItemRoom = tempShopRoomItm.get(id) as ShopItemRoom;
      
        if (tempShopRooms)
        {
            _collectChunker = new CollectChunker(tempShopRooms.ref_items, 6) 
            _collectChunker.reset();
            shopView.items = _collectChunker.next();
           
        }
        
        
    }

    override public function onRemove():void
    {
        shopView.closeButton.removeEventListener(MouseEvent.CLICK, closeClickHandler);
        shopView.prevItemsBtn.removeEventListener(MouseEvent.CLICK, prevItemsClickHandler);
        shopView.nextItemsBtn.removeEventListener(MouseEvent.CLICK, nextItemsClickHandler);
        shopView.removeEventListener(ItemEvent.ITEM_CLICKED, shopItemClickHandler);
        shopView.items = [];
    }

    private function closeClickHandler(event:MouseEvent):void
    {
        hideShop.dispatch(GameStates.STATE_OUT);
    }

    private function prevItemsClickHandler(event:MouseEvent):void
    {
        shopView.items = _collectChunker.prev();
        checkItemsBtnVisible();
    }

    private function nextItemsClickHandler(event:MouseEvent):void
    {
        shopView.items = _collectChunker.next();
        checkItemsBtnVisible();
    }

    private function checkItemsBtnVisible():void
    {
        if (_collectChunker)
        {
            shopView.prevItemsBtn.visible = _collectChunker.hasPrev();
            shopView.nextItemsBtn.visible = _collectChunker.hasNext();
        }
        else
        {
            shopView.prevItemsBtn.visible  = false;
            shopView.nextItemsBtn.visible = false;
        }
    }

    private function shopItemClickHandler(event:ItemEvent):void
    {
       // buyItem.dispatch(event.item);
       shopMdl.selectedShopItem = event.item;
       
    }
    private function shopView_itemOvered(e:ItemEvent):void 
    {
        shopMdl.overedShopItem = e.item;
    }
    private function shopView_itemMouseOut(e:ItemEvent):void 
    {
         shopMdl.overedShopItem = null;
    }*/
}
}