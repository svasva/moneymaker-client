package head.friendpanel
{

	import flash.display.Sprite;
	
	public class FriendCardSprite extends Sprite
	{
		public function FriendCardSprite()
		{
		}
		
		public function setCard(card:FriendCard):void
		{
			if (numChildren > 0) {
				removeChildAt(0);
			}
			
			addChild(card);
		}

	}
}