/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 11:41
 */
package ru.fcl.sdd.preloader
{

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import mx.core.FlexGlobals;
import mx.events.RSLEvent;
import mx.managers.SystemManager;
import mx.preloaders.SparkDownloadProgressBar;

//import ru.fcl.sdd.Preloader1McArt;

import spark.effects.Fade;

public class Preloader extends SparkDownloadProgressBar
{

    [Embed(source="art/star.png")]
    private static const _starClass:Class;
    [Embed(source="art/PreloaderBgArt.jpg")]
    private static const _bgClass:Class;
    [Embed(source="art/AVA_LL.TTF", fontFamily="a_AvanteLt", mimeType="application/x-font", embedAsCFF="false")]
    public var _lightFont:Class;
    [Embed(source="art/AVA_LDB.TTF", fontFamily="AVA_B", mimeType="application/x-font", embedAsCFF="false")]
    public var _boldFont:Class;

    private var _text:TextField = new TextField();
    private var _star:Sprite = new Sprite();
    private var tf:TextFormat;

    private const X_OFFSET:int = 450;
    private const Y_OFFSET:int = 192;

    private var _displayStartCount:uint = 0;
    private var _initProgressCount:uint = 0;
    private var _downloadComplete:Boolean = false;
    private var _showingDisplay:Boolean = false;
    private var _startTime:int;
    private var rslBaseText:String = "";
    private var numberRslTotal:Number = 1;
    private var numberRslCurrent:Number = 1;
    private var preloaderDisplay:DisplayObject;
    public var flashVars:Object;

    public function Preloader()
    {
        super();
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
//        this.width=this.height=800;
    }

    /**
     *  Event listener for the <code>FlexEvent.INIT_COMPLETE</code> event.
     *  NOTE: This event can be commented out to stop preloader from completing during testing
     */
    override protected function initCompleteHandler(event:Event):void
    {
        FlexGlobals.topLevelApplication.flashVars = flashVars;
        FlexGlobals.topLevelApplication.addEventListener("applicationReady", dispatchInitComplete);
        FlexGlobals.topLevelApplication.startInit();
    }

    private function dispatchInitComplete(event:Event):void
    {
        SystemManager.getSWFRoot(FlexGlobals.topLevelApplication).visible = true;
        _star.removeEventListener(Event.ENTER_FRAME, rotateStar);
        var fade:Fade = new Fade(this);
        fade.alphaTo = 0;
        fade.duration = 1000;
        fade.play();
        setTimeout(function ():void
        {
            dispatchEvent(new Event(Event.COMPLETE))
        }, 1000);
    }

    /**
     *  Creates the subcomponents of the display.
     */
    override protected function createChildren():void
    {
        if (!preloaderDisplay)
        {
            preloaderDisplay = new _bgClass();

            var startX:Number = Math.round((stageWidth - preloaderDisplay.width) / 2) + X_OFFSET;
            var startY:Number = Math.round((stageHeight - preloaderDisplay.height) / 2) + Y_OFFSET;

//            preloaderDisplay.x = startX;
//            preloaderDisplay.y = startY;
            addChild(preloaderDisplay);

            var s:DisplayObject = new _starClass();
//            addChild(_star);
            _star.addChild(s);
            s.y = s.x = -s.width / 2;
            _star.x = stage.stageWidth / 2;
            _star.y = 150;
            _star.addEventListener(Event.ENTER_FRAME, rotateStar);

//            addChild(_text);

            tf = new TextFormat();
            tf.font = 'AVA_B';
            tf.size = 54;
            tf.align = 'center';

            _text.embedFonts = true;
            _text.antiAliasType = "advanced";
            _text.textColor = 0x00b500;
            _text.defaultTextFormat = tf;

            _text.autoSize = TextFieldAutoSize.LEFT;
            _text.y = stageHeight - 400;
        }
    }

    /**
     * Event listener for the <code>ProgressEvent.PROGRESS event</code> event.
     * Download of the first SWF app
     **/
    override protected function progressHandler(evt:ProgressEvent):void
    {
        if (preloaderDisplay)
        {
            var progressApp:int = Math.round((evt.bytesLoaded / evt.bytesLoaded) * 100);

            //Main Progress displays the shape of the logo
//            preloaderDisplay.gotoAndStop(progressApp);

            setPreloaderLoadingText(rslBaseText + Math.round((evt.bytesLoaded / evt.bytesLoaded) * 100).toString() +
                    "%");
        } else
        {
            show();
        }
    }

    private function rotateStar(e:Event):void
    {
        _star.rotation += 3;
    }

    /**
     * Event listener for the <code>RSLEvent.RSL_PROGRESS</code> event.
     **/
    override protected function rslProgressHandler(evt:RSLEvent):void
    {
        if (evt.rslIndex && evt.rslTotal)
        {

            numberRslTotal = evt.rslTotal;
            numberRslCurrent = evt.rslIndex;
            rslBaseText = "loading RSLs (" + evt.rslIndex + " of " + evt.rslTotal + ") ";

            var progressRsl:Number = Math.round((evt.bytesLoaded / evt.bytesTotal) * 100);

//            preloaderDisplay.setDownloadRSLProgress(Math.round((numberRslCurrent - 1) * 100 / numberRslTotal +
//                    progressRsl / numberRslTotal));

            //setPreloaderLoadingText(rslBaseText + Math.round((evt.bytesLoaded / evt.bytesTotal) * 100).toString() + "%");
        }
    }

    /**
     *  indicate download progress.
     */
    override protected function setDownloadProgress(completed:Number, total:Number):void
    {
        if (preloaderDisplay)
        {
            //useless class in my case. I manage the display changes directly in the Progress handlers
        }
    }

    /**
     *  Updates the inner portion of the download progress bar to
     *  indicate initialization progress.
     */
    override protected function setInitProgress(completed:Number, total:Number):void
    {
        if (preloaderDisplay)
        {
            //set the initialization progress : red square fades out
            //preloaderDisplay.setInitAppProgress(Math.round((completed/total)*100));

            //set loading text
            if (completed > total)
            {
                //setPreloaderLoadingText("ready for action");
            } else
            {
                //setPreloaderLoadingText("initializing " + completed + " of " + total);
            }
        }
    }

    /**
     *  Event listener for the <code>FlexEvent.INIT_PROGRESS</code> event.
     *  This implementation updates the progress bar
     *  each time the event is dispatched.
     */
    override protected function initProgressHandler(event:Event):void
    {
        var elapsedTime:int = getTimer() - _startTime;
        _initProgressCount++;

        if (!_showingDisplay && showDisplayForInit(elapsedTime, _initProgressCount))
        {
            _displayStartCount = _initProgressCount;
            show();
            // If we are showing the progress for the first time here, we need to call setDownloadProgress() once to set the progress bar background.
            setDownloadProgress(100, 100);
        }

        if (_showingDisplay)
        {
            // if show() did not actually show because of SWFObject bug then we may need to set the download bar background here
            if (!_downloadComplete)
            {
                setDownloadProgress(100, 100);
            }
            setInitProgress(_initProgressCount, initProgressTotal);
        }
    }

    private function show():void
    {
        // swfobject reports 0 sometimes at startup
        // if we get zero, wait and try on next attempt
        if (stageWidth == 0 && stageHeight == 0)
        {
            try
            {
                stageWidth = stage.stageWidth;
                stageHeight = stage.stageHeight
            }
            catch (e:Error)
            {
                stageWidth = loaderInfo.width;
                stageHeight = loaderInfo.height;
            }
            if (stageWidth == 0 && stageHeight == 0)
            {
                return;
            }
        }
        _showingDisplay = true;
        createChildren();
    }

    private function setPreloaderLoadingText(value:String):void
    {
        _text.text = value;
        _text.x = (stage.stageWidth - _text.textWidth) / 2;
    }

    private function addedToStageHandler(event:Event):void
    {
        flashVars = new Object();
        flashVars = stage.loaderInfo.parameters;
    }
}
}
