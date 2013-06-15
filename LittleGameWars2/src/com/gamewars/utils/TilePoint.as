package com.gamewars.utils
{
  import com.gamewars.structures.Tile;

  public class TilePoint
  {
    /** Coordonnées en tile */
    public var tileX:uint;
    public var tileY:uint;
    
    /** Offsets en pixels */
    public function get xOffset() : Number{return tileX * Tile.TILE_SIZE;}
    public function get yOffset() : Number{return tileY * Tile.TILE_SIZE;}
    
    /** Constructeur */
    public function TilePoint(pX:uint = 0, pY:uint = 0)
    {
      tileX = pX;
      tileY = pY;
    }
    
    /** Définit les coordonnées */
    public function setTo(pX:uint, pY:uint) : void
    {
      tileX = pX;
      tileY = pY;
    }
    
    /** Copie les coordonnées du point passé en paramètres */
    public function copyFrom(pPoint:TilePoint) : void
    {
      setTo(pPoint.tileX, pPoint.tileY);
    }
    
    /** Retourne la distance entre 2 points */
    public static function distance(pt1:TilePoint, pt2:TilePoint) : uint
    {
      return Math.abs(pt1.tileX - pt2.tileX)+Math.abs(pt1.tileY-pt2.tileY);
    }
  }
}