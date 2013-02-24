package social.vo
{
	import social.connector.ConnectorType;
	import social.vo.common.AbstractVO;
	import social.vo.common.Picture;
	
	public class PhotoVO extends AbstractVO
	{
		private var _id:String;
		private var _image:Picture;
		
		public function PhotoVO(type:ConnectorType, obj:Object)
		{
			super(type, obj);
		}
		
		protected override function convertFromVkJson(obj:Object):void
		{
			 _id = obj.pid;
			
			 _image = new Picture(obj.src_small, obj.src, obj.src_big);
		}
		
		protected override function convertFromDuduJson(obj:Object):void
		{
			_id = String(obj.id)
			
			 _image = new Picture(obj.photo_small, obj.photo_normal, obj.photo_big);
		}

		public function get id():String
		{
			return _id;
		}

		public function get image():Picture
		{
			return _image;
		}

	}
}