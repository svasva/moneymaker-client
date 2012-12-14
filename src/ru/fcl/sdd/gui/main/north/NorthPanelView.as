/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.north
{
import flash.display.Sprite;

import org.aswing.JLabel;

import ru.fcl.sdd.gui.textformats.StatisticNumberTextField;

import ru.fcl.sdd.rsl.GuiRsl;

public class NorthPanelView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;
    private var _bg:Sprite;

    private var _gameMoneyTextField:StatisticNumberTextField;

    [PostConstruct]
    public function init():void
    {

        _bg = rsl.getUpBarArtInstance;
        this.addChild(_bg);

        _gameMoneyTextField = new StatisticNumberTextField();
        _gameMoneyTextField.text="0";
        _gameMoneyTextField.x=30;
        _gameMoneyTextField.y=15;
        this.addChild(_gameMoneyTextField);
    }

    public function set gameMoney(value:int):void
    {
        _gameMoneyTextField.text = value.toString();
    }
}
}
