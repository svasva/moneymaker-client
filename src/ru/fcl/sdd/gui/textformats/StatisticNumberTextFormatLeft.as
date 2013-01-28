package ru.fcl.sdd.gui.textformats 
{
	import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
	
	/**
     * ...
     * @author atuzov
     */
    public class StatisticNumberTextFormatLeft extends TextFormat 
    {
          [Embed(source="./assets/AVA_LDB.TTF", fontFamily="a_AvanteLdb", mimeType="application/x-font", embedAsCFF="false")]
        private var  _fontLDB:Class;
        
        public function StatisticNumberTextFormatLeft() 
        {
             align = TextFormatAlign.RIGHT;
             color = 0xe2e8b9;
            font = "a_AvanteLdb";
            size = 16;
        }
        
    }

}