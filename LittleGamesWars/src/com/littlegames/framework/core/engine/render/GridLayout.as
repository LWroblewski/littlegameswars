package com.littlegames.framework.core.engine.render
{
  import flash.geom.Point;
  
  import starling.display.DisplayObject;
  import starling.display.Image;

  public class GridLayout
  {
    /** Dimensions des tiles */
    private var _tileSize:Point=new Point();
    
    /** Positionneur de tiles */
    public function GridLayout(pTileWidth:Number, pTileHeight:Number)
    {
      _tileSize.x = pTileWidth;
      _tileSize.y = pTileHeight;
    }
    
    /** Transforme les coordonnées */
    public function tileToOrigin(pTileX:uint, pTileY:uint) : Point
    {
      return new Point(pTileX*_tileSize.x, pTileY*_tileSize.y);
    }
    
    /** Positionne et définit des dimensions en rapport avec celles des tiles */
    public function positionAndSize(pDisplayObject:DisplayObject, pX:uint, pY:uint) : void
    {
      pDisplayObject.x = pX * _tileSize.x;
      pDisplayObject.y = pY * _tileSize.y;
      pDisplayObject.width = _tileSize.x;
      pDisplayObject.height = _tileSize.y;
    }
    
    /** Transforme les coordonnées */
    public function originToTile(pScreenX:Number, pScreenY:Number) : Point
    {
      return new Point(uint(pScreenX/_tileSize.x), uint(pScreenY/_tileSize.y));
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