package com.littlegames.framework.resources
{
  import com.littlegames.framework.utils.Global;
  
  import flash.display.Bitmap;
  
  import starling.core.Starling;
  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;
  
  /** Classe de gestion des ressources du jeu */
  public class Resources
  {
    /** Atlas XML des animations */
    [Embed(source="../assets/sheet.xml", mimeType="application/octet-stream")]
    private static const _ATLAS:Class;
    
    /** Stylesheet des animations */
    [Embed(source="../assets/sheet.png")]
    private static const _SPRITESHEET:Class;
    
    /** Atlas des animations */
    private static var _textureAtlas:TextureAtlas;
    
    /** Récupération d'un movieClip avec l'animation dont l'id commence par pPrefix. */
    public static function get(pPrefix:String = ""):MovieClip
    {
      if (!_textureAtlas)
      {
        var xml:XML = XML(new _ATLAS());
        var bitmap:Bitmap = new _SPRITESHEET();
        var texture:Texture = Texture.fromBitmap(bitmap);
        _textureAtlas = new TextureAtlas(texture, xml);
      }
      var movieClip:MovieClip = new MovieClip(_textureAtlas.getTextures(pPrefix));
      Starling.juggler.add(movieClip);
      return movieClip;
    }
    
    /** Ajout d'un movieClip à la vue courante, d'animation d'id pPrefix, et aux coordonnées pX et pY. */
    public static function add(pPrefix:String = "", pX:int = 0, pY:int = 0):MovieClip
    {
      var movieClip:MovieClip = get(pPrefix);
      if (movieClip)
      {
        Global.currentScreen.addChild(movieClip);
        movieClip.x = pX;
        movieClip.y = pY;
      }
      return movieClip;
    }
  }
}