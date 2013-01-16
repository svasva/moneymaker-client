package ru.fcl.sdd.gui
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import org.aswing.event.InteractiveEvent;
    import org.robotlegs.mvcs.Mediator;
    import ru.fcl.sdd.gui.main.friendbar.FriendBarView;
    import ru.fcl.sdd.gui.main.MainInterfaceView;
    import ru.fcl.sdd.log.ILogger;
    import ru.fcl.sdd.services.shared.FriendBarVisModel;
    import ru.fcl.sdd.services.shared.FriendBarVisModelUpdatedSignal;
    import ru.fcl.sdd.services.shared.FriendBarVisServiceUpdatedSignal;
    import ru.fcl.sdd.services.shared.ISharedGameDataService;
    
    /**
     * <p>
     * Description
     *
     * Mediator:
     * • The View is represented by your view components and their Mediators
     * • Mediators provide an API for view components (to keep the framework out)
     * • Mediators listen for view component events
     * • Mediators listen for framework events
     * • Mediators dispatch framework events
     * • view components are <b>not</b> coupled to their Mediators (or any other framework class, period.)
     * • Mediators <b>are</b> coupled to view components
     * • Mediators can access Service and Model classes directly (but this will couple the Mediator to the Actor, tread carefully)
     * </p>
     *
     * @class MainInterfaceMediator
     * @author atuzov
     * @date 01.16.2013
     * @version 1.0
     * @see
     */
    
    public class MainInterfaceMediator extends Mediator
    {        
        [Inject]
        public var view:MainInterfaceView;
        
        [Inject]
        public var friendBarView:FriendBarView;
        
        [Inject]
        public var model:FriendBarVisModel;
        
        [Inject]
        public var friendBarModelUpdatedSignal:FriendBarVisModelUpdatedSignal;
        
        [Inject]
        public var logger:ILogger;
        
        [Inject]
        public var fiendBarVisBtnPressed:FriendBarVisBtnPressedSignal;
        
        [Inject]
        public var sharedGameDataSrv:ISharedGameDataService;
        /**
         * Constructor
         */
        public function MainInterfaceMediator()
        {
        
        }
        
        /*-----------------------------------------------------------------------------------------
           Public methods
         -------------------------------------------------------------------------------------------*/
        override public function onRegister():void
        {
            view.friendBarVisBtn.addEventListener(MouseEvent.CLICK, onCloseFriendBarSelected);
            friendBarModelUpdatedSignal.add(onFriendBarVisModelUpdated);
            sharedGameDataSrv.friendBarVisState = sharedGameDataSrv.friendBarVisState;
        }
        
        private function onFriendBarVisModelUpdated(value:Boolean):void
        {
            logger.log(this, "onFriendBarVisModelUpdated",value);
            friendBarView.visible = value;
            if (value)
            {
                view.friendBarVisBtn.setText("Закрыть");
                view.friendBarVisBtn.setSelected(false);
            }
            else
            {
                view.friendBarVisBtn.setText("Открыть");
                view.friendBarVisBtn.setSelected(true);
            }
        }
        
        private function onCloseFriendBarSelected(e:Event):void
        {
            fiendBarVisBtnPressed.dispatch();
        }
    
    /*-----------------------------------------------------------------------------------------
       Private methods
     -------------------------------------------------------------------------------------------*/
    
    /*-----------------------------------------------------------------------------------------
       Event Handlers
     -------------------------------------------------------------------------------------------*/
    }
}