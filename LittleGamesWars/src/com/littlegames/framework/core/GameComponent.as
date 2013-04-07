package com.littlegames.framework.core
{
  import com.littlegames.framework.core.engine.logic.GameEngine;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.engine.render.tileengine.TileMapGenerator;
  
  import flash.display.Stage;
  
  import starling.core.Starling;
  import starling.display.Sprite;
  import starling.events.EnterFrameEvent;
  import starling.events.Event;
  
  public class GameComponent extends Sprite
  {
    /** Moteur du jeu */
    private var _gameEngine:GameEngine;
    /** Initialisation */
    private var _isInitialized:Boolean = false;
    
    /** Composant du jeu */
    public function GameComponent()
    {
      super();
      
      // DBG
      Starling.current.showStats = true;
      // Main loop
      addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
      // Moteur
      _gameEngine = new GameEngine(this);
    }
    
    /** Nouvelle frame */
    private function onEnterFrame(pEvent:EnterFrameEvent) : void
    {
      // Initialisation du jeu
      if (!_isInitialized) initialize();
      
      _gameEngine.update(pEvent.passedTime);
    }

    /** Initialisation du jeu */
    private function initialize() : void
    {
      _isInitialized = true;
      
      _gameEngine.initializeGame(null);
    }
  }
}