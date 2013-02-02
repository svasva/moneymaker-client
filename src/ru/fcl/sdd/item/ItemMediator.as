package ru.fcl.sdd.item 
{
    import flash.events.Event;
    import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
    import ru.fcl.sdd.item.iso.ItemIsoView;
	
	/**
     * ...
     * @author atuzov
     */
    public class ItemMediator extends Mediator 
    {
        
        [Inject]
        public var item:ItemIsoView;
        
       
        override public function onRegister():void
        {
            trace("------------------------------------=================================================");
            item.addEventListener(MouseEvent.MOUSE_OVER, itemView_mouseOverHandler);
            item.addEventListener(MouseEvent.MOUSE_OUT, itemView_mouseOutHandler);
        }
        
        private function itemView_mouseOutHandler(e:Event):void 
        {
            
        }
        
        private function itemView_mouseOverHandler(e:Event):void 
        {
            trace("itemView_mouseOverHandler");
        }
    }

}