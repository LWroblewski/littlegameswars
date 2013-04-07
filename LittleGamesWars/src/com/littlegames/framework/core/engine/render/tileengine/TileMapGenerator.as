package com.littlegames.framework.core.engine.render.tileengine
{
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.TilesId;
  import com.littlegames.framework.core.data.TileMap;

  public class TileMapGenerator
  {
    /** Constructeur */
    public function TileMapGenerator(){};
    
    /** Génère un nouveau calque avec les dimensions spécifiées */
    public function generate(pTileMap:TileMap) : void
    {
      if (pTileMap.numTilesW == 0 || pTileMap.numTilesH == 0) throw new Error('Bad map size');
      
      var listTiles:Vector.<Tile> = new <Tile>[];
      var totalTiles:uint = pTileMap.numTilesW * pTileMap.numTilesH;
      for (var i:uint = 0; i < totalTiles; i++)
      {
        var rd:Number = Math.random()*100;
        var tile:Tile = pTileMap.getRandomTile();
        if (rd > 30) tile.tileId = TilesId.GRASS;
        else if (rd > 20) tile.tileId = TilesId.FOREST;
        else if (rd > 10) tile.tileId = TilesId.MOUNTAIN;
        else if (rd > 0) tile.tileId = TilesId.RIVER;
      }
    }
  }//end class
}//end package