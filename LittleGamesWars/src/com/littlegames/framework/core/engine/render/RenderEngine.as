package com.littlegames.framework.core.engine.render
{
  import com.littlegames.framework.core.action.GameAction;
  import com.littlegames.framework.core.action.GameActionResult;
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.engine.render.layers.EntityLayer;
  import com.littlegames.framework.core.engine.render.layers.GUILayer;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.resources.Resources;
  
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.TouchEvent;
  import flash.geom.Point;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.ResizeEvent;

  public class RenderEngine
  {
    /** Zone de rendu global */
    public var renderLayer:Sprite;
    /** Zone de rendu du jeu */
    private var _entityLayer:EntityLayer;
    /** Zone de rendu de l'interface graphique */
    private var _guiLayer:GUILayer;
    // ------------------------------------------------------------------------
    /** Gestion du curseur */
    private var _cursor:Image;
    // ------------------------------------------------------------------------
    /** Liste des resultats d'actions à traiter */
    private var _listGameActionResults:Vector.<GameActionResult> = new <GameActionResult>[];
    /** Liste des actions en attente de traitement */
    private var _listPendingActions:Vector.<GameAction> = new <GameAction>[];
    /** Layout du jeu */
    private var _layout:GridLayout;
    // ------------------------------------------------------------------------
    /** Données du jeu */
    private var _gameData:GameData;
    // ------------------------------------------------------------------------
    /** Reset de l'affichage */
    private var _viewIsDirty:Boolean = false;
    
    /** Moteur de rendu */
    public function RenderEngine()
    {
      _layout = new GridLayout(20, 20);
      
      _entityLayer = new EntityLayer();
      _guiLayer = new GUILayer();
      _cursor = Resources.getImage("cursor");
      _layout.sizeImage(_cursor);
      
      renderLayer = new Sprite();
      renderLayer.addChild(_entityLayer);
      renderLayer.addChild(_guiLayer);
      renderLayer.addChild(_cursor);
      
      Starling.current.nativeStage.addEventListener(MouseEvent.CLICK, onTouch);
      Starling.current.stage.addEventListener(ResizeEvent.RESIZE, onResize);
    }
    
    /** Redimensionnement du jeu */
    private function onResize(pEvent:ResizeEvent) : void
    {
      updateLayout();
    }
    
    private function get maxWidth() : Number
    {
      return Starling.current.stage.width;
    }
    
    private function get maxHeigh() : Number
    {
      return Starling.current.stage.height;
    }
    
    /** Maj du layout */
    private function updateLayout() : void
    {
      _guiLayer.updateLayout();
    }
    
    /** Maj du rendu */
    public function update(pTimeDelta:Number) : void
    {
      if (_viewIsDirty) 
      {
        rebuildView();
        _viewIsDirty = false;
      }
      
      _gameData.ellapsedTime = pTimeDelta;
      _entityLayer.update(_gameData);
      _guiLayer.update(_gameData);
    }
    
    /** Réinitialize la vue */
    private function rebuildView() : void
    {
      _entityLayer.initialize(_gameData);
    }
    
    /** Définit la map */
    public function setGameData(pGameData:GameData) : void
    {
      _gameData = pGameData;
      _viewIsDirty = true;
    }
    
    /** Gestion touch/click */
    private function onTouch(pEvent:MouseEvent) : void
    {
      // Récupère les coords de la souris
      _gameData.cursorPosition.setTo(pEvent.stageX, pEvent.stageY);
      _layout.clampToTile(_gameData.cursorPosition);
      
      // Modifie la position du curseur
      _cursor.x = _gameData.cursorPosition.x;
      _cursor.y = _gameData.cursorPosition.y;
    }
    
    /** Gère le traitement graphique d'une action */
    public function pushActionResult(pActionResult:GameActionResult) : void
    {
      // TODO
    }
  }
}