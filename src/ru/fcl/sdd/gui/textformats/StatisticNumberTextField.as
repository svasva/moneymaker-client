/**
 * User: Jessie
 * Date: 14.12.12
 * Time: 12:34
 */
package ru.fcl.sdd.gui.textformats
{
import flash.filters.GlowFilter;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;


public class StatisticNumberTextField extends TextField
{
    public function StatisticNumberTextField():void
    {
        embedFonts = true;
        defaultTextFormat = new StatisticNumberTextFormat();
        antiAliasType = AntiAliasType.NORMAL;
        selectable = false;
//        maxChars = 7;
        multiline=false;
		//autoSize = TextFieldAutoSize.RIGHT;

        //***effects*****
        filters = [new GlowFilter(0x733923,1,4,4,5)];
    }
}
}
