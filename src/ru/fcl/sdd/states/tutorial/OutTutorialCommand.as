/**
 * User: Jessie
 * Date: 10.12.12
 * Time: 12:21
 */
package ru.fcl.sdd.states.tutorial
{
import org.robotlegs.mvcs.SignalCommand;
import ru.fcl.sdd.gui.ingame.InGameGuiView;
import ru.fcl.sdd.gui.main.tutorial.TutorialView;



public class OutTutorialCommand extends SignalCommand
{
	 [Inject]
    public var tutorialView:TutorialView;
    [Inject]
    public var inGameGuiView:InGameGuiView;

    override public function execute():void
    {
		inGameGuiView.removeChild(tutorialView);
       // mediatorMap.removeMediatorByView(injector.getInstance(TutorialView));
       /// mediatorMap.unmapView(TutorialView);
    }
}
}
