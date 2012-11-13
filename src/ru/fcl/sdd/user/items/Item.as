/**
 * User: Jessie
 * Date: 13.11.12
 * Time: 12:36
 */
package ru.fcl.sdd.user.items
{
import com.hurlant.util.der.Integer;

import flash.utils.Dictionary;

public class Item
{
    private var name: String;
    private var item_type: String;
    private var money_cost: int;
    private var coins_cost: int;
    private var sell_cost:int;
    private var sizeX:int;
    private var sizeY:int;
    private var reputation_bonus:int;
    private var reqirements:Dictionary;
    private var rewards:Dictionary;
}
}
