package com.littlegames.framework.core.engine.render
{
  import com.littlegames.framework.resources.Resources;
  
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.textures.Texture;
  
  public class EntityRenderer extends MovieClip
  {
    /** La data lié au renderer */
    public var data:*;
    
    /** Constructeur */
    public function EntityRenderer(pTextures:Vector.<Texture>)
    {
      super(pTextures);
    }
  }
}