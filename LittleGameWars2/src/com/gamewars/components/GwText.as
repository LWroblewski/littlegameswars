package com.gamewars.components
{
  import starling.text.TextField;
  import starling.utils.HAlign;
  import starling.utils.VAlign;
  
  public class GwText extends TextField
  {
    public function GwText(pFontSize:Number = 12)
    {
      super(pFontSize, pFontSize*2, '', "Verdana", pFontSize);
      hAlign = HAlign.LEFT;
      vAlign = VAlign.TOP;
    }
    
    /** @inheritDoc */
    override public function set text(value:String):void
    {
      super.text = value;
      width = (1+value.length) * fontSize;
    }
  }
}