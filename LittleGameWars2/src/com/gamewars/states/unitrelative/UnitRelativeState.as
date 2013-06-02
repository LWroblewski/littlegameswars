package com.gamewars.states.unitrelative
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.structures.Unit;
  import com.gamewars.states.AbstractGameState;
  
  public class UnitRelativeState extends AbstractGameState
  {
    /** Réference vers l'unitée */
    protected var mUnit:Unit;
    
    /** Constructeur */
    public function UnitRelativeState(pGameScreen:GameScreen, pUnit:Unit)
    {
      super(pGameScreen);
      mUnit = pUnit;
    }
  }
}