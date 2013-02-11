package ru.fcl.sdd.userdata.experience 
{
	/**
     * ...
     * @author atuzov
     */
    public class Experience implements IExperience
    {
        private var _count:int;
        private var _nextLevel:int;
        private var _levelNumer:int;
        private var _isLevelUdated:Boolean = true;
        
        [Inject]
        public var updater:UpdateExperienceSignal;
       
        
        public function Experience() 
        {
            
        }
        
        public function get count():int 
        {
            return _count;
        }
        
        public function set count(value:int):void 
        {
            _count = value;
            updater.dispatch();
        }
        
        public function get nextLevel():int 
        {
            return _nextLevel;
        }
        
        public function set nextLevel(value:int):void 
        {
            _nextLevel = value;
        }
        
        public function get levelNumer():int 
        {
            return _levelNumer;
        }
        
        public function set levelNumer(value:int):void 
        {
            _levelNumer = value;
           // updaterLevel.dispatch();
        }
        
        public function get isLevelUdated():Boolean 
        {
            return _isLevelUdated;
        }
        
        public function set isLevelUdated(value:Boolean):void 
        {
            _isLevelUdated = value;
        }
        
    }

}