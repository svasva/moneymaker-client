/**
 * User: Jessie
 * Date: 30.11.12
 * Time: 13:56
 */
package ru.fcl.sdd.item
{
import de.polygonal.core.fmt.Sprintf;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import org.aswing.EmptyLayout;
import ru.fcl.sdd.config.FlashVarsModel;

import org.aswing.AssetBackground;
import org.aswing.BorderLayout;
import org.aswing.CenterLayout;
import org.aswing.JLabel;
import org.aswing.JLoadPane;
import org.aswing.JPanel;
import org.aswing.SoftBoxLayout;
import org.aswing.geom.IntDimension;
import org.aswing.plaf.EmptyLayoutUIResourse;
import org.aswing.plaf.EmptyUIResources;

import ru.fcl.sdd.gui.textformats.StatisticNumberTextField;

import ru.fcl.sdd.rsl.GuiRsl;

public class ItemShopView extends JPanel
{
    [Inject]
    public var rsl:GuiRsl;
    
     [Inject]
     public var flashVars:FlashVarsModel;
    
    private var _bg:DisplayObject;
    private var _iconUrl:String;
    private var _loadPane:JLoadPane;
    private var _realMoneyPriceTextField:StatisticNumberTextField;
    private var _gameMoneyPriceTextField:StatisticNumberTextField;
    private var _itemNameTf:StatisticNumberTextField;
    private var  highLightFilter:GlowFilter;
    private var  shadowFilter:DropShadowFilter;
    private var _realMoneySp:Sprite
    private var _blockedSp:Sprite;
    private var _levelNeeded:StatisticNumberTextField;
    private var _gameMoneyContainer:Sprite = new Sprite();
    


    [PostConstruct]
    public function init():void
    {
        highLightFilter = new GlowFilter();
        highLightFilter.color = 0xCCFF00;
        highLightFilter.blurX = 5;
        highLightFilter.blurY = 5;

        _bg = getAsset("ItemPlaceArt");
       // this.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,20,SoftBoxLayout.CENTER));
        this.setLayout((new EmptyLayout()));
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.setMaximumSize(new IntDimension(193, 255));
        this.setMinimumSize(new IntDimension(193, 255));
        shadowFilter = new DropShadowFilter(4, 45, 0, 1, 5, 5, 0.2);
        this.filters = [shadowFilter];

        var loadPanel:JPanel = new JPanel(new EmptyLayout());
        loadPanel.setSizeWH(155, 155);
        loadPanel.setX(21);
        loadPanel.setY(43);
        loadPane = new JLoadPane();
        loadPane.setSizeWH(155, 155);
        
        loadPanel.append(loadPane);
        this.append(loadPanel);
       
        
       
        gameMoneyContainer.addChild(getAsset("PriceRubBig"));
        gameMoneyContainer.width = 121;
        gameMoneyContainer.height = 40;
        gameMoneyPriceTextField = new StatisticNumberTextField();
        gameMoneyContainer.addChild(gameMoneyPriceTextField);
       // gameMoneyPriceTextField.width = 116;
       // gameMoneyPriceTextField.height = 30;
        gameMoneyPriceTextField.autoSize = TextFieldAutoSize.LEFT;

        gameMoneyPriceTextField.y+=7;
        gameMoneyPriceTextField.x =52;
        gameMoneyContainer.x = 32;
        gameMoneyContainer.y = 215;
        this.addChild(gameMoneyContainer);
        
        _itemNameTf = new StatisticNumberTextField();
        this.addChild(_itemNameTf);
        _itemNameTf.width = 190;        
        _itemNameTf.height = 90;
        _itemNameTf.wordWrap = true;
        var tf:TextFormat = new TextFormat()
        tf.align ="center";
        _itemNameTf.setTextFormat(tf);
        _itemNameTf.y = 12;
        
        _realMoneySp = new Sprite();
        _realMoneySp.addChild(getAsset("PriceGoldBigArt"));
        _realMoneySp.x = 32;
        _realMoneySp.y = 174;
        this.addChild(_realMoneySp);
        
        _realMoneyPriceTextField = new StatisticNumberTextField();
        realMoneySp.addChild(_realMoneyPriceTextField);
        _realMoneyPriceTextField.y = 7;
        _realMoneyPriceTextField.x = 52;
        _realMoneyPriceTextField.width = 121;
        _realMoneyPriceTextField.height = 40;
        _realMoneyPriceTextField.autoSize = TextFieldAutoSize.LEFT;
        _realMoneyPriceTextField.text = "222";
        
        _blockedSp = new Sprite();
        _blockedSp.addChild(getAsset("LockedItem"));
        addChild(_blockedSp);
        _blockedSp.x = 36;
        _blockedSp.y = 70;
        _levelNeeded = new StatisticNumberTextField();
        _levelNeeded.text = "kfkfk";
        _levelNeeded.y = 126;
        
        _blockedSp.addChild(_levelNeeded);
        
        
        
          
        
    }

    public function getAsset(value:String):DisplayObject
    {
        return rsl.getAsset("gui.ingame.shop." + value);
    }

    public function get iconUrl():String
    {
        return _iconUrl;
    }

    public function set iconUrl(value:String):void
    {
        _iconUrl = value;
        loadPane.load(new URLRequest(value));
    }

    public function get loadPane():JLoadPane
    {
        return _loadPane;
    }

    public function set loadPane(value:JLoadPane):void
    {
        _loadPane = value;
    }

    public function get realMoneyPriceTextField():StatisticNumberTextField
    {
        return _realMoneyPriceTextField;
    }

    public function set realMoneyPriceTextField(value:StatisticNumberTextField):void
    {
        _realMoneyPriceTextField = value;
    }

    public function get gameMoneyPriceTextField():StatisticNumberTextField
    {
        return _gameMoneyPriceTextField;
    }

    public function set gameMoneyPriceTextField(value:StatisticNumberTextField):void
    {
        _gameMoneyPriceTextField = value;
    }

    override public function set buttonMode(value:Boolean):void
    {
        if (value)
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        } else
        {
            this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        }
        super.buttonMode = value;
    }
    
    public function get itemNameTf():StatisticNumberTextField 
    {
        return _itemNameTf;
    }
    
    public function set itemNameTf(value:StatisticNumberTextField):void 
    {
        _itemNameTf = value;
    }
    
    public function get realMoneySp():Sprite 
    {
        return _realMoneySp;
    }
    
    public function get blockedSp():Sprite 
    {
        return _blockedSp;
    }
    
    public function set blockedSp(value:Sprite):void 
    {
        _blockedSp = value;
    }
    
    public function get levelNeeded():StatisticNumberTextField 
    {
        return _levelNeeded;
    }
    
    public function set levelNeeded(value:StatisticNumberTextField):void 
    {
        _levelNeeded = value;
    }
    
    public function get gameMoneyContainer():Sprite 
    {
        return _gameMoneyContainer;
    }
    
    public function set gameMoneyContainer(value:Sprite):void 
    {
        _gameMoneyContainer = value;
    }
    
    

    private function mouseOverHandler(event:MouseEvent):void
    {
        this.filters = [highLightFilter, shadowFilter];
    }

    private function mouseOutHandler(event:MouseEvent):void
    {
        this.filters = [shadowFilter];
    }
}
}
