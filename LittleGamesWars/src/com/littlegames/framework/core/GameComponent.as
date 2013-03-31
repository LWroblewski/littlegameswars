package com.littlegames.framework.core
{
  import com.littlegames.framework.core.engine.GameEngine;
  import com.littlegames.framework.core.engine.tileengine.TileMap;
  import com.littlegames.framework.core.engine.tileengine.TileMapGenerator;
  
  import starling.core.Starling;
  import starling.display.Sprite;
  import starling.events.EnterFrameEvent;
  
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
      
      Starling.current.showStats = true;
      
      _gameEngine = new GameEngine(this);
      
      addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
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
      
      // MAP Random
      var tileMap:TileMap = new TileMap(40, 40);
      new TileMapGenerator().generate(tileMap);
      _gameEngine.initializeGame(tileMap);
    }
  }
}