package com.gamewars.components
{
  import starling.display.Image;
  import starling.textures.Texture;
  import starling.textures.TextureSmoothing;
  
  public class GwImage extends Image
  {
    /** Constructeur */
    public function GwImage(texture:Texture)
    {
      super(texture);
      smoothing = TextureSmoothing.NONE;
    }
    
    /** @inheritDoc */
    override public function set texture(value:Texture):void
    {
      super.texture = value;
      readjustSize();
    }
  }
}