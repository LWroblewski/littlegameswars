package com.gamewars.managers
{
  import com.gamewars.structures.Player;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.utils.TileUtils;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.Quad;
  import starling.display.Sprite;
  
  public class FogManager
  {
    /** Réference vers le monde */
    private var mWorld:World;
    /** Layer du brouillard */
    private var mFogLayer:Sprite;
    /** Rendus de brouillard */
    private var mRenderers:Dictionary = new Dictionary(); // [WorldCell] => Renderer
    /** Liste des cellulles explorées */
    private var mExploredCells:WorldCell;
    /** Indicateur d'initialisation */
    private var mIsInitialized:Boolean = false;
    /** Joueur associé */
    private var mPlayer:Player;
    /** Liste des cellules non valides */
    private var mInvalidates:Vector.<WorldCell> = new <WorldCell>[];
    
    /** Constructeur */
    public function FogManager(pWorld:World, pFogLayer:Sprite)
    {
      mWorld = pWorld;
      mFogLayer = pFogLayer;
    }
    
    /** Effectue le rendu de tous les brouillards */
    private function build() : void
    {
      var renderer:DisplayObject;
      for each (var c:WorldCell in mWorld.mCells)
      {
        renderer = new Quad(Tile.TILE_SIZE, Tile.TILE_SIZE, 0);
        c.layoutElement(renderer);
        //mFogLayer.addChild(renderer);
        mRenderers[c] = renderer;
      }
    }
    
    /** Initialize le brouillard de guerre pour le joueur */
    public function initialize(pPlayer:Player) : void
    {
      mPlayer = pPlayer;
      if (!mIsInitialized)
      {
        build();
      }
      // TODO ExploredCells
    }
    
    /** Maj du brouillard lors du déplacement d'une unitée */
    public function unitPositionUpdate(pUnit:Unit, pLastX:uint, pLastY:uint, pNewX:uint, pNewY:uint) : void
    {
      // Calcul toutes les cellules visibles dans l'ancienne position
      var before:Vector.<WorldCell> = TileUtils.computeVisibility(mWorld.getCellAt(pLastX, pLastY), pUnit.mUnitType.mVision);
      var after:Vector.<WorldCell> = TileUtils.computeVisibility(mWorld.getCellAt(pNewX, pNewY), pUnit.mUnitType.mVision);
    }
    
    /** Callback du spreadTest d'exploration */
    private function doExploration(pCell:WorldCell, pVisitedCells:Vector.<WorldCell>, pData:*) : Boolean
    {
      if (pVisitedCells.indexOf(pCell) != -1) return false;
      var rd:Quad = mRenderers[pCell] as Quad;
      rd.alpha = 0;
      return true;
    }
    
    /** Maj des brouillards */
    public function update(pTimeDelta:Number) : void
    {
      
    }
  }
}