//Created by Action Script Viewer - http://www.buraks.com/asv
package legacy 
{
    import legacy.ContentCache;
    import legacy.FailCodes;
    import legacy.ILoadingIndicator;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class ContentLoader extends EventDispatcher 
    {

        private static const FAKE_PREFETCHED_FILE_SIZE:Number = 0x2800;

        private var _filesInfos:Array = null;
        private var _loadingIndicator:legacy.ILoadingIndicator = null;
        private var _loader:URLLoader = null;
        private var _lastLoaderBytesLoaded:int = 0;
        private var _lastMainSWFLoaderBytesLoaded:int = 0;
        private var _fileBeingLoadedURL:String = null;
        private var _loadedFiles:Dictionary = null;
        private var _loadingFiles:Boolean = false;
		
		public var loadFinished:Boolean = false;

        public function ContentLoader()
        {
            super();
            this._filesInfos = new Array();
            this._loader = new URLLoader();
            this._loadedFiles = new Dictionary();
        }

        public function init(loadingIndicator:ILoadingIndicator):void
        {
            this._loadingIndicator = loadingIndicator;
            this._loader.addEventListener(Event.COMPLETE, this.onURLLoaderComplete);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onURLLoaderIOError);
        }

        public function onURLLoaderIOError(e:IOErrorEvent):void
        {
			trace("IOError on loading file" + this._fileBeingLoadedURL + ". This file will be skipped.");
            //DebugConsole.Exception((("IOError on loading file" + this._fileBeingLoadedURL) + ".This file will be skipped."));
            var fi:FileInfo = this.getFileBeingLoaded();
            if (((fi) && (fi.failIfNotLoaded))){
				throw new Error('Crazy shit happened: ' + FailCodes.INITIALIZATION_FILE_NOT_FOUND + ', ' + this._fileBeingLoadedURL);
                //ErrorManager.getInstance().failWithCode_tValue(FailCodes.INITIALIZATION_FILE_NOT_FOUND, this._fileBeingLoadedURL, true);
            } else {
                if (this._filesInfos.length > 0){
                    this.loadNextFile();
                } else {
                    this.onURLLoaderComplete(null);
                };
            };
        }

        private function getFileBeingLoaded():FileInfo
        {
            var fi:FileInfo;
            for each (fi in this._filesInfos) {
                if (fi.path == this._fileBeingLoadedURL){
                    return (fi);
                };
            };
            return (null);
        }

        private function onURLLoaderComplete(e:Event):void
        {
            this._lastLoaderBytesLoaded = 0;
            this._loadedFiles[this._fileBeingLoadedURL] = this._loader.data;
            var fi:FileInfo = this.getFileBeingLoaded();
            if (fi.path) {
                this._loadingIndicator.current = (this._loadingIndicator.current + fi.estimatedSize);
            }
            var fileInfo:FileInfo = this._filesInfos.pop();
			//Slog.log('onURLLoaderComplete: ' + fileInfo.path);
			//Slog.log('length=' + this._filesInfos.length.toString() + '; current=' + this._loadingIndicator.current.toString() + '; total=' + this._loadingIndicator.total.toString());
            if (this._filesInfos.length > 0){
                this.loadNextFile();
            } else {
				// alex 
                if (this._loadingIndicator.current >= this._loadingIndicator.total){
                    this._loadingFiles = false;
                    dispatchEvent(new Event(Event.COMPLETE));
                }
            }
        }

        public function queueFile(filePath:String, estimatedSize:int, dataFormat:String="text", failIfNotLoaded:Boolean=true):void
        {
            if (this._loadingFiles){
				trace("ContentLoader is now loading files, wait for him to finish before queue new files to load");
                //DebugConsole.Exception("ContentLoader is now loading files, wait for him to finish before queue new files to load");
                return;
            }
            this._loadingIndicator.total = (this._loadingIndicator.total + estimatedSize);
            var fileInfo:FileInfo = new FileInfo();
            fileInfo.path = filePath;
            fileInfo.format = dataFormat;
            fileInfo.estimatedSize = estimatedSize;
            fileInfo.failIfNotLoaded = failIfNotLoaded;
            this._filesInfos.push(fileInfo);
			//Slog.log('queueFile: ' + filePath);
			//Slog.log('length=' + this._filesInfos.length.toString() + '; current=' + this._loadingIndicator.current.toString() + '; total=' + this._loadingIndicator.total.toString());
        }

        public function prefetchFile(filePath:String):void
        {
            if (this._loadingFiles){
                throw new Error("ContentLoader is now loading files, wait for him to finish before queue new files to load");
                return;
            };
            this._loadingIndicator.total = (this._loadingIndicator.total + FAKE_PREFETCHED_FILE_SIZE);
            ContentCache.getInstance().getData(filePath, this.onPrefetchFile, null, this.onFailedPrefetchFile, filePath);
        }

        public function onPrefetchFile(object:*, context:*):void
        {
            this._loadingIndicator.current = (this._loadingIndicator.current + FAKE_PREFETCHED_FILE_SIZE);
            if (this._loadingIndicator.current >= this._loadingIndicator.total){
                this._loadingFiles = false;
                dispatchEvent(new Event(Event.COMPLETE));
            };
        }

        public function onFailedPrefetchFile(path:String):void
        {
			throw new Error("Failed prefetching : " + path);
			
            this._loadingIndicator.current = (this._loadingIndicator.current + FAKE_PREFETCHED_FILE_SIZE);
            if (this._loadingIndicator.current >= this._loadingIndicator.total){
                this._loadingFiles = false;
                dispatchEvent(new Event(Event.COMPLETE));
            };
        }

        public function loadFiles():void
        {
            this._loadingFiles = true;
            this.loadNextFile();
        }

        public function getData(avatarItemsXmlPath:String):Object
        {
            return (this._loadedFiles[avatarItemsXmlPath]);
        }

        public function get loadingIndicator():ILoadingIndicator
        {
            return (this._loadingIndicator);
        }

        private function loadNextFile():void
        {
            if (this._filesInfos.length == 0){
				//dispatchEvent(new Event(Event.COMPLETE));
                return;
            };
            var fileInfo:FileInfo = this._filesInfos[(this._filesInfos.length - 1)];
            this._fileBeingLoadedURL = fileInfo.path;
            var request:URLRequest = new URLRequest(this._fileBeingLoadedURL);
            this._loader.dataFormat = fileInfo.format;
            this._loader.load(request);
        }


    }
}//package engine.core 

class FileInfo 
{

    public var path:String;
    public var format:String;
    public var estimatedSize:int;
    public var failIfNotLoaded:Boolean;

    public function FileInfo()
    {
    }

}
