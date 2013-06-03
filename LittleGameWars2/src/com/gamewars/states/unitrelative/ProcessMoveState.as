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
    /** Réference vers le chemin à parcourir */
    private var mPath:Path;
    /** Index du chemin en cours */
    private var mPathIndex:uint = 0;
    /** Temps écoulé */
    private var mTime:Number = 0;

    /** Constructeur */
    public function ProcessMoveState(pGameScreen:GameScreen, pUnit:Unit, pPath:Path)
    {
      super(pGameScreen, pUnit);

      mPath = pPath;
    }

    /** @inheritDoc */
    override public function exitState():void
    {
      var endPoint:PathPoint = mPath.mPoints[mPath.mPoints.length - 1];
      // Points de mouvement restants
      mUnit.mMovePoints = endPoint.mMvtPtsLeft;
      // Assigne la nouvelle position
      mUnit.setCell(endPoint.mCell);
    }

    /** @inheritDoc */
    override public function update(pTimeDelta:Number):void
    {
      var renderer:MovieClip = mGameScreen.mWorldView.getEntityRenderer(mUnit) as MovieClip;

      mTime += pTimeDelta;
      var timePerCase:Number = 0.2; // Durée de déplacement par case
      var totalTime:Number = timePerCase * mPath.mPoints.length;  // Durée du déplacement
      // Arrivé à la fin
      if (mTime >= totalTime)
      {
        // Passe à l'état suivant
        mGameScreen.setState(new FreeState(mGameScreen));
      }
      // Calcul de l'interpolation linéaire des coords
      var dt:Number = mTime / timePerCase;
      var idx:Number = uint(dt);
      var interpVal:Number = dt - idx;
      var current:PathPoint = mPath.mPoints[idx];
      var next:PathPoint = mPath.mPoints[idx + 1];
      var xx:Number = FMath.interp_linear(current.mCell.mX, next.mCell.mX, interpVal) * Tile.TILE_SIZE;
      var yy:Number = FMath.interp_linear(current.mCell.mY, next.mCell.mY, interpVal) * Tile.TILE_SIZE;
      // Positionne le sprite
      renderer.x = xx;
      renderer.y = yy;
    }
  }
}
