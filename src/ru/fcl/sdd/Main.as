/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 16:16
 */
package ru.fcl.sdd
{
import flash.display.Sprite;
[SWF(width=800, height=800)]
public class Main extends Sprite
{
    private var context:SDDContext;
    public function Main()
    {
        context = new SDDContext(this);
    }
}
}
