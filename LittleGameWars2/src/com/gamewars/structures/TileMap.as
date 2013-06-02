package com.gamewars.structures
{
  import com.gamewars.enums.GroundType;

  public class TileMap
  {
    /** Dimensions de la map */
    public var mWidth:uint;
    public var mHeight:uint;
    /** Liste de cellules */
    public var mTiles:Vector.<uint> = new <uint>[];
    
    /** Constructeur */
    public function TileMap(pWidth:uint, pHeight:uint)
    {
      mWidth = pWidth;
      mHeight = pHeight;
      
      for (var yy:uint = 0; yy < mHeight; yy++)
      {
        for (var xx:uint = 0; xx < mWidth; xx++)
        {
          // DBG
          mTiles.push(GroundType.PLAIN.mId);
        }
      }
    }
    
    /** Retourne les informations de tiles */
    public function getTileAt(pX:uint, pY:uint) : uint
    {
      return mTiles[pY*mWidth+pX];
    }
  }
}