package ru.fcl.sdd.gui.main.tutorial 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Timonin
	 */
	public class Screen 
	{
		public var sp:Sprite;
		public var title:String;
		public var text:String;
		public function Screen(sp:Sprite,title:String,text:String) 
		{
			this.sp = sp;
			this.text =  text;
			this.title =  title;
		}
		
	}

}