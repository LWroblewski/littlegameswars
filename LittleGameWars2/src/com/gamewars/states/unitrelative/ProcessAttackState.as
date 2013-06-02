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
      // TODO Afficher l'écran de combat
      mGameScreen.mFightScreen.renderFight(mUnit, mTarget, getWorld());
      mGameScreen.mFightScreen.visible = true;
    }
    
    /** @inheritDoc */
    override public function update(pTimeDelta:Number):void
    {
      mGameScreen.mFightScreen.update(pTimeDelta);
      if (mGameScreen.mFightScreen.isAnimationFinished())
      {
        mGameScreen.setState(new FreeState(mGameScreen));
      }
    }
    
    override public function exitState():void
    {
      mGameScreen.mFightScreen.visible = false;
      // TODO Si hp == 0, détruire unitée
      // Calcul des hps
      mTarget.mHp -= 5;
    }
  }
}