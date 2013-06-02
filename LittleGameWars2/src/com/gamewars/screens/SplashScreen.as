package com.gamewars.screens
{
  import com.gamewars.GameWarsRoot;
  import com.gamewars.utils.Resources;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;

  /**
  * Ecran d'accueil
  */
  public class SplashScreen extends BaseScreen
  {
    public function SplashScreen()
    {
      super();
      addChild(new Image(Resources.getSplash()));
      addEventListener(TouchEvent.TOUCH, onTouch);
    }
    
    /** Affiche l'écran de menu du jeu */
    private function onTouch(pEvent:TouchEvent) : void
    {
      if (pEvent.touches[0].phase == TouchPhase.ENDED)
      {
        removeEventListener(TouchEvent.TOUCH, onTouch);
        GameWarsRoot.getInstance().displayScreen(new MainMenuScreen());
      }
    }
  }
}