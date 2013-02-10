package head.friendpanel
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.*;
	
	public class FriendCardPhoto extends Sprite
	{
		private var _photoWidth:int = 0;
		private var _photoHeight:int = 0;
		
		private var _photo:DisplayObject;
		private var _photoBitmap:Bitmap;
		private var _photoLoader:Loader;

		private var _photoURL:String = null;
		private var _noSpace:Boolean;
		
		private var _mask:DisplayObject;
		
		public function FriendCardPhoto()
		{
			super();
		}
		
		public function init(url:String = null, photoWidth:int = 50, photoHeight:int = 0, mask:DisplayObject = null):void
		{
			_photoWidth = photoWidth;
			_photoHeight = photoHeight;

			_noSpace = false;
			
			_mask = mask;
			
			loadPhoto(url);
		}
		
		public function loadPhoto(url:String = null):void
		{
			if (_photoURL == url) return;
			_photoURL = url;
			
			if (url == null || url == '') {
				return;
			}
			
			if (_photoLoader == null) {
				_photoLoader = new Loader();
			}
			
			_photoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPhotoLoadSuccess);

			_photoLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onPhotoLoadError);
			
			try	{
				_photoLoader.load(
					new URLRequest(url),
					new LoaderContext(
						true,
						ApplicationDomain.currentDomain,
						Security.sandboxType == Security.REMOTE ? SecurityDomain.currentDomain : null
					)
				);
			} catch (e:Error) {
				_photoURL = null;
			}
		}
		
	
		public function sizePhoto():void
		{
			if (_photo != null)	{
				var unscaledPhotoWidth:Number  = _photo.width / _photo.scaleX;
				var unscaledPhotoHeight:Number = _photo.height / _photo.scaleY;
				
				var newPhotoWidth:Number  = 0;
				var newPhotoHeight:Number = 0;
				
				if ( (_photoWidth > 0) && (_photoHeight > 0) ) {
					newPhotoWidth  = _photoWidth;
					newPhotoHeight = _photoHeight;
				} else {
					if ( (_photoWidth == 0) && (_photoHeight == 0) ) {
						newPhotoWidth  = unscaledPhotoWidth;
						newPhotoHeight = unscaledPhotoHeight;
					} else {
						if (_photoWidth > 0) {
							newPhotoWidth  = _photoWidth;
							newPhotoHeight = unscaledPhotoHeight * (_photoWidth / unscaledPhotoWidth);
						}
						
						if (_photoHeight > 0) {
							newPhotoHeight = _photoHeight;
							newPhotoWidth = unscaledPhotoWidth * (_photoHeight / unscaledPhotoHeight);
						}
					}
				}
				
				var scaleCoeffW:Number = newPhotoWidth / unscaledPhotoWidth;
				var scaleCoeffH:Number = newPhotoHeight / unscaledPhotoHeight;
				var scaleCoeff:Number = _noSpace ? Math.max(scaleCoeffW, scaleCoeffH) : Math.min(scaleCoeffW, scaleCoeffH);
				
				if (_mask != null) {
					_photo.scaleX = _photo.scaleY = Math.max(_photoWidth / unscaledPhotoWidth, _photoHeight / unscaledPhotoHeight);
				} else {
					_photo.scaleX = scaleCoeff;
					_photo.scaleY = scaleCoeff;
				}
				
				if (_mask != null) {
					_photo.mask = _mask;
				}
			}
		}

		private function onPhotoLoadSuccess(e:Event):void
		{	
			_photoLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPhotoLoadSuccess);
			_photoLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onPhotoLoadError);

			if ( _photoBitmap != null && contains(_photoBitmap) ) {
				removeChild(_photoBitmap);
			}
			
			if (_photoLoader.content is Bitmap) {
				try {
					(_photoLoader.content as Bitmap).smoothing = true;
				} catch (e:Error) {}
			}
			_photo = _photoLoader;
			addChild(_photo);
			
			sizePhoto();	
				
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onPhotoLoadError(e:Event):void
		{
			_photoLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPhotoLoadSuccess);
			_photoLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onPhotoLoadError);
					
			_photoLoader = null;
			
			dispatchEvent(
				new Event(Event.COMPLETE)
			);
		}
	}
}