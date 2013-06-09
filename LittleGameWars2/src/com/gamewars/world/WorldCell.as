package com.gamewars.world
{
  import com.gamewars.enums.GroundType;
  import com.gamewars.enums.WindRose;
  import com.gamewars.gfx.WaterTileRenderer;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  
  import starling.core.Starling;
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.textures.Texture;

  public class WorldCell
  {
    /** Réference vers le monde */
    private var mWorld:World;
    /** Type de terrain */
    public var mGroundType:GroundType;
    /** Structure de la cellule */
    public var mStructure:Tile;
    /** Unité sur la cellule */
    private var mUnit:Unit;
    /** Position de la cellule sur la map*/
    public var mX:uint=0, mY:uint=0;
    
    /** Définit l'unitée de la cellule */
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
    
    /** Retourne la position en pixels */
    public function getX() : Number{return mX * Tile.TILE_SIZE;}
    public function getY() : Number{return mY * Tile.TILE_SIZE;}
    
    /** Cellule du monde */
    public function WorldCell(pWorld:World, pX:uint, pY:uint, pGroundType:GroundType = null)
    {
      if (pGroundType == null) pGroundType = GroundType.PLAIN;
      mWorld = pWorld;
      mX = pX;
      mY = pY;
      mGroundType = pGroundType;
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
        case WindRose.NORTH_EAST:
          return mWorld.getCellAt(mX+1, mY-1)
          break;
        case WindRose.NORTH_WEST:
          return mWorld.getCellAt(mX-1, mY-1);
          break;
        case WindRose.SOUTH_EAST:
          return mWorld.getCellAt(mX+1, mY+1);
          break;
        case WindRose.SOUTH_WEST:
          return mWorld.getCellAt(mX-1, mY+1);
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
      if (mGroundType == GroundType.WATER)
        return false;
      
      // TODO Implementation
      return true;
    }
    
    /** Retourne le type de terrain dans la direction spécifiée */
    public function getGroundTypeAt(pDir:WindRose) : GroundType
    {
      if (getCellAt(pDir) != null)
        return getCellAt(pDir).mGroundType;
      else
        return null;
    }
    
    /** Positionne l'élément passé en paramètres sur la cellule */
    public function layoutElement(pElement:DisplayObject) : void
    {
      pElement.x = mX * Tile.TILE_SIZE;
      pElement.y = mY * Tile.TILE_SIZE;
    }
    
    /** Crée un rendu pour la cellule */
    public function createRenderer() : DisplayObject
    {
      var result:DisplayObject;
      
      // Cas spécifique
      if (mGroundType == GroundType.WATER)
      {
        result = new WaterTileRenderer();
        (result as WaterTileRenderer).initializeFromCell(this);
      }
      else
        result = new MovieClip(Resources.getTileTextures(mGroundType.mTexPrefix));
      
      result.x = mX * Tile.TILE_SIZE;
      result.y = mY * Tile.TILE_SIZE;
      
      return result;
    }
    
    /** Retourne le cout de déplacement sur la case */
    public function getMovementCost() : int
    {
      return mGroundType.mMovementCost;
    }
    
    /** Retourne la distance entre deux cellules */
    public function getDistance(pCell:WorldCell) : uint
    {
      var dx:int = Math.abs(mX - pCell.mX);
      var dy:int = Math.abs(mY - pCell.mY);
      return dx + dy;
    }
  }
}