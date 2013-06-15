package com.gamewars.states.unitrelative
{
  import com.gamewars.components.GwMovieClip;
  import com.gamewars.screens.GameScreen;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.utils.pathfinding.PathNode;
  import com.gamewars.utils.pathfinding.PathResult;
  import com.gamewars.world.WorldCell;
  
  import flash.utils.Dictionary;
  
  import starling.animation.IAnimatable;
  import starling.core.Starling;
  import starling.display.DisplayObject;
  import starling.events.Touch;
  import starling.events.TouchPhase;
  
  public class MovementState extends UnitRelativeState
  {
    /** Cible du déplacement */
    private var mTargetCell:WorldCell;
    /** Dictionnaire des chemins de l'unité */
    private var mPathResult:PathResult;
    /** Liste des renderers */
    private var mRenderers:Vector.<GwMovieClip> = new <GwMovieClip>[];
    
    /** Constructeur */
    public function MovementState(pGameScreen:GameScreen, pUnit:Unit)
    {
      super(pGameScreen, pUnit);
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      // Calcul des chemins de déplacements
      mPathResult = getWorld().mPathFinding.computePaths(mUnit);
      // Affiche la grille de déplacements
      getWorld().mMovementGrid.renderOnCells(mPathResult.getCells(), renderFunction);
    }
    
    /** @inheritDoc */
    override public function exitState():void
    {
      // Nettoie la map de déplacements
      getWorld().mMovementGrid.clearGrid();
      for each (var clip:IAnimatable in mRenderers)
      {
        Starling.juggler.remove(clip);
      }
    }
    
    /** Fonction de rendu de grille */
    private function renderFunction(pCell:WorldCell) : DisplayObject
    {
      var clip:GwMovieClip = new GwMovieClip(Resources.getGuiTexs('SelectionGrid'), 8);
      clip.alpha = 0.7;
      pCell.layoutElement(clip);
      mRenderers.push(clip);
      Starling.juggler.add(clip);
      return clip;
    }
    
    /** Gestion du prochain touch */
    override public function manageTouch(pTouch:Touch):void
    {
      if (pTouch.phase != TouchPhase.ENDED)
        return;
      
      // Cellule relative
      var cell:WorldCell = getWorld().getCellFromPoint(pTouch.getLocation(getWorld()));
      // Affiche la flèche de déplacement si possible
      if (cell != null && cell != mUnit.getCell())
      {
        // Positionne le curseur
        getWorld().setCursorPosition(cell.mPosition.tileX, cell.mPosition.tileY);
        // Affiche les informations de tile
        mGameScreen.displayCellInfo(cell);
        
        // Nouvelle case sélectionnée
        if (cell != mTargetCell)
        {
          var node:PathNode = mPathResult.getNode(cell);
          if (node != null)
          {
            mTargetCell = cell;
            node = mPathResult.getNode(cell);
            getWorld().mMovementGrid.renderArrow(node);
          }
        }
        // Même case selectionnée, effectue le déplacement
        else
        {
          mGameScreen.setState(new ProcessMoveState(mGameScreen, mUnit, mPathResult.getNode(mTargetCell)));
        }
      }
    }
  }
}