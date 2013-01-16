package ru.fcl.sdd.services.shared
{
    
    /**
     * ...
     * @author atuzov
     */
    public interface ISharedService
    {
        /**загружает файл локального хранилища **/
        function getLocalObject():void;
        
        /**получает значение переменной из локального хранилища**/
        function getLocal(name:String):Object;
        /**изменяет значение переменной в локальном хранилище**/
        function setLocal(name:String, val:Object):void;
    }

}