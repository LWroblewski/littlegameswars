package com.littlegames.framework.utils
{
  import flash.display.Bitmap;
  
  import starling.display.Button;
  import starling.display.Image;
  import starling.events.Event;
  import starling.textures.Texture;

  public class ComponentUtils
  {
    public static function addButton(pBitmap:Class, pHandler:Function, pX:int = 0, pY:int = 0):Button
    {
      var button:Button = new Button(Texture.fromBitmap(new pBitmap() as Bitmap));
      button.addEventListener(Event.TRIGGERED, pHandler);
      button.x = pX;
      button.y = pY;
      Global.currentScreen.addChild(button);
      return button;
    }
    
    public static function addImage(pBitmap:Class, pX:int = 0, pY:int = 0):Image
    {
      var image:Image = new Image(Texture.fromBitmap(new pBitmap() as Bitmap));
      image.x = pX;
      image.y = pY;
      return Global.currentScreen.addChild(image) as Image;
    }
  }
}