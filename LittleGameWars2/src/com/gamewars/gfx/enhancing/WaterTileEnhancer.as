package com.gamewars.gfx.enhancing
{
  import com.gamewars.enums.GroundType;
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Tile;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.WorldCell;
  
  import starling.display.Image;
  import starling.textures.RenderTexture;

  public class WaterTileEnhancer
  {
    /** Rendu des tiles de type eau */
    public static function render(pCell:WorldCell, pTexture:RenderTexture) : void
    {
      var miSize:Number = Tile.TILE_SIZE >> 1;
      var waterPrefix:String = 'WATER_';
      var img:Image = new Image(Resources.emptyTex(miSize, miSize));
      var partName:String;
      
      // Haut gauche
      partName = waterPrefix + getTexSuffix(pCell, WindRose.WEST, WindRose.NORTH, WindRose.NORTH_WEST) + '_TL';
      img.texture = Resources.getTileTextures(partName)[0];
      img.x = pCell.mPosition.xOffset;
      img.y = pCell.mPosition.yOffset;
      pTexture.draw(img);
      // Haut droit
      partName = waterPrefix + getTexSuffix(pCell, WindRose.NORTH, WindRose.EAST, WindRose.NORTH_EAST) + '_TR';
      img.texture = Resources.getTileTextures(partName)[0];
      img.x = pCell.mPosition.xOffset + miSize;
      img.y = pCell.mPosition.yOffset;
      pTexture.draw(img);
      // Bas droit
      partName = waterPrefix + getTexSuffix(pCell, WindRose.EAST, WindRose.SOUTH, WindRose.SOUTH_EAST) + '_BR';
      img.texture = Resources.getTileTextures(partName)[0];
      img.x = pCell.mPosition.xOffset + miSize;
      img.y = pCell.mPosition.yOffset + miSize;
      pTexture.draw(img);
      // Bas gauche
      partName = waterPrefix + getTexSuffix(pCell, WindRose.SOUTH, WindRose.WEST, WindRose.SOUTH_WEST) + '_BL';
      img.texture = Resources.getTileTextures(partName)[0];
      img.x = pCell.mPosition.xOffset;
      img.y = pCell.mPosition.yOffset + miSize;
      pTexture.draw(img);
    }

    /** Retourne le suffixe à utiliser pour les parties du rendu d'eau en fonction des terrains aux directions spécifiées */
    private static function getTexSuffix(pCell:WorldCell, pSideDir:WindRose, pSide2Dir:WindRose, pCornerDir:WindRose) : String
    {
      var suffix:String = 'FULL';
      var side:GroundType = pCell.getGroundTypeAt(pSideDir);
      if (side == null) side = GroundType.PLAIN;
      var side2:GroundType = pCell.getGroundTypeAt(pSide2Dir);
      if (side2 == null) side2 = GroundType.PLAIN;
      var corner:GroundType = pCell.getGroundTypeAt(pCornerDir);
      if (corner == null) corner = GroundType.PLAIN;
      
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
  }
}