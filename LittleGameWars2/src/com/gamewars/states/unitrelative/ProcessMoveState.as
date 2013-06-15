package com.gamewars.states.unitrelative
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.states.FreeState;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.FMath;
  import com.gamewars.utils.pathfinding.PathNode;
  import com.gamewars.utils.pathfinding.PathResult;
  import com.gamewars.world.WorldCell;
  
  import starling.display.DisplayObject;
  import starling.display.MovieClip;

  public class ProcessMoveState extends UnitRelativeState
  {
    /** Durée de déplacement d'une case à l'autre (en sec.) */
    private const STEP_DURATION:Number = 0.2;
    // ------------------------------------------------------------------------
    /** Réference vers le chemin à parcourir */
    private var mNode:PathNode;
    /** Index du chemin en cours */
    private var mCellIndex:uint = 0;
    // ------------------------------------------------------------------------
    /** Toutes les cellules */
    private var mAllCells:Vector.<WorldCell>;
    /** Cellule sur laquelle se trouve l'unitée */
    private var mCurrentCell:WorldCell;
    /** Déplacement sur la prochaine cellule */
    private var mNextCell:WorldCell;
    /** Temps écoulé (pour interp.) */
    private var mTime:Number = 0;
    /** Réference vers le renderer de l'unitée */
    private var mRenderer:DisplayObject;

    /** Constructeur */
    public function ProcessMoveState(pGameScreen:GameScreen, pUnit:Unit, pNode:PathNode)
    {
      super(pGameScreen, pUnit);
      mNode = pNode;
      mRenderer = getWorld().getEntityRenderer(pUnit);
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      mAllCells = mNode.getCells().reverse();
      moveToNextCell();
    }

    /** @inheritDoc */
    override public function exitState():void
    {
      // Points de mouvement restants
      mUnit.mMovePoints = mNode.mPtsLeft;
      // Assigne la nouvelle position
      mUnit.setCell(mCurrentCell);
      mCurrentCell.layoutElement(mRenderer);
    }
    
    /** Prépare le déplacement sur la case suivante */
    private function moveToNextCell() : Boolean
    {
      mCurrentCell = mAllCells[mCellIndex];
      mCurrentCell.layoutElement(mRenderer);
      //mUnit.setCell(mCurrentCell);
      mTime = 0;
      mCellIndex++;
      // Plus de déplacements possible
      if (mCellIndex >= mAllCells.length) 
        return false;
      else
        mNextCell = mAllCells[mCellIndex];
      getWorld().mFogManager.unitPositionUpdate(mUnit, mCurrentCell.mPosition, mNextCell.mPosition);
      return true;
    }

    /** @inheritDoc */
    override public function update(pTimeDelta:Number):void
    {
      mTime += pTimeDelta;
      if (mTime >= STEP_DURATION && !moveToNextCell())
      {
        mGameScreen.setState(new FreeState(mGameScreen));
        return;
      }
      
      // Calcul de l'interp. de position
      mRenderer.x = FMath.interp_linear(mCurrentCell.mPosition.xOffset, mNextCell.mPosition.xOffset, mTime/STEP_DURATION);
      mRenderer.y = FMath.interp_linear(mCurrentCell.mPosition.yOffset, mNextCell.mPosition.yOffset, mTime/STEP_DURATION);
    }
  }
}
