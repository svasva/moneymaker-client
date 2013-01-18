package ru.fcl.sdd.userdata.capacity 
{
	/**
     * ...
     * @author atuzov
     */
    public class Capacity implements ICapacity
    {
        [Inject]
        public var updater:CapacityUpdateSignal;
        
        private var _capacity:Number=NaN;
        private var _persentageFill:Number;
        
        
        public function Capacity() 
        {
       
        }
        
        public function get capacity():Number 
        {
            return _capacity;
        }
        
        public function set capacity(value:Number):void 
        {
            _capacity = value;
            trace("CapacityUpdateSignal");
            updater.dispatch();
        }
        
        public function get persentageFill():Number 
        {
            return _persentageFill;
        }
        
        public function set persentageFill(value:Number):void 
        {
            _persentageFill = value;
        }
        
    }

}