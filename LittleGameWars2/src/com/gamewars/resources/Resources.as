package com.gamewars.resources
{
  import flash.display.Bitmap;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;
  
  public class Resources
  {
    /** Atlas XML des animations */
    [Embed(source="resources/spritesheet.xml", mimeType="application/octet-stream")]
    private static const _ATLAS:Class;
    
    /** Stylesheet des animations */
    [Embed(source="resources/spritesheet.png")]
    private static const _SPRITESHEET:Class;
    
    private static var _textureAtlas:TextureAtlas;
    
    private static function get textureAtlas():TextureAtlas
    {
      if (!_textureAtlas)
      {
        var xml:XML = XML(new _ATLAS());
        var bitmap:Bitmap = new _SPRITESHEET();
        var texture:Texture = Texture.fromBitmap(bitmap);
        _textureAtlas = new TextureAtlas(texture, xml);
      }
      return _textureAtlas;
    }
    
    /** Retourne un vecteur de textures de préfixe donné. */
    public static function getTextures(pPrefix:String):Vector.<Texture>
    {
      var textures:Vector.<Texture> = textureAtlas.getTextures(pPrefix);
      if (!textures || textures.length == 0)
      {
        throw new Error('Texture ['+pPrefix+'] introuvable!');
      }
      return textures;
    }
    
    /** Retourne une texture unique. */
    public static function getSingleTexture(pPrefix:String):Texture
    {
      return getTextures(pPrefix)[0];
    }
    
    /** Récupération d'un movieClip avec l'animation dont l'id commence par pPrefix. */
    public static function getMovieClip(pPrefix:String = ""):MovieClip
    {
      var movieClip:MovieClip = new MovieClip(getTextures(pPrefix));
      Starling.juggler.add(movieClip);
      return movieClip;
    }
    
    /** Création d'une image avec une texture unique donnée. */
    public static function getImage(pPrefix:String = ""):Image
    {
      return new Image(getSingleTexture(pPrefix));
    }
    
    public static function animateBackground(pPrefix:String):void
    {
      
    }
  }
}