package com.littlegames.framework.core
{
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.resources.Textures;
  import com.littlegames.framework.tileengine.TileMap;
  import com.littlegames.framework.tileengine.TileMapViewer;
  
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.Sprite;

  public class GameEngine
  {
    /** Réference vers le composant de jeu */
    private var _gameComponent:GameComponent;
    // ------------------------------------------------------------------------
    /** Réference vers le viewer de map */
    private var _tileMapViewer:TileMapViewer;
    /** Map en cours */
    private var _currentMap:TileMap;
    /** Entrée de jeu */
    private var _gameInput:GameInput;
    /** Curseur de selection */
    private var _cursor:Image;
    
    public function GameEngine(pRoot:GameComponent)
    {
      _gameComponent = pRoot;
      
      _tileMapViewer = new TileMapViewer();
      addChild(_tileMapViewer);
      
      _cursor = new Image(Textures.textureAtlas.getTexture('Cursor_0'));
      addChild(_cursor);
      
      _gameInput = new GameInput();
    }
    
    /** Ajoute un child au jeu */
    private function addChild(pSprite:DisplayObject) : void
    {
      _gameComponent.addChild(pSprite);
    }
    
    /** Lance le jeu */
    public function initializeGame(pMap:TileMap) : void
    {
      _currentMap = pMap;
      _tileMapViewer.setMap(pMap);
    }
    
    /** Boucle de jeu */
    public function update(pTimeDelta:Number) : void
    {
      // MAJ de la map
      _tileMapViewer.update(pTimeDelta);
      
      // MAJ du curseur
      // TODO Centraliser 16 (=dimension en pixels d'une tile)
      var cursorX:Number = 16*uint(_gameInput.getMousePosition().x/16);
      var cursorY:Number = 16*uint(_gameInput.getMousePosition().y/16);
      _cursor.x = cursorX;
      _cursor.y = cursorY;
    }
  }
}