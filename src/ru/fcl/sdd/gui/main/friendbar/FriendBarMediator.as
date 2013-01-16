/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.friendbar
{
import org.aswing.event.InteractiveEvent;
import org.robotlegs.mvcs.Mediator;
import ru.fcl.sdd.gui.FriendBarVisBtnPressedSignal;
import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.shared.FriendBarVisModel;
import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
import ru.fcl.sdd.services.shared.ISharedGameDataService;

public class FriendBarMediator extends Mediator
{
    
     [Inject]
    public var view:FriendBarView;
    
    [Inject]
    public var model:FriendBarVisModel;
    
     [Inject]
    public var friendBarModelUpdatedSignal:FriendBarVisModelUpdatedSignal;
    
    [Inject]
    public var logger:ILogger;
    
    [Inject]
    public var fiendBarVisBtnPressed:FriendBarVisBtnPressedSignal;
    
    [Inject]
    public var sharedGameDataSrv:ISharedGameDataService
    
    override public function onRegister():void
    {
        view.checkBtn.addSelectionListener(onCloseFriendBarSelected);
        friendBarModelUpdatedSignal.add(onFriendBarVisModelUpdated);
    }
    
    private function onFriendBarVisModelUpdated(value:Boolean):void 
    {
        logger.log(this, "onFriendBarVisModelUpdated");
    }
    private function onCloseFriendBarSelected(e:InteractiveEvent):void 
    {
         fiendBarVisBtnPressed.dispatch();
          
        if (  view.checkBtn.getModel().isSelected())
        {           
            trace("pressed");
          
              view.checkBtn.setText("Открыть");
              //view.vis = false;
        }
        else
        {
            trace("relised");
            view.checkBtn.setText("Закрыть");
            //view.vis = true;
           
        }
       
    }
}
}
