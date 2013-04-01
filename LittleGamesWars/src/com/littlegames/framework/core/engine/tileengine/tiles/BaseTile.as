package com.littlegames.framework.core.engine.tileengine.tiles
{
  public class BaseTile
  {
    /** Id de la tile */
    public var tileId:String;
    /** Modificateur de temps */
    public var tileWeather:uint = 0;
    /** Walkable */
    public var isWalkable:Boolean = false;
    
    /** Constructeur */
    public function BaseTile(pTileId:String = null, pTileWeather:uint = 0, pIsWalkable:Boolean = true)
    {
      tileId = pTileId ? pTileId : TilesId.GRASS;
      tileWeather = pTileWeather;
      isWalkable = pIsWalkable;
    }
  }
}