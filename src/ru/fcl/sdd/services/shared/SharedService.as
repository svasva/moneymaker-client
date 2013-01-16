package ru.fcl.sdd.services.shared
{
    import flash.net.SharedObject;
    
    /**
     * ...
     * @author atuzov
     */
    public class SharedService implements ISharedService
    {
        private var _shared:SharedObject;
        
        private static const SHARED_OBJECT_NAME:String = "SDDSharedDate";
        
        public function SharedService()
        {
            trace("SharedService");
        }
        
        /**загружает файл локального хранилища **/
        public function getLocalObject():void
        {
            trace("getLocalObject");
            _shared = SharedObject.getLocal(SHARED_OBJECT_NAME);
            
        }
        
        /**получает значение переменной из локального хранилища**/
        public function getLocal(name:String):Object
        {
            if (!_shared)
                return null;
            
            return _shared.data[name];
        
        }
        /**изменяет значение переменной в локальном хранилище**/ 
        public function setLocal(name:String, val:Object):void
        {
            if (!_shared)
                return;
        }
    
    
    }

}