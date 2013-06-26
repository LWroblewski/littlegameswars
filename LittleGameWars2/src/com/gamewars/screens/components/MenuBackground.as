package com.gamewars.screens.components
{
  import com.gamewars.interfaces.IRender;
  import com.gamewars.resources.Resources;
  import com.gamewars.utils.ImageUtils;
  
  import flash.display.Bitmap;
  import flash.geom.Point;
  
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.textures.Texture;

  public class MenuBackground extends Image implements IRender
  {
    [Embed(source="resources/menu_background.png")]
    private static const _MENU_BACKGROUND:Class;
    
    public function MenuBackground(pBitmap:Bitmap = null)
    { 
      if (!pBitmap)
      {
        pBitmap = new _MENU_BACKGROUND as Bitmap;
      }
      
      var texture:Texture = Texture.fromBitmap(pBitmap);
      texture.repeat = true;
      
      super(texture);
      
      addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }
    
    private function addedToStageHandler(pEvent:Event):void
    {
      removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
      
      var widthTexture:Number = width;
      var heightTexture:Number = height;
      
      width = stage.stageWidth * 2;
      height = stage.stageHeight * 2;
      
      initPosition();
      
      ImageUtils.repeat(this, int(width/widthTexture), int(height/heightTexture));
    }
    
    private function initPosition():void
    {
      x = -stage.stageWidth;
      y = -stage.stageHeight;
    }
    
    public function renderElement():void
    {
      x++;
      y++;
      if (x == 0 || y == 0)
      {
        initPosition();
      }
    }
  }
}