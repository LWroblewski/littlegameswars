package com.gamewars.states.unitrelative
{
  import com.gamewars.components.GwMovieClip;
  import com.gamewars.screens.GameScreen;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.utils.pathfinding.Path;
  import com.gamewars.utils.pathfinding.PathPoint;
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
    private var mPathPoints:Dictionary; // [WorldCell] => PathPoint
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
      mPathPoints = getWorld().mPathFinding.computeReachables(mUnit);
      var cells:Vector.<WorldCell> = new <WorldCell>[];
      for (var key:* in mPathPoints)
      {
        cells.push(key as WorldCell);
      }
      // Affiche la grille de déplacements
      getWorld().mMovementGrid.renderOnCells(cells, renderFunction);
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
        getWorld().setCursorPosition(cell.mX, cell.mY);
        // Affiche les informations de tile
        mGameScreen.displayCellInfo(cell);
        
        // Nouvelle case
        var path:Path;
        if (cell != mTargetCell)
        {
          if (mPathPoints[cell] != undefined)
          {
            mTargetCell = cell;
            path = (mPathPoints[mTargetCell] as PathPoint).getPath();
            getWorld().mMovementGrid.renderArrow(path);
          }
        }
        // Même case selectionnée, effectue le déplacement
        else
        {
          path = (mPathPoints[mTargetCell] as PathPoint).getPath();
          mGameScreen.setState(new ProcessMoveState(mGameScreen, mUnit, path));
        }
      }
    }
  }
}