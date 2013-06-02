package com.gamewars.world
{
  import com.gamewars.enums.GroundType;
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;

  public class WorldCell
  {
    /** Réference vers le monde */
    private var mWorld:World;
    /** Tile de la cellule */
    public var mTile:Tile;
    /** Structure de la cellule */
    public var mStructure:Tile;
    /** Unité sur la cellule */
    private var mUnit:Unit;
    /** Position de la cellule sur la map*/
    public var mX:uint=0, mY:uint=0;
    
    public function setUnit(pUnit:Unit) : void
    {
      if (pUnit != null && (mUnit != null ||  mUnit == pUnit))
        throw new Error('Unit already there!');
      // Supprime la réference de l'ancienne cellule
      if (pUnit && pUnit.getCell() != null)
      {
        pUnit.getCell().setUnit(null);
      }
      mUnit = pUnit;
    }
    public function getUnit():Unit{return mUnit;};
    
    /** Cellule du monde */
    public function WorldCell(pWorld:World, pX:uint, pY:uint)
    {
      mWorld = pWorld;
      mX = pX;
      mY = pY;
    }
    
    /** Retourne la cellule située à pDirection */
    public function getCellAt(pDirection:WindRose) : WorldCell
    {
      switch(pDirection)
      {
        case WindRose.NORTH:
          return mWorld.getCellAt(mX, mY-1);
          break;
        case WindRose.EAST:
          return mWorld.getCellAt(mX+1, mY);
          break;
        case WindRose.SOUTH:
          return mWorld.getCellAt(mX, mY+1);
          break;
        case WindRose.WEST:
          return mWorld.getCellAt(mX-1, mY);
          break;
        
        default:
          return null;
          break;
      }
    }
    
    /** Retourne la direction de la cellule par rapport à celle ci */
    public function getDirection(pCell:WorldCell) : WindRose
    {
      for each (var dir:WindRose in WindRose.all)
      {
        if (getCellAt(dir) == pCell)
          return dir;
      }
      return null;
    }
    
    /** Indique si l'unitée peut se déplacer sur la case */
    public function isMovementAllowed(pUnit:Unit) : Boolean
    {
      if (mTile.mGroundType == GroundType.WATER)
        return false;
      
      // TODO Implementation
      return true;
    }
    
    /** Retourne le cout de déplacement sur la case */
    public function getMovementCost() : int
    {
      return mTile.mGroundType.mMovementCost;
    }
    
    /** Retourne la distance entre deux cellules */
    public function getDistance(pCell:WorldCell) : uint
    {
      var dx:int = Math.abs(mX - pCell.mX);
      var dy:int = Math.abs(mY - pCell.mY);
      return dx + dy;
    }
    
    /** Calcule les cellules sur lesquels on peut effectuer le mouvement */
    public function renderMovementGrid(pSprite:Sprite, pMovementPts:int) : void
    {
      // TODO Calculer le mouvement par rapport au cout du type de terrain
      if (pMovementPts <= 0)
        return;

      var render:MovieClip = new MovieClip(Resources.getGuiTexs('SelectionGrid'), 4);
      render.x = mX * Tile.TILE_SIZE;
      render.y = mY * Tile.TILE_SIZE;
      pSprite.addChild(render);
      Starling.juggler.add(render);
      
      for each (var dir:WindRose in WindRose.all)
      {
        var cell:WorldCell = getCellAt(dir);
        if (cell)
          cell.renderMovementGrid(pSprite, pMovementPts-cell.getMovementCost());
      }
    }
  }
}