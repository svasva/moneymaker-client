/**
 * Created with IntelliJ IDEA.
 * User: questa_4
 * Date: 07.11.12
 * Time: 19:24
 * To change this template use File | Settings | File Templates.
 */
package ru.fcl.sdd.buildapplication.test
{
import com.junkbyte.console.Cc;

import org.robotlegs.mvcs.SignalCommand;

public class BuildDebugConsoleCommand extends SignalCommand
{
    override public function execute():void
    {
        Cc.startOnStage(contextView, '`');
    }
}
}
