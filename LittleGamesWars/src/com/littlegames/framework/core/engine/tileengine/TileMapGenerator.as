package com.littlegames.framework.core.engine.tileengine
{
  import com.littlegames.framework.core.engine.tileengine.tiles.BaseTile;
  import com.littlegames.framework.core.engine.tileengine.tiles.TilesId;

  public class TileMapGenerator
  {
    /** Constructeur */
    public function TileMapGenerator(){};
    
    /** Génère un nouveau calque avec les dimensions spécifiées */
    public function generate(pTileMap:TileMap) : void
    {
      if (pTileMap.numTilesW == 0 || pTileMap.numTilesH == 0) throw new Error('Bad map size');
      
      var groundLayer:TileLayer = pTileMap.getLayerAt(0);
      var listTiles:Vector.<BaseTile> = new <BaseTile>[];
      var totalTiles:uint = groundLayer.numTilesW * groundLayer.numTilesH;
      for (var i:uint = 0; i < totalTiles; i++)
      {
        var rd:Number = Math.random()*100;
        var tile:BaseTile = groundLayer.getRandomTile();
        if (rd > 30) tile.tileId = TilesId.GRASS;
        else if (rd > 20) tile.tileId = TilesId.FOREST;
        else if (rd > 10) tile.tileId = TilesId.MOUNTAIN;
        else if (rd > 0) tile.tileId = TilesId.RIVER;
      }
    }
    
    // Ground
    // ------------------------------------------------------------------------
    /** Ajoute un lac sur la map */
    public function addLake(pLayer:TileLayer) : void
    {
      // TODO
    }
    
    /** Ajoute une chaine de montagnes */
    public function addMountainChain(pTileLayer:TileLayer) : void
    {
      // TODO
    }
    
    /** Ajoute une foret */
    public function addForest(pTileLayer:TileLayer) : void
    {
      // TODO
    }
    
    /** Ajoute un canal */
    public function addChannel(pTileLayer:TileLayer) : void
    {
      // TODO
    }
    // ------------------------------------------------------------------------
    
    // Buildings
    // ------------------------------------------------------------------------
    /** Ajoute une ville */
    public function addCity(pTileLayer:TileLayer) : void
    {
      // TODO
    }
  }
}