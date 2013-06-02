package com.gamewars.states.unitrelative
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.pathfinding.Path;
  import com.gamewars.utils.pathfinding.PathPoint;
  import com.gamewars.world.WorldCell;
  
  import starling.display.MovieClip;
  import com.gamewars.states.FreeState;
  
  public class ProcessMoveState extends UnitRelativeState
  {
    /** Réference vers le chemin à parcourir */
    private var mPath:Path;
    /** Index du chemin en cours */
    private var mPathIndex:uint = 0;
    
    /** Constructeur */
    public function ProcessMoveState(pGameScreen:GameScreen, pUnit:Unit, pPath:Path)
    {
      super(pGameScreen, pUnit);
      
      mPath = pPath;
    }
    
    /** @inheritDoc */
    override public function exitState():void
    {
      var endPoint:PathPoint = mPath.mPoints[mPath.mPoints.length-1];
      // Points de mouvement restants
      mUnit.mMovePoints = endPoint.mMvtPtsLeft;
      // Assigne la nouvelle position
      mUnit.setCell(endPoint.mCell);
    }
    
    /** @inheritDoc */
    override public function update(pTimeDelta:Number):void
    {
      var renderer:MovieClip = mGameScreen.mWorldView.getEntityRenderer(mUnit) as MovieClip;
      var point:PathPoint = mPath.mPoints[mPathIndex];
      
      var dstX:Number = point.mCell.mX * Tile.TILE_SIZE;
      var dstY:Number = point.mCell.mY * Tile.TILE_SIZE;
      
      var dx:Number = dstX - renderer.x;
      var dy:Number = dstY - renderer.y;
      
      renderer.x = dstX;
      renderer.y = dstY;
      
      // Arrivé à destination
      if (renderer.x == dstX && renderer.y == dstY)
      {
        // Fin
        if (++mPathIndex == mPath.mPoints.length)
        {
          mGameScreen.setState(new FreeState(mGameScreen));
        }
      }
    }
  }
}