package com.gamewars.utils.mapgen
{
  import com.gamewars.enums.GroundType;
  import com.gamewars.structures.TileMap;
  import com.gamewars.utils.FMath;

  /** Générateur de maps */
  public class MapGenerator
  {
    /** Dimensions souhaités pour la map */
    private var mWidth:uint, mHeight:uint;
    
    /** Constructeur */
    public function MapGenerator(pWidth:uint, pHeight:uint)
    {
      mWidth = pWidth;
      mHeight = pHeight;
    }
    
    /** Crée une nouvelle map et renvoie le resultat */
    public function newMap() : TileMap
    {
      var map:TileMap = new TileMap(mWidth, mHeight, null);
      processGround(map, GroundType.MOUNTAIN.mId, 30);
      processGround(map, GroundType.FOREST.mId, 30);
      processGround(map, GroundType.WATER.mId, 10);
      return map;
    }
    
    /** Ajoute le type de terrain aléatoirement en pourcentage */
    private function processGround(pMap:TileMap, pGround:uint, pPercent:Number) : void
    {
      var i:uint = 0;
      var count:uint = pMap.mWidth * pMap.mHeight * pPercent/100;
      while (i < count)
      {
        var rdx:uint = Math.random() * pMap.mWidth;
        var rdy:uint = Math.random() * pMap.mHeight;
        if (pMap.getGroundAt(rdx, rdy) != pGround)
        {
          pMap.setGroundAt(rdx, rdy, pGround);
          i++;
        }
      }
    }
    
    /** Ajoute des lacs */
    private function addLake(pMap:TileMap) : void
    {
      var radWidth:uint = 1;//2+Math.random() * 2;
      var radHeight:uint = 1;//2+Math.random() * 2;
      var rdx:uint = radWidth/2+(Math.random() * (mWidth-radWidth/2));
      var rdy:uint = radHeight/2+(Math.random() * (mHeight-radHeight/2));
      
      var left:uint = Math.max(rdx - radWidth, 0);
      var top:uint = Math.max(rdy-radHeight, 0);
      var right:uint = Math.min(rdx + radWidth, mWidth-1);
      var bot:uint = Math.min(rdy + radHeight, mHeight-1);
      
      for (var xx:uint = left; xx < right; xx++)
      {
        for (var yy:uint = top; yy < bot; yy++)
        {
          pMap.mTiles[xx+yy*mWidth] = GroundType.WATER.mId;
        }
      }
    }
  }
}