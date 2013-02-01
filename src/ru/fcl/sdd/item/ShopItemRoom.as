package ru.fcl.sdd.item 
{
    import de.polygonal.ds.HashMap;
    import org.aswing.JButton;
    import org.aswing.JToggleButton;
    import ru.fcl.sdd.rsl.GuiRsl;
     
	/**
     * ...
     * @author atuzov
     */
    public class ShopItemRoom 
    {
        private var _icon_filename:String;
        private var _id:String;
        private var _item_name:String;
        private var _ref_items:HashMap=new HashMap();
        private var _room_type_id:String;
        private var _desc:String;
        private var _order:int;
        private var _btnView:JToggleButton;
        private var _disBtnView:JToggleButton;
        private var _isPurshed:Boolean = false;
        private var _avalibleItems:HashMap = new HashMap();
        private var _shopItemRoomView:ShopItemRoomView;
        
       
        public function setValue():void
        {
            
        } 
        
        public function get icon_filename():String 
        {
            return _icon_filename;
        }
        
        public function set icon_filename(value:String):void 
        {
            _icon_filename = value;
        }
        
        public function get id():String 
        {
            return _id;
        }
        
        public function set id(value:String):void 
        {
            _id = value;
        }
        
        public function get desc():String 
        {
            return _desc;
        }
        
        public function set desc(value:String):void 
        {
            _desc = value;
        }
        
        public function get room_type_id():String 
        {
            return _room_type_id;
        }
        
        public function set room_type_id(value:String):void 
        {
            _room_type_id = value;
        }
        
        public function get ref_items():HashMap 
        {
            return _ref_items;
        }
        
        public function set ref_items(value:HashMap):void 
        {
            _ref_items = value;
        }
        
        public function get item_name():String 
        {
            return _item_name;
        }
        
        public function set item_name(value:String):void 
        {
            _item_name = value;
        }
        
        public function get order():int 
        {
            return _order;
        }
        
        public function set order(value:int):void 
        {
            _order = value;
        }
        
        public function get btnView():JToggleButton 
        {
            return _btnView;
        }
        
        public function set btnView(value:JToggleButton):void 
        {
            _btnView = value;
        }
        
        public function get shopItemRoomView():ShopItemRoomView 
        {
            return _shopItemRoomView;
        }
        
        public function set shopItemRoomView(value:ShopItemRoomView):void 
        {
            _shopItemRoomView = value;
        }
        
        public function get isPurshed():Boolean 
        {
            return _isPurshed;
        }
        
        public function set isPurshed(value:Boolean):void 
        {
            _isPurshed = value;
        }
        
        
        
    }

}