package com.littlegames.framework.core.engine.render
{
  import com.littlegames.framework.core.data.TilePosition;
  
  import flash.geom.Point;
  
  import starling.display.DisplayObject;
  import starling.display.Image;

  public class TileGridLayout
  {
    /** Position de scroll */
    public var scrollPosition:Point = new Point(0, 0);
    // ------------------------------------------------------------------------    
    /** Dimensions des tiles */
    private var _tileSize:Point=new Point();
    public function get tileSize() : Point
    {
      return _tileSize;
    }
    // ------------------------------------------------------------------------
    /** Positionneur de tiles */
    public function TileGridLayout(pTileWidth:Number, pTileHeight:Number)
    {
      _tileSize.x = pTileWidth;
      _tileSize.y = pTileHeight;
    }
    
    /** Positionne l'élement */
    public function layoutElement(pElement:DisplayObject, pX:uint, pY:uint) : void
    {
      pElement.x = pX * _tileSize.x - scrollPosition.x;
      pElement.y = pY * _tileSize.y - scrollPosition.y;
    }
    
    /** Transforme les coordonnées */
    public function tileToWorld(pTileX:uint, pTileY:uint) : Point
    {
      return new Point(pTileX*_tileSize.x, pTileY*_tileSize.y);
    }
    
    /** Transforme les coordonnées */
    public function worldToTile(pScreenX:Number, pScreenY:Number) : TilePosition
    {
      return new TilePosition(uint(pScreenX/_tileSize.x), uint(pScreenY/_tileSize.y));
    }
    
    /** Modifie les coordonnées du point pour se trouver sur une position de tile */
    public function clampToTile(pPoint:Point) : void
    {
      pPoint.x = _tileSize.x * uint(pPoint.x/_tileSize.x);
      pPoint.y = _tileSize.y * uint(pPoint.y/_tileSize.y);
    }
    
    /** Définit des dimensions correspondant au tiles sur l'image */
    public function sizeImage(pImage:Image) : void
    {
      pImage.width = _tileSize.x;
      pImage.height = _tileSize.y;
    }
  }
}