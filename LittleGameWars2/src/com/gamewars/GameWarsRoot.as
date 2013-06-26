package com.gamewars
{
  import com.gamewars.screens.COSelectionScreen;
  import com.gamewars.screens.GameScreen;
  import com.gamewars.screens.SplashScreen;
  
  import starling.core.Starling;
  import starling.display.Quad;
  import starling.display.Sprite;
  
  public class GameWarsRoot extends Sprite
  {
    /** Singleton */
    private static var sInstance:GameWarsRoot;
    public static function getInstance() : GameWarsRoot {return sInstance;}
    
    /** Référence vers le splash */
    private var mCurrentScreen:Sprite;
    
    /** Arrière plan */
    private var bg:Quad;
    
    public function GameWarsRoot()
    {
      super();
      sInstance = this;
      
      bg = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0x555555);
      addChild(bg);
      
      //displayScreen(new SplashScreen());
      displayScreen(new COSelectionScreen());
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