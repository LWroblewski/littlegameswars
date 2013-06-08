package com.gamewars
{
  import com.gamewars.screens.GameScreen;
  import com.gamewars.screens.SplashScreen;
  
  import starling.display.Sprite;
  
  public class GameWarsRoot extends Sprite
  {
    /** Singleton */
    private static var sInstance:GameWarsRoot;
    public static function getInstance() : GameWarsRoot {return sInstance;}
    
    /** Référence vers le splash */
    private var mCurrentScreen:Sprite;
    
    public function GameWarsRoot()
    {
      super();
      sInstance = this;
      
      //displayScreen(new SplashScreen());
      displayScreen(new GameScreen());
    }
    
    /** Lance un jeu escarmouche */
    public function playSkirmish() : void
    {
      displayScreen(new GameScreen());
    }
    
    /** Affichage d'une vue */
    public function displayScreen(pScreen:Sprite) : void
    {
      if (mCurrentScreen) 
      {
        removeChild(mCurrentScreen);
        mCurrentScreen = null;
      }
      if (pScreen)
      {
        addChild(pScreen);
        mCurrentScreen = pScreen;
      }
    }
  }
}