/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 15:33
 */
package ru.fcl.sdd.services.main.listen
{
public class IllegalCommandMapError extends Error
{
    public function IllegalCommandMapError(message:*, id:int):void
    {
        super(message,id);
    }
}
}
