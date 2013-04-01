package com.littlegames.framework.resources
{
  import com.littlegames.framework.utils.Global;
  
  import flash.display.Bitmap;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;
  
  /** Classe de gestion des ressources du jeu */
  public class Resources
  {
    /** Bouton démarrer campagne */
    [Embed(source="assets/menu/btnCampaign.png")]
    public static const BTN_CAMPAIGN:Class;
    
    /** Bouton démarrer campagne */
    //[Embed(source="assets/menu/main-screen.png")]
    //public static const MAIN_SCREEN:Class;
    
    /** Atlas XML des animations */
    [Embed(source="assets/map/spritesheet.xml", mimeType="application/octet-stream")]
    private static const _ATLAS:Class;
    
    /** Stylesheet des animations */
    [Embed(source="assets/map/spritesheet.png")]
    private static const _SPRITESHEET:Class;
    
    /** Atlas des animations */
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
    
    public static function getTextures(pPrefix:String):Vector.<Texture>
    {
      var textures:Vector.<Texture> = textureAtlas.getTextures(pPrefix);
      if (!textures || textures.length == 0)
      {
        throw new Error('Texture ['+pPrefix+'] introuvable!');
      }
      return textures;
    }
    
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
    
    public static function getImage(pPrefix:String = ""):Image
    {
      return new Image(getSingleTexture(pPrefix));
    }
    
    /** Ajout d'un movieClip à la vue courante, d'animation d'id pPrefix, et aux coordonnées pX et pY. */
    public static function add(pPrefix:String = "", pX:int = 0, pY:int = 0):MovieClip
    {
      var movieClip:MovieClip = getMovieClip(pPrefix);
      if (movieClip)
      {
        Global.currentScreen.addChild(movieClip);
        movieClip.x = pX;
        movieClip.y = pY;
      }
      return movieClip;
    }
    
    /** Suppression du movieClip pMovieClip de l'écran courant. */
    public static function remove(pMovieClip:MovieClip):void
    {
      if (pMovieClip && Global.currentScreen.getChildIndex(pMovieClip) > -1)
      {
        Global.currentScreen.removeChild(pMovieClip);
      }
    }
    
    public static function replace(pMovieClip:MovieClip, pPrefix:String = ""):MovieClip
    {
      return null;
    }
  }
}