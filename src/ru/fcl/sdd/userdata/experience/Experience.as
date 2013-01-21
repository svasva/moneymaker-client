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
        }
        
    }

}