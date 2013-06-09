package com.gamewars.gfx
{
  import com.gamewars.enums.GroundType;
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Tile;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.WorldCell;
  
  import starling.animation.IAnimatable;
  import starling.display.DisplayObject;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  
  public class WaterTileRenderer extends Sprite implements IAnimatable
  {
    /** Constructeur */
    public function WaterTileRenderer()
    {
      super();
    }
    
    /** Initialisation */
    public function initializeFromCell(pCell:WorldCell) : void
    {
      removeChildren();
      
      var waterPrefix:String = 'WATER_';
      var clip:MovieClip;
      var partName:String;
      // Haut gauche
      partName = waterPrefix + getTexSuffix(pCell, WindRose.WEST, WindRose.NORTH, WindRose.NORTH_WEST) + '_TL';
      clip = new MovieClip(Resources.getTileTextures(partName));
      clip.x = 0;
      clip.y = 0;
      addChild(clip);
      // Haut droit
      partName = waterPrefix + getTexSuffix(pCell, WindRose.NORTH, WindRose.EAST, WindRose.NORTH_EAST) + '_TR';
      clip = new MovieClip(Resources.getTileTextures(partName));
      clip.x = Tile.TILE_SIZE/2;
      clip.y = 0;
      addChild(clip);
      // Bas droit
      partName = waterPrefix + getTexSuffix(pCell, WindRose.EAST, WindRose.SOUTH, WindRose.SOUTH_EAST) + '_BR';
      clip = new MovieClip(Resources.getTileTextures(partName));
      clip.x = Tile.TILE_SIZE/2;
      clip.y = Tile.TILE_SIZE/2;
      addChild(clip);
      // Bas gauche
      partName = waterPrefix + getTexSuffix(pCell, WindRose.SOUTH, WindRose.WEST, WindRose.SOUTH_WEST) + '_BL';
      clip = new MovieClip(Resources.getTileTextures(partName));
      clip.x = 0;
      clip.y = Tile.TILE_SIZE/2;
      addChild(clip);
    }
    
    /** Retourne le suffixe à utiliser pour les parties du rendu d'eau en fonction des terrains aux directions spécifiées */
    private function getTexSuffix(pCell:WorldCell, pSideDir:WindRose, pSide2Dir:WindRose, pCornerDir:WindRose) : String
    {
      var suffix:String = 'FULL';
      var side:GroundType = pCell.getGroundTypeAt(pSideDir);
      if (side == null) side = GroundType.WATER;
      var side2:GroundType = pCell.getGroundTypeAt(pSide2Dir);
      if (side2 == null) side2 = GroundType.WATER;
      var corner:GroundType = pCell.getGroundTypeAt(pCornerDir);
      if (corner == null) corner = GroundType.WATER;
      
      // Joint
      if (side != GroundType.WATER && side2 != GroundType.WATER)
        suffix = 'JOIN';
        // Ile
      else if (side == GroundType.WATER && side2 == GroundType.WATER && corner != GroundType.WATER)
        suffix = 'ISLE';
        // Side
      else if (side != GroundType.WATER && side2 == GroundType.WATER)
        suffix = 'SIDE';
        // Side2
      else if (side == GroundType.WATER && side2 != GroundType.WATER)
        suffix = 'SIDE2';
      
      return suffix;
    }
    
    /** Animation */
    public function advanceTime(time:Number):void
    {
      for (var i:uint = 0; i < numChildren; i++)
      {
        if (getChildAt(i) is IAnimatable)
          (getChildAt(i) as IAnimatable).advanceTime(time);
      }
    }
  }
}