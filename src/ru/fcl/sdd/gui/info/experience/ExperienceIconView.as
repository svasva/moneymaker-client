/**
 * User: Jessie
 * Date: 18.01.13
 * Time: 16:31
 */
package ru.fcl.sdd.gui.info.experience
{
import flash.display.Sprite;

import ru.fcl.sdd.gui.textformats.StatisticNumberTextField;

public class ExperienceIconView extends Sprite
{
    private var value:int;
    private var valueTextField:StatisticNumberTextField;

    public function ExperienceIconView(value:int)
    {
        valueTextField = new StatisticNumberTextField();
        addChild(valueTextField);
        valueTextField.text = value.toString();
    }
}
}
