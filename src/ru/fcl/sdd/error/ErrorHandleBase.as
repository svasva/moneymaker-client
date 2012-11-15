/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 16:21
 */
package ru.fcl.sdd.error
{
import mx.controls.Alert;
import mx.core.UIComponent;

public class ErrorHandleBase
{
    protected var viewTarget:UIComponent;
    protected var _silentMode:Boolean = false;

    public function init(viewTarget:UIComponent):void
    {
        this.viewTarget = viewTarget;
    }

    public function get silentMode():Boolean
    {
        return _silentMode;
    }

    public function set silentMode(value:Boolean):void
    {
        _silentMode = value;
    }

    protected function showError(title:String, text:String):void
    {
        if(!silentMode)
        {
            Alert.show(title, text,4,viewTarget);
        }
    }
}
}
