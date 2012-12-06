/**
 * User: Jessie
 * Date: 30.11.12
 * Time: 13:56
 */
package ru.fcl.sdd.item
{
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;

import org.aswing.AssetBackground;
import org.aswing.CenterLayout;
import org.aswing.JLabel;
import org.aswing.JLoadPane;
import org.aswing.JPanel;
import org.aswing.geom.IntDimension;

import ru.fcl.sdd.rsl.GuiRsl;

public class ItemShopView extends JPanel
{
    [Inject]
    public var rsl:GuiRsl;
    private var _bg:DisplayObject;
    private var _iconUrl:String;
    private var _loadPane:JLoadPane;
    private var _realPriceLabel:JLabel;
    private var _goldPriceLabel:JLabel;
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
        this.setLayout(new CenterLayout());
        this.setBackgroundDecorator(new AssetBackground(_bg));
        this.setMaximumSize(new IntDimension(193, 255));
        this.setMinimumSize(new IntDimension(193, 255));
        shadowFilter = new DropShadowFilter(4, 45, 0, 1, 5, 5, 0.2);
        this.filters = [shadowFilter];

        loadPane = new JLoadPane();
        this.append(loadPane);

        realPriceLabel = new JLabel("1024");
        realPriceLabel.setBackgroundDecorator(new AssetBackground(getAsset("PriceGoldSmallArt")));
        this.append(realPriceLabel);
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

    public function get realPriceLabel():JLabel
    {
        return _realPriceLabel;
    }

    public function set realPriceLabel(value:JLabel):void
    {
        _realPriceLabel = value;
    }

    public function get goldPriceLabel():JLabel
    {
        return _goldPriceLabel;
    }

    public function set goldPriceLabel(value:JLabel):void
    {
        _goldPriceLabel = value;
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
