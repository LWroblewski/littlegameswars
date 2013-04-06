package com.littlegames.framework.stage
{
  import com.littlegames.framework.utils.Global;
  
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;
  
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.KeyboardEvent;

  public class BaseScreen extends Sprite
  {
    public function BaseScreen()
    {
      super();
      addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
    }

    private function addedToStage_handler(pEvent:Event):void
    {
      removeEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);

      //Mise à jour de l'affichage à chaque ENTER_FRAME (moment où la scène est redessinée)
      //Correspond au cycle de rafraichissement de l'application.
      stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame);

      //Passage du stage dans une variable statique, pour utilisation en dehors des vues.
      Global.stage = stage;

      initGameStage();

      //Mode dev Cylande...
      //alpha = 0.2;
    }

    protected function initGameStage():void
    {

    }

    /**
     * Fonction appelée à chaque rafraichissement de l'écran. Détermine les actions à
     * effectuer à l'écran.
     */
    private function _onEnterFrame(pEvent:Event):void
    {
      onEnterFrame();
    }

    protected function onEnterFrame():void
    {

    }

    override public function dispose():void
    {
      super.dispose();

      stage.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
    }
  }
}