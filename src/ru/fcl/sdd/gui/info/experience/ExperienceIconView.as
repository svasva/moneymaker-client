/**
 * User: Jessie
 * Date: 18.01.13
 * Time: 16:31
 */
package ru.fcl.sdd.gui.info.experience
{
import flash.display.DisplayObject;
import flash.display.Sprite;

import ru.fcl.sdd.gui.textformats.StatisticNumberTextField;
import ru.fcl.sdd.homus.ClientusIsoView;
import ru.fcl.sdd.rsl.GuiRsl;

public class ExperienceIconView extends Sprite
{
    private var valueTextField:StatisticNumberTextField;
    private var icon:DisplayObject;

    [Inject]
    public var rsl:GuiRsl;

    public function setValue(value:int):void
    {
        valueTextField = new StatisticNumberTextField();
        if (value > 0)
        {
            icon = getAssets("Reputation4Art");
            valueTextField.text = "+" + value.toString();
        }else
        {
            icon = getAssets("Reputation4Art");
            valueTextField.text = "-" + value.toString();
        }
        addChild(icon);
        valueTextField.x = icon.width+10;
        addChild(valueTextField);
    }

    private function getAssets(value:String):DisplayObject
    {
        return rsl.getAsset("panels." + value);
    }
}
}
