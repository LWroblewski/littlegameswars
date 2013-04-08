package com.littlegames.framework.core.engine.render.tileengine.tiles
{
  public class Tile
  {
    /** Id de la tile */
    public var tileId:String;
    /** Modificateur de temps */
    public var tileWeather:String;
    /** Walkable */
    public var isWalkable:Boolean = false;
    /** Coordonnées de la tile */
    public var x:uint, y:uint;
    
    /** Constructeur */
    public function Tile(pTileId:String = null, pTileWeather:String = TilesWeather.DEFAULT, pIsWalkable:Boolean = true, pX:uint = 0, pY:uint = 0)
    {
      tileId = pTileId ? pTileId : TilesId.GRASS;
      tileWeather = pTileWeather;
      isWalkable = pIsWalkable;
      x = pX;
      y = pY;
    }
  }
}