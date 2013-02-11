/**
 * User: Jessie
 * Date: 28.11.12
 * Time: 14:37
 */
package ru.fcl.sdd.gui.main.tutorial
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.getDefinitionByName;
import mx.core.SpriteAsset;
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

public class TutorialView extends Sprite
{
    [Inject]
	 public var rsl:GuiRsl;
    private var _bg:DisplayObject;
    private var _closeButton:SimpleButton;
	private var _title:TextField;
	private var _title2:TextField;
	
	private var _text:TextField;
   
    private var _prevStepBtn:SimpleButton;
    private var _nextStepBtn:SimpleButton;
	private var _Secreture:DisplayObject;
	
    private var _screens:Vector.<Screen> = new Vector.<Screen>();
	private var content:Sprite = new Sprite;
	
	private var curr_screen:int = 0;
    
	public function TutorialView():void
	{
		init();
		addEventListener(Event.REMOVED_FROM_STAGE, clear);
	}
	
	private function clear(e:Event):void
	{
		_prevStepBtn.removeEventListener(MouseEvent.CLICK, onPrev);
		_nextStepBtn.removeEventListener(MouseEvent.CLICK, onNext);
		_closeButton.removeEventListener(MouseEvent.CLICK, onClose);
		removeChild(_bg);
		removeChild(_prevStepBtn);
		removeChild(_nextStepBtn);
		removeChild(content);
		removeChild(_closeButton);
		_screens.length = 0;
	
	}

    [PostConstruct]
    public function init():void
    {
       
       _bg = new BackGround();
		addChild(_bg);
		content.x = 217;
		content.y = 92;
		addChild(content);
	
        _closeButton = new SimpleButton(new CloseUpArt(),new CloseOverArt(),new CloseDownArt(), new CloseUpArt());
        _closeButton.x = 705;
        _closeButton.y = 10;
        addChild(_closeButton);
		_closeButton.addEventListener(MouseEvent.CLICK, onClose);
		
		_Secreture =  new Secretary();
		_Secreture.x = 9;
		_Secreture.y = 54;
		addChild(_Secreture);

        _prevStepBtn =new SimpleButton(new LeftArrowUpArt(),new LeftArrowOverArt(),new LeftArrowDownArt(), new LeftArrowUpArt());
        _prevStepBtn.x = 458;
        _prevStepBtn.y = 36;
        addChild(_prevStepBtn); 
		_prevStepBtn.addEventListener(MouseEvent.CLICK, onPrev);

        _nextStepBtn = new SimpleButton( new RightArrowUpArt(), new RightArrowOverArt(),new RightArrowUpArt(), new RightArrowUpArt());
        _nextStepBtn.x = 673;
        _nextStepBtn.y = 36;
        this.addChild(_nextStepBtn);
		_nextStepBtn.addEventListener(MouseEvent.CLICK, onNext);
		
		_title = createTitle(40);
		_title.x = 260;
		_title.y = 15;
		_title.text = "Справка";
		addChild(_title);
		_title2 = createTitle(30);
		_title2.x = 492;
		_title2.y = 15;
	
		addChild(_title2);
		_text = createText(16);
		_text.x = 231;
		_text.y = 546;
		addChild(_text);
		
		 sc = new Screen(new screen1, "главный\nэкран", "На главном экране есть все основные элементы управления игрой, здесь можно видеть ресурсы банка, его внутреннее убранство, его клиентов и получить доступ к различным игровым меню.");
		_screens.push(sc);		
		sc = new Screen(new screen4, "объекты\nв банке", "В помещении банка можно выбрать любой активный объект и путем несложных манипуляций поменять его местоположение, повернуть, убрать на склад или посмотреть информацию о нем.");
		_screens.push(sc);		
		sc = new Screen(new screen3, "игровой\nпроцесс", " Специальные иконки, появляющиеся над некоторыми объектами в банке - покажут что происходит в банке в данный момент. Кликая на такие объекты, можно получить дополнительные ресурсы для развития банка.");
		_screens.push(sc);
		var sc:Screen = new Screen(new screen2, "магазин", "В магазине можно купить множество предметов для банка. Набирая уровни и достаточное количество средств можно значительно улучшить как обстановку в помещениях банка, так и его работу в общем.");
		_screens.push(sc);
		
		
		content.addChild((_screens[curr_screen] as Screen).sp);
		_text.text = (_screens[curr_screen] as Screen).text;
		_title2.text = (_screens[curr_screen] as Screen).title;
		_text.multiline = true;
		_text.wordWrap = true;
		_text.width = 458;
		_text.height = 52;
       /* _uiJpanel = new JPanel();
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
        _itemsJPanel.validate();*/
          
    }
	
	private function createText(size:int):TextField
	{
		var text:TextField = new TextField();
		var fmt:TextFormat = text.getTextFormat();
        fmt.size = size;
		fmt.letterSpacing = 0;
		fmt.color = 0x4C2D00;
		text.defaultTextFormat = fmt;	
		
		text.antiAliasType =  AntiAliasType.NORMAL;
		text.autoSize = TextFieldAutoSize.LEFT;
		return text;
	}
	
	
	private function createTitle(size:int):TextField
	{
		var title:TextField = new TextField();
		var fmt:TextFormat = title.getTextFormat();
        fmt.size = size;
		fmt.letterSpacing = -0.2;
		fmt.color = 0xFFF772;
		title.defaultTextFormat = fmt;
		title.filters = [new GlowFilter(0x763E1B, 1, 6, 6, 2000), new GlowFilter(0xFFFCFB, 1, 6, 6, 3000), new DropShadowFilter(5, 75, 0x909A43, 1, 2, 2, 5000)];
		
		title.antiAliasType =  AntiAliasType.NORMAL;
		title.autoSize = TextFieldAutoSize.LEFT;
		return title;
	}
	
	private function onClose(e:MouseEvent):void
	
	{
		this.visible = false;
	}
	private function onNext(e:MouseEvent):void
	{
		curr_screen++;
		if (curr_screen > _screens.length-1 )
		curr_screen--;
		
		content.removeChildAt(0);
		
		content.addChild((_screens[curr_screen] as Screen).sp);
		_title2.text = (_screens[curr_screen] as Screen).title;
		_text.text = (_screens[curr_screen] as Screen).text;
		
		
	}
	private function onPrev(e:MouseEvent):void
	{
		curr_screen--;
		if (curr_screen <0 )
		curr_screen = 0;
		content.removeChildAt(0);
		content.addChild(_screens[curr_screen].sp);
		_title2.text = (_screens[curr_screen] as Screen).title;
		_text.text = (_screens[curr_screen] as Screen).text;
		
	}
	  internal function get closeButton():SimpleButton
    {
        return _closeButton;
    }
	 private function getAsset(value:String):DisplayObject
    {
		var sp:Sprite  = new Sprite();
		sp = getDefinitionByName("ru.fcl.sdd.gui.main.tutorial." + value) as Sprite;
        return sp;
    }

  /*  public function clearIcon():void
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
    }*/
}
}
