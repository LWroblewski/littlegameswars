package com.littlegames.framework.tileengine
{
  import com.littlegames.framework.tileengine.tiles.BaseTile;
  
  import flash.geom.Point;
  import flash.geom.Rectangle;
  
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  public class TileMapViewer extends Sprite
  {
    private static const GROUND_TILE_PREFIX:String = 'groundTile_';
    // ------------------------------------------------------------------------
    /** Viewport */
    private var _viewPort:Rectangle;
    /** Zoom */
    private var _zoom:Number;
    /** Position du point haut gauche */
    private var _position:Point;
    /** TileMap */
    public var tileMap:TileMap;
    
    /** Dimension des tiles */
    public var tileWidth:Number = 16;
    public var tileHeight:Number = 16;
    
    /** Indicateur de MAJ */
    private var _isDirty:Boolean = true;
    /** Liste des images composant la vue */
    private var _listImages:Vector.<Image>;
    
    // TODO Export
    // ------------------------------------------------------------------------
    [Embed(source="../assets/map/spritesheet.png")]
    private var SpriteSheet:Class;
    [Embed(source="../assets/map/spritesheet.xml", mimeType = "application/octet-stream")]
    private var SpriteSheetXml:Class;
    /** Tex */
    private var _textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new SpriteSheet()), XML(new SpriteSheetXml()));
    // ------------------------------------------------------------------------
    
    /** Constructeur */
    public function TileMapViewer(pViewPort:Rectangle)
    {
      _position = new Point();
      _viewPort = pViewPort;
      _zoom = 1;
      _listImages = new <Image>[];
    }
    
    /** MAJ de la vue */
    public function updateView() : void
    {
      if (!_isDirty) return;
      if (!tileMap) return;
      
      // Création des images
      addChild(renderMap(tileMap));
    }
    
    /** Crée toutes les images de des layers de la map */
    private function renderMap(pTileMap:TileMap) : Sprite
    {
      var result:Sprite = new Sprite();
      
      // Crée toutes les tiles de layers
      var i:uint = 0;
      var len:uint = pTileMap.listLayers.length;
      while (i < len)
      {
        var layer:TileLayer = pTileMap.getLayerAt(i);
        result.addChild(renderTiles(layer));
        i++;
      }
      
      return result;
    }
    
    /** Crée les images de chaque tile du layer */
    private function renderTiles(pLayer:TileLayer) : Sprite
    {
      var result:Sprite = new Sprite();
      var wwidth:uint = pLayer.numTilesW;
      var hheight:uint = pLayer.numTilesH;
      
      for (var yy:uint = 0; yy < hheight; yy++)
      {
        for (var xx:uint = 0; xx < wwidth; xx++)
        {
          var tile:BaseTile = pLayer.getTileAt(xx, yy);
          var img:Image = new Image(_textureAtlas.getTexture(GROUND_TILE_PREFIX+tile.tileId));
          img.x = tileWidth * xx;
          img.y = tileHeight * yy;
          result.addChild(img);
        }
      }
      return result;
    }
    
  }//end class
}//end package