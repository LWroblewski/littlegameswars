package com.gamewars.components
{
  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureSmoothing;
  
  public class GwMovieClip extends MovieClip
  {
    public function GwMovieClip(textures:Vector.<Texture>, fps:Number=12)
    {
      super(textures, fps);
      smoothing = TextureSmoothing.NONE;
    }
  }
}