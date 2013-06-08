package com.gamewars.states
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.states.unitrelative.UnitSelectedState;
  import com.gamewars.world.WorldCell;
  
  import flash.geom.Point;
  
  import starling.events.Touch;
  import starling.events.TouchPhase;
  
  public class FreeState extends AbstractGameState
  {
    /** Constructeur */
    public function FreeState(pGameScreen:GameScreen)
    {
      super(pGameScreen);
    }
    
    /** Gestion du touch */
    override public function manageTouch(pTouch:Touch):void
    {
      if (pTouch.phase != TouchPhase.ENDED)
        return;
      var localPoint:Point = pTouch.getLocation(mGameScreen.mWorld);
      
      var cell:WorldCell = mGameScreen.mWorld.getCellFromPoint(localPoint);
      if (!cell)
        return;
      
      mGameScreen.mWorld.setCursorPosition(cell.mX, cell.mY);
      mGameScreen.mCellInfoView.setCellInfo(cell);
      // Selectionne l'unitée sur la cellule
      if (cell.getUnit() != null && cell.getUnit().mMovePoints > 0)
      {
        // Passe à l'état déplacement
        mGameScreen.setState(new UnitSelectedState(mGameScreen, cell.getUnit()));
      }
    }
  }
}