package com.gamewars.states.unitrelative
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.states.FreeState;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.FMath;
  import com.gamewars.utils.pathfinding.Path;
  import com.gamewars.utils.pathfinding.PathPoint;
  import com.gamewars.world.WorldCell;
  
  import starling.display.MovieClip;

  public class ProcessMoveState extends UnitRelativeState
  {
    /** Durée de déplacement d'une case à l'autre (en sec.) */
    private const STEP_DURATION:Number = 0.2;
    /** Réference vers le chemin à parcourir */
    private var mPath:Path;
    /** Index du chemin en cours */
    private var mPathIndex:uint = 0;
    /** Temps écoulé */
    private var mTime:Number = 0;
    /** Temps total d'animation de déplacement */
    private var mTotalTime:Number;

    /** Constructeur */
    public function ProcessMoveState(pGameScreen:GameScreen, pUnit:Unit, pPath:Path)
    {
      super(pGameScreen, pUnit);

      mPath = pPath;
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      // Calcule la durée totale d'animation
      mTotalTime = (mPath.mPoints.length-1) * STEP_DURATION;
    }

    /** @inheritDoc */
    override public function exitState():void
    {
      var renderer:MovieClip = mGameScreen.mWorld.getEntityRenderer(mUnit) as MovieClip;
      var endPoint:PathPoint = mPath.mPoints[mPath.mPoints.length - 1];
      // Points de mouvement restants
      mUnit.mMovePoints = endPoint.mMvtPtsLeft;
      // Assigne la nouvelle position
      mUnit.setCell(endPoint.mCell);
      renderer.x = endPoint.mCell.mX * Tile.TILE_SIZE;
      renderer.y = endPoint.mCell.mY * Tile.TILE_SIZE;
    }

    /** @inheritDoc */
    override public function update(pTimeDelta:Number):void
    {
      var renderer:MovieClip = mGameScreen.mWorld.getEntityRenderer(mUnit) as MovieClip;
      mTime += pTimeDelta;
      if (mTime >= mTotalTime)
      {
        mGameScreen.setState(new FreeState(mGameScreen));
        return;
      }
      var framePos:Number = mTime / STEP_DURATION;
      var pathIdx:uint = uint(framePos);
      var interpVal:Number = framePos - pathIdx;
      var currentCell:WorldCell = mPath.mPoints[pathIdx].mCell;
      var nextCell:WorldCell = mPath.mPoints[pathIdx+1].mCell;
      renderer.x = FMath.interp_linear(currentCell.getX(), nextCell.getX(), interpVal);
      renderer.y = FMath.interp_linear(currentCell.getY(), nextCell.getY(), interpVal);
    }
  }
}
