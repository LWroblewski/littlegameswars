package com.gamewars.structures
{
  import com.gamewars.enums.GroundType;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.textures.Texture;

  public class Tile extends BaseEntity
  {
    /** Dimension des tiles */
    public static const TILE_SIZE:Number = 32;
    
    /** Type de sol */
    public var mGroundType:GroundType;
    /** Rendus */
    private var mGroundRender:MovieClip;
    /** Valeur de défense du terrain */
    public var mDefense:uint = 0;
    
    /** Constructeur */
    public function Tile(pX:uint, pY:uint, pGroundType:GroundType, pStructureType:String = null)
    {
      super(pX, pY);
      mGroundType = pGroundType;
    }
    
    /** @inheritDoc */
    override public function setCell(pCell:WorldCell):void
    {
      pCell.mTile = this;
      super.setCell(pCell);
    }
    
    /** @inheritDoc */
    override public function createRenderer():MovieClip
    {
      var result:MovieClip = new MovieClip(Resources.getTileTextures(mGroundType.mTexPrefix));
      return result;
    }
  }
}