package com.littlegames.framework.resources
{
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  public class Textures
  {
    [Embed(source="../assets/map/spritesheet.png")]
    private static var SpriteSheet:Class;
    [Embed(source="../assets/map/spritesheet.xml", mimeType = "application/octet-stream")]
    private static var SpriteSheetXml:Class;
    /** Tex */
    public static var textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SpriteSheet()), XML(new SpriteSheetXml()));

    /** Constructeur */
    public function Textures()
    {
    }
  }
}