package com.gamewars.states.unitrelative
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.states.FreeState;
  import com.gamewars.structures.Unit;
  
  public class ProcessAttackState extends UnitRelativeState
  {
    /** Réference vers la cible */
    private var mTarget:Unit;
    
    /** Constructeur */
    public function ProcessAttackState(pGameScreen:GameScreen, pUnit:Unit, pTarget:Unit)
    {
      super(pGameScreen, pUnit);
      mTarget = pTarget;
    }
    
    /** @inheritDoc */
    override public function enterState():void
    {
      // Calcul du combat entre les 2 unitées
      mGameScreen.mGameEngine.processFight(mUnit, mTarget);
      // Change l'état de jeu
      mGameScreen.setState(new FreeState(mGameScreen));
    }
  }
}