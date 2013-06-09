package com.gamewars.components
{
  import com.gamewars.structures.Tile;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.WorldCell;
  
  import starling.animation.IAnimatable;
  import starling.display.Sprite;
  import starling.textures.Texture;
  
  public class GwCursor extends Sprite implements IAnimatable
  {
    private static const SELECT_TEXS:Vector.<Texture> = Resources.getCursorTexs('CursorSelect');
    private static const TARGET_TEXS:Vector.<Texture> = Resources.getCursorTexs('CursorTarget');
    
    /** Movie clip du curseur */
    private var mClip:GwMovieClip;
    
    /** Constructeur */
    public function GwCursor()
    {
      super();
      mClip = new GwMovieClip(SELECT_TEXS);
      mClip.fps = 8;
      addChild(mClip);
    }
    
    /** Affiche le curseur de selection */
    public function setModeSelect() : void
    {
      setTextures(SELECT_TEXS);
    }
      
    /** Affiche le curseur d'attaque */
    public function setModeAttack() : void
    {
      setTextures(TARGET_TEXS);
    }
    
    /** Active les textures passées en paramètres */
    private function setTextures(pTexs:Vector.<Texture>) : void
    {
      for (var i:uint = SELECT_TEXS.length; i > 0; i--)
      {
        mClip.setFrameTexture(i-1, pTexs[i-1]);
      }
    }
    
    /** Centre le curseur sur la cellule passée en paramètres */
    public function centerOnCell(pCell:WorldCell) : void
    {
      x = -(width - Tile.TILE_SIZE)/2 + pCell.mX * Tile.TILE_SIZE;
      y = -(height - Tile.TILE_SIZE)/2 + pCell.mY * Tile.TILE_SIZE;
    }
    
    /** Maj */
    public function advanceTime(pTime:Number):void
    {
      mClip.advanceTime(pTime);
    }
  }
}