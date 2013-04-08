package com.littlegames.framework.core.engine.render.tileengine
{
  import com.littlegames.framework.core.engine.render.tileengine.tiles.Tile;
  import com.littlegames.framework.core.engine.render.tileengine.tiles.TilesId;
  import com.littlegames.framework.core.gui.listing.GUIPathDrawer;
  import com.littlegames.framework.core.input.GameInput;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  
  import flash.geom.Point;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.textures.Texture;
  import starling.textures.TextureSmoothing;
  import com.littlegames.framework.core.data.TileMap;

  /** Classe de gestion de la TileMap */
  public class Board extends Sprite
  {
    /** TileMap */
    private var _tileMap:TileMap;
    // ------------------------------------------------------------------------
    /** Dimension des tiles en pixels */
    private var tileSideLenght:Number = 32;
    // ------------------------------------------------------------------------
    /** Indicateur de MAJ */
    private var _isDirty:Boolean = true;
    /** Liste des tiles */
    private var _listTiles:Vector.<Image>;
    private var _tileLayer:Sprite;
    /** Liste des unitées de jeu */
    private var _listUnits:Vector.<UnitInstance>;
    private var _unitLayer:Sprite;
    // ------------------------------------------------------------------------
    /** Curseur de selection */
    private var _cursor:Image;
    /** Unitée selectionnée */
    private var _selectedUnit:UnitInstance;
    /** Destination de l'unitée */
    private var _actionTarget:Point = new Point();
    // ------------------------------------------------------------------------
    /** Gestion des déplacements */
    private var _pathDrawer:GUIPathDrawer;
    private var _lastPathPosition:Point = new Point(-1, -1);
    
    /** Constructeur */
    public function Board()
    {
      _listTiles = new <Image>[];
      _tileLayer = new Sprite();
      addChild(_tileLayer);
      
      _listUnits = new <UnitInstance>[];
      _unitLayer = new Sprite();
      addChild(_unitLayer);
      
      _pathDrawer = new GUIPathDrawer();
      addChild(_pathDrawer);
      
      _cursor = Resources.getImage('cursor');
      _cursor.smoothing = TextureSmoothing.NONE;
      _cursor.width = _cursor.height = tileSideLenght;
      addChild(_cursor);
      
      addEventListener(TouchEvent.TOUCH, onTouch);
    }
    
    /** Touch */
    private function onTouch(pEvent:TouchEvent) : void
    {
      var touch:Touch = pEvent.touches[0];
      
      // Coordonnées tiles
      var xx:uint = uint(touch.globalX/tileSideLenght);
      var yy:uint = uint(touch.globalY/tileSideLenght);
      
      // Coordonnées réelles
      _cursor.x = tileSideLenght*xx;
      _cursor.y = tileSideLenght*yy;
      
      if (touch.phase == TouchPhase.ENDED)
      {
        var selection:UnitInstance = getUnitUnderCursor();
        if (!_selectedUnit)
          _selectedUnit = selection;
        if (_selectedUnit && selection == null)
        {
          if (_lastPathPosition.x != xx || _lastPathPosition.y != yy)
          {
            _pathDrawer.drawPath(_selectedUnit.x, _selectedUnit.y, xx, yy);
            _lastPathPosition.setTo(xx, yy);
          }
          else
          {
            _pathDrawer.clear();
            _actionTarget.setTo(_cursor.x, _cursor.y);
            _lastPathPosition.setTo(-1, -1);
          }
        }
      }
    }
    
    /** Retourne l'unitée sous le curseur */
    private function getUnitUnderCursor() : UnitInstance
    {
      var cursorX:uint = uint(_cursor.x/tileSideLenght);
      var cursorY:uint = uint(_cursor.y/tileSideLenght);
      
      // Parcours les unitées à la recherche de celle sous le curseur
      for each (var unit:UnitInstance in _listUnits)
      {
        if (unit.x == cursorX && unit.y == cursorY)
          return unit;
      }
      
      return null;
    }
    
    /** Ajoute une unitée sur le plateau */
    public function addUnit(pUnit:UnitInstance) : void
    {
      if (!pUnit.unitMovieClip)
      {
        pUnit.unitMovieClip = Resources.getMovieClip(pUnit.unitId + '_' + Animations.LEFT);
        //pUnit.unitMovieClip.width = pUnit.unitMovieClip.height = tileSideLenght;
        pUnit.unitMovieClip.smoothing = TextureSmoothing.NONE;
        pUnit.unitMovieClip.fps = 4;
        layoutUnit(pUnit);
        centerUnit(pUnit);
      }
      
      _listUnits.push(pUnit);
      
      _unitLayer.addChild(pUnit.unitMovieClip);
      Starling.juggler.add(pUnit.unitMovieClip);
    }
    
    /** Positionne l'unitée en fonction de ses coordonnées */
    private function layoutUnit(pUnit:UnitInstance) : void
    {
      pUnit.unitMovieClip.x = pUnit.x * tileSideLenght;
      pUnit.unitMovieClip.y = pUnit.y * tileSideLenght;
    }
    
    /** Centre l'unité sur une tile. */
    private function centerUnit(pUnit:UnitInstance):void
    {
      pUnit.unitMovieClip.x += (tileSideLenght - pUnit.unitMovieClip.width)/2;
      pUnit.unitMovieClip.y += (tileSideLenght - pUnit.unitMovieClip.height)/2;
    }
    
    /** Définit la map affichée */
    public function setMap(pMap:TileMap) : void
    {
      _tileMap = pMap;
      _isDirty = true;
    }
    
    /** MAJ de la vue */
    public function update(pTimeDelta:Number) : void
    {
      if (_isDirty && _tileMap)
      {
        _isDirty = false;
        createViewImages();
      }
      
      // Déplacement
      if (_actionTarget.length != 0)
      {
        _selectedUnit.x = uint(_actionTarget.x/tileSideLenght);
        _selectedUnit.y = uint(_actionTarget.y/tileSideLenght);
        _selectedUnit.unitMovieClip.x = _actionTarget.x;
        _selectedUnit.unitMovieClip.y = _actionTarget.y;
        _actionTarget.setTo(0,0);
        _selectedUnit = null;
      }
    }
    
    /** Crée toutes les images de tiles nécessaires */
    private function createViewImages() : void
    {
      // Vérifie si on a assez d'images pour toutes les tiles
      var toAdd:int = _tileMap.numTilesH * _tileMap.numTilesW - _listTiles.length;
      var img:Image;
      
      while (toAdd--)
      {
        img = Resources.getImage(TilesId.GRASS);
        img.smoothing = TextureSmoothing.NONE;
        img.width = img.height = tileSideLenght;
        _tileLayer.addChild(img);
        _listTiles.push(img);
      }
      
      // Corrige les terrains
      for (var i:uint = 0; i < _tileMap.numTilesW; i++)
      {
        for (var j:uint = 0; j < _tileMap.numTilesH; j++)
        {
          img = _listTiles[i + j * _tileMap.numTilesW];
          img.texture = Resources.getSingleTexture(_tileMap.getTileAt(i, j).tileId);
          img.x = i * tileSideLenght;
          img.y = j * tileSideLenght;
        }
      }
    }
  }//end class
}//end package