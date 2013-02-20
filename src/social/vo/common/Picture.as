package social.vo.common
{
	public final class Picture
	{
		private var _small:String;
		private var _normal:String;
		private var _large:String;
		
		public static var imageDomain : String = null;
		private static const forbiddenDomains : Array = ["http://vk.com/images/", "https://vk.com/images/"];
		
		public function Picture(small:String, normal:String, large:String)
		{
			_small = cleanImage(small);
			_normal = cleanImage(normal);
			_large = cleanImage(large);
		}

		public function get small():String
		{
			return _small;
		}

		public function get normal():String
		{
			return _normal;
		}

		public function get large():String
		{
			return _large;
		}

		private function cleanImage(image : String) : String
		{
			if (image != null)
			{
				for each (var img : String in forbiddenDomains)
				{
					if (image.substr(0,img.length) == img)
					{
						if (imageDomain == null)
						{
							return null;
						}
						else
						{
							return imageDomain + image.substr(img.length);
						}
					}
				}
			}
			return image;
		}
	}
}