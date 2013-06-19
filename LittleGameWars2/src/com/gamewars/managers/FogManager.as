package com.gamewars.managers
{
  import com.gamewars.structures.Player;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.utils.TilePoint;
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
    
    /** Active/Désactive le brouillard */
    public function displayFog(pYes:Boolean) : void
    {
      if (mIsInitialized && !pYes) destroy();
      else if (!mIsInitialized && pYes) build();
    }
    
    /** Effectue le rendu de tous les brouillards */
    private function build() : void
    {
      var renderer:DisplayObject;
      for each (var c:WorldCell in mWorld.mCells)
      {
        renderer = new Quad(Tile.TILE_SIZE, Tile.TILE_SIZE, 0);
        c.layoutElement(renderer);
        mFogLayer.addChild(renderer);
        mRenderers[c] = renderer;
      }
      mIsInitialized = true;
    }
    
    /** Détruit le brouillard */
    private function destroy() : void
    {
      var renderer:Quad;
      for each (var c:WorldCell in mWorld.mCells)
      {
        renderer = mRenderers[c];
        mFogLayer.removeChild(renderer);
        delete mRenderers[c];
      }
      mIsInitialized = false;
    }
    
    /** Initialize le brouillard de guerre pour le joueur */
    public function initialize(pPlayer:Player) : void
    {
      if (!mIsInitialized)return;
      mPlayer = pPlayer;
      // TODO ExploredCells
      
      // Affiche les cellules visibles par chaque unitée
      for each (var unit:Unit in pPlayer.mUnits)
      {
        var visibles:Vector.<WorldCell> = TileUtils.computeVisibility(unit.getCell(), unit.mUnitType.mVision);
        for each (var c:WorldCell in visibles)
        {
          (mRenderers[c] as Quad).alpha = 0;
        }
      }
    }
    
    /** Maj du brouillard lors du déplacement d'une unitée */
    public function unitPositionUpdate(pUnit:Unit, pBefore:TilePoint, pAfter:TilePoint) : void
    {
      if (!mIsInitialized) return;
      
      // Calcul toutes les cellules visibles dans l'ancienne position
      var before:Vector.<WorldCell> = TileUtils.computeVisibility(mWorld.getCellAt(pBefore.tileX, pBefore.tileY), pUnit.mUnitType.mVision);
      var after:Vector.<WorldCell> = TileUtils.computeVisibility(mWorld.getCellAt(pAfter.tileX, pAfter.tileY), pUnit.mUnitType.mVision);
      var c:WorldCell;
      for each (c in after)
      {
        if (before.indexOf(c) != -1)
          before.splice(before.indexOf(c), 1);
        (mRenderers[c] as Quad).alpha = 0;
      }
      // Calcul des cellules visible par les autres unitées
      var otherUnits:Vector.<Unit> = mPlayer.mUnits.slice();
      otherUnits.splice(otherUnits.indexOf(pUnit), 1);
      var otherVisibles:Vector.<WorldCell> = computeAllVisibleCells(otherUnits);
      for each (c in before)
      {
        // Grise la cellule si elle n'est pas visibles par une autre unitée
        if (otherVisibles.indexOf(c) == -1)
          (mRenderers[c] as Quad).alpha = 0.5;
      }
    }
    
    /** Calcul de toutes les cellules visibles par le joueur */
    private function computeAllVisibleCells(pUnits:Vector.<Unit>) : Vector.<WorldCell>
    {
      var all:Vector.<WorldCell> = new <WorldCell>[];
      for each (var u:Unit in pUnits)
      {
        var visibles:Vector.<WorldCell> = TileUtils.computeVisibility(u.getCell(), u.mUnitType.mVision);
        for each (var c:WorldCell in visibles)
        {
          if (all.indexOf(c) == -1)
            all.push(c);
        }
      }
      return all;
    }
    
    /** Callback du spreadTest d'exploration */
    private function doExploration(pCell:WorldCell, pVisitedCells:Vector.<WorldCell>, pData:*) : Boolean
    {
      if (!mIsInitialized) return false;
      if (pVisitedCells.indexOf(pCell) != -1) return false;
      var rd:Quad = mRenderers[pCell] as Quad;
      rd.alpha = 0;
      return true;
    }
    
    /** Maj des brouillards */
    public function update(pTimeDelta:Number) : void
    {
      // TODO Fade-in/Fade-out des quads
    }
  }
}