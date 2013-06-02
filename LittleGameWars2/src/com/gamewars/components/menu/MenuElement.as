package com.gamewars.components.menu
{
  public class MenuElement
  {
    /** Id de l'élément */
    public var mId:uint;
    /** Texte de l'élément de menu */
    public var mText:String;
    
    /** Constructeur */
    public function MenuElement(pId:uint, pText:String)
    {
      mId = pId;
      mText = pText;
    }
  }
}