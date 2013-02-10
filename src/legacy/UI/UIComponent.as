//Created by Action Script Viewer - http://www.buraks.com/asv
package engine.core.UI 
{
    import flash.display.*;

    public class UIComponent extends Sprite 
    {

        private var _helpString:String;
        protected var _saveHelpString:String = null;

        public function UIComponent()
        {
        }

        public function get helpString():String
        {
            return (this._helpString);
        }

        public function set helpString(value:String):void
        {
            if (value == null){
                return;
            };
            this._helpString = value;
            if (!(this._saveHelpString)){
                this._saveHelpString = value;
            };
        }


    }
}//package engine.core.UI 
