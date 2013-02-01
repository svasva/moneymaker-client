/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:37
 */
package ru.fcl.sdd.gui.ingame.shop
{
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import ru.fcl.sdd.gui.ingame.shop.events.ShopItemRoomEvent;
import ru.fcl.sdd.item.ShopModel;

import org.aswing.AssetBackground;
import org.aswing.GridLayout;
import org.aswing.JPanel;
import org.aswing.geom.IntDimension;
import org.aswing.plaf.EmptyLayoutUIResourse;

import ru.fcl.sdd.gui.ingame.shop.events.ItemEvent;
import ru.fcl.sdd.item.Item;

import ru.fcl.sdd.item.ItemShopView;
import ru.fcl.sdd.rsl.GuiRsl;

public class ShopView extends JPanel
{
    [Inject]
    public var rsl:GuiRsl;
    private var _bg:DisplayObject;
    private var _closeButton:SimpleButton;
    private var _helpButton:SimpleButton;
    private var _itemsJPanel:JPanel;
    private var _uiJpanel:JPanel;
    private var _prevItemsBtn:SimpleButton;
    private var _nextItemsBtn:SimpleButton;
    private var _storeShopBtn:SimpleButton;
    private var _roomsShopBtn:SimpleButton; 
    private var _specialShopBtn:SimpleButton;
    private var _moneyShopBtn:SimpleButton;
    private var _iconVec:Vector.<Sprite> = new Vector.<Sprite>();
    private var _iconSprite:Sprite = new Sprite();

    [PostConstruct]
    public function init():void
    {
        this.setLayout(new EmptyLayoutUIResourse());
        _bg = getAsset("BackgroundArt");
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.width = _bg.width;
        this.height = _bg.height;
        _closeButton = new SimpleButton(getAsset("ButtonCloseUpArt"),getAsset("ButtonCloseOverArt"),getAsset("ButtonCloseDownArt"),getAsset("ButtonCloseUpArt"));
        _closeButton.x = 722;
        _closeButton.y = 54;
        this.addChild(_closeButton);

        _prevItemsBtn =new SimpleButton(getAsset("LeftArrowBtnBigUpArt"),getAsset("LeftArrowBtnBigOverArt"),getAsset("LeftArrowBtnBigDownArt"),getAsset("LeftArrowBtnBigDownArt"));
        _prevItemsBtn.x = 13;
        _prevItemsBtn.y = 390;
        this.addChild(_prevItemsBtn);

        _itemsJPanel = new JPanel();
        var layout0:GridLayout = new GridLayout(2,3,29,16);
        _itemsJPanel.setLayout(layout0);
        _itemsJPanel.setSize(new IntDimension(650, 526));
        _itemsJPanel.x = 60;
        _itemsJPanel.y = 165;
        _itemsJPanel.setClipMasked(false);
        
        this.append(_itemsJPanel);

        _nextItemsBtn = new SimpleButton(getAsset("RightArrowBtnBigUpArt"),getAsset("RightArrowBtnBigOverArt"),getAsset("RightArrowBtnBigDownArt"),getAsset("RightArrowBtnBigDownArt"));
        _nextItemsBtn.x = 711;
        _nextItemsBtn.y = 390;
        this.addChild(_nextItemsBtn);
        
        _uiJpanel = new JPanel();
        _uiJpanel.setSize(new IntDimension(600, 140));
        _uiJpanel.setLayout(new EmptyLayoutUIResourse());
        _uiJpanel.setX (0);
        _uiJpanel.setY (0);
        _uiJpanel.setClipMasked(false);
        
        _storeShopBtn = new SimpleButton(getAsset("ButtonStorageUpArt"),getAsset("ButtonStorageOverArt"),getAsset("ButtonStorageDownArt"),getAsset("ButtonStorageUpArt"));
        _storeShopBtn.x = 158;
        _storeShopBtn.y = 4;
        _storeShopBtn.name = ShopModel.SHOP_TAB_WAREHOUSE;
        uiJpanel.addChild(_storeShopBtn);
        
        _roomsShopBtn = new SimpleButton(getAsset("ButtonRoomsUpArt"),getAsset("ButtonRoomsOverArt"),getAsset("ButtonRoomsDownArt"),getAsset("ButtonRoomsDownArt"));
        _roomsShopBtn.visible = false;
        _roomsShopBtn.name = ShopModel.SHOP_TAB_MAIN;
        
        uiJpanel.addChild(_roomsShopBtn);
        
        _specialShopBtn = new SimpleButton(getAsset("ButtonSpecialUpArt"),getAsset("ButtonSpecialOverArt"),getAsset("ButtonSpecialDownArt"),getAsset("ButtonSpecialUpArt"));
        _specialShopBtn.x  = 284;
        _specialShopBtn.y  = 4;
        _specialShopBtn.name = ShopModel.SHOP_TAB_BONUS;
        uiJpanel.addChild(_specialShopBtn);
        
        _moneyShopBtn = new SimpleButton(getAsset("ButtonMoneyUpArt"),getAsset("ButtonMoneyOverArt"),getAsset("ButtonMoneyDownArt"),getAsset("ButtonMoneyUpArt"));
        _moneyShopBtn.x = 400; 
        _moneyShopBtn.y = 4;
        _moneyShopBtn.name = ShopModel.SHOP_TAB_PREMIUM;
        uiJpanel.addChild(_moneyShopBtn);
        uiJpanel.setClipMasked(false);
        
        
        uiJpanel.addChild(_iconSprite);
        _iconSprite.x = 18;
        _iconSprite.y = 19;
        _iconVec.push(getAsset("IconRoomsBigArt"));       
        _iconVec.push(getAsset("IconStorageBigArt"));
        _iconVec.push(getAsset("IconSpecialBigArt"));
        _iconVec.push(getAsset("IconMoneyBigArt"));
        _iconSprite.addChild(_iconVec[1]);
        
        this.append(_uiJpanel);
        _itemsJPanel.validate();
          
    }
    public function clearIcon():void
    {
        while (iconSprite.numChildren) iconSprite.removeChildAt(0);
    }
    
    

    internal function set items(value:Array):void
    {
        clearItems();
        
        for (var i:int = 0; i < value.length; i++)
        {
            var item:Item = value[i] as Item;
            item.addEventListener(MouseEvent.CLICK, itemClickHandler);
            item.addEventListener(MouseEvent.MOUSE_OVER, itemOverHnd);
            item.addEventListener(MouseEvent.MOUSE_OUT, item_mouseOut);
            item.buttonMode = true;
            item.useHandCursor = true;
            item.mouseChildren = false;
            _itemsJPanel.append(value[i] as Item);
        }
        _itemsJPanel.validate();
    }
    public function clearItems():void
    {
         while(_itemsJPanel.getComponentCount())
        {
            (_itemsJPanel.getComponent(0)).removeEventListener(MouseEvent.CLICK, itemClickHandler);
            _itemsJPanel.removeAt(0);
        }
    }
    
  
    
  

    private function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop."+value);
    }

    internal function get closeButton():SimpleButton
    {
        return _closeButton;
    }

    internal function set closeButton(value:SimpleButton):void
    {
        _closeButton = value;
    }

    public function get prevItemsBtn():SimpleButton
    {
        return _prevItemsBtn;
    }

    public function set prevItemsBtn(value:SimpleButton):void
    {
        _prevItemsBtn = value;
    }

    public function get nextItemsBtn():SimpleButton
    {
        return _nextItemsBtn;
    }

    public function set nextItemsBtn(value:SimpleButton):void
    {
        _nextItemsBtn = value;
    }
    
    public function get itemsJPanel():JPanel 
    {
        return _itemsJPanel;
    }
    
    public function set itemsJPanel(value:JPanel):void 
    {
        _itemsJPanel = value;
    }
    
    public function get uiJpanel():JPanel 
    {
        return _uiJpanel;
    }
    
    public function set uiJpanel(value:JPanel):void 
    {
        _uiJpanel = value;
    }
    
    public function get iconVec():Vector.<Sprite> 
    {
        return _iconVec;
    }
    
    public function get roomsShopBtn():SimpleButton 
    {
        return _roomsShopBtn;
    }
    
    public function get specialShopBtn():SimpleButton 
    {
        return _specialShopBtn;
    }
    
    public function get moneyShopBtn():SimpleButton 
    {
        return _moneyShopBtn;
    }
    
    public function get storeShopBtn():SimpleButton 
    {
        return _storeShopBtn;
    }
    
    public function get iconSprite():Sprite 
    {
        return _iconSprite;
    }

    private function itemClickHandler(event:MouseEvent):void
    {
        this.dispatchEvent(new ItemEvent(ItemEvent.ITEM_CLICKED,event.currentTarget as Item));
    }
    private function itemOverHnd(e:MouseEvent):void 
    {
         this.dispatchEvent(new ItemEvent(ItemEvent.ITEM_OVERED,e.currentTarget as Item));
    }
      private function item_mouseOut(e:MouseEvent):void 
    {
          this.dispatchEvent(new ItemEvent(ItemEvent.ITEM_MOUSE_OUT,e.currentTarget as Item));
    }
}
}
