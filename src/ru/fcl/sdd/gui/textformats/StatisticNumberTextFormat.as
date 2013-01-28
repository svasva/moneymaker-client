/**
 * User: Jessie
 * Date: 14.12.12
 * Time: 11:32
 */
package ru.fcl.sdd.gui.textformats
{
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class StatisticNumberTextFormat extends TextFormat
{
    [Embed(source="./assets/AVA_LDB.TTF", fontFamily="a_AvanteLdb", mimeType="application/x-font", embedAsCFF="false")]
    private var  _fontLDB:Class;

    public function StatisticNumberTextFormat():void
    {
        align = TextFormatAlign.CENTER;
        color = 0xe2e8b9;
        font = "a_AvanteLdb";
        size = 16;
    }
}
}
