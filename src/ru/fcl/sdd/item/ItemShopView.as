/**
 * User: Jessie
 * Date: 30.11.12
 * Time: 13:56
 */
package ru.fcl.sdd.item
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;

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
    
    private var _bg:DisplayObject;
    private var _iconUrl:String;
    private var _loadPane:JLoadPane;
    private var _realMoneyPriceTextField:StatisticNumberTextField;
    private var _gameMoneyPriceTextField:StatisticNumberTextField;
    private var  highLightFilter:GlowFilter;
    private var  shadowFilter:DropShadowFilter;


    [PostConstruct]
    public function init():void
    {
        highLightFilter = new GlowFilter();
        highLightFilter.color = 0xCCFF00;
        highLightFilter.blurX = 5;
        highLightFilter.blurY = 5;

        _bg = getAsset("ItemPlaceArt");
        this.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS,20,SoftBoxLayout.CENTER));
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.setMaximumSize(new IntDimension(193, 255));
        this.setMinimumSize(new IntDimension(193, 255));
        shadowFilter = new DropShadowFilter(4, 45, 0, 1, 5, 5, 0.2);
        this.filters = [shadowFilter];

        var loadPanel:JPanel = new JPanel(new CenterLayout());
        loadPane = new JLoadPane();
        loadPanel.append(loadPane);
        this.append(loadPanel);

        var gameMoneyContainer:Sprite = new Sprite();
        gameMoneyContainer.addChild(getAsset("PriceRubBig"));
        gameMoneyContainer.width = 121;
        gameMoneyContainer.height = 40;
        gameMoneyPriceTextField = new StatisticNumberTextField();
        gameMoneyContainer.addChild(gameMoneyPriceTextField);
        gameMoneyPriceTextField.width = 116;
        gameMoneyPriceTextField.height = 30;

        gameMoneyPriceTextField.y+=7;
        gameMoneyContainer.x = 37;
        gameMoneyContainer.y = 207;

        this.addChild(gameMoneyContainer);
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
