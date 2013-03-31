package com.littlegames.framework.core.engine.tileengine
{
  public class TileMap
  {
    /** Liste des layers */
    public var listLayers:Vector.<TileLayer>;
    /** Dimensions */
    public var numTilesW:uint;
    public var numTilesH:uint;
    
    /** Map de tiles */
    public function TileMap(pWidth:uint=0, pHeight:uint=0)
    {
      listLayers = new <TileLayer>[];
      numTilesW = pWidth;
      numTilesH = pHeight;
    }
    
    /** Retourne le layer dont z est pZ (z=0 pour le niveau le plus bas) */
    public function getLayerAt(pZ:uint = 0) : TileLayer
    {
      // Ajoute des layers jusqu'a Z spécifié
      var toAdd:uint = listLayers.length - pZ + 1;
      while (toAdd-- > 0)
      {
        listLayers.push(new TileLayer(numTilesW, numTilesH));
      }
      
      return listLayers[pZ];
    }
  }
}