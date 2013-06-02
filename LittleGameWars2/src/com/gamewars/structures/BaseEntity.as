package com.gamewars.structures
{
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import starling.display.MovieClip;
  import starling.display.Sprite;

  public class BaseEntity
  {
    /** Coordonnées de l'entitée */
    protected var mX:uint = 0;
    protected var mY:uint = 0;
    /** Réference vers le monde */
    public var mWorld:World;
    
    /** Constructeur */
    public function BaseEntity(pX:uint, pY:uint)
    {
      mX = pX;
      mY = pY;
    }
    
    /** Définit le monde */
    public function setWorld(pWorld:World) : void
    {
      mWorld = pWorld;
      setCell(mWorld.getCellAt(mX, mY));
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
      mX = pCell.mX;
      mY = pCell.mY;
    }
    
    /** Retourne la cellule */
    public function getCell() : WorldCell
    {
      return mWorld.getCellAt(mX, mY);
    }
  }
}