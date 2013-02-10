//Created by Action Script Viewer - http://www.buraks.com/asv
package legacy 
{
    import com.adobe.crypto.MD5;
    
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    import legacy.ContentCache;
    import legacy.IDisposable;
    
    public class ContentCache implements IDisposable 
    {

        private static var instance:ContentCache = new (ContentCache)();
        private static var _dataDirectory:String;
        private static var _gameconfigDirectory:String;
        public static var language:String = 'ru';

        private const languageToken:String = "$$";

        private var dictionnary:Object;
        private var itemsList:Array;
        private var totalSize:int = 0;
        private var budgetSize:int;
        private var pendingCount:int = 0;
        private var loader:Loader;

        public function ContentCache(budjet:int=52428800)
        {
			Security.allowDomain("*");
			
            super();
            if (instance){
                throw Error("Private constructor, use GetInstance()");
            };
            this.budgetSize = budjet;
            this.dictionnary = new Object();
            this.itemsList = new Array();
            trace((("Cache initialized (Budget: " + this.budgetSize.toString()) + ")"));
        }

        public static function getInstance():ContentCache
        {
            return (instance);
        }

        public static function get dataDirectory():String
        {
            return Config.STATIC_PATH;
        }
		
 /*       public static function getThumbnailPath(id:String):String
        {
            return ((("thumbnails/" + id.toLowerCase()) + ".png"));
        }

        public static function getThumbnail70Path(id:String):String
        {
            return ((("thumbnails70/" + id.toLowerCase()) + ".png"));
        }

        public static function getFeedPath(name:String):String
        {
            return ((("feeds/" + name.toLowerCase()) + ".jpg"));
        }

		public static function getWallPath(name:String):String
		{
			return ((("walls/" + name.toLowerCase()) + ".jpg"));
		}
		
		public static function getLocationsPath(id:String):String
		{
			return dataDirectory + 'locations/' + id + '.swf';
		}*/
		
        public function ResetPendingCounter():void
        {
            this.pendingCount = 0;
        }

        public function GetPendingCounter():int
        {
            return (this.pendingCount);
        }

        private function AddCallback(item:CacheItem, callback:Function=null, callbackContext:Object=null, errorCallback:Function=null, errorCallbackContext:Object=null):void
        {
            var cb:CacheCallback;
            if (callback != null){
                if (item.callbackFunctions == null){
                    item.callbackFunctions = new Array();
                };
                cb = new CacheCallback();
                cb.callbackFunction = callback;
                cb.callbackData = callbackContext;
                cb.errorCallbackData = errorCallbackContext;
                cb.errorCallbackFunction = errorCallback;
                item.callbackFunctions.push(cb);
            };
        }

        private function onIOError(e:IOErrorEvent):void
        {
            var loaderAsEventDispatcher:EventDispatcher = (this.loader as EventDispatcher);
            if (loaderAsEventDispatcher){
                loaderAsEventDispatcher.removeEventListener(Event.COMPLETE, this.dataArrived);
                loaderAsEventDispatcher.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                loaderAsEventDispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            };
            trace("IO error ", e.text);
            this.onError(e.target);
        }

        private function onSecurityError(e:SecurityErrorEvent):void
        {
			// message: Error #2048: Security sandbox violation.. 
			// такое случается во вконтакте при обращении к несуществующей аватаре
			if (e.text.indexOf('http://vkontakte.ru/images/question_c.gif') != -1) {
				return;
			}
			
			var loaderAsEventDispatcher:EventDispatcher = (this.loader as EventDispatcher);
        	if (loaderAsEventDispatcher){
        	    loaderAsEventDispatcher.removeEventListener(Event.COMPLETE, this.dataArrived);
        	    loaderAsEventDispatcher.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        	    loaderAsEventDispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
       		};
        	trace("Security error ", e.text);
        	this.onError(e.target);
        }

        private function onError(loader:Object):void
        {
            var item:CacheItem;
            var cacheCallBack:CacheCallback;
            this.pendingCount = Math.max(0, (this.pendingCount - 1));
            if (loader == null){
                return;
            };
            var i:int;
            while (i < this.itemsList.length) {
                item = this.itemsList[i];
                if (loader == item.dataLoader){
                    item.failed = true;
                    for each (cacheCallBack in item.callbackFunctions) {
                        if (cacheCallBack.errorCallbackFunction != null){
                            cacheCallBack.errorCallbackFunction(cacheCallBack.errorCallbackData);
                        };
                    };
                    this.itemsList.splice(i, 1);
                    break;
                };
                i++;
            };
        }

        private function dataArrived(e:Event):void
        {
            var loader:* = undefined;
            var i:* = 0;
            var item:* = null;
            var j:* = 0;
            var it:* = null;
            var e:* = e;
            loader = e.target;
            var loaderAsEventDispatcher:* = (loader as EventDispatcher);
            if (loaderAsEventDispatcher){
                loaderAsEventDispatcher.removeEventListener(Event.COMPLETE, this.dataArrived);
                loaderAsEventDispatcher.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                loaderAsEventDispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            };
            try {
                i = 0;
                while (i < this.itemsList.length) {
                    item = this.itemsList[i];
                    if (loader == item.dataLoader){
                        if ((e.target is Sound)){
                            item.data = e.target;
                            item.size = (e.target as Sound).bytesTotal;
                            this.totalSize = (this.totalSize + item.size);
                        } else {
                            item.data = loader.content;
                            item.size = loader.bytesTotal;
                            this.totalSize = (this.totalSize + item.size);
                        };
                        if (item.callbackFunctions){
                            j = 0;
                            while (j < item.callbackFunctions.length) {
                                item.callbackFunctions[j].callbackFunction(item.data, item.callbackFunctions[j].callbackData);
                                j = (j + 1);
                            };
                        };
                        if (this.totalSize > this.budgetSize){
                            this.itemsList.sortOn("lastUse");
                            while (this.totalSize > this.budgetSize) {
                                it = (this.itemsList[0] as CacheItem);
                                this.dictionnary[it.key] = null;
                                this.totalSize = (this.totalSize - it.size);
                                this.itemsList.splice(0, 1);
                            };
                        };
                        break;
                    };
                    i = (i + 1);
                };
                this.pendingCount = Math.max(0, (this.pendingCount - 1));
            } catch(e:SecurityError) {
                onError(loader);
            };
        }

        private function UrlToKey(url:String):String
        {
            url = this.Localize(url).toLowerCase();
            url = url.replace(/\\/g, "/");
            return (url);
        }

        public function getData(url:String, callback:Function=null, callbackContext:Object=null, errorCallback:Function=null, errorCallbackContext:Object=null):void
        {
            var req:URLRequest;
            var son:Sound;
            var context:LoaderContext;
            url = this.UrlToKey(url);
            if (url == ""){
                url = "CONTENT_CACHE_EMPTY_URL";
            };
            var item:CacheItem = (this.dictionnary[url] as CacheItem);
            if (item == null){
                this.pendingCount++;
                item = new CacheItem();
                item.key = url;
                item.failed = false;
                this.AddCallback(item, callback, callbackContext, errorCallback, errorCallbackContext);
                req = new URLRequest(composeHashedUrl(url));
                if (this.isSoundUrl(url)){
                    son = new Sound();
                    son.addEventListener(Event.COMPLETE, this.dataArrived, false, 0, true);
                    son.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError, false, 0, true);
                    son.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError, false, 0, true);
                    son.load(req);
                    item.dataLoader = son;
                } else {
                    this.loader = new Loader();
                    this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.dataArrived, false, 0, true);
                    this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError, false, 0, true);
                    this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError, false, 0, true);
                    if (url.indexOf("fbcdn.net") != -1){
                        context = new LoaderContext();
                        context.checkPolicyFile = true;
                        this.loader.load(req, context);
						
					} else if (url.indexOf("vkontakte.ru") != -1) {
						Security.loadPolicyFile("http://rgcdn.ru/crossdomain.xml");
						this.loader.load(req, new LoaderContext(
							false,
							ApplicationDomain.currentDomain,
							Security.sandboxType == Security.REMOTE ? SecurityDomain.currentDomain : null
						));
						
                    } else {
                        this.loader.load(req, new LoaderContext(
							false,
							ApplicationDomain.currentDomain,
							Security.sandboxType == Security.REMOTE ? SecurityDomain.currentDomain : null
						));
                    };
                    item.dataLoader = this.loader.contentLoaderInfo;
                };
                this.dictionnary[url] = item;
                this.itemsList.push(item);
            } else {
                if ((((item.data == null)) && ((item.failed == false)))){
                    this.AddCallback(item, callback, callbackContext, errorCallback, errorCallbackContext);
                } else {
                    if ((((item.data == null)) && ((item.failed == true)))){
                        if (errorCallback != null){
                            errorCallback.call(item.data, errorCallbackContext);
                        };
                    } else {
                        if (callback != null){
                            callback(item.data, callbackContext);
                        };
                    };
                };
            };
            item.lastUse = getTimer();
        }

        public function getDataNow(url:String):Object
        {
            var item:CacheItem = (this.dictionnary[this.UrlToKey(url)] as CacheItem);
            if (!(item)) {
                return (null);
            };
            return (item.data);
        }

        private function isSoundUrl(url:String):Boolean
        {
            var stxt:String = url.substr((url.lastIndexOf(".") + 1), 3);
            if ((((stxt == "mp3")) || ((stxt == "wav")))){
                return (true);
            };
            return (false);
        }

        public function Localize(url:String):String
        {
            var languageTokenIndex:int = url.indexOf(this.languageToken);
            if (languageTokenIndex != -1){
                return (url.replace(this.languageToken, ("-" + language)));
            };
            return (url);
        }

        public function dispose():void
        {
            var item:CacheItem;
            this.ResetPendingCounter();
            var i:int;
            while (i < this.itemsList.length) {
                item = this.itemsList[i];
                if (item.callbackFunctions){
                    item.callbackFunctions.length = 0;
                };
                i++;
            };
        }
		
		static public function composeHashedUrl(url:String):String
		{
				return url + '?v=' + Config.VER;
		}
		
		public function getSymbol(url:String, symbol:String, callback:Function):void
		{
			this.getData(url, function(data:Object, context:Object):void {
				var className:Object = data.loaderInfo.applicationDomain.getDefinition(symbol);
				callback(new className() as MovieClip);
			});
		}
		
		public function getSymbolNow(url:String, symbol:String):MovieClip
		{
			var data:Object = getDataNow(url);
			var className:Object = data.loaderInfo.applicationDomain.getDefinition(symbol);
			return new className() as MovieClip;
		}


    }
}//package engine.core 

class CacheCallback 
{

    public var callbackFunction:Function;
    public var callbackData:Object;
    public var errorCallbackFunction:Function;
    public var errorCallbackData:Object;

    public function CacheCallback()
    {
    }

}
class CacheItem 
{

    public var dataLoader:Object;
    public var data:Object;
    public var size:int;
    public var callbackFunctions:Array;
    public var lastUse:int;
    public var key:String;
    public var failed:Boolean;

    public function CacheItem()
    {
        super();
    }

}
class CacheSound 
{

    public function CacheSound()
    {
    }

}
