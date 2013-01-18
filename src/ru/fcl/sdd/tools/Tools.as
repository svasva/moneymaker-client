package ru.fcl.sdd.tools
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard;
    
    public class Tools
    {
//---------------------------------------------------------------------
        public static var invPI:Number = 180 / Math.PI;
        
        
        public static function Random(min:Number, max:Number):Number
        {
            return min + Math.random() * (max - min);
        }
        
//---------------------------------------------------------------------
        
        public static function UintToArgb(argb:uint):Array
        {
            var arARGB:Array = new Array();
            arARGB.push(argb >> 24 & 0xFF);
            arARGB.push(argb >> 16 & 0xFF);
            arARGB.push(argb >> 8 & 0xFF);
            arARGB.push(argb & 0xFF);
            return arARGB;
        }
        
//---------------------------------------------------------------------
        
        public static function ArgbToUint(arARGB:Array):uint
        {
            var argb:uint = 0;
            argb += (arARGB[0] << 24);
            argb += (arARGB[1] << 16);
            argb += (arARGB[2] << 8);
            argb += (arARGB[3]);
            return argb;
        }
        
//---------------------------------------------------------------------
        
        public static function BitmapToPixelBitmap(bmp:Bitmap, threshold:int):void
        {
            for (var i:Number = 0; i < bmp.bitmapData.width; i++ )
            {
                for ( var j:Number = 0; j < bmp.bitmapData.height; j++ )
                {
                    var color:uint = bmp.bitmapData.getPixel32(i, j);
                    var arr:Array = UintToArgb(color);
                    if (arr[0] > 0 && arr[0] < 255 )
                    {
                        arr[0] = (arr[0] < threshold) ? 0 : 255;
                        color = ArgbToUint(arr);
                        bmp.bitmapData.setPixel32(i, j, color);
                    }
                }
            }
        }
        
//---------------------------------------------------------------------
        
        /** 180 deg -> 3.14 rad */
        public static function radians(deg:Number):Number
        {
            return deg / invPI;
        }
        
//---------------------------------------------------------------------
        
        /** 3.14 rad -> 180 deg */
        public static function degrees(rad:Number):Number
        {
            return rad * invPI;
        }
        
//---------------------------------------------------------------------
        
        public static function GetAngle(firstPnt:Point, secondPnt:Point):Number
        {
            var width:Number = -(firstPnt.x - secondPnt.x);
            var height:Number = (firstPnt.y - secondPnt.y);
            var length:Number = Math.sqrt(width * width + height * height);
            var angle:Number = Math.asin(height / length);
            if (width < 0 ) 
                angle = Math.PI - angle;
            return angle;
        }
        
//---------------------------------------------------------------------
        
        public static function clamp(f:int, min:int, max:int):int
        {
            return (f < min) ? min : ( (f > max) ? max : f );
        }
        
//---------------------------------------------------------------------
        
        public static function clampf(f:Number, min:Number, max:Number):Number
        {
            return (f < min) ? min : ( (f > max) ? max : f );
        }
        
//---------------------------------------------------------------------
        
        public static function random(min:Number, max:Number):Number
        {
            return min + (max - min)*Math.random();
        }
        
//---------------------------------------------------------------------
        
        public static function randomf():Number
        {
            return Math.random();
        }
        
//---------------------------------------------------------------------
        
        public static function randomi(max:int):int
        {
            return max * Math.random();
        }
        
//---------------------------------------------------------------------
        
        public static function lerp(f1:Number, f2:Number, alpha:Number):Number
        {
            return f1 + (f2 - f1)*alpha;
        }
        
//---------------------------------------------------------------------
        
        public static function fmodf(val:Number, cropTo:Number):Number
        {
            if (val >= 0 )
                return val % cropTo;
            else
            {
                val = val % cropTo;
                if ( val < 0 )
                    return val + cropTo;
                else
                    return val;
            }
        }
        
//---------------------------------------------------------------------
        
        public static function TileImage(tileTexture:BitmapData, target:BitmapData, region:Rectangle, textureRect:Rectangle = null):void
        {
            var remWidth:int = region.width;
            var remHight:int = region.height;
            var xx:int = region.x;
            var yy:int = region.y;
            var imgWidth:int;
            var imgHeight:int;
            
            var texX:int = (textureRect != null) ? textureRect.x : 0;
            var texY:int = (textureRect != null) ? textureRect.y : 0;
            var texWidth:int = (textureRect != null) ? textureRect.width : tileTexture.width;
            var texHeight:int = (textureRect != null) ? textureRect.height : tileTexture.height;
            
            for (;;)
            {
                imgWidth = Math.min(texWidth, remWidth);
                imgHeight = Math.min(texHeight, remHight);
                target.copyPixels(tileTexture, new Rectangle(texX, texY, imgWidth, imgHeight), new Point(xx, yy), null, null, true);
                
                xx += imgWidth;
                remWidth -= imgWidth;
                if ( remWidth <= 0 )
                {
                    xx = region.x;
                    remWidth = region.width;
                    yy += imgHeight;
                    remHight -= imgHeight;
                }
                if ( remHight <= 0 )
                    break;
            }			
        }
        
//---------------------------------------------------------------------
        
        public static function GetRotationOffsetDeg(angleDeg:Number, centerOfsX:Number, centerOfsY:Number):Point
        {
            var radius:Number = Math.sqrt(centerOfsX * centerOfsX + centerOfsY * centerOfsY);
            var angle:Number;
            if ( radius != 0 )
            {
                angle = Math.asin(centerOfsY / radius);
                if (centerOfsX < 0 ) 
                    angle = Math.PI - angle;
            }
            else
                angle = 0;
            
            return new Point(-Math.cos(angleDeg / invPI + angle) * radius + centerOfsX, -Math.sin(angleDeg / invPI + angle) * radius + centerOfsY);
        }
        
//---------------------------------------------------------------------
        
        public static function GetRotationOffsetRad(angleRad:Number, centerOfsX:Number, centerOfsY:Number):Point
        {
            var radius:Number = Math.sqrt(centerOfsX * centerOfsX + centerOfsY * centerOfsY);
            var angle:Number;
            if ( radius != 0 )
            {
                angle = Math.asin(centerOfsY / radius);
                if (centerOfsX < 0 ) 
                    angle = Math.PI - angle;
            }
            else
                angle = 0;
            
            return new Point(-Math.cos(angleRad + angle) * radius + centerOfsX, -Math.sin(angleRad + angle) * radius + centerOfsY);
        }
        
//---------------------------------------------------------------------
        
        public static function Fill9GridTexture(source:BitmapData, texture:BitmapData, centerTexRect:Rectangle, centerSize:Point):void
        {
            // 1 2 3
            // 4 5 6	centerTexRect - размер пятерки на текстуре
            // 7 8 9	centerSize - размер пятерки требуемый
            
            // 1
            source.copyPixels(texture, new Rectangle(0, 0, centerTexRect.x, centerTexRect.y), new Point(0, 0), null, null, true);
            
            // 3
            source.copyPixels(texture, new Rectangle(centerTexRect.x + centerTexRect.width, 0, texture.width - (centerTexRect.x + centerTexRect.width), centerTexRect.y),
                new Point(centerTexRect.x + centerSize.x, 0), null, null, true);
            
            // 7
            source.copyPixels(texture, new Rectangle(0, centerTexRect.y + centerTexRect.height, centerTexRect.x, texture.height - (centerTexRect.y + centerTexRect.height)),
                new Point(0, centerTexRect.y + centerSize.y), null, null, true);
            
            // 9
            source.copyPixels(texture, new Rectangle(centerTexRect.x + centerTexRect.width, centerTexRect.y + centerTexRect.height, texture.width - (centerTexRect.x + centerTexRect.width), texture.height - (centerTexRect.y + centerTexRect.height)),
                new Point(centerTexRect.x + centerSize.x, centerTexRect.y + centerSize.y), null, null, true);
            
            if (centerTexRect.width > 0 && centerSize.x > 0 )
            {
                // 2
                TileImage(texture, source, new Rectangle(centerTexRect.x, 0, centerSize.x, centerTexRect.y), new Rectangle(centerTexRect.x, 0, centerTexRect.width, centerTexRect.y));
                
                // 8
                TileImage(texture, source, new Rectangle(centerTexRect.x, centerTexRect.y + centerSize.y, centerSize.x, texture.height - (centerTexRect.y + centerTexRect.height)),
                    new Rectangle(centerTexRect.x, centerTexRect.y + centerTexRect.height, centerTexRect.width, texture.height - (centerTexRect.y + centerTexRect.height)) );
            }
            
            if ( centerTexRect.height > 0 && centerSize.y > 0 )
            {
                // 4
                TileImage(texture, source, new Rectangle(0, centerTexRect.y, centerTexRect.x, centerSize.y), new Rectangle(0, centerTexRect.y, centerTexRect.x, centerTexRect.height));
                
                // 6
                TileImage(texture, source, new Rectangle(centerTexRect.x + centerSize.x, centerTexRect.y, texture.width - (centerTexRect.x + centerTexRect.width), centerSize.y),
                    new Rectangle(centerTexRect.x + centerTexRect.width, centerTexRect.y, texture.width - (centerTexRect.x + centerTexRect.width), centerTexRect.height) );
            }
            
            if ( centerTexRect.height > 0 && centerSize.y > 0 && centerTexRect.width > 0 && centerSize.x > 0 )
            {
                // 5
                TileImage(texture, source, new Rectangle(centerTexRect.x, centerTexRect.y, centerSize.x, centerSize.y), new Rectangle(centerTexRect.x, centerTexRect.y, centerTexRect.width, centerTexRect.height));
            }
        }
        
//---------------------------------------------------------------------
        
        public static function UpdatePopupScale(currentScale:Number, maxScale:Number, isIncrease:Boolean, step:Number):Number
        {
            var maxValue:Number = (maxScale * 2.0) - 1.0;
            
            if ( isIncrease && currentScale < maxValue )
            {
                if ( currentScale < maxValue )
                {
                    if ( currentScale < maxScale )		currentScale += (maxScale + 0.07 - currentScale) * step * 8;
                    else								currentScale += (maxValue + 0.07 - currentScale) * step * 5;
                    
                    if ( currentScale > maxValue )			
                        currentScale = maxValue;	
                }
            }
            else if ( !isIncrease && currentScale > 0.0 )
            {
                if ( currentScale > 0.0 )
                {
                    if ( currentScale > maxScale )		currentScale -= (maxValue + 0.07 - currentScale) * step * 5;
                    else								currentScale -= (maxScale + 0.07 - currentScale) * step * 8;
                    
                    if ( currentScale < 0.0 )
                        currentScale = 0.0;
                }
            }
            return currentScale;
        }
        
// функция определяет с какой стороны находится точка относительно отрезка
//public static function Classify( p0x:Number, p0y:Number, p1x:Number, p1y:Number, p2x:Number, p2y:Number ):int
        public static function IsOnTrueSide(p0x:Number, p0y:Number, p1x:Number, p1y:Number, p2x:Number, p2y:Number):Boolean
        {
            var sa:Number = (p1x - p0x) * (p2y - p0y) - (p2x - p0x) * (p1y - p0y);
            
            //if (sa > 0.0)									return CLS_LEFT;		// СЛЕВА
            //if (sa < 0.0)									return CLS_RIGHT;		// СПРАВА
            //if ((a.x * b.x < 0.0) || (a.y * b.y < 0.0))	return CLS_BEHIND;		// ПОЗАДИ
            //if (a.length() < b.length()/*длина вектора*/)	return CLS_BEYOND;		// ВПЕРЕДИ
            //if (p0 == p2)									return CLS_ORIGIN;		// НАЧАЛО
            //if (p1 == p2)									return CLS_DESTINATION;	// КОНЕЦ
            //return CLS_BETWEEN;													// МЕЖДУ
            
            if (sa > 0.0)		
                return false;	// СЛЕВА
            else
                return true;	// ВСЕ ОСТАЛЬНОЕ
        /*if (sa < 0.0)
           return true;	// СПРАВА
           else
         return false;	// ВСЕ ОСТАЛЬНОЕ*/
        }
        
//---------------------------------------------------------------------
        
        public static function PointInTriangle(px:Number, py:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):Boolean
        {
            return ( IsOnTrueSide(ax, ay, bx, by, px, py) && IsOnTrueSide(bx, by, cx, cy, px, py) && IsOnTrueSide(cx, cy, ax, ay, px, py));
        }
        
//---------------------------------------------------------------------
        
        public static function MergeMaskWithBitmap(image:BitmapData, mask:BitmapData):Bitmap
        {
            var alphaImage:Bitmap = new Bitmap(new BitmapData(image.width, image.height));
            alphaImage.bitmapData.copyPixels(image, new Rectangle(0, 0, image.width, image.height), new Point());
            alphaImage.bitmapData.copyChannel(mask, new Rectangle(0, 0, image.width, image.height), new Point(), BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);
            return alphaImage;
        }
        
//---------------------------------------------------------------------
        
        public static function CompareNoCase(str1:String, str2:String):Boolean
        {
            return (str1.toLowerCase().localeCompare(str2.toLowerCase()) == 0);
        }
        
//---------------------------------------------------------------------
        
        public static function TrimSpaces(str:String):String
        {
            while (str.length > 0 && str.charCodeAt(0) == Keyboard.SPACE)
                str = str.slice(1, str.length);
            while (str.length > 0 && str.charCodeAt(str.length - 1) == Keyboard.SPACE)
                str = str.slice(0, str.length - 1);
            return str;
        }
        
//---------------------------------------------------------------------
        
        public static function ParseBoolean(str:String):Boolean
        {
            str = TrimSpaces(str);
            return (str == "true");
        }
        
//---------------------------------------------------------------------
        
//public static function ParsePointI( str:String ):PointI
//{
//	str = TrimSpaces( str );
//	var pnt:PointI = new PointI();
//	var strArr:SArray = Utils.Split( str, " " );
//	if ( strArr.length == 2 )
//	{
//		pnt.x = int( strArr[0] );
//		pnt.y = int( strArr[1] );
//	}
//	else
//		throw( "wrong parse" );
//	return pnt;
//}
//
////---------------------------------------------------------------------
//
//public static function ParsePointF( str:String ):Point
//{
//	str = TrimSpaces( str );
//	var pnt:Point = new Point();
//	var strArr:SArray = Utils.Split( str, " " );
//	if ( strArr.length == 2 )
//	{
//		pnt.x = Number( strArr[0] );
//		pnt.y = Number( strArr[1] );
//	}
//	else
//		throw( "wrong parse" );
//	return pnt;
//}
//
////---------------------------------------------------------------------
//
//public static function ParseRectF( str:String ):RectF
//{
//	str = TrimSpaces( str );
//	var rect:RectF = new RectF();
//	var strArr:SArray = Utils.Split( str, " " );
//	if ( strArr.length == 4 )
//	{
//		rect.x = Number( strArr[0] );
//		rect.y = Number( strArr[1] );
//		rect.width = Number( strArr[2] );
//		rect.height = Number( strArr[3] );
//	}
//	else
//		throw( "wrong parse" );
//	return rect;
//}
//
////---------------------------------------------------------------------
//
//public static function ParseRectI( str:String ):RectI
//{
//	str = TrimSpaces( str );
//	var rect:RectI = new RectI();
//	var strArr:SArray = Utils.Split( str, " " );
//	if ( strArr.length == 4 )
//	{
//		rect.x = int( strArr[0] );
//		rect.y = int( strArr[1] );
//		rect.width = int( strArr[2] );
//		rect.height = int( strArr[3] );
//	}
//	else
//		throw( "wrong parse" );
//	return rect;
//}
//
////---------------------------------------------------------------------
//
//public static function ParseSizeF( str:String ):SizeF
//{
//	str = TrimSpaces( str );
//	var size:SizeF = new SizeF();
//	var strArr:SArray = Utils.Split( str, " " );
//	if ( strArr.length == 2 )
//	{
//		size.width = Number( strArr[0] );
//		size.height = Number( strArr[1] );
//	}
//	else
//		throw( "wrong parse" );
//	return size;
//}
//
////---------------------------------------------------------------------
//
//public static function ParseSizeI( str:String ):SizeI
//{
//	str = TrimSpaces( str );
//	var size:SizeI = new SizeI();
//	var strArr:SArray = Utils.Split( str, " " );
//	if ( strArr.length == 2 )
//	{
//		size.width = int( strArr[0] );
//		size.height = int( strArr[1] );
//	}
//	else
//		throw( "wrong parse" );
//	return size;
//}
//
////---------------------------------------------------------------------
//
//public static function ParseArrayFloat( str:String ):SArray
//{
//	str = TrimSpaces( str );
//	var arr:SArray = new SArray();
//	var strArr:SArray = Utils.Split( str, "," );
//	for ( var i:int= 0; i < strArr.length; i++ )
//		arr.push( Number( strArr[i] ) );
//	return arr;
//}
//
////---------------------------------------------------------------------
//
//public static function ParseArrayInt( str:String ):SArray
//{
//	str = TrimSpaces( str );
//	var arr:SArray = new SArray();
//	var strArr:SArray = Utils.Split( str, "," );
//	for ( var i:int= 0; i < strArr.length; i++ )
//		arr.push( int( strArr[i] ) );
//	return arr;
//}
        
//---------------------------------------------------------------------
        
        public static function GetOverlayModeAddMatrix(r:int, g:int, b:int):ColorMatrixFilter
        {
            return new ColorMatrixFilter([1.0, 0.0, 0.0, 0.0, r, 0.0, 1.0, 0.0, 0.0, g, 0.0, 0.0, 1.0, 0.0, b, 0.0, 0.0, 0.0, 1.0, 0.0]);
        }
        
//---------------------------------------------------------------------
        
        public static function GetOverlayModeMultiplyMatrix(r:int, g:int, b:int):ColorMatrixFilter
        {
            return new ColorMatrixFilter([r / 255, 0.0, 0.0, 0.0, 0.0, 0.0, g / 255, 0.0, 0.0, 0.0, 0.0, 0.0, b / 255, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0]);
        }
        
//---------------------------------------------------------------------
        
        public static function GetOverlayModeGrayscaleMatrix():ColorMatrixFilter
        {
            return new ColorMatrixFilter([0.5, 0.5, 0.5, 0.0, 0, 0.5, 0.5, 0.5, 0.0, 0, 0.5, 0.5, 0.5, 0.0, 0, 0.0, 0.0, 0.0, 1.0, 0]);
        }
        
//---------------------------------------------------------------------
        
        public static function Printf(format:String, ... args):String
        {
            var result:String = "";
            
            var length:int = format.length;
            for (var i:int = 0; i < length; i++)
            {
                var c:String = format.charAt(i);
                
                if (c == "%")
                {
                    var next: *;
                    var str: String;
                    var pastFieldWidth:Boolean = false;
                    var pastFlags:Boolean = false;
                    
                    var flagAlternateForm:Boolean = false;
                    var flagZeroPad:Boolean = false;
                    var flagLeftJustify:Boolean = false;
                    var flagSpace:Boolean = false;
                    var flagSign:Boolean = false;
                    
                    var fieldWidth:String = "";
                    var precision:String = "";
                    
                    c = format.charAt(++i);
                    
                    while (c != "d"
                        && c != "i"
                        && c != "o"
                        && c != "u"
                        && c != "x"
                        && c != "X"
                        && c != "f"
                        && c != "F"
                        && c != "c"
                        && c != "s"
                        && c != "%")
                    {
                        if (!pastFlags)
                        {
                            if (!flagAlternateForm && c == "#")
                                flagAlternateForm = true;
                            else if (!flagZeroPad && c == "0")
                                flagZeroPad = true;
                            else if (!flagLeftJustify && c == "-")
                                flagLeftJustify = true;
                            else if (!flagSpace && c == " ")
                                flagSpace = true;
                            else if (!flagSign && c == "+")
                                flagSign = true;
                            else
                                pastFlags = true;
                        }
                        
                        if (!pastFieldWidth && c == ".")
                        {
                            pastFlags = true;
                            pastFieldWidth = true;
                            
                            c = format.charAt(++i);
                            continue;
                        }
                        
                        if (pastFlags)
                        {
                            if (!pastFieldWidth)
                                fieldWidth += c;
                            else
                                precision += c;
                        }
                        
                        c = format.charAt(++i);
                    }
                    
                    switch (c)
                    {
                        case "d":
                        case "i":
                            next = args.shift();
                            str = String(Math.abs(int(next)));
                            
                            if (precision != "")
                                str = leftPad(str, int(precision), "0");
                            
                            if (int(next) < 0)
                                str = "-" + str;
                            else if (flagSign && int(next) >= 0)
                                str = "+" + str;
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else if (flagZeroPad && precision == "")
                                    str = leftPad(str, int(fieldWidth), "0");
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            result += str;
                            break;
                        
                        case "o":
                            next = args.shift();
                            str = uint(next).toString(8);
                            
                            if (flagAlternateForm && str != "0")
                                str = "0" + str;
                            
                            if (precision != "")
                                str = leftPad(str, int(precision), "0");
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else if (flagZeroPad && precision == "")
                                    str = leftPad(str, int(fieldWidth), "0");
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            result += str;
                            break;
                        
                        case "u":
                            next = args.shift();
                            str = uint(next).toString(10);
                            
                            if (precision != "")
                                str = leftPad(str, int(precision), "0");
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else if (flagZeroPad && precision == "")
                                    str = leftPad(str, int(fieldWidth), "0");
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            result += str;
                            break;
                        
                        case "X":
                            var capitalise:Boolean = true;
                        case "x":
                            next = args.shift();
                            str = uint(next).toString(16);
                            
                            if (precision != "")
                                str = leftPad(str, int(precision), "0");
                            
                            var prepend:Boolean = flagAlternateForm && uint(next) != 0;
                            
                            if (fieldWidth != "" && !flagLeftJustify
                                && flagZeroPad && precision == "")
                                str = leftPad(str, prepend ? int(fieldWidth) - 2 : int(fieldWidth), "0");
                            
                            if (prepend)
                                str = "0x" + str;
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            if (capitalise)
                                str = str.toUpperCase();
                            
                            result += str;
                            break;
                        
                        case "f":
                        case "F":
                            next = args.shift();
                            str = Math.abs(Number(next)).toFixed(precision != "" ? int(precision) : 6);
                            
                            if (int(next) < 0)
                                str = "-" + str;
                            else if (flagSign && int(next) >= 0)
                                str = "+" + str;
                            
                            if (flagAlternateForm && str.indexOf(".") == -1)
                                str += ".";
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else if (flagZeroPad && precision == "")
                                    str = leftPad(str, int(fieldWidth), "0");
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            result += str;
                            break;
                        
                        case "c":
                            next = args.shift();
                            str = String.fromCharCode(int(next));
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            result += str;
                            break;
                        
                        case "s":
                            next = args.shift();
                            str = String(next);
                            
                            if (precision != "")
                                str = str.substring(0, int(precision));
                            
                            if (fieldWidth != "")
                            {
                                if (flagLeftJustify)
                                    str = rightPad(str, int(fieldWidth));
                                else
                                    str = leftPad(str, int(fieldWidth));
                            }
                            
                            result += str;
                            break;
                        
                        case "%":
                            result += "%";
                    }
                }
                else
                {
                    result += c;
                }
            }
            
            return result;
        }
        
        
        private static function leftPad(source:String, targetLength:int, padChar:String = " "):String
        {
            if (source.length < targetLength)
            {
                var padding:String = "";
                
                while (padding.length + source.length < targetLength)
                    padding += padChar;
                
                return padding + source;
            }
            
            return source;
        }
        
        
        private static function rightPad(source:String, targetLength:int, padChar:String = " "):String
        {
            while (source.length < targetLength)
                source += padChar;
            
            return source;
        }
        
        
        public static function FormatMoneyString(count:int, noCurrencySymbol:Boolean = true):String
        {
            var string:String;
            var negative:Boolean = (count < 0 );
            
            if ( negative )
                count = -count;
            
            var currencyGroupSeparator:String = ",";
            var currencyPositivePattern:String = "$%s";
            var currencyNegativePattern:String = "-$%s";
            
            var gs:String = currencyGroupSeparator;
            
            if ( count < 1000 )
                string = String(count);
            else if (count < 1000000 )
                string = Printf("%i%s%03i", int(count / 1000), gs, count % 1000);
            else if (count < 1000000000 )
                string = Printf("%i%s%03i%s%03i", int(count / 1000000), gs, int(count / 1000) % 1000, gs, count % 1000);
            else
                string = Printf("%i%s%03i%s%03i%s%03i", int(count / 1000000000), gs, int(count / 1000000) % 1000, gs, int(count / 1000) % 1000, gs, count % 1000);
            
            if (noCurrencySymbol )
            {
                if ( !negative )
                    return string;
                else
                    return "-" + string;
            }
            else
            {
                if ( negative )
                    return Printf(currencyNegativePattern, string);
                else
                    return Printf(currencyPositivePattern, string);
            }
        }
    }
}

