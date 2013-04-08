package com.littlegames.framework.core.engine.render
{
  import com.littlegames.framework.core.action.GameAction;
  import com.littlegames.framework.core.action.GameActionResult;
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.engine.render.layers.GUILayer;
  import com.littlegames.framework.core.engine.render.layers.MapLayer;
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
    private var _mapLayer:MapLayer;
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
    // ------------------------------------------------------------------------
    /** Données du jeu */
    private var _gameData:GameData;
    // ------------------------------------------------------------------------
    /** Reset de l'affichage */
    private var _viewIsDirty:Boolean = false;
    
    /** Moteur de rendu */
    public function RenderEngine()
    {
      _mapLayer = new MapLayer();
      _guiLayer = new GUILayer();
      _cursor = Resources.getImage("cursor");
      
      renderLayer = new Sprite();
      renderLayer.addChild(_mapLayer);
      renderLayer.addChild(_guiLayer);
      renderLayer.addChild(_cursor);
      
      //Starling.current.nativeStage.addEventListener(MouseEvent.CLICK, onTouch);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
      Starling.current.nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEvent);
      Starling.current.stage.addEventListener(ResizeEvent.RESIZE, onResize);
    }
    
    // ------------------------------------------------------------------------
    private var _mouseIsDown:Boolean = false;
    private var _mouseDownPosition:Point = new Point();
    private var _initialScrollPosition:Point;
    /** Gestion de la souris */
    private function onMouseEvent(pEvent:MouseEvent) : void
    {
      if (pEvent.type == MouseEvent.MOUSE_DOWN)
      {
        _mouseIsDown = true;
        _mouseDownPosition.setTo(pEvent.stageX, pEvent.stageY);
      }
      else if (pEvent.type == MouseEvent.MOUSE_UP)
      {
        _mouseIsDown = false;
        _mapLayer.setLocalCursorPosition(pEvent.stageX, pEvent.stageY);
      }
      else if (pEvent.type == MouseEvent.MOUSE_MOVE && _mouseIsDown)
      {
        var deltaX:Number= _mouseDownPosition.x - pEvent.stageX;
        var deltaY:Number = _mouseDownPosition.y - pEvent.stageY;
        _mouseDownPosition.setTo(pEvent.stageX, pEvent.stageY);
        if (deltaX != 0 || deltaY != 0)
        {
          _mapLayer.scroll(deltaX, deltaY);
        }
      }
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
      _mapLayer.update(_gameData);
      _guiLayer.update(_gameData);
    }
    
    /** Réinitialize la vue */
    private function rebuildView() : void
    {
      _mapLayer.initialize(_gameData);
    }
    
    /** Définit la map */
    public function setGameData(pGameData:GameData) : void
    {
      _gameData = pGameData;
      _viewIsDirty = true;
    }
    
    /** Gère le traitement graphique d'une action */
    public function pushActionResult(pActionResult:GameActionResult) : void
    {
      // TODO
    }
  }
}