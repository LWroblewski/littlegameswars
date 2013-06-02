package com.gamewars.states
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.world.World;
  
  import starling.events.Touch;
  import starling.events.TouchEvent;

  public class AbstractGameState
  {
    /** Réference vers le context */
    public var mGameScreen:GameScreen;
    
    /** Getter sur le monde */
    protected function getWorld() : World
    {
      return mGameScreen.mWorldView;
    }
    
    /** Constructeur */
    public function AbstractGameState(pGameScreen:GameScreen)
    {
      mGameScreen = pGameScreen;
    }
    
    /** Transition d'entrée */
    public function enterState() : void
    {
      // TO OVERRIDE
    }
    
    /** Transition de sortie */
    public function exitState() : void
    {
      // TO OVERRIDE
    }
    
    /** Gestion du touch */
    public function manageTouch(pTouch:Touch) : void
    {
      // TO OVERRIDE
    }
    
    /** Maj */
    public function update(pTimeDelta:Number) : void
    {
      // TO OVERRIDE
    }
  }
}