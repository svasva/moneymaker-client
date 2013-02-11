package ru.fcl.sdd.tempFloorView 
{
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.ByteArray;
    import ru.fcl.sdd.tempFloorView.Nodes.IsoFloor;

    
	
	public class FloorManager 
	{	
		[Embed(source="../../../../../art/bin/State0.xml" , mimeType = "application/octet-stream")] private static const  State0:Class;
		[Embed(source = "../../../../../art/bin/State1.xml" , mimeType = "application/octet-stream")] private static const State1:Class;
		[Embed(source = "../../../../../art/bin/State2.xml" , mimeType = "application/octet-stream")] private static const State2:Class;
		[Embed(source = "../../../../../art/bin/State3.xml" , mimeType = "application/octet-stream")] private static const State3:Class;
		[Embed(source = "../../../../../art/bin/State4.xml" , mimeType = "application/octet-stream")] private static const State4:Class;
		[Embed(source = "../../../../../art/bin/State5.xml" , mimeType = "application/octet-stream")] private static const State5:Class;
		[Embed(source = "../../../../../art/bin/State6.xml" , mimeType = "application/octet-stream")] private static const State6:Class;
		[Embed(source = "../../../../../art/bin/State7.xml" , mimeType = "application/octet-stream")] private static const State7:Class;
		[Embed(source = "../../../../../art/bin/State8.xml" , mimeType = "application/octet-stream")] private static const State8:Class;
		[Embed(source = "../../../../../art/bin/State9.xml" , mimeType = "application/octet-stream")] private static const State9:Class;
		[Embed(source = "../../../../../art/bin/State10.xml" , mimeType = "application/octet-stream")] private static const State10:Class;
		[Embed(source = "../../../../../art/bin/State11.xml" , mimeType = "application/octet-stream")] private static const State11:Class;
		[Embed(source = "../../../../../art/bin/State12.xml" , mimeType = "application/octet-stream")] private static const State12:Class;
		[Embed(source = "../../../../../art/bin/State13.xml" , mimeType = "application/octet-stream")] private static const State13:Class;
		[Embed(source = "../../../../../art/bin/State14.xml" , mimeType = "application/octet-stream")] private static const State14:Class;
		[Embed(source = "../../../../../art/bin/State15.xml" , mimeType = "application/octet-stream")] private static const State15:Class;
		[Embed(source = "../../../../../art/bin/State16.xml" , mimeType = "application/octet-stream")] private static const State16:Class;
		[Embed(source = "../../../../../art/bin/State17.xml" , mimeType = "application/octet-stream")] private static const State17:Class;
		[Embed(source = "../../../../../art/bin/State18.xml" , mimeType = "application/octet-stream")] private static const State18:Class;
		[Embed(source = "../../../../../art/bin/State19.xml" , mimeType = "application/octet-stream")] private static const State19:Class;
		[Embed(source = "../../../../../art/bin/State20.xml" , mimeType = "application/octet-stream")] private static const State20:Class;
		[Embed(source = "../../../../../art/bin/State21.xml" , mimeType = "application/octet-stream")] private static const State21:Class;
		[Embed(source = "../../../../../art/bin/State22.xml" , mimeType = "application/octet-stream")] private static const State22:Class;
		[Embed(source = "../../../../../art/bin/State23.xml" , mimeType = "application/octet-stream")] private static const State23:Class;
		[Embed(source = "../../../../../art/bin/State24.xml" , mimeType = "application/octet-stream")] private static const State24:Class;
		[Embed(source = "../../../../../art/bin/State25.xml" , mimeType = "application/octet-stream")] private static const State25:Class;
		[Embed(source = "../../../../../art/bin/State26.xml" , mimeType = "application/octet-stream")] private static const State26:Class;
		[Embed(source = "../../../../../art/bin/State27.xml" , mimeType = "application/octet-stream")] private static const State27:Class;
		[Embed(source = "../../../../../art/bin/State28.xml" , mimeType = "application/octet-stream")] private static const State28:Class;
		[Embed(source = "../../../../../art/bin/State29.xml" , mimeType = "application/octet-stream")] private static const State29:Class;
			[Embed(source = "../../../../../art/bin/State30.xml" , mimeType = "application/octet-stream")] private static const State30:Class;
				[Embed(source = "../../../../../art/bin/State31.xml" , mimeType = "application/octet-stream")] private static const State31:Class;
					[Embed(source = "../../../../../art/bin/State32.xml" , mimeType = "application/octet-stream")] private static const State32:Class;
		
		private static var instane:FloorManager;
		
		public var CurrState:int = 0;
		
		private var states:Array =[];
		
		public  function Count():int
		{
			return states.length;
		}
		public static function get_Instance():FloorManager
		{
			if (instane == null)
			instane = new FloorManager();
			
			return instane;
		}
		
		
		public function FloorManager() 
		{
			var bytes:ByteArray;
			bytes = new State0();
            states.push(new XML(bytes.readUTFBytes(bytes.length)));
			bytes = new State1();
			states.push(new XML(bytes.readUTFBytes(bytes.length)));
			bytes = new State2();
			states.push(new XML(bytes.readUTFBytes(bytes.length)));
			bytes = new State3();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			bytes = new State4();
			 states.push(new XML(bytes.readUTFBytes(bytes.length))); 
			 bytes = new State5();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));  
			  bytes = new State6();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			  bytes = new State7();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));  
			bytes = new State8();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			 	bytes = new State9();
			 states.push(new XML(bytes.readUTFBytes(bytes.length))); 
			 	bytes = new State10();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			 	bytes = new State11();
			 states.push(new XML(bytes.readUTFBytes(bytes.length))); 
			 bytes = new State12();
			 states.push(new XML(bytes.readUTFBytes(bytes.length))); 
			  bytes = new State13();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			  bytes = new State14();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State15();
			 states.push(new XML(bytes.readUTFBytes(bytes.length))); 
			    bytes = new State16();
			 states.push(new XML(bytes.readUTFBytes(bytes.length))); 
			   bytes = new State17();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			    bytes = new State18();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State19();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State20();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			    bytes = new State21();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State22();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			  bytes = new State23();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State24();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			  bytes = new State25();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State26();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			    bytes = new State27();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			    bytes = new State28();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State29();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State30();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			  bytes = new State31();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			   bytes = new State32();
			 states.push(new XML(bytes.readUTFBytes(bytes.length)));
			 
			 
			
		}
		public function get STATE():int
		{
			return CurrState;
		}
	
		public function reset():void
		{
			CurrState = 0;
		}
		
		public  function Current():XML		
		{
			return states[CurrState];
		}
		
		public  function Next():XML
		{
			CurrState++;
			if (CurrState > Count()-1)
			CurrState--;
			trace(CurrState);
			
			return Current();
			
			
		}
		
		public  function Prev():XML
		{
			CurrState--;
			if (CurrState < 0)
			CurrState = 0;
			trace(CurrState);
			
			return Current();
		}
	
	}

}