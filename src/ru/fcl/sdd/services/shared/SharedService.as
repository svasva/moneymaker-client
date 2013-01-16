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
            
        }
        
        /**загружает файл локального хранилища **/
        public function getLocalObject():void
        {            
            _shared = SharedObject.getLocal(SHARED_OBJECT_NAME);
        }
        
        /**получает значение переменной из локального хранилища**/
        public function getLocal(name:String):Object
        {
            return _shared.data[name];
        }
        /**изменяет значение переменной в локальном хранилище**/ 
        public function setLocal(name:String, val:Object):void
        {
            _shared.setProperty(name,val);
        }
    
    
    }

}