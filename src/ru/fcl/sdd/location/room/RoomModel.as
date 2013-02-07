package ru.fcl.sdd.location.room 
{
    import ru.fcl.sdd.item.iso.ItemIsoView;
	/**
     * ...
     * @author atuzov
     */
    public class RoomModel 
    {
        private var _selectedItemId:String;
        private var _selectedItem:ItemIsoView;
        
        [Inject]
        public var updatedSig:SelectedItemUpdated;
        
        
        
        public function RoomModel() 
        {
            
        }
        
      
        
        public function get selectedItem():ItemIsoView 
        {
            return _selectedItem;
        }
        
        public function set selectedItem(value:ItemIsoView):void 
        {
            _selectedItem = value;
            updatedSig.dispatch();
        }
        
        public function get selectedItemId():String 
        {
            return _selectedItemId;
        }
        
        public function set selectedItemId(value:String):void 
        {
            _selectedItemId = value;
        }
        
    }

} 