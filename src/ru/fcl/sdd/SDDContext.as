/**
 * User: Jessie
 * Date: 07.11.12
 * Time: 12:58
 */
package ru.fcl.sdd
{
import flash.display.DisplayObjectContainer;

import org.robotlegs.base.ContextEvent;

import org.robotlegs.mvcs.SignalContext;

public class SDDContext extends SignalContext
{
    public function SDDContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
    {
        super(contextView, autoStartup);
    }

    override public function startup():void
    {
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, BuildApplicationCommand, ContextEvent, true);
        super.startup();
    }
}
}
