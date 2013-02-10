//Created by Action Script Viewer - http://www.buraks.com/asv
package legacy.UI 
{
    import com.adobe.serialization.json.JSON;
    
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    

    public class Text extends TextField 
    {

        private var _opaqueBackgroundWhenTranslationFails:Boolean = false;
        private var hlRatio:Number = 0;

        public function Text(templateTextField:TextField=null, opaqueBackgroundWhenTranslationFails:Boolean=false)
        {
            super();
            _opaqueBackgroundWhenTranslationFails = opaqueBackgroundWhenTranslationFails;
            var templateTextFormat:TextFormat;
            antiAliasType = AntiAliasType.ADVANCED;
            autoSize = TextFieldAutoSize.LEFT;
            selectable = false;
            if (templateTextField){
                template = templateTextField;
            };
        }

        public static function centerInBox(text:Text, upperLeftCornerX:int, upperLeftCornerY:int, lowerRightCornerX:int, lowerRightCornerY:int, wordWrap:Boolean = true):void
        {
            text.autoSize = TextFieldAutoSize.CENTER;
            text.x = upperLeftCornerX;
            text.width = (lowerRightCornerX - upperLeftCornerX);
            text.wordWrap = wordWrap;
            text.y = (upperLeftCornerY + (((lowerRightCornerY - upperLeftCornerY) - text.height) * 0.5));
        }


        public function get realTextWidth():Number
        {
            if (text.length == 0){
                return (0);
            };
            if (text.charAt((text.length - 1)) != " "){
                return (textWidth);
            };
            var tmp:String = text;
            rawText = "-";
            var w:Number = textWidth;
            rawText = (tmp + "-");
            var ret:Number = (textWidth - w);
            rawText = tmp;
            return (ret);
        }

        public function set template(value:TextField):void
        {
            filters = value.filters;
            defaultTextFormat = value.getTextFormat();
            embedFonts = value.embedFonts;
			styleSheet = value.styleSheet;
        }

        override public function set text(value:String):void
        {
            super.text = value;
        }

        public function set rawText(value:String):void
        {
            super.text = value;
        }

        public function set size(value:int):void
        {
            var textFormat:TextFormat = getTextFormat();
			if (defaultTextFormat.font == 'Charcoal CY' && defaultTextFormat.size == 15) {
				textFormat.size = value-4;
			} else
			if (defaultTextFormat.font == 'Charcoal CY' && defaultTextFormat.size == 16) {
				textFormat.size = value-4;
			} else
			if (defaultTextFormat.font == 'Charcoal CY' && defaultTextFormat.size == 17) {
				textFormat.size = value-4;
			} else
			if (defaultTextFormat.font == 'Charcoal CY' && defaultTextFormat.size == 18) {
				textFormat.size = value-4;
			} else
			if (defaultTextFormat.font == 'PT Sans Caption' && defaultTextFormat.size == 15) {
				textFormat.size = value-4;
			} else
			if (defaultTextFormat.font == 'PT Sans Caption' && defaultTextFormat.size == 17) {
				textFormat.size = value-7;
			}
			else textFormat.size = value-4; 
            defaultTextFormat = textFormat;
        }

        public function set align(value:String):void
        {
            var textFormat:TextFormat = getTextFormat();
            textFormat.align = value;
            defaultTextFormat = textFormat;
        }

        public function highLight():void
        {
            if (hlRatio == 0){
                addEventListener(Event.ENTER_FRAME, onUpdateHighlight);
            };
            hlRatio = 1;
        }

        private function onUpdateHighlight(e:Event):void
        {
            transform.colorTransform = new ColorTransform(1, 1, 1, 1, (hlRatio * 150), (hlRatio * 150), (hlRatio * 100));
            hlRatio = (hlRatio - 0.03);
            if (hlRatio <= 0){
                hlRatio = 0;
                removeEventListener(Event.ENTER_FRAME, onUpdateHighlight);
            };
        }


    }
}//package engine.core.UI 
