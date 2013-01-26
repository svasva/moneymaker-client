package ru.fcl.sdd.gui.ingame.shop.events 
{
    import flash.events.Event;
    
    /**
     * ...
     * @author atuzov
     */
    public class ShopItemRoomEvent extends Event 
    {
        
        public var id:String;
        public static const ITEM_CLICKED:String = "item_clicked";
        
        public function ShopItemRoomEvent(type:String, id,bubbles:Boolean=false, cancelable:Boolean=false) 
        { 
            this.id = id;
            super(type, bubbles, cancelable);
            
            
        } 
        
        public override function clone():Event 
        { 
            return new ShopItemRoomEvent(type,this.id ,bubbles, cancelable);
        } 
        
        public override function toString():String 
        { 
            return formatToString("ShopItemRoomEvent", "type","id", "bubbles", "cancelable", "eventPhase"); 
        }
        
    }
    
}