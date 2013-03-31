package com.littlegames.framework.core.engine.tileengine.tiles
{
  public class BaseTile
  {
    /** Id de la tile */
    public var tileId:uint = 0;
    /** Modificateur de temps */
    public var tileWeather:uint = 0;
    /** Walkable */
    public var isWalkable:Boolean = false;
    
    /** Constructeur */
    public function BaseTile(pTileId:uint = 0, pTileWeather:uint = 0, pIsWalkable:Boolean = true)
    {
      tileId = pTileId;
      tileWeather = pTileWeather;
      isWalkable = pIsWalkable;
    }
  }
}