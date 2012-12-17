/**
 * User: Jessie
 * Date: 17.12.12
 * Time: 12:20
 */
package ru.fcl.sdd.services.main.test
{
import com.junkbyte.console.Cc;

import ru.fcl.sdd.services.main.ISender;

public class Send4test
{

    [Inject]
    public var sender:ISender;

    [PostConstruct]
    public function init():void
    {
        Cc.addSlashCommand("pushClient", function ():void
        {
            sender.send({command: "pushClient", args: []})
        })
    }
}
}
