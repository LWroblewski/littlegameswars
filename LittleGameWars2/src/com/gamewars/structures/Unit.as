package com.gamewars.structures
{
  import com.gamewars.enums.UnitType;
  import com.gamewars.enums.WindRose;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.textures.Texture;

  /**
  * Représente une unitée du jeu
  */
  public class Unit extends BaseEntity
  {
    /** Type d'unité */
    public var mUnitType:UnitType;
    /** Joueur possédant l'unitée */
    public var mOwner:Player;
    /** Hp de l'unitée (10 pour toutes) */
    public var mHp:uint = 10;
    /** Fuel de l'unitée */
    public var mFuel:uint;
    /** Munitions */
    public var mAmmo:uint;
    /** Points de mouvements */
    public var mMovePoints:int;
    /** Portée de l'unitée */
    public var mRange:int;
    
    /** Constructeur */
    public function Unit(pX:uint, pY:uint, pUnitType:UnitType)
    {
      super(pX, pY);
      mUnitType = pUnitType;
      mFuel = pUnitType.mFuel;
      mAmmo = pUnitType.mAmmo;
      mMovePoints = pUnitType.mMovePts;
      mRange = pUnitType.mRange;
    }
    
    /** @inheritDoc */
    override public function setCell(pCell:WorldCell) : void
    {
      pCell.setUnit(this);
      super.setCell(pCell);
    }
    
    /** Récupère la texture */
    public function getRenderTex() : Texture
    {
      return Resources.getUnitTextures(mUnitType)[0];
    }
    
    /** Fonction de MAJ du rendu de l'unitée */
    override public function createRenderer():MovieClip
    {
      var result:MovieClip = new MovieClip(Resources.getUnitTextures(mUnitType), 3);
      return result;
    }
  }
}