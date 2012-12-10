/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:01
 */
package ru.fcl.sdd.states
{
import org.robotlegs.mvcs.SignalCommand;

import ru.fcl.sdd.states.iso.OutIsoViewCommand;

import ru.fcl.sdd.states.shop.EnterShopCommand;
import ru.fcl.sdd.states.iso.EnterIsoViewCommand;
import ru.fcl.sdd.states.shop.OutShopCommand;

public class ChangeStateCommand extends SignalCommand
{
    [Inject]
    public var currentState:GameStates;
    [Inject]
    public var stateHolder:IStateHolder;

    [Inject]

    override public function execute():void
    {
        if (currentState != stateHolder.currentState)
        {
            if (stateHolder.stateOutCommand)
            {
                commandMap.execute(stateHolder.stateOutCommand);
            }

            switch (currentState)
            {
                case GameStates.IN_SHOP:
                {
                    stateHolder.stateOutCommand = OutShopCommand;
                    commandMap.execute(EnterShopCommand);
                    break;
                }
                case GameStates.VIEW:
                {
                    stateHolder.stateOutCommand = OutIsoViewCommand;
                    commandMap.execute(EnterIsoViewCommand);
                    break;
                }
                case GameStates.STATE_OUT:
                {
                    stateHolder.stateOutCommand = OutIsoViewCommand;
                    commandMap.execute(EnterIsoViewCommand);
                    break;
                }
                default :
                {
                    stateHolder.stateOutCommand = OutIsoViewCommand;
                    commandMap.execute(EnterIsoViewCommand);
                    break;
                }
            }
            stateHolder.currentState = currentState;
        }
    }
}
}
