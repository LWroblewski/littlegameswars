package com.littlegames.framework.resources
{
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;
  
  public class TextureManager
  {
    /** Préfixes de textures */
    private const UNIT_PREFIX:String = 'Unit_';
    private const TILE_PREFIX:String = 'Tile_';
    
    private static var _instance:TextureManager;
    public static function getInstance() : TextureManager
    {
      if (!_instance) _instance = new TextureManager();
      return _instance;
    }
    
    // ------------------------------------------------------------------------
    
    [Embed(source="assets/map/spritesheet.png")]
    private var SpriteSheet:Class;
    [Embed(source="assets/map/spritesheet.xml", mimeType = "application/octet-stream")]
    private var SpriteSheetXml:Class;
    /** Tex */
    private var textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SpriteSheet()), XML(new SpriteSheetXml()));
    
    /** Constructeur */
    public function TextureManager()
    {
    }
    
    /** Récupère les textures ayant le préfixe pTexturePrefix en identifiant */
    public function getTextures(pTexturePrefix:String) : Vector.<Texture>
    {
      var result:Vector.<Texture> = textureAtlas.getTextures(pTexturePrefix);
      if (!result || result.length == 0) throw new Error('Texture ['+pTexturePrefix+'] introuvable!');
      
      return result;
    }
    
    /** Récupère les texture d'une tile à partir de l'id */
    public function getTileTextureFromId(pId:uint) : Vector.<Texture>
    {
      return getTextures(TILE_PREFIX+pId.toString());
    }
    
    /** Récupère les textures d'animation d'une unitée */
    public function getUnitTexturesFromId(pId:uint) : Vector.<Texture>
    {
      return getTextures(UNIT_PREFIX+pId);
    }
  }
}
