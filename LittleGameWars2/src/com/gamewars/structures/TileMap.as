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
    public function TileMap(pWidth:uint, pHeight:uint, pInitialGround:GroundType)
    {
      mWidth = pWidth;
      mHeight = pHeight;
      if (pInitialGround == null) pInitialGround = GroundType.PLAIN;
      
      for (var yy:uint = 0; yy < mHeight; yy++)
      {
        for (var xx:uint = 0; xx < mWidth; xx++)
        {
          // DBG
          mTiles.push(pInitialGround.mId);
        }
      }
    }
    
    /** Récupère le terrain aux coordonnées */
    public function getGroundAt(pX:uint, pY:uint) : uint
    {
      return mTiles[pY*mWidth+pX];
    }
    
    /** Définit le terrain aux coordonnées */
    public function setGroundAt(pX:uint, pY:uint, pGround:uint) : void
    {
      mTiles[pY*mWidth+pX] = pGround;
    }
  }
}