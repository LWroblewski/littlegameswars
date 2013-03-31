package com.littlegames.framework.core.engine.tileengine
{
  import com.littlegames.framework.core.engine.tileengine.tiles.BaseTile;
  import com.littlegames.framework.core.input.GameInput;
  import com.littlegames.framework.entities.unit.UnitInstance;
  import com.littlegames.framework.resources.TextureManager;
  
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

  /** Classe de gestion de la TileMap */
  public class Board extends Sprite
  {
    /** Zoom */
    private var _zoom:Number;
    /** TileMap */
    private var _tileMap:TileMap;
    // ------------------------------------------------------------------------
    /** Dimension des tiles */
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
    
    /** Constructeur */
    public function Board()
    {
      _zoom = 1;
      _listTiles = new <Image>[];
      _tileLayer = new Sprite();
      addChild(_tileLayer);
      _listUnits = new <UnitInstance>[];
      _unitLayer = new Sprite();
      addChild(_unitLayer);
      
      _cursor = new Image(TextureManager.getInstance().getTextures('Cursor_0')[0]);
      _cursor.smoothing = TextureSmoothing.NONE;
      _cursor.width = _cursor.height = tileSideLenght;
      addChild(_cursor);
      
      addEventListener(TouchEvent.TOUCH, onTouch);
    }
    
    /** Touch */
    private function onTouch(pEvent:TouchEvent) : void
    {
      var touch:Touch = pEvent.touches[0];
      
      _cursor.x = tileSideLenght*uint(touch.globalX/tileSideLenght);
      _cursor.y = tileSideLenght*uint(touch.globalY/tileSideLenght);
      
      if (touch.phase == TouchPhase.ENDED)
      {
        var selection:UnitInstance = getUnitUnderCursor();
        if (!_selectedUnit)
          _selectedUnit = selection;
        if (_selectedUnit && selection == null)
          _actionTarget.setTo(_cursor.x, _cursor.y);
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
        pUnit.unitMovieClip = new MovieClip(TextureManager.getInstance().getUnitTexturesFromId(pUnit.unit.unitId));
        pUnit.unitMovieClip.smoothing = TextureSmoothing.NONE;
        pUnit.unitMovieClip.fps = 2;
        layoutUnit(pUnit);
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
      var toAdd:int = _tileMap.numTilesH * _tileMap.numTilesW;
      // Création des images
      var tileX:Number = 0;
      var tileY:Number = 0;
      while (toAdd-- > 0)
      {
        var img:Image = new Image(getTileTexture(0));
        img.smoothing = TextureSmoothing.NONE;
        img.width = img.height = tileSideLenght;
        img.x = tileX*tileSideLenght;
        img.y = tileY*tileSideLenght;
        _tileLayer.addChild(img);
        tileX++;
        if (tileX > _tileMap.numTilesW)
        {
          tileX = 0;
          tileY++;
        }
      }
    }
    
    // ------------------------------------------------------------------------
    // Helper
    // ------------------------------------------------------------------------
    /** Retourne la texture de tile passée en paramètre */
    private function getTileTexture(pTileId:uint) : Texture
    {
      return TextureManager.getInstance().getTileTextureFromId(pTileId)[0];
    }
  }//end class
}//end package