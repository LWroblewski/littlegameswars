package com.littlegames.framework.core.xml.map
{
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.TilesWeather;
  import com.littlegames.framework.core.xml.XMLLoader;

  public class MapManager
  {
    public static function loadXMLMap(pPath:String):void
    {
      new XMLLoader(pPath, toTileMap).load();
    }
    
    public static function toTileMap(pXML:XML):TileMap
    {
      var tilemap:TileMap;
      
      return tilemap;
    }
    
    public static function fromTileMap(pTileMap:TileMap):XML
    {
      var xmlRoot:XML = <map/>;
      
      if (pTileMap && pTileMap.listTiles && pTileMap.listTiles.length > 0)
      {
        var nbNodes:uint = pTileMap.listTiles.length;
        
        for (var index:uint = 0; index < nbNodes; index++)
        {
          xmlRoot[index] = fromTile(pTileMap.listTiles[index]);
        }
      }
      
      return xmlRoot;
    }
    
    private static function fromTile(pTile:Tile):XML
    {
      var xmlNode:XML = <tile/>;
      xmlNode.@id = pTile.tileId;
      xmlNode.@x = pTile.x;
      xmlNode.@y = pTile.y;
      return xmlNode;
    }
    
    private static function toTile(pXML:XML):Tile
    {
      return new Tile(pXML.@id, TilesWeather.DEFAULT, true, pXML.@x, pXML.@y);
    }
  }
}