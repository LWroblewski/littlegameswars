package com.gamewars.enums
{
  import com.gamewars.utils.Resources;
  
  import starling.textures.Texture;

  public class CursorType
  {
    public static var SELECTION:CursorType = new CursorType(Resources.getCursorTexs('CursorSelect'));
    public static var TARGET:CursorType = new CursorType(Resources.getCursorTexs('CursorTarget'));
    
    public var mTexs:Vector.<Texture>;
    public function CursorType(pTexs:Vector.<Texture>)
    {
      mTexs = pTexs;
    }
  }
}