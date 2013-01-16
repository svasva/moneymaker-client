/**
 * User: Jessie
 * Date: 21.11.12
 * Time: 14:39
 */
package ru.fcl.sdd.gui.main
{
import ru.fcl.sdd.gui.*;
import ru.fcl.sdd.services.shared.FriendBarVisModel;
import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
import ru.fcl.sdd.services.shared.ISharedGameDataService;
import ru.fcl.sdd.services.shared.SharedGameDataService;

import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.config.FlashVarsModel;
import ru.fcl.sdd.gui.main.controlpanel.BuildControlPanel;

import ru.fcl.sdd.gui.main.controlpanel.ControlPanelView;
import ru.fcl.sdd.gui.main.friendbar.BuildFriendbar;
import ru.fcl.sdd.gui.main.friendbar.FriendBarView;

import ru.fcl.sdd.gui.main.north.BuildNorthPanel;
import ru.fcl.sdd.gui.main.north.NorthPanelView;
import ru.fcl.sdd.gui.ingame.shop.BuildShopCommand;
import ru.fcl.sdd.gui.ingame.shop.ShopView;

public class BuildMainGUICommand extends SignalCommand
{
    [Inject]
    public var flashVars:FlashVarsModel;
    
    [Inject] 
    public var sharedGameData:ISharedGameDataService;

    

    override public function execute():void
    {
        commandMap.execute(BuildNorthPanel);
        commandMap.execute(BuildControlPanel);
        
        injector.mapSingleton(FriendBarVisBtnPressedSignal);
        commandMap.execute(BuildFriendbar);
        
        //TODO:Перенестикнопку и модель из френдбара в майнгуй. 
        injector.mapSingleton(FriendBarVisModelUpdatedSignal);   
        
        injector.mapSingleton(FriendBarVisModel);
       
        /*if (!sharedGameData.friendBarVisState)
        {
            sharedGameData.friendBarVisState = true;
        }
        else
        {
           sharedGameData.friendBarVisState =  sharedGameData.friendBarVisState;
        }*/
        

        injector.mapSingleton(MainInterfaceView);        

        var mainInterfaceView:MainInterfaceView = injector.getInstance(MainInterfaceView);

        var northPanelView:NorthPanelView = injector.getInstance(NorthPanelView);
        northPanelView.x = flashVars.app_width/2-northPanelView.width/2;
        mainInterfaceView.addChild(northPanelView);

        var friendBarView:FriendBarView = injector.getInstance(FriendBarView);        
       injector.mapSingleton(SetFriendBarVisSignal);
       signalCommandMap.mapSignalClass(SetFriendBarVisSignal, SetFriendBarVisCommand);
        
        friendBarView.x = flashVars.app_width/2-friendBarView.width/2;
        friendBarView.y = flashVars.app_height-friendBarView.height;
        mainInterfaceView.addChild(friendBarView);

        var controlPanelView:ControlPanelView = injector.getInstance(ControlPanelView);
        controlPanelView.y = flashVars.app_height - controlPanelView.height - 36;
        controlPanelView.x = flashVars.app_width - controlPanelView.width - 35;
        mainInterfaceView.addChild(controlPanelView);
        
        
        
    }
}
}
