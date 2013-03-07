package com.littlegames.framework.stage
{
  import flash.display.Sprite;
  import flash.display.StageAlign;

  import starling.core.Starling;
  
  /** Classe de base des applications de chaque niveau de la campagne */
  public class GameApplication extends Sprite
  {
    /** Moteur de rendu du jeu. */
    protected var _starling:Starling = null;

    /** Constructeur de l'application */
    public function GameApplication(pDefaultStage:Class = null)
    {
      super();

      stage.align = StageAlign.TOP_LEFT;

      if (!pDefaultStage)
      {
        pDefaultStage = ScreenSwitcher;
      }

      //Gestion de l'affichage de l'application.
      _starling = new Starling(pDefaultStage, stage);

      // réglage de l'antialiasing (valeur haute = meilleure qualité, mais performances moindres)
      _starling.antiAliasing = 1;

      // démarrage du main.
      _starling.start();
    }
  }
}