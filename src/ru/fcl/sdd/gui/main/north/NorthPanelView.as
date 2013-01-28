/**
 * User: Jessie
 * Date: 19.11.12
 * Time: 18:40
 */
package ru.fcl.sdd.gui.main.north
{
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import ru.fcl.sdd.gui.textformats.StatisticNumberTextFormatLeft;
    
    import org.aswing.JLabel;
    
    import ru.fcl.sdd.gui.GameProgressBar;
    import ru.fcl.sdd.gui.textformats.StatisticNumberTextField;
    import ru.fcl.sdd.rsl.GuiRsl;
    import ru.fcl.sdd.tools.Tools;
    
    public class NorthPanelView extends Sprite
    {
        [Inject]
        public var rsl:GuiRsl;
        private var _bg:Sprite;
        
        private var _gameMoneyTextField:StatisticNumberTextField;
        private var _realMoneyTextField:StatisticNumberTextField;
        private var _experienceTextField:StatisticNumberTextField;
        private var _reputationTextField:StatisticNumberTextField;
        private var smileArts:Array;
        private var currentSmile:Sprite = null;
        
        private var _gameMoneyBtn:SimpleButton;
        private var _realMoneyBtn:SimpleButton;
        private var _experienceBtn:SimpleButton;
        private var _reputationBtn:SimpleButton;
        private var _bucksIcon:Sprite;
        private var _levelIcon:Sprite;
        
        
        private var _gameMoneyBar:GameProgressBar;
        private var _experienceBar:GameProgressBar;
        
        private var _reputationLevel:int
        
        private var _smileLayerSp:Sprite = new Sprite();
        
        [PostConstruct]
        public function init():void
        {
            _bg = rsl.getUpBarArtInstance;
            this.addChild(_bg);
            
            smileArts = new Array();
            smileArts.push(rsl.getAsset("panels.Reputation1Art"));
            smileArts.push(rsl.getAsset("panels.Reputation2Art"));
            smileArts.push(rsl.getAsset("panels.Reputation3Art"));
            smileArts.push(rsl.getAsset("panels.Reputation4Art"));
            
            _bucksIcon = getAsset("IconMoney") as Sprite;
            _bucksIcon.x = 12;
            _bucksIcon.y = 7;
            
            _experienceBar = new GameProgressBar(rsl.getAsset("panels.ProgressBarExperience"));
            _experienceBar.x = 636;
            _experienceBar.y = 14;
            addChild(_experienceBar);
            
            _gameMoneyBar = new GameProgressBar(rsl.getAsset("panels.ProgressBarBarMoneyArt"));
            _gameMoneyBar.x = 39;
            _gameMoneyBar.y = 14;
            addChild(_gameMoneyBar);
            
            _levelIcon = getAsset("IconLVLArt") as Sprite;
            _levelIcon.x = 625;
            _levelIcon.y = 9;
            addChild(_levelIcon);
            
            _gameMoneyTextField = new StatisticNumberTextField();
         
                               
           
            
            
            _gameMoneyTextField.x=90;
            _gameMoneyTextField.y=15;
            _gameMoneyTextField.textColor = 0x93CDA8;
            this.addChild(_gameMoneyTextField);
            _gameMoneyTextField.defaultTextFormat = new StatisticNumberTextFormatLeft();
            _gameMoneyTextField.setTextFormat(new StatisticNumberTextFormatLeft());
           // _gameMoneyTextField.autoSize =  TextFieldAutoSize.CENTER;
            _gameMoneyTextField.width = 30;
            
               
            this.addChild(_bucksIcon);
            
            _realMoneyTextField = new StatisticNumberTextField();
            _realMoneyTextField.x=190;
            _realMoneyTextField.y=15;
            _realMoneyTextField.textColor = 0xFFFA66;
            _realMoneyTextField.defaultTextFormat = new StatisticNumberTextFormatLeft();
            _realMoneyTextField.setTextFormat(new StatisticNumberTextFormatLeft());
            this.addChild(_realMoneyTextField);
            
            _experienceTextField = new StatisticNumberTextField();
            _experienceTextField.x=550;
            _experienceTextField.y=15;
            _experienceTextField.textColor = 0x93CDA8;
         
            _experienceTextField.defaultTextFormat = new StatisticNumberTextFormatLeft();
            _experienceTextField.setTextFormat(new StatisticNumberTextFormatLeft());
            
            this.addChild(_experienceTextField);
            
            _reputationTextField = new StatisticNumberTextField();
            _reputationTextField.x=400;
            _reputationTextField.y = 15;
            _reputationTextField.defaultTextFormat = new StatisticNumberTextFormatLeft();
            _reputationTextField.setTextFormat(new StatisticNumberTextFormatLeft());
            
            
           // this.addChild(_reputationTextField);
            
            addChild(_smileLayerSp);
            _smileLayerSp.x = 509;
            _smileLayerSp.y = 9;
            
            
            _gameMoneyBtn = createSimpleButton("ButtonMoney");
            _gameMoneyBtn.x = 133;
            _gameMoneyBtn.y = 11;
            this.addChild(_gameMoneyBtn);
            
            _realMoneyBtn = createSimpleButton("ButtonGold");
            _realMoneyBtn.x = 294;
            _realMoneyBtn.y = 11;
            this.addChild(_realMoneyBtn);
            
            _experienceBtn = createSimpleButton("ButtonLvl");
            _experienceBtn.x = 731;
            _experienceBtn.y = 11;
            this.addChild(_experienceBtn);
            
            _reputationBtn = createSimpleButton("ButtonReputation");
            _reputationBtn.x = 590;
            _reputationBtn.y = 11;
            this.addChild(_reputationBtn);
        
        }
        
        public function set gameMoney(value:int):void
        {
            _gameMoneyTextField.text = Tools.FormatMoneyString(value, true);
        }
        
        public function set realMoney(value:int):void
        {
            _realMoneyTextField.text = Tools.FormatMoneyString(value, true);
        }
        
        public function set experience(value:int):void
        {
            _experienceTextField.text = Tools.FormatMoneyString(value, true);
        }
        
        public function set reputation(value:int):void
        {
            _reputationTextField.text = value.toString();
            
           /* var neededSmileId:int = 0;	// TODO: реализовать градацию иконок		
            if ( currentSmile != smileArts[ neededSmileId ] )
            {
                if ( currentSmile != null && currentSmile.parent != null )
                    currentSmile.parent.removeChild(currentSmile);
                currentSmile = smileArts[ neededSmileId ];
              //  currentSmile.x = 503;
              //  currentSmile.y = 9;
                _smileLayerSp.addChild(currentSmile);
            }*/
        }
        
        private function createSimpleButton(baseName:String):SimpleButton
        {
            return new SimpleButton(rsl.getAsset("panels." + baseName + "UpArt"), rsl.getAsset("panels." + baseName + "OverArt"), rsl.getAsset("panels." + baseName + "DownArt"), rsl.getAsset("panels." + baseName + "DownArt"));
        }
        
        public function get gameMoneyBtn():SimpleButton
        {
            return _gameMoneyBtn;
        }
        
        public function set reputationLevel(value:int):void 
        {        
            if (value > 3 || value < 0)
            return;
            _reputationLevel = value;
            
            
            
           while (_smileLayerSp.numChildren > 0) 
            _smileLayerSp.removeChildAt(0);

            _smileLayerSp.addChild(smileArts[ _reputationLevel] as Sprite);
           
        
        }
        
        public function set gameMoneyBtn(value:SimpleButton):void
        {
            _gameMoneyBtn = value;
        }
        
        public function get realMoneyBtn():SimpleButton
        {
            return _realMoneyBtn;
        }
        
        public function set realMoneyBtn(value:SimpleButton):void
        {
            _realMoneyBtn = value;
        }
        
        public function get experienceBtn():SimpleButton
        {
            return _experienceBtn;
        }
        
        public function set experienceBtn(value:SimpleButton):void
        {
            _experienceBtn = value;
        }
        
        public function get reputationBtn():SimpleButton
        {
            return _reputationBtn;
        }
        
        public function set reputationBtn(value:SimpleButton):void
        {
            _reputationBtn = value;
        }
        
        public function get experienceBar():GameProgressBar
        {
            return _experienceBar;
        }
        
        public function set experienceBar(value:GameProgressBar):void
        {
            _experienceBar = value;
        }
        
        public function get gameMoneyBar():GameProgressBar
        {
            
            return _gameMoneyBar;
        
        }
        
        public function set gameMoneyBar(value:GameProgressBar):void
        {
            
            _gameMoneyBar = value;
        
        }
        
        
        private function getAsset(value:String):DisplayObject
        {
            return rsl.getAsset("panels." + value);
        }
    
    }
}
