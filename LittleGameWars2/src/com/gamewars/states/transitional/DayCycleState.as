package com.gamewars.states.transitional
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.states.AbstractGameState;
  import com.gamewars.states.FreeState;
  
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
      mGameScreen.nextPlayer();
      
      mGameScreen.setState(new FreeState(mGameScreen));
    }
  }
}