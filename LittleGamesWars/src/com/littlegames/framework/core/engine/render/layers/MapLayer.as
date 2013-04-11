package com.littlegames.framework.core.engine.render.layers
{
  import com.littlegames.framework.core.data.GameData;
  import com.littlegames.framework.core.data.Player;
  import com.littlegames.framework.core.data.TileMap;
  import com.littlegames.framework.core.data.TilePosition;
  import com.littlegames.framework.core.engine.render.EntityRenderer;
  import com.littlegames.framework.core.engine.render.TileGridLayout;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.entities.unit.Units;
  import com.littlegames.framework.resources.Resources;
  
  import flash.geom.Point;
  
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.textures.Texture;
  import starling.textures.TextureSmoothing;
  
  /**
  * Gère l'affichage de tous les éléments du jeu
  */
  public class MapLayer extends Sprite
  {
    /** Dimension des tiles */
    private const TILE_SIZE:Number = 20;
    // ------------------------------------------------------------------------
    /** Layer de la TileMap */
    private var _tileMapLayer:Sprite;
    /** Layer des unitées */
    private var _layerUnits:Sprite;
    /** Liste de toutes les unitées */
    private var _listRenderers:Vector.<EntityRenderer> = new <EntityRenderer>[];
    // ------------------------------------------------------------------------
    /** Nombre de tiles longueure/largeur */
    private var _tilesXCount:uint;
    private var _tilesYCount:uint;
    /** Layout du jeu */
    private var _layout:TileGridLayout;
    /** Scrolling */
    private var _scrollPositionChanged:Boolean = true;
    /** Dimesions max en pixels */
    private var _maxWidth:Number = 800;
    private var _maxHeight:Number = 440;
    // ------------------------------------------------------------------------
    /** Position du curseur */
    private var _cursorPosition:TilePosition = new TilePosition(0, 0);
    private var _cursorPositionChanged:Boolean = true;
    private var _cursorRenderer:EntityRenderer;
    
    // ------------------------------------------------------------------------
    /** Données du jeu */
    private var _gameData:GameData;
    
    /** Constructeur */
    public function MapLayer()
    {
      super();
      
      _layout = new TileGridLayout(TILE_SIZE, TILE_SIZE);
      _tileMapLayer = new Sprite();
      addChild(_tileMapLayer);
      _layerUnits = new Sprite();
      addChild(_layerUnits);
      _cursorRenderer = new EntityRenderer(Resources.getTextures('cursor'));
      addChild(_cursorRenderer);
    }
    
    /** Initialize le jeu */
    public function initialize(pGameData:GameData) : void
    {
      _gameData = pGameData;
      
      createRenderers();
    }
    
    /** Retourne l'unitée sous le curseur */
    public function getUnitUnderCursor() : UnitInstance
    {
      for each (var renderer:EntityRenderer in _listRenderers)
      {
        if (!renderer.data is UnitInstance) continue;
        
        if (renderer.x == _cursorRenderer.x && renderer.y == _cursorRenderer.y)
        {
          return renderer.data as UnitInstance;
        }
      }
      
      return null;
    }

    /** Construit la tileMap */
    private function createRenderers() : void
    {
      // Crée autant d'image qu'on a besoin pour les tiles
      var renderer:EntityRenderer;
      var totalCount:uint = _tilesXCount * _tilesYCount;
      for each (var tile:Tile in _gameData.tileMap.listTiles)
      {
        renderer = new EntityRenderer(Resources.getTextures(tile.tileId));
        renderer.data = tile;
        renderer.smoothing = TextureSmoothing.NONE;
        renderer.width = renderer.height = TILE_SIZE;
        _layout.layoutElement(renderer, tile.x, tile.y);
        _tileMapLayer.addChild(renderer);
        _listRenderers.push(renderer);
      }
      
      // Parcours des joueurs
      for each (var player:Player in _gameData.listPlayers)
      {
        // Parcours des unitées
        for each (var unit:UnitInstance in player.units)
        {
          renderer = new EntityRenderer(Resources.getTextures(unit.unitId+"_"+"left"));
          renderer.data = unit;
          renderer.width = renderer.height = TILE_SIZE;
          renderer.smoothing = TextureSmoothing.NONE;
          _layout.layoutElement(renderer, unit.x, unit.y);
          _listRenderers.push(renderer);
          _layerUnits.addChild(renderer);
        }
      }
    }
    
    /** Maj */
    public function update() : void
    {
      if (_scrollPositionChanged) updateView();
      if (_cursorPositionChanged)
      {
        _layout.layoutElement(_cursorRenderer, _cursorPosition.x, _cursorPosition.y);
      }
    }
    
    /** Scrolling */
    public function scroll(pDeltaX:Number, pDeltaY:Number) : void
    {
      if (pDeltaX != 0 || pDeltaY != 0)
      {
        _scrollPositionChanged = true;
        _layout.scrollPosition.offset(pDeltaX, pDeltaY);
      }
    }
    
    /** Définit la position du curseur dans le système de coordonnées local */
    public function setLocalCursorPosition(pX:Number, pY:Number) : void
    {
      // TODO Bizarrerie de code, ça doit pas se trouver la mais dans le renderEngine
      var localToWorld:Point = new Point(pX, pY);
      localToWorld.offset(_layout.scrollPosition.x, _layout.scrollPosition.y);
      var worldToTile:TilePosition = _layout.worldToTile(localToWorld.x, localToWorld.y);
      _cursorPosition.x = worldToTile.x;
      _cursorPosition.y = worldToTile.y;
      _cursorPositionChanged = true;
    }
    
    /** Maj de la vue */
    private function updateView() : void
    {
      _scrollPositionChanged = false;
      
      // Repositionne tous les renderers
      for each (var renderer:EntityRenderer in _listRenderers)
      {
        // TODO Typage maybe
        var data:* = renderer.data;
        _layout.layoutElement(renderer, renderer.data.x, renderer.data.y);
        renderer.visible = isVisible(renderer);
      }
    }
    
    /** Teste si le renderer sort de la zone visible */
    private function isVisible(pRenderer:EntityRenderer) : Boolean
    {
      return (pRenderer.x+pRenderer.width) >= 0 && pRenderer.x <= _maxWidth &&
             (pRenderer.y+pRenderer.height) >= 0 && pRenderer.y <= _maxHeight;
    }
  }
}