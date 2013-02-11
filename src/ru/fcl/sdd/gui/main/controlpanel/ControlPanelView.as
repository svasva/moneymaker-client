/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.controlpanel
{
import flash.display.SimpleButton;
import flash.display.Sprite;

import ru.fcl.sdd.gui.ExtendedButton;
import ru.fcl.sdd.rsl.GuiRsl;

public class ControlPanelView extends Sprite
{
    [Inject]
    public var rsl:GuiRsl;

    private var _bg:Sprite;
    private var _shopBtn:ExtendedButton;
    private var _floorDownBtn:ExtendedButton;
    private var _floorUpBtn:ExtendedButton;
	private var _configBtn:ExtendedButton;
	private var _fullscreenBtn:ExtendedButton;
	private var _statisticBtn:ExtendedButton;
	private var _mapBtn:ExtendedButton;
	private var _missionBtn:ExtendedButton;
	private var _postBtn:ExtendedButton;
	private var _rateBtn:ExtendedButton;
    private var _zoomInBtn:SimpleButton;
    private var _zoomOutBtn:SimpleButton;


    [PostConstruct]
    public function init():void
    {
        _bg = rsl.getCpBarArtInstance;
		_bg.x = 22;
		_bg.y = 34;
        this.addChild(_bg);

        _shopBtn = createExtendedButton( "ButtonShop" );
        _shopBtn.y = 43;
		this.addChild(_shopBtn);

        _floorDownBtn = createExtendedButton( "ButtonDown" );
        _floorDownBtn.x = 47;
        _floorDownBtn.y = 146;
        this.addChild(_floorDownBtn);

        _floorUpBtn = createExtendedButton( "ButtonUp" );
        _floorUpBtn.y = 102;
        this.addChild(_floorUpBtn);

        _zoomInBtn = createSimpleButton( "ButtonInc" );
        _zoomInBtn.x = 160;
        _zoomInBtn.y = 180;
        this.addChild(_zoomInBtn);

        _zoomOutBtn = createSimpleButton( "ButtonDec" );
        _zoomOutBtn.x = 160;
        _zoomOutBtn.y = 202;
        this.addChild(_zoomOutBtn);
		
		_configBtn = createExtendedButton( "ButtonConfig" );
		_configBtn.x = 104;
		_configBtn.y = 146;
		_configBtn.locked = true;
		//this.addChild(_configBtn);
		
		_missionBtn = createExtendedButton( "ButtonMission" );
		_missionBtn.x = 47;
	//	_missionBtn.locked = true;
		this.addChild(_missionBtn);
		
		_fullscreenBtn = createExtendedButton( "ButtonFullscreen" );
		_fullscreenBtn.x = 181;
		_fullscreenBtn.y = 185;
		_fullscreenBtn.locked = true;
		this.addChild(_fullscreenBtn);
		
		_statisticBtn = createExtendedButton( "StatisticButton" );
		_statisticBtn.x = 52;
		_statisticBtn.y = 64;
		_statisticBtn.locked = true;
		this.addChild(_statisticBtn);
		
		_mapBtn = createExtendedButton( "ButtonMap" );
		_mapBtn.x = 110;
		_mapBtn.y = 1;
		_mapBtn.locked = true;
	//	this.addChild(_mapBtn);
		
		_postBtn = createExtendedButton( "ButtonPost" );
		_postBtn.x = 152;
		_postBtn.y = 102;
		//_postBtn.locked = true;
		this.addChild(_postBtn);
		
		_rateBtn = createExtendedButton( "ButtonRate" );
		_rateBtn.x = 152;
		_rateBtn.y = 45;
	//	_rateBtn.locked = true;
		this.addChild(_rateBtn);
    }
	
	private function createExtendedButton( baseName:String ):ExtendedButton
	{
		return new ExtendedButton( getAsset(baseName + "Up"), getAsset(baseName + "Over"), getAsset(baseName + "Down"), getAsset(baseName + "Down"), getAsset(baseName + "NoActive") );
	}
	
	private function createSimpleButton( baseName:String ):SimpleButton
	{
		return new SimpleButton( getAsset(baseName + "Up"), getAsset(baseName + "Over"), getAsset(baseName + "Down"), getAsset(baseName + "Down") );
	}

    private function getAsset(clazz:String):*
    {
        return rsl.getAsset("gui.MainPanel."+clazz);
    }

    private function draw():void
    {

    }

    public function get shopBtn():ExtendedButton
    {
        return _shopBtn;
    }

    public function set shopBtn(value:ExtendedButton):void
    {
        _shopBtn = value;
    }

    public function get floorDownBtn():ExtendedButton
    {
        return _floorDownBtn;
    }

    public function set floorDownBtn(value:ExtendedButton):void
    {
        _floorDownBtn = value;
    }

    public function get floorUpBtn():ExtendedButton
    {
        return _floorUpBtn;
    }

    public function set floorUpBtn(value:ExtendedButton):void
    {
        _floorUpBtn = value;
    }

    public function get zoomInBtn():SimpleButton
    {
        return _zoomInBtn;
    }

    public function set zoomInBtn(value:SimpleButton):void
    {
        _zoomInBtn = value;
    }

    public function get zoomOutBtn():SimpleButton
    {
        return _zoomOutBtn;
    }

    public function set zoomOutBtn(value:SimpleButton):void
    {
        _zoomOutBtn = value;
    }

	public function get configBtn():ExtendedButton
	{
		return _configBtn;
	}

	public function set configBtn(value:ExtendedButton):void
	{
		_configBtn = value;
	}

	public function get fullscreenBtn():ExtendedButton
	{
		return _fullscreenBtn;
	}

	public function set fullscreenBtn(value:ExtendedButton):void
	{
		_fullscreenBtn = value;
	}

	public function get statisticBtn():ExtendedButton
	{
		return _statisticBtn;
	}

	public function set statisticBtn(value:ExtendedButton):void
	{
		_statisticBtn = value;
	}

	public function get mapBtn():ExtendedButton
	{
		return _mapBtn;
	}

	public function set mapBtn(value:ExtendedButton):void
	{
		_mapBtn = value;
	}

	public function get missionBtn():ExtendedButton
	{
		return _missionBtn;
	}

	public function set missionBtn(value:ExtendedButton):void
	{
		_missionBtn = value;
	}

	public function get postBtn():ExtendedButton
	{
		return _postBtn;
	}

	public function set postBtn(value:ExtendedButton):void
	{
		_postBtn = value;
	}

	public function get rateBtn():ExtendedButton
	{
		return _rateBtn;
	}

	public function set rateBtn(value:ExtendedButton):void
	{
		_rateBtn = value;
	}


}
}
