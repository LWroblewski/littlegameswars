package com.littlegames.framework.stage
{
  import com.littlegames.framework.resources.Resources;
  
  import flash.display.Bitmap;
  
  import starling.core.Starling;
  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;
  
  /** Ecran d'introduction */
  public class MainScreen extends BaseScreen
  {
    
    
    override protected function initGameStage():void
    {
      Resources.add("InfantryWalkRight");
      Resources.add("MechStandRight", 50, 50);
    }
    
    override protected function onEnterFrame():void
    {
      
    }
  }
}