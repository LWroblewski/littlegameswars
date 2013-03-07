package com.littlegames.framework.stage
{

  import com.littlegames.framework.event.ChangeScreenEvent;
  import com.littlegames.framework.utils.Global;
  import com.littlegames.framework.utils.Views;
  
  import flash.utils.Dictionary;
  
  import starling.display.Sprite;
  import starling.events.Event;
  
  /** Gestionnaire des écrans */
  public class ScreenSwitcher extends Sprite
  {
    /** Ecran courant */
    private var _currentScreen:Sprite = null;
    
    /** Liste des classes des vues de l'application */
    protected var _views:Dictionary;

    public final function get views():Dictionary
    {
      if (!_views)
      {
        _views = defineViews();
      }
      return _views;
    }
    
    /** Initialisation des différentes vues du jeu */
    protected function defineViews():Dictionary
    {
      var views:Dictionary = new Dictionary(true);
      views[Views.SCREEN_MAIN] = MainScreen;
      views[Views.SCREEN_CO_SELECTION] = ScreenSelectCO;
      return views;
    }
    
    /** Première vue du jeu */
    protected function get mainScreenClass():Class
    {
      return MainScreen;
    }

    public function ScreenSwitcher()
    {
      super();
      addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
    }
    
    /** Handler sur le ADDED_TO_STAGE, affiche la première vue par défaut */
    private function addedToStage_handler(pEvent:Event):void
    {
      removeEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);

      if (mainScreenClass)
      {
        pushView(mainScreenClass);
      }
    }
    
    /** Changement de vue courante */
    private function pushView(pClass:Class):void
    {
      if (_currentScreen)
      {
        _currentScreen.dispose();
      }

      removeChildren();

      Global.currentScreen = _currentScreen = new pClass();
      _currentScreen.addEventListener(ChangeScreenEvent.CHANGE, screenChange_handler);

      addChild(_currentScreen);
    }

    private function screenChange_handler(pEvent:ChangeScreenEvent):void
    {
      if (views && views[pEvent.screenId] is Class)
      {
        pushView(views[pEvent.screenId]);
      }
    }
  }
}
