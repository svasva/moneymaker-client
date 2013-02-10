//Created by Action Script Viewer - http://www.buraks.com/asv
package legacy
{
    import __AS3__.vec.*;
    
    import legacy.I18n;
    
    import flash.display.*;
    import flash.utils.*;

    public class Utilities 
    {

        public function Utilities()
        {
        }

        public static function clearDictionary(d:Dictionary):void
        {
            var id:String;
            for (id in d) {
                id = null;
                delete d[id];
            };
        }

        public static function getHiddenObjectFromRandom(rnd:int, action:XML):XML
        {
            var hidden:XML;
            var prob:int;
            var totalProba:int;
            for each (hidden in action.Hidden) {
                prob = hidden.@probability;
                totalProba = (totalProba + prob);
                if (rnd <= totalProba){
                    return (hidden);
                };
            };
            return (null);
        }

        public static function disposeSprite(sprite:Sprite):void
        {
            while (sprite.numChildren > 0) {
                sprite.removeChildAt(0);
            };
            sprite.graphics.clear();
        }

        public static function getChildWithValuedParameter(parentXml:XML, nodeName:String, parameterName:String, parameterValue:String):XML
        {
            var correspondingXmls:* = null;
            var parentXml:* = parentXml;
            var nodeName:* = nodeName;
            var parameterName:* = parameterName;
            var parameterValue:* = parameterValue;
            correspondingXmls = parentXml[nodeName].(@[parameterName] == parameterValue);
            if ((((correspondingXmls == null)) || ((correspondingXmls.length() < 1)))){
                return (null);
            };
            if (correspondingXmls.length() > 1){
				trace(((((("there is more than one " + nodeName) + " child node with ") + parameterName) + " parameter of value ") + parameterValue));
                //DebugConsole.instance.Trace(((((("there is more than one " + nodeName) + " child node with ") + parameterName) + " parameter of value ") + parameterValue), DebugConsole.TRACE_ERROR);
            };
            return (correspondingXmls[0]);
        }

        public static function getUniqueChildWithName(parentXml:XML, nodeName:String):XML
        {
            var correspondingXmls:XMLList = parentXml[nodeName];
            if ((((correspondingXmls == null)) || ((correspondingXmls.length() < 1)))){
                return (null);
            };
            if (correspondingXmls.length() > 1){
                //DebugConsole.instance.Trace((("there is more than one " + nodeName) + " child node"), DebugConsole.TRACE_ERROR);
				trace((("there is more than one " + nodeName) + " child node"));
            };
            return (correspondingXmls[0]);
        }

        public static function distance(xa:Number, ya:Number, xb:Number, yb:Number):Number
        {
            return (Math.sqrt((Math.pow((xb - xa), 2) + Math.pow((yb - ya), 2))));
        }

        public static function getRandomElt(array:Array):Object
        {
            if (array.length == 0) {
                return (null);
            };
            return (array[int((Math.random() * array.length))]);
        }

        public static function prettyRound(x:Number):int
        {
            var log:int = (Math.log(x) * Math.LOG10E);
            var flog:Number = Math.pow(10, (log - 1));
            return ((Math.round((x / flog)) * flog));
        }

        public static function getNeighborsNumberToShow(mapPopulation:int):int
        {
            var capsNumber:int;
            var i:int;
            var neighborsNumber:int;
            
			//var PnjCreationPopulationCaps:XML = GlobalInfo.miscSettings.PnjCreationPopulationCaps[0];
			var PnjCreationPopulationCaps:XML;
			throw new Error('fixme');
			
            if (PnjCreationPopulationCaps == null){
				throw new Error("Couldn't find PnjCreationPopulationCaps in miscSettings xml");
                //DebugConsole.Exception("couldn't find PnjCreationPopulationCaps in miscSettings xml");
            } else {
                capsNumber = PnjCreationPopulationCaps.Cap.length();
                i = 0;
                while (i < capsNumber) {
                    if (int(PnjCreationPopulationCaps.Cap.@population[i]) <= mapPopulation){
                        neighborsNumber++;
                    } else {
                        break;
                    };
                    i++;
                };
            };
            return (neighborsNumber);
        }

        public static function getPrettyDate():String
        {
            var date:Date = new Date();
            var day:String = date.getDate().toString();
            var month:String = I18n.instance.getLocalizeString(("date_month_" + date.getMonth()));
            var year:String = date.getFullYear().toString();
            return (((((day + " ") + month) + " ") + year));
        }

        public static function formatDate(timestamp:Number, noSpace:Boolean=false, showMinutes:Boolean=true, showSeconds:Boolean=true):String
        {
            var granularity:int = 3;
            var detail:int = 2;
            var i:int;
            var result:String = "";
            var part:int;
            var pow:int;
            timestamp = (timestamp / 1000);
            if (timestamp <= 0){
                if (showSeconds){
                    return ("0 сек");
                };
                if (showMinutes){
                    return ("0 мин");
                };
                return ("0 ч");
            };
            while ((((granularity >= 0)) && ((i < detail)))) {
                if (((!(showMinutes)) && ((granularity == 1)))){
                    granularity--;
                } else {
                    if (((!(showSeconds)) && ((granularity == 0)))){
                        granularity--;
                    } else {
                        if (granularity == 3){
                            pow = (Math.pow(60, 2) * 24);
                        } else {
                            pow = Math.pow(60, granularity);
                        };
                        if (timestamp < pow){
                            granularity--;
                        } else {
                            part = (timestamp / pow);
                            if ((((i > 0)) && ((part < 10)))){
                                result = (result + "0");
                            };
                            result = (result + part);
                            switch (granularity){
                                case 3:
                                    switch (I18n.language){
                                        case "fr":
                                            result = (result + "j");
                                            break;
                                        case "en":
                                            result = (result + "d");
                                            break;
										case "ru":
											result = (result + " д");
											break;
                                        default:
                                            result = (result + "d");
                                    };
                                    break;
                                case 2:
									switch (I18n.language){
										case "ru":
											result = (result + " ч");
											break;
										default:
                                    		result = (result + "h");
									}
									break;
                                case 1:
									switch (I18n.language){
										case "ru":
											result = (result + " мин");
											break;
										default:
        		                            result = (result + "min");
									}
									break;
                                case 0:
									switch (I18n.language){
										case "ru":
											result = (result + " сек");
											break;
										default:
		                                    result = (result + "s");
									}
                            };
                            if ((((((noSpace == false)) && (((i + 1) < detail)))) && ((granularity > 0)))){
                                result = (result + " ");
                            };
                            timestamp = (timestamp - (part * pow));
                            granularity--;
                            i++;
                        };
                    };
                };
            };
            return (result);
        }

        /*public static function ConvertServerAvatarsToDictionary(param:Object):Dictionary
        {
            var item:Object;
            var avatar:Avatar;
            var avatars:Dictionary = new Dictionary();
            var serverdata:Array = (param as Array);
            for each (item in serverdata) {
                avatar = new Avatar();
                avatar.setFromServerData(item.avatar);
                avatars[(item.userId as String)] = avatar;
            };
            return (avatars);
        }*/

        public static function getViralityInfo(elementType:String):Object
        {
            var xml:* = null;
            var viralityElement:* = null;
            var lootAmount:* = 0;
            var loots:* = 0;
			var itemId:* = null;
			var captionTitle:* = null;
			var captionInfo:* = null;
            var elementType:* = elementType;
            xml = Settings.virality;
            viralityElement = xml..element.(@type == elementType)[0];
            if (viralityElement){
                lootAmount = viralityElement.@lootAmount;
                loots = viralityElement.@loots;
				itemId = viralityElement.@id;
				captionTitle = viralityElement.@captionTitle;
				captionInfo = viralityElement.@captionInfo;
                return ({
                    lootAmount:lootAmount,
                    loots:loots,
					itemId:itemId,
					captionTitle:captionTitle,
					captionInfo:captionInfo
                });
            };
            return (null);
        }

		public static function getGiftByItem(giftItem:String):Object
		{
			var xml:* = null;
			var giftElement:* = null;
			var itemId:* = null;
			var id:* = null;
			var giftItem:* = giftItem;
			xml = Settings.gifts;
			giftElement = xml..gift.(@itemId == giftItem)[0];
			if (giftElement){
				itemId = giftElement.@itemId;
				id = giftElement.@id;				
				return ({
					itemId:itemId,
					id:id
				});
			};
			return (null);
		}
		
        public static function cSharpDateTimeToUnixTime(date:Number):Number
        {
            var res:Number = (date - 62135596800000);
            return (res);
        }

        /*
		public static function hasHardCurreencyAsCost(itemXml:XML):Boolean
        {
            var cost:XML;
            for each (cost in itemXml.Cost) {
                if (String(cost.@type) == CurrenciesAndConditions.HARD_CURRENCY){
                    return (true);
                };
            };
            return (false);
        }*/
		
        public static function getDictionaryOrdredKeys(dictionary:Dictionary):Array
        {
            var key:Object;
            var reference:Array = new Array();
            for (key in dictionary) {
                reference.push(key);
            };
            reference.sort();
            return (reference);
        }


    }
}//package engine.core 
