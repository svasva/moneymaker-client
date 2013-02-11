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
import ru.fcl.sdd.gui.main.tutorial.TutorialViewMediator;


public class EnterTutorialCommand extends SignalCommand
{
	[Inject(name = "tutorial")]
	
 [Inject]
   public var tutorialView:TutorialView;
  [Inject]
    public var inGameGuiView:InGameGuiView;
	
    override public function execute():void
    {
        mediatorMap.mapView(TutorialView, TutorialViewMediator);
        var tutorialView:TutorialView = injector.getInstance(TutorialView);
        if (tutorialView.stage)
       {
            mediatorMap.createMediator(tutorialView);
       }
	  
//	inGameGuiView.addChild( tutorialView);
    }
}
}
