/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 12:38
 */
package ru.fcl.sdd.rsl
{
import flash.display.Sprite;

public class MainInterfaceRsl extends RslLoader implements IRsl,IRslLoader
{
    public static const UP_INTERFACE:String = "NorthMainInterface.swf";
    public static const MAIN_CONTROL_PANEL:String = "MainControlPanel.swf";

    public function get isReady():Boolean
    {
        return _isReady;
    }

    public function get buttonGoldDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonGoldOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonGoldUpArtInstance():Sprite
    {
        return null;
    }

    public function get buttonLvlDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonLvlOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonLvlUpArtInstance():Sprite
    {
        return null;
    }

    public function get buttonMoneyDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonMoneyOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonMoneyUpArtInstance():Sprite
    {
        return null;
    }

    public function get buttonReputationDownArtInstance():Sprite
    {
        return null;
    }

    public function get buttonReputationOverArtInstance():Sprite
    {
        return null;
    }

    public function get buttonReputationUpArtInstance():Sprite
    {
        return null;
    }

    public function get reputation1ArtInstance():Sprite
    {
        return null;
    }

    public function get reputation2ArtInstance():Sprite
    {
        return null;
    }

    public function get reputation3ArtInstance():Sprite
    {
        return null;
    }

    public function get reputation4ArtInstance():Sprite
    {
        return null;
    }

    public function get barArtInstance():Sprite
    {
        return null;
    }

}
}
