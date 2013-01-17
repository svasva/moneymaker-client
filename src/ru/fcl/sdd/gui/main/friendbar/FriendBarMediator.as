/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.friendbar
{
import org.aswing.event.InteractiveEvent;
import org.robotlegs.mvcs.Mediator;

import ru.fcl.sdd.log.ILogger;
import ru.fcl.sdd.services.shared.FriendBarVisModel;
import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
import ru.fcl.sdd.services.shared.ISharedGameDataService;

public class FriendBarMediator extends Mediator
{
    
     [Inject]
    public var view:FriendBarView;
    
    override public function onRegister():void
    {
      
    }
    
   
   
}
}
