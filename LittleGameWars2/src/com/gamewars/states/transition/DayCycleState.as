package com.gamewars.states.transition
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.states.AbstractGameState;
  import com.gamewars.states.FreeState;
  import com.gamewars.structures.Player;
  import com.gamewars.structures.Unit;
  import com.gamewars.world.WorldCell;
  
  /**
  * Affiche le numéro du jour de jeu
  */
  public class DayCycleState extends AbstractGameState
  {
    /** Constructeur */
    public function DayCycleState(pGameScreen:GameScreen)
    {
      super(pGameScreen);
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      // Sélectionne le joueur en cours
      var pl:Player = mGameScreen.nextPlayer();
      mGameScreen.mWorld.mFogManager.initialize(pl);
      mGameScreen.setState(new FreeState(mGameScreen));
    }
  }
}