package com.gamewars.structures
{
  import com.gamewars.utils.TilePoint;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import starling.display.MovieClip;
  import starling.display.Sprite;

  public class BaseEntity
  {
    /** Position */
    public var mPosition:TilePoint;
    /** Réference vers le monde */
    public var mWorld:World;
    
    /** Constructeur */
    public function BaseEntity(pX:uint = 0, pY:uint = 0)
    {
      mPosition = new TilePoint(pX, pY);
    }
    
    /** Définit le monde */
    public function setWorld(pWorld:World) : void
    {
      mWorld = pWorld;
      setCell(mWorld.getCellAtPoint(mPosition));
    }
    
    /** Rendu graphique */
    public function createRenderer() : MovieClip
    {
      // TO OVERRIDE
      return null;
    }
    
    /** Nettoyage */
    public function dispose() : void
    {
      // TO OVERRIDE
    }
    
    /** Définition de la cellule */
    public function setCell(pCell:WorldCell) : void
    {
      mPosition.copyFrom(pCell.mPosition);
    }
    
    /** Retourne la cellule */
    public function getCell() : WorldCell
    {
      return mWorld.getCellAtPoint(mPosition);
    }
  }
}