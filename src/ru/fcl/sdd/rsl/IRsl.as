/**
 * User: Jessie
 * Date: 20.11.12
 * Time: 12:33
 */
package ru.fcl.sdd.rsl
{
import flash.display.Sprite;

public interface IRsl
{
    function get isReady():Boolean;

    function get buttonGoldDownArtInstance():Sprite;

    function get buttonGoldOverArtInstance():Sprite;

    function get buttonGoldUpArtInstance():Sprite;

    function get buttonLvlDownArtInstance():Sprite;

    function get buttonLvlOverArtInstance():Sprite;

    function get buttonLvlUpArtInstance():Sprite;

    function get buttonMoneyDownArtInstance():Sprite;

    function get buttonMoneyOverArtInstance():Sprite;

    function get buttonMoneyUpArtInstance():Sprite;

    function get buttonReputationDownArtInstance():Sprite;

    function get buttonReputationOverArtInstance():Sprite;

    function get buttonReputationUpArtInstance():Sprite;

    function get reputation1ArtInstance():Sprite;

    function get reputation2ArtInstance():Sprite;

    function get reputation3ArtInstance():Sprite;

    function get reputation4ArtInstance():Sprite;

    function get getBarArtInstance():Sprite;
}
}
