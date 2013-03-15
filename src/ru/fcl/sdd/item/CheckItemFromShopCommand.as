package ru.fcl.sdd.item 
{
	import de.polygonal.ds.HashMap;
	import org.robotlegs.mvcs.SignalCommand;
	import ru.fcl.sdd.location.room.Room;
	import ru.fcl.sdd.location.room.RoomCatalog;
	import ru.fcl.sdd.location.room.UserRoomList;
	import ru.fcl.sdd.userdata.experience.IExperience;
	import ru.fcl.sdd.userdata.reputation.IReputation;
	
	/**
	 * ...
	 * @author 
	 */
	public class CheckItemFromShopCommand extends SignalCommand 
	{
		[Inject]
        public var itemCatalog:ItemCatalog;
		
		 [Inject]
		public var userRoomList:UserRoomList;

		[Inject]
		public var roomList:RoomCatalog;
		
		[Inject]
        public var expMdl:IExperience;
		
		[Inject]
		public var  repMdl:IReputation;
		
		[Inject]
        public var shopMdl:ShopModel;
		
		
		
		override public function execute():void 
		{
		   trace("CheckItemFromShopCommand");
		   var lim:int =  itemCatalog.toArray().length;
           var itemCatalogArr:Array = itemCatalog.toArray();
           
		   var userRoomsArr:Array = userRoomList.toArray();
		   var reqRoomId:String;	   
		   //предметы
           for (var j:int = 0; j < lim; j++) 
           {
               if (itemCatalogArr[j].requirementLevel > expMdl.levelNumer)
			   {
					//itemCatalogArr[j].isLock = true;
					itemCatalogArr[j].sucssiseLvl = false;
			   }
			   else
			   {
				  // itemCatalogArr[j].isLock = false;
				   itemCatalogArr[j].sucssiseLvl = true;
			   }
			   if (itemCatalogArr[j].reqExp)
			   {
				   if (itemCatalogArr[j].reqExp > repMdl.countValue)
				   {
					  // itemCatalogArr[j].isLock = true;
					   itemCatalogArr[j].sucssiseRep = false;
					   trace(" itemCatalogArr[j].sucssiseRep = false;");
				   }
				   else
				   {
					   itemCatalogArr[j].sucssiseRep = true;
				   }
			   }
			 
			   for each (var item:Object in userRoomsArr) 
			   {
					
					if (itemCatalogArr[j].reqRoom)
					{						
						if (itemCatalogArr[j].reqRoom == item.catalogId)
						{		
							itemCatalogArr[j].sucssiseRoom = true;
							//itemCatalogArr[j].isLock = false;
							break
						}
						else
						{							
							reqRoomId = itemCatalogArr[j].reqRoom;							
							itemCatalogArr[j].reqRoomName = (roomList.get(reqRoomId) as Room).name;
							//itemCatalogArr[j].isLock = true;
							itemCatalogArr[j].sucssiseRoom = false;
						}
					}
			   }
			   if (itemCatalogArr[j].sucssiseLvl && itemCatalogArr[j].sucssiseRep && itemCatalogArr[j].sucssiseRoom )
			   {
				   itemCatalogArr[j].isLock = false;
			   }
			   else
			   {
				    itemCatalogArr[j].isLock = true;
			   }
			   
			  
           }
		   //комнаты. 
		    var temVec:Vector.<Object> = (shopMdl.get("main") as HashMap).toVector();          
            for each (var item1:ShopItemRoom in temVec) 
            {
			   if (item1.shopItemRoomView.requirementLevel > expMdl.levelNumer)
			   {
					item1.shopItemRoomView.isLock = true;
					item1.shopItemRoomView.sucssiseLvl = false;
			   }
			   else
			   {
				   item1.shopItemRoomView.isLock = false;
				   item1.shopItemRoomView.sucssiseLvl = true;
			   }
			   if (item1.shopItemRoomView.reqExp!= NaN)
			   {
				   if (item1.shopItemRoomView.reqExp > repMdl.countValue)
				   {
					   item1.shopItemRoomView.isLock = true;
					   item1.shopItemRoomView.sucssiseRep = false;
				   }
				   else
				   {
					   item1.shopItemRoomView.sucssiseRep = true;
				   }
			   }
			    for each (var item2:Object in userRoomsArr) 
			   {
					
					if ( item1.shopItemRoomView.reqRoom)
					{					
						if ( item1.shopItemRoomView.reqRoom == item2.catalogId)
						{		
							item1.shopItemRoomView.sucssiseRoom = true;
							item1.shopItemRoomView.isLock = false;
							reqRoomId =  item1.shopItemRoomView.reqRoom;							
						//	itemCatalogArr[j].reqRoomName = (roomList.get(reqRoomId) as Room).name;
							
						}
						else
						{
							
							reqRoomId =  item1.shopItemRoomView.reqRoom;							
							 item1.shopItemRoomView.reqRoomName = (roomList.get(reqRoomId) as Room).name;
							 item1.shopItemRoomView.isLock = true;
							 item1.shopItemRoomView.sucssiseRoom = false;
						}
					}
			   }
			   
			   item1.shopItemRoomView.checkReq();
			}
		}
		
	}

}