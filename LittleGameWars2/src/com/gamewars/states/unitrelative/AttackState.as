package com.gamewars.states.unitrelative
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.WorldCell;
  
  import starling.core.Starling;
  import starling.display.MovieClip;
  import starling.events.Touch;
  import starling.events.TouchPhase;
  
  public class AttackState extends UnitRelativeState
  {
    /** Liste des cases que l'unitée peut attaquer */
    private var mTargetables:Vector.<WorldCell>;
    /** Liste des rendus générés */
    private var mRenderers:Vector.<MovieClip> = new <MovieClip>[];
    
    /** Constructeur */
    public function AttackState(pGameScreen:GameScreen, pUnit:Unit)
    {
      super(pGameScreen, pUnit);
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      // Calcul toutes les cibles
      mTargetables = getWorld().mPathFinding.computeTargetables(mUnit);
      getWorld().mMovementGrid.renderOnCells(mTargetables, renderFunction);
      // Affiche le curseur de cible
      getWorld().mCursor.setModeAttack();
      // Positionne le curseur sur le premier ennemi
      getWorld().mCursor.centerOnCell(mTargetables[0]);
    }
    
    /** @inheritDoc */
    override public function exitState():void
    {
      getWorld().mCursor.setModeSelect();
      getWorld().mMovementGrid.clearGrid();
      for each (var renderer:MovieClip in mRenderers)
      {
        Starling.juggler.remove(renderer);
      }
    }
    
    /** Fonction de rendu du grille */
    private function renderFunction(pCell:WorldCell) : MovieClip
    {
      var result:MovieClip = new MovieClip(Resources.getGuiTexs('SelectionGrid'), 5);
      pCell.layoutElement(result);
      mRenderers.push(result);
      Starling.juggler.add(result);
      return result;
    }
    
    /** @inheritDoc */
    override public function manageTouch(pTouch:Touch):void
    {
      if (pTouch.phase != TouchPhase.ENDED)
        return;
      
      // Cellule relative
      var cell:WorldCell = getWorld().getCellFromPoint(pTouch.getLocation(getWorld()));
      // Si la cellule contient un ennemi, on l'attaque
      if (cell.getUnit() && cell.getUnit() != mUnit)
      {
        mGameScreen.setState(new ProcessAttackState(mGameScreen, mUnit, cell.getUnit()));
      }
    }
  }
}