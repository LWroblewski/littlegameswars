package com.littlegames.framework.core.data
{
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.TilesId;

  public class TileMap
  {
    /** Liste des tiles du layer */
    public var listTiles:Vector.<Tile>;
    /** Dimensions */
    public var numTilesW:uint = 0;
    public var numTilesH:uint = 0;
    
    /** Map de tiles */
    public function TileMap(pColumns:uint, pRows:uint)
    {
      numTilesW = pColumns;
      numTilesH = pRows;
      listTiles = new <Tile>[];
      fillTiles(TilesId.GRASS);
    }
    
    /** Initialize toutes les tiles avec de l'herbe */
    public function fillTiles(pTileId:String) : void
    {
      listTiles.length = 0;
      for (var yy:uint = 0; yy < numTilesH; yy++)
      {
        for (var xx:uint = 0; xx < numTilesW; xx++)
        {
          var tile:Tile = new Tile(pTileId);
          tile.x = xx;
          tile.y = yy;
          listTiles.push(tile);
        }
      }
    }
    
    /** Retourne une tile aux coordonnées spécifiées */
    public function getTileAt(pX:uint, pY:uint) : Tile
    {
      if (!validCoordinates(pX, pY)) return null;
      return listTiles[pX+pY*numTilesW];
    }
    
    /** Vérifie la validité des coordonnées */
    private function validCoordinates(pX:uint, pY:uint) : Boolean
    {
      return pX < numTilesW && pY < numTilesH;
    }
    
    /** Définit une tile aux coordonnées spécifiées */
    public function setTileAt(pX:uint, pY:uint, pTile:Tile) : void
    {
      if (!validCoordinates(pX, pY)) return;
      listTiles[pX+pY*numTilesW] = pTile;
    }
    
    /** Récupère une tile aléatoirement */
    public function getRandomTile() : Tile
    {
      return listTiles[(uint)(Math.random() * numTilesH * numTilesW - 1)];
    }
  }
}