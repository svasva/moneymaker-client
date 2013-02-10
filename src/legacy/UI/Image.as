//Created by Action Script Viewer - http://www.buraks.com/asv
package engine.core.UI 
{
    import flash.geom.*;
    import flash.events.*;
    import flash.ui.*;
    import engine.core.*;
    import flash.display.*;

    public class Image extends UIComponent 
    {

        protected static const identityMatrix:Matrix = new Matrix();

        private var _asyncloader:AsyncLoader = null;
        private var _forceAsyncLoader:Boolean = false;
        private var _loadingImage:String = null;
        private var _tempPath:String = null;
        private var _path:String = null;

        public function Image(imwidth:int=0, imheight:int=0, imagePath:String=null, relativePath:Boolean=true)
        {
            super();
            graphics.beginFill(4474009, 0.05);
            graphics.drawRect(0, 0, imwidth, imheight);
            graphics.endFill();
            if (imagePath != null){
                if (relativePath){
                    SetImageRelative(imwidth, imheight, imagePath);
                } else {
                    SetImageAbsolute(imwidth, imheight, imagePath);
                };
            };
            addEventListener(MouseEvent.ROLL_OUT, rollOut);
            addEventListener(MouseEvent.ROLL_OVER, rollOver);
        }

        public function get path():String
        {
            return (_path);
        }

        public function set forceAsyncLoader(value:Boolean):void
        {
            _forceAsyncLoader = value;
        }

        public function set loadingImage(value:String):void
        {
            _loadingImage = value;
        }

        public function get loading():Boolean
        {
            return (!((_asyncloader == null)));
        }

        public function set loading(value:Boolean):void
        {
            if (((value) && (!(_asyncloader)))){
                if (_loadingImage){
                    _tempPath = _path;
                    SetImageRelative(width, height, _loadingImage);
                };
                _forceAsyncLoader = true;
                UpdateAsyncLoader((width * 1.2), (height * 0.9));
                _asyncloader.width = (_asyncloader.width * 0.5);
                _asyncloader.height = (_asyncloader.height * 0.5);
            } else {
                if (((!(value)) && (_asyncloader))){
                    removeChild(_asyncloader);
                    _asyncloader.dispose();
                    _asyncloader = null;
                    if (_loadingImage){
                        SetImageRelative(width, height, _tempPath);
                    };
                };
            };
        }

        private function rollOut(e:MouseEvent):void
        {
            Mouse.cursor = MouseCursor.ARROW;
        }

        private function rollOver(e:MouseEvent):void
        {
            if (buttonMode){
                Mouse.cursor = MouseCursor.BUTTON;
            };
        }

        public function SetImageRelative(width:int, height:int, imagePath:String):void
        {
            _path = imagePath;
            UpdateAsyncLoader(width, height);
            if (((imagePath) && ((imagePath.length > 0)))){
                ContentCache.getInstance().getData((ContentCache.dataDirectory + imagePath), BitmapReady, new SPoint(width, height), errorCallBack, null);
            } else {
                errorCallBack(null);
            };
        }

        private function UpdateAsyncLoader(width:int, height:int):void
        {
            if ((((((((width > 70)) && ((height > 70)))) || (_forceAsyncLoader))) && (!(_asyncloader)))){
                _asyncloader = new AsyncLoader();
                addChild(_asyncloader);
            };
            if (_asyncloader){
                _asyncloader.x = (width * 0.5);
                _asyncloader.y = (height * 0.5);
            };
        }

        public function SetImageAbsolute(width:int, height:int, imagePath:String):void
        {
            _path = imagePath;
            UpdateAsyncLoader(width, height);
            if (((imagePath) && ((imagePath.length > 0)))){
                ContentCache.getInstance().getData(imagePath, BitmapReady, new SPoint(width, height), errorCallBack, null);
            } else {
                errorCallBack(null);
            };
        }

        protected function BitmapReady(bitmap:Bitmap, context):void
        {
            var size:SPoint = (context as SPoint);
            graphics.clear();
            graphics.beginBitmapFill(bitmap.bitmapData, identityMatrix, false);
            graphics.drawRect(0, 0, size.x, size.y);
            graphics.endFill();
            if (_asyncloader){
                removeChild(_asyncloader);
                _asyncloader.dispose();
                _asyncloader = null;
            };
            if (hasEventListener(Event.COMPLETE)){
                dispatchEvent(new Event(Event.COMPLETE));
            };
        }

        public function errorCallBack(data):void
        {
            if (_asyncloader){
                removeChild(_asyncloader);
                _asyncloader.dispose();
                _asyncloader = null;
            };
            if (hasEventListener(ErrorEvent.ERROR)){
                dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
            };
        }


    }
}//package engine.core.UI 
