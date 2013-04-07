package com.littlegames.framework.core.engine.render.tileengine.tiles
{
  public class Tile
  {
    /** Id de la tile */
    public var tileId:String;
    /** Modificateur de temps */
    public var tileWeather:uint = 0;
    /** Walkable */
    public var isWalkable:Boolean = false;
    /** Coordonnées de la tile */
    public var x:uint, y:uint;
    
    /** Constructeur */
    public function Tile(pTileId:String = null, pTileWeather:uint = 0, pIsWalkable:Boolean = true)
    {
      tileId = pTileId ? pTileId : TilesId.GRASS;
      tileWeather = pTileWeather;
      isWalkable = pIsWalkable;
    }
  }
}