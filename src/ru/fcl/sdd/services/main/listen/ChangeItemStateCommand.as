package ru.fcl.sdd.services.main.listen 
{
	import org.robotlegs.mvcs.SignalCommand;
    import ru.fcl.sdd.item.ActiveUserItemList;
    import ru.fcl.sdd.item.iso.ItemIsoView;
    import ru.fcl.sdd.item.ItemStatus;
    import ru.fcl.sdd.tools.PrintJSON;
	
	/**
     * ...
     * @author atuzov
     */
    public class ChangeItemStateCommand extends SignalCommand 
    {
         [Inject]
        public var response:Object;
        
         [Inject]
        public var userItems:ActiveUserItemList;
        
        override public function execute():void
        {
            var item:ItemIsoView =  userItems.get(response.response.id) as ItemIsoView;
            
            
            trace(item.status);
               trace("response.changes " +response.response.changes)
            if (response.response.changes)
            {
                trace("response.changes " +response.response.changes)
                if (response.response.changes.state)
                {
                     trace("response.changes.state" +response.response.changes.state)
                    if (response.response.changes.state == ItemStatus.EMPTY)
                    {
                        
                        item.status = ItemStatus.EMPTY;
                        item.cashMoney = response.response.changes.cash;
                         item.giveMoney.visible = true;
                        item.render();
                    }
                    else if (response.response.changes.state == ItemStatus.STANDBY)
                    {
                        item.status = ItemStatus.STANDBY;
                        item.cashMoney = response.response.changes.cash;
                        item.giveMoney.visible = false;
                        item.takeMoney.visible = false;
                        item.render();
                    }
                      else if (response.response.changes.state == ItemStatus.FULL)
                    {
                        item.status = ItemStatus.FULL;
                        item.cashMoney = response.response.changes.cash;
                        item.takeMoney.visible = true;
                        item.render();
                    }
                }
             
            }
               trace(item.status);
            
           // {"requestId":"-2","response":{"id":"51179a5e5dae91a0d9000004","changes":{"cash":"0","client_id":"","operation_id":"","state":"empty","updated_at":"2013-02-10 13:57:50 UTC"}}} 

        }
        
    }

}