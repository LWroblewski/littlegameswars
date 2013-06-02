package com.gamewars.components
{
  import starling.display.Image;
  import starling.textures.Texture;
  
  public class GwImage extends Image
  {
    /** Constructeur */
    public function GwImage(texture:Texture)
    {
      super(texture);
    }
    
    /** @inheritDoc */
    override public function set texture(value:Texture):void
    {
      super.texture = value;
      readjustSize();
    }
  }
}