/**
 * User: Jessie
 * Date: 15.11.12
 * Time: 15:11
 */
package ru.fcl.sdd.services.main.errorhandle
{
import flash.events.ErrorEvent;

public class ResponseErrorEvent extends ErrorEvent
{
    public static const UNCNOWN_ERROR:String = "uncnown_error";

    public function ResponseErrorEvent(type:String):void
    {
        super(type);
    }
}
}
